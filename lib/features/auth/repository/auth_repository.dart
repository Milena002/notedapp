import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notedapp/common/helpers/db_helper.dart';
import 'package:notedapp/common/routes/routes.dart';
import 'package:notedapp/common/widgets/show_alert_dialog.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(auth: FirebaseAuth.instance);
});

class AuthRepository {
  final FirebaseAuth auth;

  AuthRepository({required this.auth});

  void verifyOtpCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: smsCodeId,
        smsCode: smsCode,
      );

      final userCredential = await auth.signInWithCredential(credential);

      // Check if the sign-in was successful
      if (userCredential.user != null) {
        if (!mounted) {
          return;
        }
        DBHelper.createUser(1);
        // User signed in successfully
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.home,
          (route) => false,
        );
      } else {
        // Sign-in failed
        // ignore: use_build_context_synchronously
        showAlertDialog(
          context: context,
          message: 'Failed to sign in. Invalid OTP code.',
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions
      showAlertDialog(
        context: context,
        message: 'Failed to sign in. Error: ${e.message}',
      );
    } catch (e) {
      // Handle other errors
      showAlertDialog(
        context: context,
        message: 'Failed to sign in. Error: $e',
      );
    }
  }

  void sendOtp({
    required BuildContext context,
    required String phone,
  }) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            showAlertDialog(context: context, message: e.toString());
          },
          codeSent: (smsCodeId, resendCodeId) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.otp,
              (route) => false,
              arguments: {
                'phone': phone,
                'smsCodeId': smsCodeId,
              },
            );
          },
          codeAutoRetrievalTimeout: (String smsCodeId) {});
    } on FirebaseAuth catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }
}
