// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:kuaforv1/screens/profile_screens/change_profile_details.dart';
// import 'package:kuaforv1/screens/main_screens/home_screen.dart';
// import 'package:kuaforv1/screens/main_screens/my_reservations_screen.dart';
// import 'package:kuaforv1/services/auth.dart';
// import 'package:kuaforv1/widgets/profile_widget.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);
//
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   final auth = FirebaseAuth.instance;
//   String uMail = "";
//   String uName = "";
//   bool isDark = false; // Başlangıçta dark mode kapalı
//
//   void toggleDarkMode() {
//     setState(() {
//       isDark = !isDark;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     loadProfileDetails();
//   }
//
//   Future<void> loadProfileDetails() async {
//
//     var user = auth.currentUser;
//     var userMail = user?.email;
//     var col = FirebaseFirestore.instance.collection('users');
//     var doc = await col.doc(userMail).get();
//     setState(() {
//       uMail = userMail.toString();
//       uName = doc['name'];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: isDark ? ThemeData.dark() : ThemeData.light(),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text("Profil"),
//           centerTitle: true,
//           leading: BackButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const HomePage(),
//                 ),
//               );
//             },
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(
//                 isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
//                 color: isDark ? Colors.white : Colors.black,
//               ),
//               onPressed: toggleDarkMode,
//             ),
//           ],
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
//           ),
//           backgroundColor: Colors.transparent,
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.all(50),
//             child: Column(
//               children: [
//                 const Center(
//                   child: CircleAvatar(
//                     backgroundImage: AssetImage("images/profile.jpg"),
//                     radius: 70,
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 Text(
//                   uName.toLowerCase(),
//                   style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   uMail,
//                   style: const TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 GestureDetector(
//                   onTap: () {
//                     if(context.mounted) {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeProfileDetails()));
//                     }
//                   },
//                   child: Container(
//                     width: 150,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: Colors.black,
//                     ),
//                     child: const Center(
//                       child: Text(
//                         "Profili Düzenle",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 ProfileMenuWidget(
//                   title: "Hesabım",
//                   icon: Icons.person_outline,
//                   onPress: (){},
//                 ),
//                 ProfileMenuWidget(
//                   title: "Bildirimler",
//                   icon: LineAwesomeIcons.bell,
//                   onPress: (){},
//                 ),
//                 ProfileMenuWidget(
//                   title: "Rezervasyonlar",
//                   icon: Icons.list_alt,
//                   onPress: () async {
//                     FirebaseAuth auth = FirebaseAuth.instance;
//                     final User? user = auth.currentUser;
//                     final uMail = user?.email;
//                     String mail = uMail.toString();
//
//                     QuerySnapshot snapshot = await FirebaseFirestore.instance
//                         .collectionGroup("Seanslar")
//                         .where("musteriMail", isEqualTo: mail)
//                         .get();
//
//                     List<Map<String, dynamic>> selected = snapshot.docs
//                         .map<Map<String, dynamic>>(
//                             (doc) => doc.data() as Map<String, dynamic>)
//                         .toList();
//
//                     if (selected.isNotEmpty) {
//
//                       // Navigate to the screen that lists the reservations
//                       if(context.mounted){
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             // builder: (context) => MyReservationsPage(selected, (){}),
//                             builder: (context) =>
//                                 ReservationListScreen(reservations: selected),
//                           ),
//                         );
//                       }
//                     } else {
//                       // Show a message if no reservations are found
//                       if(context.mounted){
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: const Text("Rezervasyon Bulunamadı"),
//                               backgroundColor: Colors.white.withOpacity(0.9),
//                               content: const Text(
//                                   "Henüz bir rezervasyon yapmadınız."),
//                               actions: <Widget>[
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     backgroundColor: Colors.grey,
//                                   ),
//                                   child: const Text("Tamam"),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       }
//                     }
//                   },
//                 ),
//                 ProfileMenuWidget(
//                   title: "Ayarlar",
//                   icon: LineAwesomeIcons.cog,
//                   onPress: (){},
//                 ),
//                 ProfileMenuWidget(
//                   title: "Çıkış yap",
//                   icon: Icons.logout,
//                   onPress: (){
//                     // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
//                     AuthService().signOut(context);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//         // bottomNavigationBar: BottomBar(index: 0),
//       ),
//     );
//   }
// }

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuaforv1/screens/profile_screens/change_profile_details.dart';
import 'package:kuaforv1/screens/main_screens/home_screen.dart';
import 'package:kuaforv1/screens/main_screens/my_reservations_screen.dart';
import 'package:kuaforv1/services/auth.dart';
import 'package:kuaforv1/widgets/profile_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final auth = FirebaseAuth.instance;
  String uMail = "";
  String uName = "";
  bool isDark = false; // Başlangıçta dark mode kapalı
  bool positive = true;
  bool loading = false;
  String? token = "";

  void toggleDarkMode() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  void initState() {
    super.initState();
    loadProfileDetails();
    addDeviceToken();
  }

  Future<void> addDeviceToken() async {

    String? temp = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = temp;
    });
    var user = auth.currentUser;
    var userMail = user?.email;
    var col = FirebaseFirestore.instance.collection('users');
    var doc = await col.doc(userMail).get();
    doc.reference.update({
      'token': token,
    });
    // setState(() {
    //   uMail = userMail.toString();
    //   uName = doc['name'];
    // });
  }

  // Future<void> sendNotificationToUser(String userToken, String title, String body) async {
  //   final FirebaseMessaging _firebaseMessaging = await FirebaseMessaging.instance;
  //   try {
  //     await _firebaseMessaging.send(
  //       Message(
  //         notification: Notification(
  //           title: title,
  //           body: body,
  //         ),
  //         token: userToken, // Kullanıcının cihaz token'ı
  //       ),
  //     );
  //     print('Bildirim gönderildi: $title - $body');
  //   } catch (e) {
  //     print('Bildirim gönderme hatası: $e');
  //   }
  // }

  Future<void> removeDeviceToken() async {


    var user = auth.currentUser;
    var userMail = user?.email;
    var col = FirebaseFirestore.instance.collection('users');
    var doc = await col.doc(userMail).get();
    doc.reference.update({
      'token': "",
    });
  }

  Future<void> loadProfileDetails() async {

    var user = auth.currentUser;
    var userMail = user?.email;
    var col = FirebaseFirestore.instance.collection('users');
    var doc = await col.doc(userMail).get();
    setState(() {
      uMail = userMail.toString();
      uName = doc['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Profil"),
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
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
          child: Container(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                const Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/profile.jpg"),
                    radius: 70,
                  ),
                ),
                const SizedBox(height: 15),
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
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if(context.mounted) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeProfileDetails()));
                    }
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                    ),
                    child: const Center(
                      child: Text(
                        "Profili Düzenle",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ProfileMenuWidget(
                  title: "Hesabım",
                  icon: Icons.person_outline,
                  onPress: (){},
                ),
                ListTile(
                  onTap: () {},
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black.withOpacity(0.7),
                    ),
                    child: Icon(LineAwesomeIcons.bell, color: Colors.white),
                  ),
                  title: Text(
                    "Bildirimler",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  trailing: Container(
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: AnimatedToggleSwitch.dual(
                      current: positive,
                      first: false,
                      second: true,
                      spacing: 0,
                      style: const ToggleStyle(
                        borderColor: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1.5),
                          )
                        ],
                      ),
                      borderWidth: 5.0,
                      height: 55,
                      onChanged: (b) => setState(() => positive = b),
                      styleBuilder: (b) => ToggleStyle(
                        backgroundColor: b ? Colors.white : Colors.grey.withOpacity(0.1),
                        indicatorColor: b ? Colors.blue : Colors.grey,
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(50.0), right: Radius.circular(50.0)),
                        indicatorBorderRadius: BorderRadius.circular(b ? 50.0 : 50.0),
                      ),
                    ),
                  ),
                ),
                ProfileMenuWidget(
                  title: "Rezervasyonlar",
                  icon: Icons.list_alt,
                  onPress: () async {
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
                ),
                // ProfileMenuWidget(
                //   title: "Ayarlar",
                //   icon: LineAwesomeIcons.cog,
                //   onPress: (){},
                // ),
                ProfileMenuWidget(
                  title: "Çıkış yap",
                  icon: Icons.logout,
                  onPress: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    AuthService().signOut(context);
                  },
                ),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: BottomBar(index: 0),
      ),
    );
  }
}
