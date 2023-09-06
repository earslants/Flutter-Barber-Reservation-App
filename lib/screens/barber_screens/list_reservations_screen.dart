import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kuaforv1/screens/barber_screens/barber_home_screen.dart';
import 'package:kuaforv1/screens/barber_screens/seans_list.dart';

class KuaforRezervasyonApp extends StatelessWidget {
  const KuaforRezervasyonApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kuaför Rezervasyon Uygulaması',
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  final TextEditingController _tPhone = TextEditingController();
  String selectedSeans = "";
  String userId = '';
  bool isLoading = true;
  Timestamp manuelResTime = Timestamp.fromDate(DateTime(2023, 9, 10, 15, 30));
  FirebaseAuth auth = FirebaseAuth.instance;

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

  Future<List<Map<String, dynamic>>> getSeansList() async {
    var seansList = <Map<String, dynamic>>[];

    var snapshot = await FirebaseFirestore.instance
        .collection('kuaforlist')
        .doc(userId) // userId değişkenini kullanarak belirli bir kuaförü seçin
        .collection('Seanslar')
        .where('status', isEqualTo: true)
        .get();

    for (var seansDoc in snapshot.docs) {
      var seansData = seansDoc.data();
      seansList.add(seansData);
    }

    return seansList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seanslar"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Rezervasyon Ekle"),
                    backgroundColor: Colors.white.withOpacity(0.9),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text("Rezervasyon oluşturmak istediğiniz kullanıcının bilgilerini giriniz"),
                          TextField(
                            controller: _tPhone,
                            decoration: const InputDecoration(
                              hintText: "Telefon Numarası",
                            ),
                            onChanged: (value) {},
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Seans Seç"),
                                    content: SizedBox(
                                      width: double.maxFinite,
                                      child: FutureBuilder(
                                        // Seansları getiren işlevi buraya ekleyin
                                        future: getSeansList(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          }
                                          if (snapshot.hasError) {
                                            return Text('Hata: ${snapshot.error}');
                                          }
                                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                            return const Text('Hiç seans bulunamadı.');
                                          }
                                          // Seansları göstermek için bir ListView oluşturun
                                          return ListView.builder(
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, index) {
                                              var seans = snapshot.data![index];
                                              // Seansları ListView içinde gösterin
                                              // Timestamp'i DateTime nesnesine çevirme
                                              DateTime tarih = (seans['tarih'] as Timestamp).toDate();

                                              // Tarihi istediğiniz formatta biçimlendirme
                                              String formattedTarih = DateFormat('dd-MM-yyyy - HH:mm:ss').format(tarih);

                                              return ListTile(
                                                title: Text(formattedTarih),
                                                // leading: Text(seans[index]['kuaforId']),
                                                onTap: () {
                                                  setState(() {
                                                    manuelResTime = seans['tarih'];
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                // Diğer seans verilerini burada gösterin
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Text("Seans Seç"),
                          ),

                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () async {
                          var docRef = FirebaseFirestore.instance
                              .collection('kuaforlist')
                              .doc(userId)
                              .collection('Seanslar')
                              .where('tarih', isEqualTo: manuelResTime);

                          await docRef.get().then((querySnapshot) {
                            if(querySnapshot.size == 1) {
                              var seansDoc = querySnapshot.docs[0];
                              seansDoc.reference.update({
                                'musteriTel': _tPhone.text,
                                'status': false,
                              });
                              Navigator.of(context).pop();
                            }
                            else {
                              print("Hata: Seans bulunamadı");
                              Navigator.of(context).pop();
                            }
                          });
                        },
                        child: const Text("Ekle"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SeansListesi(),
    );
  }
}



// class SeansListesi extends StatelessWidget {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance
//           .collection('kuaforlist')
//           .doc('3') // Kuaförün mail adresini buraya ekleyin
//           .collection('Seanslar')
//           .where('status', isEqualTo: false)
//           .snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator(); // Veriler yüklenirken gösterilecek widget
//         }
//         if (snapshot.hasError) {
//           return Text('Hata: ${snapshot.error}');
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Text('Hiç seans bulunamadı.');
//         }
//
//         // Verileri ListView içerisinde gösterme
//         return ListView.builder(
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (context, index) {
//             DocumentSnapshot seans = snapshot.data!.docs[index];
//             // Seans verilerini kullanarak gerekli widget'ları oluşturun
//             // Timestamp'i DateTime nesnesine çevirme
//
//             DateTime tarih = (seans['tarih'] as Timestamp).toDate();
//
//             // Tarihi istediğiniz formatta biçimlendirme
//             String formattedTarih = DateFormat('dd-MM-yyyy - HH:mm:ss').format(tarih);
//
//             return ListTile(
//               title: Text(formattedTarih),
//               subtitle: Text(seans['musteriTel']),
//               // Diğer verileri burada gösterebilirsiniz
//             );
//           },
//         );
//       },
//     );
//   }
// }





// ANA SAYFA YEDEK

// class AnaSayfa extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Seanslar"),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(
//                 Icons.add
//             ),
//             onPressed: () {
//               showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: Text("Rezervasyon Ekle"),
//                       backgroundColor: Colors.white.withOpacity(0.9),
//                       content: SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             const Text("Rezervasyon oluşturmak istediğiniz kullanıcının bilgilerini giriniz"),
//                             TextField(
//                               decoration: const InputDecoration(
//                                 hintText: "Telefon Numarası",
//                               ),
//                               onChanged: (value) {
//                               },
//                             ),
//                             ElevatedButton(
//                               onPressed: (){
//                               },
//                               child: Text("Seans Seç"),
//                             ),
//                           ],
//                         ),
//                       ),
//                       actions: [
//                         ElevatedButton(
//                             onPressed: (){
//                               Navigator.of(context).pop();
//                             },
//                             child: Text("Ekle")
//                         ),
//                       ],
//                     );
//                   }
//               );
//             },
//           ),
//         ],
//         leading: BackButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const BarberHomePage(),
//               ),
//             );
//           },
//         ),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
//         ),
//         backgroundColor: Colors.transparent,
//       ),
//       body: SeansListesi(),
//     );
//   }
// }