// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:kuaforv1/screens/favorite_screen.dart';
// import 'package:kuaforv1/screens/reservation_screen.dart';
// import 'package:kuaforv1/widgets/bottom_bar.dart';
// import 'package:kuaforv1/widgets/filter_drawer.dart';
// import 'package:kuaforv1/widgets/top_screen/search_bar_widget.dart';
// import 'package:kuaforv1/widgets/top_screen/top_screen_widget.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   final _fireStore = FirebaseFirestore.instance;
//   FirebaseAuth auth = FirebaseAuth.instance;
//   List<Map<String, dynamic>> favorites = [];
//   List<String> favs = [];
//   bool isFavorite = true;
//
//   @override
//   void initState() {
//     super.initState();
//     loadFavoriteData();
//   }
//
//   Future<void> loadFavoriteData() async {
//     var user = auth.currentUser;
//     var userMail = user?.email;
//     var col = FirebaseFirestore.instance.collection('users');
//     var doc = await col.doc(userMail).get();
//     if(doc.exists) {
//       final List<dynamic> arrayData = doc.get('favoriler');
//       if(arrayData.isNotEmpty){
//         for (var item in arrayData) {
//           favs.add(item);
//         }
//       }
//     }
//     // final List<dynamic> arrayData = doc.get('favoriler');
//     // for(var item in arrayData) {
//     //   favs.add(item);
//     // }
//     if(favs.isEmpty) {
//       col.doc(userMail).set({
//         'favoriler': [],
//       }, SetOptions(merge: true));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     CollectionReference kuaforRef = _fireStore.collection("kuaforlist");
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     onTap(){}
//
//     return Scaffold(
//       endDrawer: FilterDrawer(),
//       body: Stack(
//         children: [
//           // SearchBar(),
//           SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TopScreenWidget(height: height, width: width),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 20, top: 20),
//                   child: Text(
//                     "Popüler",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 35,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: StreamBuilder(
//                         stream: FirebaseFirestore.instance
//                             .collection("kuaforlist")
//                             .snapshots(),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState == ConnectionState.waiting) {
//                             return const Center(child: CircularProgressIndicator());
//                           }
//
//                           if (snapshot.hasError) {
//                             return const Center(child: Text('Veriler alınamadı.'));
//                           }
//
//                           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                             return const Center(child: Text('Gösterilecek veri yok.'));
//                           }
//
//                           final documents = snapshot.data!.docs;
//
//                           return SizedBox(
//                             height: 200,
//                             child: ListView.builder(
//                                 itemCount: documents.length,
//                                 scrollDirection: Axis.horizontal,
//                                 shrinkWrap: true,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   DocumentSnapshot dcm = documents[index];
//                                   String kuaforName = dcm.id;
//                                   var favoritesCollection = dcm.reference.collection("Favoriler");
//                                   return InkWell(
//                                     onTap: () async {
//                                       var querySnapshot = await kuaforRef.where("id", isEqualTo: index.toString()).get();
//                                       var belge = querySnapshot.docs[0];
//                                       String d = belge.id;
//                                       if(context.mounted){
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => DbScreen(
//                                               col: "kuaforler",
//                                               doc: d,
//                                               col1: "seanslar",
//                                             ),
//                                           ),
//                                         );
//                                       }
//                                     },
//                                     child: Container(
//                                       width: 160,
//                                       padding: const EdgeInsets.all(20),
//                                       margin: const EdgeInsets.only(left: 15),
//                                       decoration: BoxDecoration(
//                                         color: Colors.black,
//                                         borderRadius: BorderRadius.circular(15),
//                                         image: const DecorationImage(
//                                           // image: AssetImage(documents[index]["image_path"]),
//                                           image: AssetImage("images/barber.jpg"),
//                                           fit: BoxFit.cover,
//                                           opacity: 0.7,
//                                         ),
//                                       ),
//                                       child: Column(
//                                         children: [
//                                           GestureDetector(
//                                             onTap: () async {
//                                               var user = auth.currentUser;
//                                               var userMail = user?.email;
//                                               var name = documents[index]['name'];
//                                               CollectionReference usersCollection = _fireStore.collection('users');
//                                               var usersDocuments = await usersCollection.doc(userMail).get();
//
//                                               if(favs.contains(name)){
//                                                 usersCollection.doc(userMail).update({
//                                                   'favoriler': FieldValue.arrayRemove([name]),
//                                                 });
//                                                 setState(() {
//                                                   favs.remove(name);
//                                                 });
//                                               }
//                                               else {
//                                                 usersCollection.doc(userMail).update({
//                                                   'favoriler': FieldValue.arrayUnion([name]),
//                                                 });
//                                                 setState(() {
//                                                   favs.add(name);
//                                                 });
//                                               }
//                                             },
//                                             child: AnimatedContainer(
//                                               duration: const Duration(milliseconds: 300),
//                                               alignment: Alignment.topRight,
//                                               child: Icon(
//                                                 favs.contains(documents[index]['name'])
//                                                     ? Icons.bookmark
//                                                     : Icons.bookmark_border_outlined,
//                                                 color: Colors.white,
//                                                 size: 30,
//                                               ),
//                                             ),
//                                           ),
//                                           const Spacer(),
//                                           Container(
//                                             alignment: Alignment.bottomLeft,
//                                             child: Text(
//                                               documents[index]["name"],
//                                               style: const TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 }
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 20, top: 20),
//                   child: Text(
//                     "Kuaförler",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 35,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//                 StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection("kuaforlist")
//                         .snapshots(),
//                     builder: (context, snapshot) {
//
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//
//                       if (snapshot.hasError) {
//                         return const Center(child: Text('Veriler alınamadı.'));
//                       }
//
//                       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                         return const Center(child: Text('Gösterilecek veri yok.'));
//                       }
//
//                       final documents = snapshot.data!.docs;
//
//                       return ListView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: documents.length,
//                         shrinkWrap: true,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Padding(
//                             padding: const EdgeInsets.all(15),
//                             child: Column(
//                               children: [
//                                 InkWell(
//                                   onTap: () async {
//                                     var querySnapshot = await kuaforRef.where("id", isEqualTo: index.toString()).get();
//                                     var belge = querySnapshot.docs[0];
//                                     String d = belge.id;
//                                     if(context.mounted) {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) => DbScreen(
//                                                 col: "kuaforler",
//                                                 doc: d,
//                                                 col1: "seanslar",
//                                               )));
//                                     }
//                                   },
//                                   child: Container(
//                                     height: 200,
//                                     decoration: BoxDecoration(
//                                       color: Colors.black,
//                                       borderRadius: BorderRadius.circular(15),
//                                       image: const DecorationImage(
//                                         // image: AssetImage(documents[index]["image_path"]),
//                                         image: AssetImage("images/barber.jpg"),
//                                         fit: BoxFit.cover,
//                                         opacity: 0.8,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 10),
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             documents[index]["name"],
//                                             style: const TextStyle(
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                           const Icon(
//                                             Icons.more_vert,
//                                             size: 30,
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Row(
//                                   children: [
//                                     const Icon(
//                                       Icons.star,
//                                       color: Colors.yellow,
//                                     ),
//                                     const SizedBox(width: 5),
//                                     Text(
//                                       documents[index]["star"],
//                                       style: const TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w300,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     }
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: SearchBarWidget(),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomBar(
//
//           onTap: () async {
//             if(favs.isNotEmpty) {
//               QuerySnapshot snap =
//                   await kuaforRef.where('name', whereIn: favs).get();
//               List<Map<String, dynamic>> favorites = snap.docs
//                   .map<Map<String, dynamic>>(
//                       (doc) => doc.data() as Map<String, dynamic>)
//                   .toList();
//               if (context.mounted) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => FavoritePage(favorites, onTap)),
//                 );
//               }
//             }
//             else {
//               print("Bu özelliği kullanabilmeniz için favorilere ekleme yapmanız gerekir");
//               showDialog(
//                 context: context, // BuildContext'i iletilmelidir.
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: const Text(
//                       "Uyarı",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     content: const Text("Bu özelliği kullanabilmeniz için favorilere ekleme yapmanız gerekir"),
//                     actions: <Widget>[
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                           backgroundColor: Colors.grey,
//                         ),
//                         child: const Text("Tamam"),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             }
//           },
//           index: 2
//       ),
//     );
//   }
// }

// Önceki Hali

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kuaforv1/screens/main_screens/details_screen.dart';
import 'package:kuaforv1/screens/main_screens/favorite_screen.dart';
import 'package:kuaforv1/screens/main_screens/reservation_screen.dart';
import 'package:kuaforv1/widgets/bottom_bar.dart';
import 'package:kuaforv1/widgets/filter_drawer.dart';
import 'package:kuaforv1/widgets/top_screen/top_screen_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> favorites = [];
  List<String> favs = [];
  List<double> stars = [];
  List<Map<String, dynamic>> barbers = [];
  List<Map<String, dynamic>> populars = [];
  bool isFavorite = true;

  @override
  void initState() {
    super.initState();
    loadFavoriteData();
    loadBarberData();
    updatePopularity();
    loadPopularData();
  }

  double calculateAverageStars(List<Map<String, dynamic>> barberDataList) {
    if (barberDataList.isEmpty) {
      return 0.0;
    }

    double totalStars = 0.0;
    int totalBarbers = 0;

    for (var barberData in barberDataList) {
      if (barberData.containsKey('stars') && barberData['stars'] is List<dynamic>) {
        List<dynamic> starsList = barberData['stars'];
        for (var star in starsList) {
          if (star is double) {
            totalStars += star;
            totalBarbers++;
          }
        }
      }
    }

    if (totalBarbers == 0) {
      return 0.0;
    }

    double averageStars = totalStars / totalBarbers;
    return averageStars;
  }


  Future<void> loadFavoriteData() async {
    var user = auth.currentUser;
    var userMail = user?.email;
    var col = FirebaseFirestore.instance.collection('users');
    var doc = await col.doc(userMail).get();
    if(doc.exists) {
      final List<dynamic> arrayData = doc.get('favoriler');
      if(arrayData.isNotEmpty){
        for (var item in arrayData) {
          favs.add(item);
        }
      }
    }
    // final List<dynamic> arrayData = doc.get('favoriler');
    // for(var item in arrayData) {
    //   favs.add(item);
    // }
    if(favs.isEmpty) {
      col.doc(userMail).set({
        'favoriler': [],
      }, SetOptions(merge: true));
    }
  }

  Future<void> loadPopularData() async {
    try {
      // Firestore koleksiyonunu ve sıralama kriterlerini belirleyin
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('kuaforlist')
          .orderBy('popularity', descending: true)
          .get();

      // Sıralanmış verileri populars listesine ekleyin
      populars = querySnapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        return data;
      }).toList();

      // Veri başarıyla yüklendi
    } catch (e) {
      // Hata yönetimi burada
      print('Hata oluştu: $e');
    }
    print(populars);
  }

  Future<void> updatePopularity() async {
    final CollectionReference kuaforCollection =
    FirebaseFirestore.instance.collection('kuaforlist');
    final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

    try {
      final QuerySnapshot kuaforSnapshot = await kuaforCollection.get();

      // Her kuaför için popülerlik hesapla ve güncelle
      for (QueryDocumentSnapshot kuaforDoc in kuaforSnapshot.docs) {
        final kuaforName = kuaforDoc.id;

        final QuerySnapshot usersSnapshot =
        await usersCollection.where('favoriler', arrayContains: kuaforName).get();

        final popularity = usersSnapshot.size;

        // Kuaför dokümanını güncelle
        await kuaforCollection.doc(kuaforName).update({
          'popularity': popularity,
        });
      }

      print('Popülerlik değerleri güncellendi.');
    } catch (e) {
      print('Popülerlik güncelleme hatası: $e');
    }
  }
  // Future<void> loadBarberData() async {
  //   try {
  //     final QuerySnapshot barberSnapshot = await FirebaseFirestore.instance
  //         .collection('kuaforlist')
  //         .get();
  //
  //     if (barberSnapshot.docs.isNotEmpty) {
  //       setState(() {
  //         barbers = barberSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  //       });
  //     }
  //   } catch (e) {
  //     // Hata durumunda gerekli işlemleri yapabilirsiniz.
  //     print('Kuaförler yüklenirken hata oluştu: $e');
  //   }
  // }
  Future<void> loadBarberData() async {
    try {
      // Firestore koleksiyonunu belge ID'sine göre sıralayarak verileri alın
      final QuerySnapshot barberSnapshot = await FirebaseFirestore.instance
          .collection('kuaforlist')
          .orderBy('id', descending: true) // Belge ID'sine göre sırala
          .get();

      if (barberSnapshot.docs.isNotEmpty) {
        setState(() {
          barbers = barberSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        });
      }
    } catch (e) {
      // Hata durumunda gerekli işlemleri yapabilirsiniz.
      print('Kuaförler yüklenirken hata oluştu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    CollectionReference kuaforRef = _fireStore.collection("kuaforlist");
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    onTap(){}

    return Scaffold(
      endDrawer: const FilterDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "Popüler",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                            itemCount: populars.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () async {
                                  if(context.mounted){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DbScreen(
                                          col: "kuaforler",
                                          doc: populars[index]['id'].toString(),
                                          col1: "seanslar",
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  width: 160,
                                  padding: const EdgeInsets.all(20),
                                  margin: const EdgeInsets.only(left: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(15),
                                    image: const DecorationImage(
                                      // image: AssetImage(documents[index]["image_path"]),
                                      image: AssetImage("images/barber.jpg"),
                                      fit: BoxFit.cover,
                                      opacity: 0.7,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          var userMail = auth.currentUser?.email;
                                          var id = populars[index]['id'];
                                          CollectionReference usersCollection = _fireStore.collection('users');
                                          if(favs.contains(id)) {
                                            usersCollection.doc(userMail).update({
                                              'favoriler': FieldValue.arrayRemove([id]),
                                            });
                                            setState(() {
                                              favs.remove(id);
                                            });
                                          }
                                          else {
                                            usersCollection.doc(userMail).update({
                                              'favoriler': FieldValue.arrayUnion([id]),
                                            });
                                            setState(() {
                                              favs.add(id);
                                            });
                                            // updatePopularity();
                                          }
                                          print(barbers);
                                          updatePopularity();
                                        },
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 300),
                                          alignment: Alignment.topRight,
                                          child: Icon(
                                            favs.contains(populars[index]['id'])
                                                ? Icons.bookmark
                                                : Icons.bookmark_border_outlined,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          // child: Icon(Icons.bookmark_border_outlined, color: Colors.white, size: 30),
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          populars[index]['name'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "Kuaförler",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: barbers.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              // var querySnapshot = await kuaforRef.where("id", isEqualTo: index.toString()).get();
                              // var belge = querySnapshot.docs[0];
                              // String d = belge.id;
                              if(context.mounted) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DbScreen(
                                          col: "kuaforler",
                                          doc: barbers[index]['id'].toString(),
                                          col1: "seanslar",
                                        )));
                              }
                            },
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
                                      barbers[index]["name"],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.more_vert,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          // Row(
                          //   children: [
                          //     const Icon(
                          //       Icons.star,
                          //       color: Colors.yellow,
                          //     ),
                          //     const SizedBox(width: 5),
                          //     Text(
                          //       barbers[index]["star"],
                          //       style: const TextStyle(
                          //         fontSize: 15,
                          //         fontWeight: FontWeight.w300,
                          //       ),
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),

      bottomNavigationBar: BottomBar(
          onTap: () async {
            if(favs.isNotEmpty) {
              QuerySnapshot snap =
              await kuaforRef.where('id', whereIn: favs).get();
              List<Map<String, dynamic>> favorites = snap.docs
                  .map<Map<String, dynamic>>(
                      (doc) => doc.data() as Map<String, dynamic>)
                  .toList();
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoritePage(favorites, onTap)),
                );
              }
            }
            else {
              showDialog(
                context: context, // BuildContext'i iletilmelidir.
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      "Uyarı",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    content: const Text("Bu özelliği kullanabilmeniz için favorilere ekleme yapmanız gerekir"),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.grey,
                        ),
                        child: const Text("Tamam"),
                      ),
                    ],
                  );
                },
              );
            }
          },
          index: 2
      ),
    );
  }
}






// return Scaffold(
//   endDrawer: FilterDrawer(),
//   body: Stack(
//     children: [
//       // SearchBar(),
//       SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TopScreenWidget(height: height, width: width),
//             const Padding(
//               padding: EdgeInsets.only(left: 20, top: 20),
//               child: Text(
//                 "Popüler",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 35,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 Expanded(
//                   child: StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection("kuaforlist")
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//
//                       if (snapshot.hasError) {
//                         return const Center(child: Text('Veriler alınamadı.'));
//                       }
//
//                       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                         return const Center(child: Text('Gösterilecek veri yok.'));
//                       }
//
//                       final documents = snapshot.data!.docs;
//
//                       return SizedBox(
//                         height: 200,
//                         child: ListView.builder(
//                             itemCount: documents.length,
//                             scrollDirection: Axis.horizontal,
//                             shrinkWrap: true,
//                             itemBuilder: (BuildContext context, int index) {
//                               DocumentSnapshot dcm = documents[index];
//                               String kuaforName = dcm.id;
//                               var favoritesCollection = dcm.reference.collection("Favoriler");
//                               return InkWell(
//                                 onTap: () async {
//                                   var querySnapshot = await kuaforRef.where("id", isEqualTo: index.toString()).get();
//                                   var belge = querySnapshot.docs[0];
//                                   String d = belge.id;
//                                   if(context.mounted){
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => DbScreen(
//                                           col: "kuaforler",
//                                           doc: d,
//                                           col1: "seanslar",
//                                         ),
//                                       ),
//                                     );
//                                   }
//                                 },
//                                 child: Container(
//                                   width: 160,
//                                   padding: const EdgeInsets.all(20),
//                                   margin: const EdgeInsets.only(left: 15),
//                                   decoration: BoxDecoration(
//                                     color: Colors.black,
//                                     borderRadius: BorderRadius.circular(15),
//                                     image: const DecorationImage(
//                                       // image: AssetImage(documents[index]["image_path"]),
//                                       image: AssetImage("images/barber.jpg"),
//                                       fit: BoxFit.cover,
//                                       opacity: 0.7,
//                                     ),
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () async {
//                                           var user = auth.currentUser;
//                                           var userMail = user?.email;
//                                           var name = documents[index]['name'];
//                                           CollectionReference usersCollection = _fireStore.collection('users');
//                                           var usersDocuments = await usersCollection.doc(userMail).get();
//
//                                           if(favs.contains(name)){
//                                             usersCollection.doc(userMail).update({
//                                               'favoriler': FieldValue.arrayRemove([name]),
//                                             });
//                                             setState(() {
//                                               favs.remove(name);
//                                             });
//                                           }
//                                           else {
//                                             usersCollection.doc(userMail).update({
//                                               'favoriler': FieldValue.arrayUnion([name]),
//                                             });
//                                             setState(() {
//                                               favs.add(name);
//                                             });
//                                           }
//                                         },
//                                         child: AnimatedContainer(
//                                           duration: const Duration(milliseconds: 300),
//                                           alignment: Alignment.topRight,
//                                           child: Icon(
//                                             favs.contains(documents[index]['name'])
//                                                 ? Icons.bookmark
//                                                 : Icons.bookmark_border_outlined,
//                                             color: Colors.white,
//                                             size: 30,
//                                           ),
//                                         ),
//                                       ),
//                                       const Spacer(),
//                                       Container(
//                                         alignment: Alignment.bottomLeft,
//                                         child: Text(
//                                           documents[index]["name"],
//                                           style: const TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const Padding(
//               padding: EdgeInsets.only(left: 20, top: 20),
//               child: Text(
//                 "Kuaförler",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 35,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//             StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection("kuaforlist")
//                     .snapshots(),
//                 builder: (context, snapshot) {
//
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//
//                   if (snapshot.hasError) {
//                     return const Center(child: Text('Veriler alınamadı.'));
//                   }
//
//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return const Center(child: Text('Gösterilecek veri yok.'));
//                   }
//
//                   final documents = snapshot.data!.docs;
//
//                   return ListView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: documents.length,
//                     shrinkWrap: true,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(15),
//                         child: Column(
//                           children: [
//                             InkWell(
//                               onTap: () async {
//                                 var querySnapshot = await kuaforRef.where("id", isEqualTo: index.toString()).get();
//                                 var belge = querySnapshot.docs[0];
//                                 String d = belge.id;
//                                 if(context.mounted) {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => DbScreen(
//                                             col: "kuaforler",
//                                             doc: d,
//                                             col1: "seanslar",
//                                           )));
//                                 }
//                               },
//                               child: Container(
//                                 height: 200,
//                                 decoration: BoxDecoration(
//                                   color: Colors.black,
//                                   borderRadius: BorderRadius.circular(15),
//                                   image: const DecorationImage(
//                                     // image: AssetImage(documents[index]["image_path"]),
//                                     image: AssetImage("images/barber.jpg"),
//                                     fit: BoxFit.cover,
//                                     opacity: 0.8,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 10),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         documents[index]["name"],
//                                         style: const TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       const Icon(
//                                         Icons.more_vert,
//                                         size: 30,
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 const Icon(
//                                   Icons.star,
//                                   color: Colors.yellow,
//                                 ),
//                                 const SizedBox(width: 5),
//                                 Text(
//                                   documents[index]["star"],
//                                   style: const TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w300,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 }
//             ),
//           ],
//         ),
//       ),
//       Positioned(
//         top: 0,
//         left: 0,
//         right: 0,
//         child: SearchBarWidget(),
//       ),
//     ],
//   ),
//   bottomNavigationBar: BottomBar(
//
//       onTap: () async {
//         if(favs.isNotEmpty) {
//           QuerySnapshot snap =
//           await kuaforRef.where('name', whereIn: favs).get();
//           List<Map<String, dynamic>> favorites = snap.docs
//               .map<Map<String, dynamic>>(
//                   (doc) => doc.data() as Map<String, dynamic>)
//               .toList();
//           if (context.mounted) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => FavoritePage(favorites, onTap)),
//             );
//           }
//         }
//         else {
//           print("Bu özelliği kullanabilmeniz için favorilere ekleme yapmanız gerekir");
//           showDialog(
//             context: context, // BuildContext'i iletilmelidir.
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: const Text(
//                   "Uyarı",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 content: const Text("Bu özelliği kullanabilmeniz için favorilere ekleme yapmanız gerekir"),
//                 actions: <Widget>[
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                       backgroundColor: Colors.grey,
//                     ),
//                     child: const Text("Tamam"),
//                   ),
//                 ],
//               );
//             },
//           );
//         }
//       },
//       index: 2
//   ),
// );