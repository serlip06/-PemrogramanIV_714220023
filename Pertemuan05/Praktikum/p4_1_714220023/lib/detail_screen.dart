import 'package:flutter/material.dart';
import 'model/tourism_place.dart';

var iniFontCustom = const TextStyle(fontFamily: 'Staatliches');

class DetailScreen extends StatelessWidget {
  final TourismPlace place;

  const DetailScreen({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                // Menampilkan gambar utama tempat wisata dengan AspectRatio
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.asset(place.imageAsset, fit: BoxFit.cover),
                ),
                
                // SafeArea untuk tombol kembali agar tidak tertutup oleh area status bar
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey, // Warna latar belakang abu-abu
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white, // Warna ikon panah putih
                        ),
                        onPressed: () {
                          Navigator.pop(context); // Fungsi kembali ke halaman sebelumnya
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Nama Tempat Wisata
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Text(
                place.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Staatliches', // Menyesuaikan dengan font yang diinginkan
                ),
              ),
            ),

            // Spacer untuk memberikan jarak antara judul dan informasi lainnya
            const SizedBox(height: 16.0),

            // Menampilkan Hari Buka, Jam Buka, dan Harga Tiket dengan Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Icon(
                      Icons.calendar_today,
                      color: Color.fromARGB(255, 34, 107, 0), // Warna hijau untuk ikon kalender
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      place.openDays,
                      style: const TextStyle(fontFamily: 'Staatliches'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Color.fromARGB(255, 34, 107, 0), // Warna hijau untuk ikon jam
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      place.openTime,
                      style: const TextStyle(fontFamily: 'Staatliches'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Icon(
                      Icons.attach_money,
                      color: Color.fromARGB(255, 34, 107, 0), // Warna hijau untuk ikon uang
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      place.ticketPrice,
                      style: const TextStyle(fontFamily: 'Staatliches'),
                    ),
                  ],
                ),
              ],
            ),
            
            // Spacer untuk memberikan jarak antara informasi dan deskripsi
            const SizedBox(height: 20.0),

            // Deskripsi Tempat Wisata
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                place.description,
                textAlign: TextAlign.justify, // Meratakan teks ke kiri dan kanan
                style: const TextStyle(fontSize: 16.0),
              ),
            ),

            // Menampilkan Galeri Gambar Tempat Wisata
            const SizedBox(height: 16.0),
            Text(
              'Gallery:',
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8.0),

            // Menampilkan gambar-gambar galeri dalam bentuk horizontal ListView
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: place.imageUrls.map((url) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(url, fit: BoxFit.cover),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
