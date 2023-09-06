import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kuaforv1/screens/barber_screens/barber_home_screen.dart';
import 'package:kuaforv1/screens/profile_screens/user_profile.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CreateBarber extends StatefulWidget {

  final _tName = TextEditingController();
  final _tCity = TextEditingController();
  final _tPrice = TextEditingController();
  final _tPhone = TextEditingController();

  CreateBarber({Key? key}) : super(key: key);

  @override
  State<CreateBarber> createState() => _CreateBarberState();
}

class _CreateBarberState extends State<CreateBarber> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Kuaför Ekle"),
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
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Kuaför Adı",
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
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Şehir",
                    ),
                    controller: widget._tCity,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              SizedBox(height: height / 30),
              Center(
                child: SizedBox(
                  width: width * 0.8,
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Fiyat",
                    ),
                    controller: widget._tPrice,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              SizedBox(height: height / 30),
              Center(
                child: SizedBox(
                  width: width * 0.8,
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Telefon Numarası",
                    ),
                    controller: widget._tPhone,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              SizedBox(height: height / 30),
              GestureDetector(
                onTap: () async {

                  try {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    CollectionReference kuaforCollection =
                        FirebaseFirestore.instance.collection('kuaforlist');
                    QuerySnapshot querySnapshot = await kuaforCollection.get();
                    String id = (querySnapshot.docs.length).toString();
                    String fiyatString = widget._tPrice.text;
                    double fiyat = double.tryParse(fiyatString) ?? 0.0;

                    // Kuaför dokümanını oluşturun
                    DocumentReference kuaforDoc = kuaforCollection.doc(id);
                    await kuaforDoc.set({
                      'id': id,
                      'city': widget._tCity.text,
                      'fiyat': fiyat,
                      'name': widget._tName.text,
                      'star': "",
                      'stars': [],
                      'popularity': 0,
                      'kuaforMail': auth.currentUser?.email.toString(),
                    });
                    if(context.mounted){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Kuaför başarıyla eklendi'),
                        ),
                      );
                    }
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
                      "Kuaför Ekle",
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
