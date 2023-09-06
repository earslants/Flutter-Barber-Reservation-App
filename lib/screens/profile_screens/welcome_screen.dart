// import 'package:flutter/material.dart';
// import 'package:kuaforv1/screens/choose_auth_method.dart';
//
// class WelcomeScreen extends StatelessWidget{
//   const WelcomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     double h = height / 80;
//     return Container(
//       decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("images/barber.jpg"),
//             fit: BoxFit.cover,
//             opacity: 0.6,)),
//       child: Material(
//         color: Colors.transparent,
//         child: SafeArea(
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: h * 12, horizontal: 25),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Text(
//                       "Hoş Geldin",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 4 * h,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 1.5,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 8 * h),
//                   Container(
//                     width: 200,
//                     child: Text(
//                       "Çevrendeki kuaförleri keşfet ve kolayca randevu oluştur",
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(0.95),
//                         fontSize: 3 * h,
//                         letterSpacing: 1.2,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 3 * h),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => const ChooseAuth()
//                           ));
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Row(
//                         children: [
//                           InkWell(
//                             onTap: (){
//                               Navigator.push(context,
//                               MaterialPageRoute(builder: (context) => const ChooseAuth(),
//                               ));
//                             },
//                             child: Ink(
//                               padding: const EdgeInsets.all(15),
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(12)
//                               ),
//                               child: const Icon(
//                                 Icons.arrow_forward_ios,
//                                 color: Colors.black54,
//                                 size: 20,
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: width / 20),
//                           Text(
//                             "Hadi Başlayalım",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 3 * h,
//                               fontStyle: FontStyle.italic,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:kuaforv1/screens/auth_screens/choose_auth_method.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double h = height / 80;
    return WillPopScope(
      // WillPopScope'un onWillPop parametresi ile geri tuşunun işlevini kontrol edebilirsiniz.
      onWillPop: () async {
        // Geri tuşunu devre dışı bırakmak için true döndürün.
        // Geri tuşunu etkin bırakmak için false döndürün.
        return false; // Geri tuşunu devre dışı bırakıyoruz.
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/barber.jpg"),
            fit: BoxFit.cover,
            opacity: 0.6,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: h * 12, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Hoş Geldin",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 4 * h,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 8 * h),
                  SizedBox(
                    width: 200,
                    child: Text(
                      "Çevrendeki kuaförleri keşfet ve kolayca randevu oluştur",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.95),
                        fontSize: 3 * h,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(height: 3 * h),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChooseAuth()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ChooseAuth()),
                              );
                            },
                            child: Ink(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black54,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: width / 20),
                          Text(
                            "Hadi Başlayalım",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 3 * h,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
