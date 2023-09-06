import 'package:flutter/material.dart';


class SearchBarWidget extends StatelessWidget {

  SearchBarWidget({
    super.key,
  });

  final List<Map<String, dynamic>> _allPlaces = [
    {"id" : "0","image_path": "images/barber.jpg", "Favoriler": "False", "name": "Ahmet", "star": "4.0"},
    {"id" : "1","image_path": "images/barbershop.jpg", "Favoriler": "False", "name": "Başak", "star": "4.2"},
    {"id" : "2","image_path": "images/barber_shop.jpg", "Favoriler": "False", "name": "Şafak", "star": "2.8"},
    {"id" : "3","image_path": "images/hd.jpg", "Favoriler": "False", "name": "Moda 1", "star": "4.5"},
    {"id" : "4","image_path": "images/space.jpg", "Favoriler": "False", "name": "Moda 2", "star": "4.7"},
    {"id" : "5","image_path": "images/space2.jpg", "Favoriler": "False", "name": "Deniz", "star": "3.6"},
    {"id" : "6","image_path": "images/space3.jpg", "Favoriler": "False", "name": "Ali", "star": "3.8"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white.withOpacity(0.7),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.search,
                    size: 20,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        // List<Map<String, dynamic>> filteredData = _allPlaces.where((name) => name["name"].toString().toLowerCase().contains(value.toLowerCase())).toList();
                        // print(filteredData);
                        List<Map<String, dynamic>> filteredData = _allPlaces.where((name) => name["name"].toString().toLowerCase().contains(value.toLowerCase())).toList();
                        List filteredNames = filteredData.map((item) => item["name"]).toList();
                      },
                      decoration: InputDecoration(
                        hintText: "ara",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
