// import 'package:flutter/material.dart';
//
// class FilterDrawer extends StatelessWidget {
//   const FilterDrawer({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           UserAccountsDrawerHeader(
//               accountName: const Text("Emirhan Arslantaş"),
//               accountEmail: const Text("emirhan.arslantas@outlook.com"),
//             currentAccountPicture: CircleAvatar(
//               child: ClipOval(
//                 child: Image.asset("images/profile.jpg"),
//               ),
//             ),
//             decoration: BoxDecoration(
//               color: Colors.blueAccent,
//               image: DecorationImage(
//                 image: AssetImage("images/hd.jpg"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.arrow_downward),
//             title: const Text('Giriş Yap'),
//             onTap: (){},
//           ),
//           ListTile(
//             leading: const Icon(Icons.map),
//             title: const Text('Konum'),
//             onTap: (){},
//           ),
//           ListTile(
//             leading: const Icon(Icons.travel_explore_outlined),
//             title: const Text('Gezi Oluştur'),
//             onTap: (){},
//           ),
//           ListTile(
//             leading: const Icon(Icons.settings),
//             title: const Text('Ayarlar'),
//             onTap: (){},
//           ),
//           ListTile(
//             leading: const Icon(Icons.logout),
//             title: const Text('Çıkış Yap'),
//             onTap: (){},
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kuaforv1/screens/main_screens/filtered_screen.dart';
import 'package:kuaforv1/screens/main_screens/home_screen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({super.key});

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  List<String> cities = ['istanbul', 'ankara', 'izmir', 'adana', 'konya', 'hatay', 'antalya'];
  List<String> selectedCities = [];
  List<String> stars = ['1 yıldız ve üzeri', '2 yıldız ve üzeri', '3 yıldız ve üzeri', '4 yıldız ve üzeri'];
  List<bool> cityCheckboxValues = [false, false, false, false, false, false, false];
  List<bool> starCheckboxValues = [false, false, false, false];
  List<String> filteredCities = [];
  double _selectedMinPrice = 0;
  double _selectedMaxPrice = 100;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Emirhan Arslantaş"),
            accountEmail: const Text("emirhan.arslantas@outlook.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("images/profile.jpg"),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              image: DecorationImage(
                image: AssetImage("images/hd.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              'Filtreler',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            // trailing: Icon(Icons.keyboard_arrow_down),
          ),
          ExpansionTile(
            leading: const Icon(LineAwesomeIcons.city),
            title: const Text('Şehir'),
            children: [
              Column(
                children: List.generate(cities.length, (index) {
                  return CheckboxListTile(
                    title: Text(cities[index]),
                    value: cityCheckboxValues[index],
                    onChanged: (newValue) {
                      setState(() {
                        cityCheckboxValues[index] = newValue!;
                      });
                      if(cityCheckboxValues[index]) {
                        setState(() {
                          // selectedCities.add(cities[index]);
                          if(!selectedCities.contains(cities[index])) {
                            selectedCities.add(cities[index]);
                          }
                        });
                      }
                      else if(!cityCheckboxValues[index]) {
                        if(selectedCities.contains(cities[index])) {
                          selectedCities.remove(cities[index]);
                        }
                      }
                    },
                  );
                }),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(LineAwesomeIcons.money_bill),
            title: const Text('Fiyat Aralığı'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    RangeSlider(
                      activeColor: Colors.blueAccent,
                      inactiveColor: Colors.grey,
                      values: RangeValues(_selectedMinPrice, _selectedMaxPrice),
                      min: 0,
                      max: 300,
                      divisions: 60,
                      onChanged: (RangeValues values) {
                        setState(() {
                          _selectedMinPrice = values.start;
                          _selectedMaxPrice = values.end;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Min: ${_selectedMinPrice.toStringAsFixed(2)}'),
                        Text('Max: ${_selectedMaxPrice.toStringAsFixed(2)}'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          ListTile(
            title: const Text(
              'Filtreleri Sıfırla',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              setState(() {
                for(int i = 0; i < cityCheckboxValues.length; i++) {
                  cityCheckboxValues[i] = false;
                }
                _selectedMinPrice = 0;
                _selectedMaxPrice = 300;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: GestureDetector(
              onTap: () async {
                if(selectedCities.isNotEmpty) {
                  try {
                    QuerySnapshot snapshot = await FirebaseFirestore.instance
                        .collection("kuaforlist")
                        .where("fiyat", isLessThan: _selectedMaxPrice)
                        .where("fiyat", isGreaterThan: _selectedMinPrice)
                        .where("city", whereIn: selectedCities)
                        .get();

                    List<Map<String, dynamic>> selected = snapshot.docs
                        .map<Map<String, dynamic>>(
                            (doc) => doc.data() as Map<String, dynamic>)
                        .toList();
                    if (context.mounted) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FilteredPage(selected, () {})));
                    }
                  } catch (e) {
                    print('Hata: $e');
                  }
                }
                else if(selectedCities.isEmpty) {
                  try {
                    QuerySnapshot snapshot = await FirebaseFirestore.instance
                        .collection("kuaforlist")
                        .where("fiyat", isLessThan: _selectedMaxPrice)
                        .where("fiyat", isGreaterThan: _selectedMinPrice)
                        .get();

                    List<Map<String, dynamic>> selected = snapshot.docs
                        .map<Map<String, dynamic>>(
                            (doc) => doc.data() as Map<String, dynamic>)
                        .toList();
                    print(selected);
                    if (context.mounted) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FilteredPage(selected, () {})));
                    }
                  } catch (e) {
                    print(e);
                  }
                }
                else {
                  if (context.mounted) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                  }
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Filtreyi Uygula",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,

                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  List<String> filterCities(String filterText) {

    return cities.where((city) =>
        city.toLowerCase().contains(filterText.toLowerCase())).toList();
  }
}