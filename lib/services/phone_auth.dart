import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PhoneAuth extends GetxController {
  static PhoneAuth get instance => Get.find();

  final firebaseAuth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = "".obs;

  Future<void> phoneAuthentication(String phoneNo) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await firebaseAuth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e){
        if(e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The provided phone number is not valid.');
        } else {
          Get.snackbar('Error', 'Something went wrong. Try again');
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await firebaseAuth
        .signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }
}