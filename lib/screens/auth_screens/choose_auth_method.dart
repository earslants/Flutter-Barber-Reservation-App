import 'package:flutter/material.dart';
import 'package:kuaforv1/screens/barber_screens/barber_login.dart';
import 'package:kuaforv1/screens/auth_screens/login_screen.dart';
import 'package:kuaforv1/screens/auth_screens/signup_screen.dart';
import 'package:kuaforv1/widgets/sign_widgets/have_no_account.dart';
class ChooseAuth extends StatefulWidget {
  const ChooseAuth({Key? key}) : super(key: key);

  @override
  _ChooseAuthState createState() => _ChooseAuthState();
}

class _ChooseAuthState extends State<ChooseAuth> {

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
                  "Giriş Yap",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height / 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: height / 12),

                // ToDO
                // Will be activated later.

                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInWithPhoneNumber()));
                //   },
                //   child: Container(
                //     height: 50,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(30),
                //       color: Colors.grey.withOpacity(0.7),
                //     ),
                //     child: const Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(Icons.phone),
                //         SizedBox(width: 10),
                //         Text(
                //           "Telefon Numarası ile Giriş Yap",
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.withOpacity(0.7),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.mail,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Kullanıcı Girişi",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BarberLogin()));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.withOpacity(0.7),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 10),
                        Text(
                          "Kuaför Girişi",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height / 40),
                CreateAccount(
                  fText: "Bir hesabın yok mu ?",
                  lText: "Üye Ol",
                  myRoute: MaterialPageRoute(builder: (context) => const SignupPage()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
