import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/format_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';

class CollectionRepository extends GetxController {
  static CollectionRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Fetch the total earnings (collection) for a specific trainer.
  Future<double> fetchTotalCollection(String trainerId) async {
    try {
      final trainerRef = _db
          .collection('Profiles')
          .doc(trainerId)
          .collection('trainerDetails')
          .doc('details');

      final snapshot = await trainerRef.get();
      if (!snapshot.exists) {
        throw Exception('Trainer details not found for ID: $trainerId');
      }

      final earnings = snapshot.get('earnings') as List<dynamic>? ?? [];
      final totalCollection = earnings
          .map((e) => (e['amount'] as num).toDouble())
          .fold(0.0, (sum, value) => sum + value);

      return totalCollection;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException().message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching total collection.';
    }
  }

  /// Fetch the earnings (collection) for a specific trainer in a given month and year.
  Future<double> fetchMonthlyCollection(
      String trainerId, int year, int month) async {
    try {
      final trainerRef = _db
          .collection('Profiles')
          .doc(trainerId)
          .collection('trainerDetails')
          .doc('details');

      final snapshot = await trainerRef.get();
      if (!snapshot.exists) {
        throw Exception('Trainer details not found for ID: $trainerId');
      }

      final earnings = snapshot.get('earnings') as List<dynamic>? ?? [];
      final monthlyCollection = earnings
          .where((e) {
            final earningDate =
                DateTime.parse(e['date']); // Parse string to DateTime
            return earningDate.year == year && earningDate.month == month;
          })
          .map((e) => (e['amount'] as num).toDouble())
          .fold(0.0, (sum, value) => sum + value);

      return monthlyCollection;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException().message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching monthly collection.';
    }
  }

  /// Fetch the earnings (collection) for a specific trainer between two dates.
  Future<double> fetchCollectionsBetweenDates(
      String trainerId, DateTime fromDate, DateTime toDate) async {
    try {
      final trainerRef = _db
          .collection('Profiles')
          .doc(trainerId) // Replace with actual trainerId
          .collection('trainerDetails')
          .doc('details');

      final snapshot = await trainerRef.get();
      if (!snapshot.exists) {
        throw Exception('Trainer details not found for ID: $trainerId');
      }

      final earnings = snapshot.get('earnings') as List<dynamic>? ?? [];
      final totalCollection = earnings
          .where((e) {
            final earningDate = DateTime.parse(e['date']); // Parse stored date
            return earningDate.isAfter(fromDate.subtract(Duration(days: 1))) &&
                earningDate.isBefore(toDate.add(Duration(days: 1)));
          })
          .map((e) => (e['amount'] as num).toDouble())
          .fold(0.0, (sum, value) => sum + value);

      return totalCollection;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException().message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching collections between dates.';
    }
  }

  /// Fetch the earnings (collection) for a specific trainer on a specific date (today).
  Future<double> fetchCollectionForDate(String trainerId, DateTime date) async {
    try {
      final trainerRef = _db
          .collection('Profiles')
          .doc(trainerId) // Replace with actual trainerId
          .collection('trainerDetails')
          .doc('details');

      final snapshot = await trainerRef.get();
      if (!snapshot.exists) {
        throw Exception('Trainer details not found for ID: $trainerId');
      }

      final earnings = snapshot.get('earnings') as List<dynamic>? ?? [];

      // Filter earnings for the specific date
      final todaysCollection = earnings
          .where((e) {
            final earningDate = DateTime.parse(e['date']); // Parse stored date
            return earningDate.year == date.year &&
                earningDate.month == date.month &&
                earningDate.day == date.day;
          })
          .map((e) => (e['amount'] as num).toDouble())
          .fold(0.0, (sum, value) => sum + value);

      return todaysCollection;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException().message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching collections for today.';
    }
  }
}
