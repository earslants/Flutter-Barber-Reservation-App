import 'package:flutter/material.dart';
import 'package:kuaforv1/services/auth.dart';
import 'package:kuaforv1/widgets/button.dart';

class SignInWithPhoneNumber extends StatefulWidget {
  const SignInWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<SignInWithPhoneNumber> createState() => _SignInWithPhoneNumberState();
}

class _SignInWithPhoneNumberState extends State<SignInWithPhoneNumber> {
  TextEditingController countryController = TextEditingController();
  var phone = "";
  var verificationId;

  @override
  void initState() {
    countryController.text = "+90";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "Telefon ile Giriş Yap",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Başlamadan önce telefon numaranız ile kaydolmanız gerekmektedir",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    color: Colors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                          onChanged: (value) {
                            phone = value;
                            // print("${countryController.text}${phone} ");
                          },
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "5xx-xxx-xxxx",
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  // AuthService().signIn(context, email: _tEmail.text, password: _tPassword.text);
                  // AuthService()._verifyPhoneNumber(context, countryController.text+phone);
                  AuthService().verifyPhoneNumber(context, phone: countryController.text + phone);
                },
                style: buttonPrimary,
                child: const Text("Kod Gönder"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
