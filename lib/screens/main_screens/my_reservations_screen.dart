import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kuaforv1/screens/profile_screens/user_profile.dart';

class ReservationListScreen extends StatefulWidget {

  final List<Map<String, dynamic>> reservations;

  const ReservationListScreen({Key? key, required this.reservations}) : super(key: key);

  @override
  State<ReservationListScreen> createState() => _ReservationListScreenState();
}

class _ReservationListScreenState extends State<ReservationListScreen> {
  List<Map<String, dynamic>> kuafor = [];

  @override
  void initState() {
    super.initState();
    loadKuaforList();
  }

  Future<void> loadKuaforList() async {
    for (var reservation in widget.reservations) {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collectionGroup("kuaforlist")
          .where('id', isEqualTo: reservation['kuaforId'])
          .get();

      kuafor.addAll(snap.docs.map<Map<String, dynamic>>(
            (doc) => doc.data() as Map<String, dynamic>,
      ));
    }

    setState(() {}); // Yükleme tamamlandığında yeniden oluşturmayı tetikle
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView.builder(
        itemCount: widget.reservations.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var timestamp = widget.reservations[index]["tarih"] as Timestamp;
          var dateTime = timestamp.toDate();
          var formattedDate = DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
                child: Text(
                  "Rezervasyonlarım",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  bool shouldCancel = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white.withOpacity(0.9),
                        title: const Text("Rezervasyonu İptal Et"),
                        content: const Text("Rezervasyonu iptal etmek istediğinize emin misiniz?"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              backgroundColor: Colors.grey,
                            ),
                            child: const Text("Hayır"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              backgroundColor: Colors.grey,
                            ),
                            child: const Text("Evet"),
                          ),
                        ],
                      );
                    },
                  );

                  if (shouldCancel == true) {
                    try {
                      QuerySnapshot snapshot = await FirebaseFirestore.instance
                          .collectionGroup('Seanslar')
                          .where('kuaforId', isEqualTo: kuafor[0]["id"])
                          .get();

                      for (QueryDocumentSnapshot doc in snapshot.docs) {
                        // Belge içerisindeki musteriMail, musteriTel ve status değerlerini güncelle
                        await doc.reference.update({
                          'musteriMail': "",
                          'musteriTel': "",
                          'status': true,
                        });
                      }
                      if(context.mounted) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const ProfilePage()));
                      }
                    } catch(e) {
                      print("Hata: $e");
                    }
                  }
                },
                child: Container(
                  height: height / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      //ToDO
                      // STORAGE'DAN BERBER RESMİ ALINACAK.
                      image: kuafor.isNotEmpty ? const AssetImage('images/barber.jpg') : const AssetImage('images/hd.jpg'),
                      fit: BoxFit.cover,
                      opacity: 0.7,
                    )
                  ),
                  child: Center(
                    child: ListTile(
                      title: Text(
                          "Tarih: $formattedDate",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                          )
                      ),
                      subtitle: kuafor.isNotEmpty ? Text(
                        "Kuaför: ${kuafor[index]['name']}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      )
                          : const Text("Kuaför: Bilinmiyor"),
                      // Diğer alanları ihtiyaca göre ekleyebilirsiniz
                    ),
                  ),
                ),
              ),
            ],
          );

          // return ListTile(
          //   onTap: () async {
          //     try {
          //       QuerySnapshot snapshot = await FirebaseFirestore.instance
          //           .collectionGroup('Seanslar')
          //           .where('kuaforId', isEqualTo: kuafor[index]["id"])
          //           .get();
          //
          //       for (QueryDocumentSnapshot doc in snapshot.docs) {
          //         // Belge içerisindeki musteriMail ve musteriTel değerlerini güncelle
          //         await doc.reference.update({
          //           'musteriMail': "",
          //           'musteriTel': "",
          //           'status': true,
          //         });
          //       }
          //       Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
          //     } catch(e) {
          //       print("Hata: ${e}");
          //     }
          //   },
          //   title: Text("Saat: ${formattedDate}"),
          //   subtitle: kuafor.isNotEmpty
          //       ? Text("Kuaför: ${kuafor[index]['name']}")
          //       : Text("Kuaför: Bilinmiyor"),
          //   // Add more fields as needed
          // );
        },
      ),
    );
  }
}
