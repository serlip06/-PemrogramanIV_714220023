import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl_browser.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

class AdvancedForm extends StatefulWidget {
  const AdvancedForm({super.key});

  @override
  State<AdvancedForm> createState() => _AdvancedFormState();
}

class _AdvancedFormState extends State<AdvancedForm> {
  DateTime _dueDate = DateTime.now();
  final currentDate = DateTime.now();
  Color _currentColor = const Color.fromARGB(255, 255, 153, 0);
  //menambahkan variabel 
  String? _dataFile;
  File? _imageFile;



 //method pick file 
 void _pickFile() async{
  final result = await FilePicker.platform.pickFiles();
  if (result == null) return;

  //mendapat file dari object result
  final file = result.files.first;
  

  //mengecek apakah file yang dipilih adalah gambar 
  if( file.extension == 'jpg' || 
    file.extension == 'png' || 
    file.extension == 'jpeg') {

    setState(() {
      _imageFile = File(file.path!); //mengambil file gambar
    });
  }
  

  //memanggil setsate untuk memperbaharui tampilan ui
  setState(() {
    //memanggil nilai _datafile dengan nama file yang dipilih.
    _dataFile = file.name;
  });

  _openFile(file);
 }
// method buat open file 
 void _openFile(PlatformFile file){
  OpenFile.open(file.path);
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Widget'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildDatePicker(context),
            const SizedBox(height: 20),
            buildColorPicker(context),
            const SizedBox(height: 20),
            buildFilePicker(context),
          ],
        ),
      ),
    );
  }

  //untuk method date picker
  Widget buildDatePicker(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Date'),
            TextButton(
              child: const Text('Select'),
              onPressed: () async {
                final selectDate = await showDatePicker(
                  context: context, 
                  firstDate: DateTime(1990), //tanggal pertama yang dapat dipilih adalah tahun 1990
                  lastDate: DateTime(currentDate.year +5), //tanggal terakhir tahun ini di tambah 5 tahun kedepan 
                  
                );
                setState(() {
                  if (selectDate != null){
                    _dueDate = selectDate;
                  }
                 });
              } 
            ),
          ],
        ),
        Text(DateFormat('dd-MM-yyyy').format(_dueDate))
      ],
    );
  }
  
  //method untuk color picker 
  Widget buildColorPicker(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('color'),
        const SizedBox(height: 10),
        Container(
          height: 100,
          width: double.infinity,
          color: _currentColor,
        ),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _currentColor,
            ),
            onPressed: () {
              showDialog(
              context: context, 
              builder: (context){
                return AlertDialog(
                  title: const Text('Pick your color'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlockPicker(
                        pickerColor: _currentColor, 
                        onColorChanged: (color) {
                          setState(() {
                            _currentColor = color;
                          });
                        }),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        return Navigator.of(context).pop();
                      },
                      child: const Text('Save'),
                      ),
                  ],
                );

              });
            },
            child: const Text('Pick Color'),
          ),
        )
      ],
    );
  }
 
 //build file picker 
 Widget buildFilePicker(BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Pick file'),
      const SizedBox(height: 10),
      Center(
        child: ElevatedButton(
          onPressed: () {
            _pickFile();
          }, 
          child: const Text('Pick and open file'),
        ),
      ),
      if (_dataFile != null) Text('File Name: $_dataFile'),
      const SizedBox(height: 10),
      //menampilkan gambar 
      if (_imageFile != null)
      Image.file(
        _imageFile!,
        height: 100,//ukuran gambar
        width: double.infinity,
        fit: BoxFit.cover,
      )
    ],
  );
 }

}
