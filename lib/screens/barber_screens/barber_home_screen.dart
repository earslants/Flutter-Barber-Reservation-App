import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kuaforv1/screens/barber_screens/create_barber_screen.dart';
import 'package:kuaforv1/screens/barber_screens/create_seans_screen.dart';
import 'package:kuaforv1/screens/barber_screens/list_reservations_screen.dart';
import 'package:kuaforv1/screens/main_screens/details_screen.dart';
import 'package:kuaforv1/services/auth.dart';
import 'package:kuaforv1/widgets/top_screen/top_screen_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:kuaforv1/widgets/barber_home_page_widget.dart';

class BarberHomePage extends StatefulWidget {
  const BarberHomePage({Key? key}) : super(key: key);

  @override
  State<BarberHomePage> createState() => _BarberHomePageState();
}

class _BarberHomePageState extends State<BarberHomePage> {

  bool isDark = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> reservations = [];

  void toggleDarkMode() {
    setState(() {
      isDark = !isDark;
    });
  }
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopScreenWidget(
                height: height,
                width: width,
                buttonText: "Detaylar",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage()));
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  "İşlemler",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BarberHomePageWidget(
                width: width,
                icon: LineAwesomeIcons.alternate_store,
                title: "Kuaför Ekle",
                onTap: () {
                  if(context.mounted) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBarber()));
                  }
                },
              ),
              const SizedBox(height: 30),
              BarberHomePageWidget(
                width: width,
                icon: Icons.list,
                title: "Seans Ekle",
                onTap: () {
                  if(context.mounted) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateSeansPage()));
                  }
                },
              ),
              const SizedBox(height: 30),
              BarberHomePageWidget(
                width: width,
                icon: Icons.list_alt,
                title: "Rezervasyonları Görüntüle",
                onTap: () {
                  if(context.mounted) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const KuaforRezervasyonApp()));
                  }
                },
              ),
              const SizedBox(height: 30),
              BarberHomePageWidget(
                width: width,
                icon: Icons.logout,
                title: "Çıkış Yap",
                onTap: () {
                  AuthService().signOut(context);
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
