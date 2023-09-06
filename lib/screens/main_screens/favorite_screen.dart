import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kuaforv1/screens/main_screens/reservation_screen.dart';
import 'package:kuaforv1/widgets/bottom_bar.dart';

class FavoritePage extends StatelessWidget {

  final VoidCallback onTap;
  final List<Map<String, dynamic>> favoriteData;
  final _fireStore = FirebaseFirestore.instance;

  FavoritePage(this.favoriteData, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference kuaforRef = _fireStore.collection("kuaforlist");

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TopScreenWidget(height: height, width: width),
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "Favoriler",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // const SizedBox(height: 20),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: favoriteData.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    // final place = favoriteData[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              // BURASI DÜZELECEK
                              // ToDO
                              var querySnapshot = await kuaforRef.where("id", isEqualTo: index.toString()).get();
                              var belge = querySnapshot.docs[0];
                              String d = belge.id;
                              if(context.mounted) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DbScreen(
                                              col: "kuaforler",
                                              doc: d,
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
                                  // image: AssetImage(favoriteData[index]["image_path"]),
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
                                      favoriteData[index]["name"],
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
                          //       favoriteData[index]["star"],
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
          ),
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   child: SearchBarWidget(),
          // )
        ],
      ),
      bottomNavigationBar: BottomBar(index: 1, onTap: onTap),
    );
  }
}
