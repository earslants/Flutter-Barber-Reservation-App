import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kuaforv1/screens/auth_screens/login_screen.dart';
import 'package:kuaforv1/widgets/button.dart';
import 'package:kuaforv1/widgets/text_fields/rounded_input_field.dart';
import 'package:kuaforv1/widgets/sign_widgets/have_no_account.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  // text field state
  final _tEmail = TextEditingController();
  final auth = FirebaseAuth.instance;


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
                  "Şifreni Sıfırla",
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
                ElevatedButton(
                  onPressed: () {
                    // AuthService().signIn(context, email: _tEmail.text, password: _tPassword.text);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Devam etmek istiyor musun ?"),
                          backgroundColor: Colors.white.withOpacity(0.9),
                          content: Text("${_tEmail.text} adresine şifre sıfırlama bağlantısı göndermek istiyor musunuz ?"),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Colors.grey,
                              ),
                              child: const Text("Hayır"),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                auth.sendPasswordResetEmail(email: _tEmail.text);
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Colors.grey,
                              ),
                              child: const Text("Evet"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: buttonPrimary,
                  child: const Text("Gönder"),
                ),
                SizedBox(height: height / 20),
                CreateAccount(
                  fText: "Zaten bir hesabın var mı ?",
                  lText: "Giriş Yap",
                  myRoute: MaterialPageRoute(builder: (context) => const LoginPage()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

