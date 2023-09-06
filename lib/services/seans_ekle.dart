import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seans Ekleme',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SeansEklemeScreen(),
    );
  }
}

class SeansEklemeScreen extends StatefulWidget {
  const SeansEklemeScreen({super.key});

  @override
  _SeansEklemeScreenState createState() => _SeansEklemeScreenState();
}

class _SeansEklemeScreenState extends State<SeansEklemeScreen> {
  final List<String> kuaforler = ['kuafor1', 'kuafor2', 'kuafor3', 'kuafor4', 'kuafor5', 'kuafor6', 'kuafor7', 'kuafor8']; // Kuafor isimleri
  final int seansAdet = 13;
  final DateTime baslangicTarihi = DateTime(2023, 8, 28, 9, 0, 0);
  final int saatAraligiDakika = 30;

  Future<void> seanslariEkle() async {
    final CollectionReference seanslarCollection =
    FirebaseFirestore.instance.collection('kuaforlist');

    for (String kuafor in kuaforler) {
      for (int i = 0; i < seansAdet; i++) {
        final DateTime seansTarihi =
        baslangicTarihi.add(Duration(minutes: i * saatAraligiDakika));
        final String seansId =
            'seans${i + 1}_${seansTarihi.month}${seansTarihi.day}${seansTarihi.year}';

        await seanslarCollection.doc(kuafor).collection('Seanslar').doc(seansId).set({
          'tarih': seansTarihi,
          'saat': '${seansTarihi.hour.toString().padLeft(2, '0')}:${seansTarihi.minute.toString().padLeft(2, '0')}:${seansTarihi.second.toString().padLeft(2, '0')}',
          'status': true,
        });
      }
    }

    print('Seanslar eklendi.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seans Ekleme'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: seanslariEkle,
          child: const Text('Seansları Ekle'),
        ),
      ),
    );
  }
}
