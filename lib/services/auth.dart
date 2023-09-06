import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kuaforv1/screens/barber_screens/barber_home_screen.dart';
import 'package:kuaforv1/screens/main_screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:kuaforv1/screens/auth_screens/verify_screen.dart';
import 'package:kuaforv1/screens/profile_screens/welcome_screen.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection("users");
  final barberCollection = FirebaseFirestore.instance.collection("barbers");
  final firebaseAuth = FirebaseAuth.instance;
  var verificationId = ''.obs;

  Future<void> signUp({required String name, required String email, required String password, required String phone, required String surname}) async {

    try{
      final UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        registerUser(name: name, email: email, password: password, phone: phone, surname: surname);
      }
    } on FirebaseAuthException catch(e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<void> signUpBarber({required String name, required String email, required String password, required String phone, required String surname}) async {

    try{
      final UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        registerBarber(name: name, email: email, password: password, phone: phone, surname: surname);
      }
    } on FirebaseAuthException catch(e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<void> signIn(BuildContext context, {required String email, required String password}) async {
    
    try {
      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        //Fluttertoast.showToast(msg: "Giriş Başarılı");
        if(context.mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      }
    } on FirebaseAuthException catch(e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<void> signInBarber(BuildContext context, {required String email, required String password}) async {

    try {
      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        //Fluttertoast.showToast(msg: "Giriş Başarılı");
        if(context.mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const BarberHomePage()),
          );
        }
      }
    } on FirebaseAuthException catch(e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<void> registerUser({required String name, required String email, required String password, required String phone, required String surname}) async {
    await userCollection.doc(email).set({
      'email' : email,
      'name' : name,
      'password' : password,
      'phone': phone,
      'surname' : surname,
      'favoriler' : [],
    });
  }

  Future<void> registerBarber({required String name, required String email, required String password, required String phone, required String surname}) async {
    await barberCollection.doc(email).set({
      'email' : email,
      'name' : name,
      'password' : password,
      'phone': phone,
      'surname' : surname,
    });
  }

  // Future<void> phoneAuthentication(String phoneNo) async {
  //   await firebaseAuth.verifyPhoneNumber(
  //     phoneNumber: phoneNo,
  //     verificationCompleted: (credentials) async {
  //       await firebaseAuth.signInWithCredential(credential);
  //       },
  //     verificationFailed: (e){},
  //     codeSent: (verificationId, resendToken) {},
  //     codeAutoRetrievalTimeout: (verificationId) {},
  //   );
  // }

  Future<void> signOut(BuildContext context) async {
    try {
      await firebaseAuth.signOut();
      // if(context.mounted) {
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => const WelcomeScreen()));
      // }
      if(context.mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()));
      }
    } catch(e) {
      print(e);
    }
  }


  Future<void> verifyPhoneNumber(BuildContext context, {required String phone}) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await firebaseAuth.signInWithCredential(credential);
        if(context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const HomePage(), // Giriş başarılı olduğunda ana ekrana yönlendir
            ),
          );
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Doğrulama hatası: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyVerify(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

}