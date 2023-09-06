import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuaforv1/screens/barber_screens/barber_home_screen.dart';

class CreateSeansPage extends StatefulWidget {
  const CreateSeansPage({super.key});

  @override
  _CreateSeansPageState createState() => _CreateSeansPageState();
}

class _CreateSeansPageState extends State<CreateSeansPage> {
  TimeOfDay? _openTime;
  TimeOfDay? _closeTime;
  final TextEditingController _tOpenTime = TextEditingController();
  final TextEditingController _tCloseTime = TextEditingController();
  final TextEditingController _tSeansTime = TextEditingController();

  @override
  void dispose() {
    _tOpenTime.dispose();
    _tCloseTime.dispose();
    _tSeansTime.dispose();
    super.dispose();
  }

  void _showTimePicker(TextEditingController controller) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: controller == _tOpenTime
          ? (_openTime ?? const TimeOfDay(hour: 8, minute: 30))
          : (_closeTime ?? const TimeOfDay(hour: 17, minute: 30)),
    );

    if (selectedTime != null) {
      setState(() {
        if (controller == _tOpenTime) {
          _openTime = selectedTime;
          _tOpenTime.text = _openTime!.format(context);
        } else if (controller == _tCloseTime) {
          _closeTime = selectedTime;
          _tCloseTime.text = _closeTime!.format(context);
        }
      });
    }
  }

  void _createSeans() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (_openTime != null && _closeTime != null) {
      final int sessionDuration = int.tryParse(_tSeansTime.text) ?? 60;

      DateTime currentSessionTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        _openTime!.hour,
        _openTime!.minute,
      );

      final DateTime closingDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        _closeTime!.hour,
        _closeTime!.minute,
      );

      final List<Map<String, dynamic>> sessions = [];

      QuerySnapshot userDocs = await FirebaseFirestore.instance
          .collection('kuaforlist')
          .where('kuaforMail', isEqualTo: auth.currentUser?.email.toString()) // Kullanıcının email alanını kullanarak filtreleme yapın
          .get();

      String userId = userDocs.docs[0].id;


      while (currentSessionTime.isBefore(closingDateTime)) {
        final Map<String, dynamic> sessionData = {
          'tarih': Timestamp.fromDate(currentSessionTime),
          'musteriMail': "", // Boş başlangıç değeri
          'musteriTel': "",  // Boş başlangıç değeri
          'status': true, // Başlangıçta false olarak ayarlanmış durum
          'kuaforId': userId,
        };

        sessions.add(sessionData);

        currentSessionTime = currentSessionTime.add(Duration(minutes: sessionDuration));
      }

      // Firestore'a seansları ekleyin
      final CollectionReference seanslarCollection =
      FirebaseFirestore.instance.collection('kuaforlist')
          .doc(userId).collection('Seanslar');

      sessions.forEach((session) {
        seanslarCollection.add(session);
      });

      // Başarılı bir şekilde eklendiğinde kullanıcıyı bilgilendirin
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Seanslar başarıyla oluşturuldu.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seans Oluştur"),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BarberHomePage(),
              ),
            );
          },
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tOpenTime,
              readOnly: true,
              onTap: () => _showTimePicker(_tOpenTime),
              decoration: const InputDecoration(
                labelText: 'Açılış Saati',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _tCloseTime,
              readOnly: true,
              onTap: () => _showTimePicker(_tCloseTime),
              decoration: const InputDecoration(
                labelText: 'Kapanış Saati',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _tSeansTime,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'İşlem Süresi (Dakika)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: _createSeans,
            //   child: const Text('Seans Oluştur'),
            // ),
            GestureDetector(
              onTap: _createSeans,
              child: Container(
                height: 50,
                width: width * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.9),
                ),
                child: const Center(
                  child: Text(
                    "Seans Oluştur",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
