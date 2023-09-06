import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kuaforv1/screens/barber_screens/barber_signup.dart';
import 'package:kuaforv1/screens/auth_screens/reset_password.dart';
import 'package:kuaforv1/services/auth.dart';
import 'package:kuaforv1/widgets/button.dart';
import 'package:kuaforv1/widgets/text_fields/rounded_input_field.dart';
import 'package:kuaforv1/widgets/text_fields/rounded_password_field.dart';
import 'package:kuaforv1/widgets/sign_widgets/have_no_account.dart';

class BarberLogin extends StatefulWidget {
  const BarberLogin({Key? key}) : super(key: key);

  @override
  _BarberLoginState createState() => _BarberLoginState();
}

class _BarberLoginState extends State<BarberLogin> {

  // text field state
  final _tEmail = TextEditingController();
  final _tPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/barbershop.jpg'),
          fit: BoxFit.cover,
          opacity: 0.7,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height / 80 * 10, horizontal: 25),
            child: Column(
              children: [
                Text(
                  "Kuaför Girişi",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height / 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: height / 8),
                Center(
                  child: RoundedInputField(
                    controller: _tEmail,
                    icon: Icons.person,
                    hintText: "e-posta",
                    onChanged: (value) {},
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(height: height / 20),
                Center(
                  child: RoundedPasswordField(
                      onChanged: (value) {},
                      controller: _tPassword,
                      hintText: 'şifre'
                  ),
                ),
                SizedBox(height: height / 80),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPassword()));
                        },
                        child: const Text(
                          "Şifreni mi unuttun?",
                          style: TextStyle(
                            color: Color(0xB3FFFFFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: height / 80 * 4),
                // SignInWithGoogle(width: width, height: height),
                SizedBox(height: height / 20),
                ElevatedButton(
                  onPressed: () async {
                    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('barbers').where('email', isEqualTo: _tEmail.text).get();
                    if(snapshot.docs.first.id == _tEmail.text) {
                      if(context.mounted){
                        AuthService().signInBarber(context,
                            email: _tEmail.text, password: _tPassword.text);
                      }
                    }
                  },
                  style: buttonPrimary,
                  child: const Text("Giriş Yap"),
                ),
                SizedBox(height: height / 40),
                CreateAccount(
                  fText: "Bir hesabın yok mu ?",
                  lText: "Üye Ol",
                  myRoute: MaterialPageRoute(builder: (context) => const BarberSignup()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

