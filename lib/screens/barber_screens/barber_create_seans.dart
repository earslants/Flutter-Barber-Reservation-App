import 'package:flutter/material.dart';
import 'package:kuaforv1/screens/barber_screens/barber_home_screen.dart';
import 'package:kuaforv1/screens/profile_screens/user_profile.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CreateSeans extends StatefulWidget {

  const CreateSeans({Key? key}) : super(key: key);

  @override
  State<CreateSeans> createState() => _CreateSeansState();
}

class _CreateSeansState extends State<CreateSeans> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Seans Ekle"),
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BarberHomePage(),
                ),
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(LineAwesomeIcons.sun),
              onPressed: () {},
            ),
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height / 20),
              Center(
                child: SizedBox(
                  width: width * 0.8,
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "aa",
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              SizedBox(height: height / 30),
              Center(
                child: SizedBox(
                  width: width * 0.8,
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "uSurname",
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              SizedBox(height: height / 30),
              Center(
                child: SizedBox(
                  width: width * 0.8,
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "uPhone",
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ),
              SizedBox(height: height / 30),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 50,
                  width: width * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.9),
                  ),
                  child: const Center(
                    child: Text(
                      "Değişiklikleri Kaydet",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
