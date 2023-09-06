import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kuaforv1/screens/profile_screens/user_profile.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ChangeProfileDetails extends StatefulWidget {

  final _tName = TextEditingController();
  final _tSurname = TextEditingController();
  final _tPhone = TextEditingController();


  ChangeProfileDetails({Key? key}) : super(key: key);

  @override
  State<ChangeProfileDetails> createState() => _ChangeProfileDetailsState();
}

class _ChangeProfileDetailsState extends State<ChangeProfileDetails> {

  bool isDark = false; // Başlangıçta dark mode kapalı
  String uMail = "";
  String uName = "";
  String uPhone = "";
  String uSurname = "";
  final auth = FirebaseAuth.instance;

  void toggleDarkMode() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  void initState() {
    super.initState();
    loadProfileDetails();
  }

  Future<void> loadProfileDetails() async {
    var user = auth.currentUser;
    var userMail = user?.email;
    var col = FirebaseFirestore.instance.collection('users');
    var doc = await col.doc(userMail).get();
    setState(() {
      uMail = userMail.toString();
      uName = doc['name'];
      uPhone = doc['phone'];
      uSurname = doc['surname'];
    });
  }

  Future<void> updateProfileInfos({required String name, required String surname, required String phone}) async {
    var user = auth.currentUser;
    var userMail = user?.email;
    var col = FirebaseFirestore.instance.collection('users');
    col.doc(userMail).update({
      'name': name,
      'surname': surname,
      'phone': phone,
    });
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Profili Düzenle"),
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
                color: isDark ? Colors.white : Colors.black,
              ),
              onPressed: toggleDarkMode,
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
              const Padding(
                padding: EdgeInsets.all(30),
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/profile.jpg'),
                  radius: 70,
                ),
              ),
              Text(
                uName.toLowerCase(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                uMail,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: height / 20),
              // Center(
              //   child: RoundedInputField(
              //     onChanged: (value){},
              //     icon: Icons.abc,
              //     controller: widget._tText,
              //     keyboardType: TextInputType.text,
              //     hintText: 'İsim',
              //   ),
              // ),
              Center(
                child: SizedBox(
                  width: width * 0.8,
                  child: TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: uName,
                    ),
                    controller: widget._tName,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              SizedBox(height: height / 30),
              Center(
                child: SizedBox(
                  width: width * 0.8,
                  child: TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: uSurname,
                    ),
                    controller: widget._tSurname,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              SizedBox(height: height / 30),
              Center(
                child: SizedBox(
                  width: width * 0.8,
                  child: TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: uPhone,
                    ),
                    controller: widget._tPhone,
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ),
              SizedBox(height: height / 30),
              GestureDetector(
                onTap: () {
                  try {
                    updateProfileInfos(
                        name: widget._tName.text,
                        surname: widget._tSurname.text,
                        phone: widget._tPhone.text);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                  } catch(e) {
                    print(e);
                  }
                },
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
