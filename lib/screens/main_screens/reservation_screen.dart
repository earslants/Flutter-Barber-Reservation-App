// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:kuaforv1/widgets/bottom_bar.dart';
// import 'package:kuaforv1/widgets/top_screen/top_screen_widget.dart';
//
// class DbScreen extends StatelessWidget {
//
//   final String col;
//   final String doc;
//   final String col1;
//
//   const DbScreen({Key? key, required this.col, required this.doc, required this.col1}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Firestore Verileri',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: FirestoreDataScreen(col: col, doc: doc, col1: col1),
//     );
//   }
// }
//
// class FirestoreDataScreen extends StatelessWidget {
//
//   final String col;
//   final String doc;
//   final String col1;
//
//   const FirestoreDataScreen({super.key, required this.col, required this.doc, required this.col1});
//
//   @override
//   Widget build(BuildContext context) {
//
//     double height = MediaQuery.of(context).size.height * 0.8;
//     double width = MediaQuery.of(context).size.width;
//     final FirebaseAuth auth = FirebaseAuth.instance;
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection("kuaforlist")
//             .doc(doc)
//             .collection("Seanslar")
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return const Center(child: Text('Veriler alınamadı.'));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('Gösterilecek veri yok.'));
//           }
//
//           final documents = snapshot.data!.docs;
//
//           return Stack(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TopScreenWidget(height: height, width: width),
//                   const Padding(
//                     padding: EdgeInsets.only(left: 20, top: 20),
//                     child: Text(
//                       "Rezervasyon",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 35,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   getResData(documents, auth),
//                   const SizedBox(height: 20),
//                   Center(
//                     child: Container(
//                       height: height * 0.125,
//                       width: width * 0.3,
//                       decoration: BoxDecoration(
//                         color: Colors.grey.withOpacity(0.6),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: InkWell(
//                         onTap: () {
//
//                         },
//                         child: Column(
//                           children: [
//                             Icon(
//                               Icons.star_border,
//                               size: width * 0.15,
//                               color: Colors.black,
//                             ),
//                             Text(
//                               "Puanla",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               const Positioned(
//                 top: 0,
//                 left: 0,
//                 right: 0,
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 30),
//                   child: Center(
//                     child: Text(
//                       "Rezervasyon",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 35,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//       // bottomNavigationBar: const BottomBar(index: 1, onTap: {}),
//     );
//   }
//
//   Container getResData(List<QueryDocumentSnapshot<Map<String, dynamic>>> documents, FirebaseAuth auth) {
//     return Container(
//       decoration: const BoxDecoration(),
//       height: 200,
//       child: ListView.builder(
//         itemCount: documents.length,
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           final data = documents[index].data() as Map<String, dynamic>;
//           final timestamp = data["tarih"] as Timestamp;
//
//           final dateTime = timestamp.toDate();
//
//           final formattedDate =
//           DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
//
//           return Container(
//             width: 160,
//             padding: const EdgeInsets.all(20),
//             margin: const EdgeInsets.only(left: 15),
//             decoration: BoxDecoration(
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.circular(30),
//                 image: const DecorationImage(
//                   image: AssetImage("images/barber.jpg"),
//                   fit: BoxFit.cover,
//                 )
//             ),
//             child: ListTile(
//               title: Column(
//                 children: [
//                   // Text('Seans Saati: $formattedDate' + '\nDurum: ${data["status"] ? "Müsait" : "Dolu"}'),
//                   Text(
//                     formattedDate,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 80),
//                   data["status"] ?
//                   buildGestureDetector(context, formattedDate, auth, documents, index) :
//                   Container(
//                     height: 30,
//                     width: 100,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Colors.white.withOpacity(0.7),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         "Dolu",
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//   GestureDetector buildGestureDetector(BuildContext context, String formattedDate, FirebaseAuth auth, List<QueryDocumentSnapshot<Map<String, dynamic>>> documents, int index) {
//     return GestureDetector(
//       onTap: () async {
//         final User? user = auth.currentUser;
//         final uMail = user?.email;
//         String mail = uMail.toString();
//
//         // Check if the user has already made a reservation
//         final existingReservation = await FirebaseFirestore.instance
//             .collectionGroup("Seanslar")
//             .where("musteriMail", isEqualTo: mail)
//             .get();
//
//           if (existingReservation.docs.isNotEmpty) {
//             if(context.mounted){
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: const Text("Zaten Rezervasyon Yaptınız"),
//                   backgroundColor: Colors.white.withOpacity(0.9),
//                   content: const Text("Sadece 1 rezervasyon yapabilirsiniz."),
//                   actions: <Widget>[
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         backgroundColor: Colors.grey,
//                       ),
//                       child: const Text("Tamam"),
//                     ),
//                   ],
//                 );
//               },
//             );
//           }
//         }
//         else {
//             if(context.mounted){
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 // ... The rest of your existing code for creating the AlertDialog
//                 return AlertDialog(
//                   title: const Text("Devam etmek istiyor musun ?"),
//                   backgroundColor: Colors.white.withOpacity(0.9),
//                   content: Text(
//                       "$formattedDate tarihine rezervasyon işleminize devam etmek istiyor musunuz ?"),
//                   actions: <Widget>[
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         backgroundColor: Colors.grey,
//                       ),
//                       child: const Text("Hayır"),
//                     ),
//                     ElevatedButton(
//                       onPressed: () async {
//                         // Navigator.of(context).pop();
//                         final User? user = auth.currentUser;
//                         final uMail = user?.email;
//                         final uPhone = user?.phoneNumber;
//                         String mail = uMail.toString();
//                         if (uPhone.toString() == "null") {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               String enteredPhoneNumber = '';
//
//                               return AlertDialog(
//                                 title: const Text("Telefon Numarası Girişi"),
//                                 backgroundColor: Colors.white.withOpacity(0.9),
//                                 content: SingleChildScrollView(
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       const Text(
//                                           "Lütfen telefon numaranızı giriniz:"),
//                                       TextField(
//                                         decoration: const InputDecoration(
//                                           hintText: "+90-5xx-xxx-xxxx",
//                                         ),
//                                         onChanged: (value) {
//                                           enteredPhoneNumber = value;
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 actions: [
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10)),
//                                       backgroundColor: Colors.grey,
//                                     ),
//                                     child: const Text("İptal"),
//                                   ),
//                                   ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10)),
//                                       backgroundColor: Colors.grey,
//                                     ),
//                                     onPressed: () async {
//                                       if (enteredPhoneNumber.isNotEmpty) {
//                                         await FirebaseFirestore.instance
//                                             .collection("kuaforlist")
//                                             .doc(doc)
//                                             .collection("Seanslar")
//                                             .doc(documents[index].id)
//                                             .update({
//                                           "status": false,
//                                           "musteriMail": uMail,
//                                           "musteriTel": enteredPhoneNumber,
//                                         });
//                                         if (context.mounted) {
//                                           Navigator.of(context).pop();
//                                         } // Close current dialog
//                                         if (context.mounted) {
//                                           Navigator.of(context).pop();
//                                         } // Close previous dialog
//                                       }
//                                     },
//                                     child: const Text("Kaydet"),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         } else {
//                           await FirebaseFirestore.instance
//                               .collection("kuaforlist")
//                               .doc(doc)
//                               .collection("Seanslar")
//                               .doc(documents[index].id)
//                               .update({
//                             "status": false,
//                             "musteriMail": mail,
//                             "musteriTel": uPhone.toString(),
//                           });
//                           if (context.mounted) {
//                             Navigator.of(context).pop();
//                           }
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         backgroundColor: Colors.grey,
//                       ),
//                       child: const Text("Evet"),
//                     ),
//                   ],
//                 );
//               },
//             );
//           }
//         }
//       },
//       child: Container(
//         height: 30,
//         width: 100,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30),
//           color: Colors.white.withOpacity(0.7),
//         ),
//         child: const Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Seç",
//             ),
//             Icon(Icons.chevron_right),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kuaforv1/widgets/rating_dialog.dart';
import 'package:kuaforv1/widgets/top_screen/top_screen_widget.dart';
import 'package:kuaforv1/screens/main_screens/details_screen.dart';

class DbScreen extends StatelessWidget {

  final String col;
  final String doc;
  final String col1;

  const DbScreen({Key? key, required this.col, required this.doc, required this.col1}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firestore Verileri',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirestoreDataScreen(col: col, doc: doc, col1: col1),
    );
  }
}

class FirestoreDataScreen extends StatelessWidget {

  final String col;
  final String doc;
  final String col1;

  const FirestoreDataScreen({super.key, required this.col, required this.doc, required this.col1});

  Future<void> addStarsToFirestore(double stars, String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection("kuaforlist")
          .doc(docId) // Kuaför dokümanının ID'si
          .update({"stars": FieldValue.arrayUnion([stars])});
    } catch (e) {
      // Hata yönetimi
      print("Hata: $e");
    }
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height * 0.8;
    double width = MediaQuery.of(context).size.width;
    final FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("kuaforlist")
            .doc(doc)
            .collection("Seanslar")
            .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Veriler alınamadı.'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Gösterilecek veri yok.'));
          }

          final documents = snapshot.data!.docs;

          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopScreenWidget(
                    height: height,
                    width: width,
                    buttonText: "Fiyatlar",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage()));
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      "Rezervasyon",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  getResData(documents, auth),
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      height: height * 0.125,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () async {
                          double selectedStars = await showDialog(
                            context: context,
                            builder: (context) => const RatingDialog(), // Pop-up yıldız seçme ekranını burada kullanın.
                          );
                          if (selectedStars != null) {
                            // Kullanıcı yıldızları seçti.
                            addStarsToFirestore(selectedStars, doc); // doc: Kuaförün ID'si
                          }
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.star_border,
                              size: width * 0.15,
                              color: Colors.black,
                            ),
                            const Text(
                              "Puanla",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                    child: Text(
                      "Rezervasyon",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      // bottomNavigationBar: const BottomBar(index: 1, onTap: {}),
    );
  }

  Container getResData(List<QueryDocumentSnapshot<Map<String, dynamic>>> documents, FirebaseAuth auth) {
    return Container(
      decoration: const BoxDecoration(),
      height: 200,
      child: ListView.builder(
        itemCount: documents.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final data = documents[index].data() as Map<String, dynamic>;
          final timestamp = data["tarih"] as Timestamp;

          final dateTime = timestamp.toDate();

          final formattedDate =
          DateFormat('dd.MM.yyyy HH:mm').format(dateTime);

          return Container(
            width: 160,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
                image: const DecorationImage(
                  image: AssetImage("images/barber.jpg"),
                  fit: BoxFit.cover,
                )
            ),
            child: ListTile(
              title: Column(
                children: [
                  // Text('Seans Saati: $formattedDate' + '\nDurum: ${data["status"] ? "Müsait" : "Dolu"}'),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 80),
                  data["status"] ?
                  buildGestureDetector(context, formattedDate, auth, documents, index) :
                  Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white.withOpacity(0.7),
                    ),
                    child: const Center(
                      child: Text(
                        "Dolu",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  GestureDetector buildGestureDetector(BuildContext context, String formattedDate, FirebaseAuth auth, List<QueryDocumentSnapshot<Map<String, dynamic>>> documents, int index) {
    return GestureDetector(
      onTap: () async {
        final User? user = auth.currentUser;
        final uMail = user?.email;
        String mail = uMail.toString();

        // Check if the user has already made a reservation
        final existingReservation = await FirebaseFirestore.instance
            .collectionGroup("Seanslar")
            .where("musteriMail", isEqualTo: mail)
            .get();

        if (existingReservation.docs.isNotEmpty) {
          if(context.mounted){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Zaten Rezervasyon Yaptınız"),
                  backgroundColor: Colors.white.withOpacity(0.9),
                  content: const Text("Sadece 1 rezervasyon yapabilirsiniz."),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text("Tamam"),
                    ),
                  ],
                );
              },
            );
          }
        }
        else {
          if(context.mounted){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // ... The rest of your existing code for creating the AlertDialog
                return AlertDialog(
                  title: const Text("Devam etmek istiyor musun ?"),
                  backgroundColor: Colors.white.withOpacity(0.9),
                  content: Text(
                      "$formattedDate tarihine rezervasyon işleminize devam etmek istiyor musunuz ?"),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text("Hayır"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Navigator.of(context).pop();
                        final User? user = auth.currentUser;
                        final uMail = user?.email;
                        final uPhone = user?.phoneNumber;
                        String mail = uMail.toString();
                        if (uPhone.toString() == "null") {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              String enteredPhoneNumber = '';

                              return AlertDialog(
                                title: const Text("Telefon Numarası Girişi"),
                                backgroundColor: Colors.white.withOpacity(0.9),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                          "Lütfen telefon numaranızı giriniz:"),
                                      TextField(
                                        decoration: const InputDecoration(
                                          hintText: "+90-5xx-xxx-xxxx",
                                        ),
                                        onChanged: (value) {
                                          enteredPhoneNumber = value;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      backgroundColor: Colors.grey,
                                    ),
                                    child: const Text("İptal"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      backgroundColor: Colors.grey,
                                    ),
                                    onPressed: () async {
                                      if (enteredPhoneNumber.isNotEmpty) {
                                        await FirebaseFirestore.instance
                                            .collection("kuaforlist")
                                            .doc(doc)
                                            .collection("Seanslar")
                                            .doc(documents[index].id)
                                            .update({
                                          "status": false,
                                          "musteriMail": uMail,
                                          "musteriTel": enteredPhoneNumber,
                                        });
                                        if (context.mounted) {
                                          Navigator.of(context).pop();
                                        } // Close current dialog
                                        if (context.mounted) {
                                          Navigator.of(context).pop();
                                        } // Close previous dialog
                                      }
                                    },
                                    child: const Text("Kaydet"),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          await FirebaseFirestore.instance
                              .collection("kuaforlist")
                              .doc(doc)
                              .collection("Seanslar")
                              .doc(documents[index].id)
                              .update({
                            "status": false,
                            "musteriMail": mail,
                            "musteriTel": uPhone.toString(),
                          });
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text("Evet"),
                    ),
                  ],
                );
              },
            );
          }
        }
      },
      child: Container(
        height: 30,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white.withOpacity(0.7),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Seç",
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
