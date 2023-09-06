import 'package:flutter/material.dart';
import 'package:kuaforv1/screens/barber_screens/barber_login.dart';
import 'package:kuaforv1/services/auth.dart';
import 'package:kuaforv1/widgets/button.dart';
import 'package:kuaforv1/widgets/sign_widgets/have_no_account.dart';
import 'package:kuaforv1/widgets/text_fields/rounded_input_field.dart';
import 'package:kuaforv1/widgets/text_fields/rounded_password_field.dart';

class BarberSignup extends StatefulWidget {
  const BarberSignup({Key? key}) : super(key: key);

  @override
  _BarberSignupState createState() => _BarberSignupState();
}

class _BarberSignupState extends State<BarberSignup> {

  final _tName = TextEditingController();
  final _tEmail = TextEditingController();
  final _tPassword = TextEditingController();
  final _tPhone = TextEditingController();
  final _tSurname = TextEditingController();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;

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
            padding: EdgeInsets.symmetric(vertical: height / 80 * 5, horizontal: 25),
            child: Column(
              children: [
                Text(
                  "Kuaför Kayıt",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height / 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: height / 30),
                Center(
                  child: RoundedInputField(
                    controller: _tEmail,
                    icon: Icons.mail,
                    hintText: "e-posta",
                    onChanged: (value) {},
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(height: height / 30),
                Center(
                  child: RoundedInputField(
                    controller: _tName,
                    icon: Icons.person,
                    hintText: "isim",
                    onChanged: (value) {},
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(height: height / 30),
                Center(
                  child: RoundedInputField(
                    controller: _tSurname,
                    icon: Icons.person,
                    hintText: "Soyisim",
                    onChanged: (value) {},
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(height: height / 30),
                Center(
                  child: RoundedPasswordField(
                      onChanged: (value) {},
                      controller: _tPassword,
                      hintText: 'şifre'
                  ),
                ),
                // SizedBox(height: height / 20),
                // Center(
                //   child: RoundedPasswordField(onChanged: (value) {}, hintText: 'şifreyi tekrar giriniz'),
                // ),
                SizedBox(height: height / 30),
                RoundedInputField(
                  controller: _tPhone,
                  hintText: "Telefon",
                  icon: Icons.phone,
                  onChanged: (value) {},
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: height / 15),
                ElevatedButton(
                  onPressed: () {
                    // locator.get<AuthService>().registerUser(name: _tName.text, email: _tEmail.text, password: _tPassword.text);
                    // AuthService().signUp(name: _tName.text, email: _tEmail.text, password: _tPassword.text, phone: _tPhone.text, surname: _tSurname.text);
                    AuthService().signUpBarber(name: _tName.text, email: _tEmail.text, password: _tPassword.text, phone: _tPhone.text, surname: _tSurname.text);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BarberLogin()));
                  },
                  style: buttonPrimary,
                  child: const Text("Kayıt Ol"),
                ),
                SizedBox(height: height / 40),
                CreateAccount(
                  fText: "Zaten bir hesabın var mı ?",
                  lText: "Giriş Yap",
                  myRoute: MaterialPageRoute(builder: (context) => const BarberLogin()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}