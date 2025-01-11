import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:t_store/admin_module/admin_navigation.dart';
import 'package:t_store/trainer_module/features/sections/add_trainer_details/add_trainer_details_screen.dart';
import 'package:t_store/trainer_module/trainer_navigation_menu.dart';
import 'package:t_store/user_module/data/repositories/user/user_repositries.dart';
import 'package:t_store/user_module/features/authentication/screens/client_details/add_client_details.dart';
import 'package:t_store/user_module/features/authentication/screens/login/login.dart';
import 'package:t_store/user_module/features/authentication/screens/onboarding/onboarding.dart';
import 'package:t_store/user_module/features/authentication/screens/signup/verify_email.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/format_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    super.onReady();
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  void screenRedirect() async {
    // Check if it's the user's first time opening the app
    await deviceStorage.writeIfNull("isFirstTime", true);
    bool isFirstTime = deviceStorage.read("isFirstTime") ?? true;
    final UserRepository userRepo = Get.put(UserRepository());

    if (isFirstTime) {
      Get.offAll(const OnBoardingScreen());
      return;
    }

    // Proceed with the normal flow if it's not the first time
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        try {
          // Fetch user details from Firestore
          final userDetails = await UserRepository.instance.fetchUserDetails();

          // Redirect based on the role
          if (userDetails.role == 'trainer') {
            // Ensure trainer details are present, and navigate accordingly
            final trainerDetailsDoc = await FirebaseFirestore.instance
                .collection('Profiles')
                .doc(user.uid)
                .collection('trainerDetails')
                .doc(
                    'details') // Assuming there is one document with the trainer's details
                .get();

            // If trainer details are not found, navigate to AddTrainerDetailsScreen
            if (!trainerDetailsDoc.exists) {
              Get.offAll(() => AddTrainerDetailsScreen(userId: user.uid));
            } else {
              // If trainer details exist, navigate to TrainerNavigationMenu
              Get.offAll(() => TrainerNavigationMenu());
            }
          } else if (userDetails.role == 'admin') {
            // Redirect to admin navigation if the role is admin
            Get.offAll(() => AdminNavigationScreen());
          } else if (userDetails.role == 'client') {
            // For clients, check if client details exist
            final clientDetailsDoc = await FirebaseFirestore.instance
                .collection('Profiles')
                .doc(user.uid)
                .collection('clientDetails')
                .doc(
                    'details') // Assuming there is one document with the trainer's details
                .get();

            // If client details don't exist, navigate to ClientDetailsScreen
            if (!clientDetailsDoc.exists) {
              Get.offAll(() => AddClientDetailsScreen(userId: user.uid));
            } else {
              // If client details exist, navigate to UserNavigationMenu
              Get.offAll(() => UserNavigationMenu());
            }
          }
        } catch (e) {
          // Handle any errors while fetching user details
          print('Error fetching user details: $e');
          screenRedirect(); // Ensure user goes to navigation menu on error
        }
      } else {
        // If email is not verified, navigate to VerifyEmailScreen
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      // If no user is logged in, navigate to LoginScreen
      Get.offAll(const LoginScreen());
    }
  }

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException().message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException().message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException().message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException().message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException().message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Delete user data from Firestore
        await _db.collection("Profiles").doc(user.uid).delete();

        // Delete the user's account
        await user.delete();

        // Logout the user
        await _auth.signOut();

        // Redirect to login screen
        Get.offAll(() => const LoginScreen());
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException().message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
