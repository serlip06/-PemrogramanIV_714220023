import 'package:flutter/material.dart';
import 'package:p4_1_714220023/main_screen.dart';
import 'detail_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tempat Wisata Bandung',
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const MainScreen(),
    );
  }
}

//detail screen
class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset('images/ranca-upas.jpg'),
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: const Text(
                'Ranca Upas',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Staatliches',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        color: Color.fromARGB(255, 34, 107, 0),
                      ),
                      SizedBox(height: 8.0),
                      Text('Open Everyday',
                        style: iniFontCustom,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(
                        Icons.access_time_filled,
                        color: Color.fromARGB(255, 34, 107, 0),
                      ),
                      SizedBox(height: 8.0),
                      Text('9:00 - 21:00',
                        style: iniFontCustom,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(Icons.monetization_on_rounded,
                       color: Color.fromARGB(255, 34, 107, 0),
                      ),
                      SizedBox(height: 8.0),
                      Text('Rp. 20.000',
                      style: iniFontCustom,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Ranca Upas Ciwidey adalah kawasan bumi perkemahan di bawah pengelolaan perhutani. Tempat ini berada di kawasan wisata Bandung Selatan, satu lokasidengan kawah putih, kolam Cimanggu dan situ Patenggang. Banyak hal yangbisa dilakukan di kawasan wisata ini, seperti berkemah, berinteraksi dengan rusa, sampai bermain di water park dan mandi air panas.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          16.0), // Sesuaikan nilai radius sesuai kebutuhan
                      child: Image.asset('images/gambar1.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          16.0), // Sesuaikan nilai radius sesuai kebutuhan
                      child: Image.asset('images/gambar2.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          16.0), // Sesuaikan nilai radius sesuai kebutuhan
                      child: Image.asset('images/gambar3.jpg'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

//  var iniFontCustom = const TextStyle(fontFamily: 'Staatliches'),