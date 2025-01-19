import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:t_store/trainer_module/data/repositories/membership_repository.dart';

class MemberRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final MembershipRepository membershipRepository =
      Get.put(MembershipRepository());

  // Fetch client details and their memberships
  Future<List<Map<String, dynamic>>> fetchClientMemberships(
      String trainerId) async {
    try {
      // Fetch client IDs associated with the trainer
      final clientIds = await membershipRepository.getClientIds(trainerId);

      List<Map<String, dynamic>> memberships = [];

      for (String clientId in clientIds) {
        final clientDoc = await _firestore
            .collection('Profiles')
            .doc(clientId)
            .collection('clientDetails')
            .doc('details')
            .get();

        final clientData = clientDoc.data();

        if (clientData != null && clientData['memberships'] != null) {
          List<dynamic> clientMemberships = clientData['memberships'];
          memberships.addAll(clientMemberships.map((membership) {
            return {
              'clientId': clientId,
              'startDate': (membership['startDate'] as Timestamp?)?.toDate(),
              'endDate': (membership['endDate'] as Timestamp?)?.toDate(),
              'status': membership['status'],
            };
          }).toList());
        }
      }

      return memberships;
    } catch (e) {
      print('Error fetching client memberships: $e');
      throw Exception('Failed to fetch client memberships');
    }
  }

  // Calculate total active and expired members
  Future<Map<String, int>> calculateActiveAndExpiredMembers(
      String trainerId) async {
    try {
      final memberships = await fetchClientMemberships(trainerId);

      int activeCount = 0;
      int expiredCount = 0;

      DateTime now = DateTime.now();

      for (var membership in memberships) {
        DateTime? endDate = membership['endDate'];
        if (endDate != null && endDate.isAfter(now)) {
          activeCount++;
        } else {
          expiredCount++;
        }
      }

      return {
        'active': activeCount,
        'expired': expiredCount,
      };
    } catch (e) {
      print('Error calculating active and expired members: $e');
      throw Exception('Failed to calculate active and expired members');
    }
  }

  // Fetch expired memberships for specific ranges
  Future<Map<String, int>> calculateExpiredInRanges(String trainerId) async {
    try {
      final memberships = await fetchClientMemberships(trainerId);

      DateTime now = DateTime.now();
      int expired1To3Days = 0;
      int expired4To7Days = 0;
      int expired8To15Days = 0;
      int expiringToday = 0;

      for (var membership in memberships) {
        DateTime? endDate = membership['endDate'];

        if (endDate != null) {
          final daysDifference = endDate.difference(now).inDays;

          if (daysDifference == 0) {
            expiringToday++;
          } else if (daysDifference >= -3 && daysDifference < 0) {
            expired1To3Days++;
          } else if (daysDifference >= -7 && daysDifference < -3) {
            expired4To7Days++;
          } else if (daysDifference >= -15 && daysDifference < -7) {
            expired8To15Days++;
          }
        }
      }

      return {
        '1-3': expired1To3Days,
        '4-7': expired4To7Days,
        '8-15': expired8To15Days,
        'today': expiringToday,
      };
    } catch (e) {
      print('Error calculating expired ranges: $e');
      throw Exception('Failed to calculate expired ranges');
    }
  }
}
