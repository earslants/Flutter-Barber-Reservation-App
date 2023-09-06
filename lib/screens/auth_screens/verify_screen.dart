import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kuaforv1/screens/main_screens/home_screen.dart';
import 'package:kuaforv1/screens/auth_screens/sign_in_with_phone_number.dart';
import 'package:pinput/pinput.dart';

class MyVerify extends StatefulWidget {
  final String verificationId;

  const MyVerify({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  final controller = const SignInWithPhoneNumber();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/firstBarber.jpg"),
              fit: BoxFit.cover,
            )
        ),
        // margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Telefon Doğrulama",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Lütfen telefonunuza gelen kodu giriniz!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                onCompleted: (pin) {
                  // Doğrulama kodu girildiğinde
                  final smsCode = pin;
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: smsCode,
                  );
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  _auth.signInWithCredential(credential).then((value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(), // Giriş başarılı olduğunda ana ekrana yönlendir
                      ),
                    );
                  }).catchError((error) {
                    print("Giriş başarısız: $error");
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        // Navigator.pushNamedAndRemoveUntil(
                        //   context,
                        //   'phone',
                        //       (route) => false,
                        // );
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInWithPhoneNumber()));
                      },
                      child: const Text(
                        "Telefon Numarasını Düzenle",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
