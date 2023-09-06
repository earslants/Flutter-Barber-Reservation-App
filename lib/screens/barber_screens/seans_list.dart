import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class SeansListesi extends StatefulWidget {
  @override
  _SeansListesiState createState() => _SeansListesiState();
}

class _SeansListesiState extends State<SeansListesi> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String userId = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBarberData();
  }

  Future<void> loadBarberData() async {
    QuerySnapshot userDocs = await FirebaseFirestore.instance
        .collection('kuaforlist')
        .where('kuaforMail', isEqualTo: auth.currentUser?.email.toString())
        .get();

    setState(() {
      userId = userDocs.docs.isNotEmpty ? userDocs.docs[0].id : '';
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('kuaforlist')
          .doc(userId) // userId değişkenini kullanarak belirli bir kuaförü seçin
          .collection('Seanslar')
          .where('status', isEqualTo: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Hata: ${snapshot.error}');
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('Hiç seans bulunamadı.');
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot seans = snapshot.data!.docs[index];
            DateTime tarih = (seans['tarih'] as Timestamp).toDate();
            String formattedTarih = DateFormat('dd-MM-yyyy - HH:mm:ss').format(tarih);

            return Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {},
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                          image: AssetImage("images/barber.jpg"),
                          fit: BoxFit.cover,
                          opacity: 0.8,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formattedTarih,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      Text(
                        seans['musteriTel'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}