import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kuaforv1/screens/main_screens/home_screen.dart';
import 'package:kuaforv1/screens/main_screens/my_reservations_screen.dart';
import 'package:kuaforv1/screens/profile_screens/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BottomBar extends StatelessWidget {

  final int index;
  final VoidCallback onTap;
  const BottomBar({Key? key, required this.index, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      index: index,
      items: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                ),
            );
          },
          child: const Icon(
              Icons.person_outline,
              size: 30
          ),
        ),
        InkWell(
          onTap: onTap,
          child: const Icon(
              Icons.favorite_outline,
              size: 30
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
          },
          child: const Icon(
              Icons.home, size: 30,
              color: Colors.redAccent
          ),
        ),
        InkWell(
          onTap: () async {
            FirebaseAuth auth = FirebaseAuth.instance;
            final User? user = auth.currentUser;
            final uMail = user?.email;
            String mail = uMail.toString();

            QuerySnapshot snapshot = await FirebaseFirestore.instance
                .collectionGroup("Seanslar")
                .where("musteriMail", isEqualTo: mail)
                .get();

            List<Map<String, dynamic>> selected = snapshot.docs
                .map<Map<String, dynamic>>(
                    (doc) => doc.data() as Map<String, dynamic>)
                .toList();

            if (selected.isNotEmpty) {

              // Navigate to the screen that lists the reservations
              if(context.mounted){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => MyReservationsPage(selected, (){}),
                    builder: (context) =>
                        ReservationListScreen(reservations: selected),
                  ),
                );
              }
            } else {
              // Show a message if no reservations are found
              if(context.mounted){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Rezervasyon Bulunamadı"),
                      backgroundColor: Colors.white.withOpacity(0.9),
                      content: const Text(
                          "Henüz bir rezervasyon yapmadınız."),
                      actions: <Widget>[
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
                          child: const Text("Tamam"),
                        ),
                      ],
                    );
                  },
                );
              }
            }
          },
          child: const Icon(
              Icons.list,
              size: 30
          ),
        ),
        InkWell(
          onTap: () {
            // Scaffold.of(context).openDrawer();
            Scaffold.of(context).openEndDrawer();
          },
          child: const Icon(
              Icons.filter_alt_rounded,
              size: 30
          ),
        ),
      ]
    );
  }
}
