import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyShared extends StatefulWidget {
  const MyShared({super.key});

  @override
  State<MyShared> createState() => _MySharedState();
}

class _MySharedState extends State<MyShared> {
  late SharedPreferences prefs;
  final _kataController = TextEditingController();
  String? kata = '';//dia datanya boleh null

  @override
  void dispose(){
    _kataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('shared preference'),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _kataController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                saveValue();
              }, 
              child: Text('save')
            ),
            SizedBox(height: 20),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: kata,
              ),
            ),
            SizedBox(height: 5),
             ElevatedButton(
              onPressed: () {
                getValue().then((Value){
                  setState(() {
                    kata = Value ?? 'Data Telah Dihapus XXX';
                  });
                });
              }, 
              child: Text('get value')
            ),
            SizedBox(height: 20),
             ElevatedButton(
              onPressed: () {
                deleteValue();
              }, 
              child: Text('delete value')
            ),
          ],
        ),
      ),
    );
  }

  //kumpulan method 
  void saveValue() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('kata', _kataController.text);
    setState(() {
      kata = _kataController.text; // Perbarui UI dengan nilai yang baru disimpan
    });
    _kataController.clear();
  }

  getValue() async {
    prefs = await SharedPreferences.getInstance();
   String? kata = prefs.getString('kata');
   return kata;
  }
  deleteValue() async {
    prefs = await SharedPreferences.getInstance();
   prefs.remove('kata');
   kata = '';
   setState(() {});
  }

}