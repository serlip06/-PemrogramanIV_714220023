import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal
import 'package:flutter_colorpicker/flutter_colorpicker.dart'; // color picker
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'dart:typed_data';
import 'dart:io';

final List<Map<String, dynamic>> _myDataList = [];

class MyInputform extends StatefulWidget {
  const MyInputform({super.key});

  @override
  State<MyInputform> createState() => _MyFormValidationState();
}

class _MyFormValidationState extends State<MyInputform> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerPhoneNumber = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerDate = TextEditingController();
  DateTime _dueDate = DateTime.now(); // untuk menyimpan tanggal yang dipilih
  Color _currentColor = const Color.fromARGB(136, 184, 129, 109);

  Map<String, dynamic>? editedData;
  String? _dataFile;
  File? _imageFile;
  Uint8List? _imageBytes;

  @override
  void dispose() {
    _controllerPhoneNumber.dispose();
    _controllerName.dispose();
    _controllerDate.dispose();
    super.dispose();
  }

  // Method untuk menambah data
  void _addData() {
    // Periksa jika warna dan gambar tidak null
    if (_controllerPhoneNumber.text.isEmpty ||
        _controllerName.text.isEmpty ||
        _controllerDate.text.isEmpty ||
        _imageBytes == null) {
      // Tampilkan snackbar jika ada data yang belum diisi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pastikan semua form telah diisi dengan lengkap.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final data = {
      'name': _controllerName.text,
      'PhoneNumber': _controllerPhoneNumber.text,
      'date': _controllerDate.text,
      'color': _currentColor,
      'image': _imageBytes, // Simpan data gambar di sini
    };

    setState(() {
      if (editedData != null) {
        // Jika sedang mengedit, update data yang ada
        final index = _myDataList.indexOf(editedData!);
        _myDataList[index] = data;
      } else {
        // Jika tidak mengedit, tambahkan data baru
        _myDataList.add(data);
      }
      // Clear text fields setelah submit
      _controllerPhoneNumber.clear();
      _controllerName.clear();
      _controllerDate.clear();
      _imageBytes = null; // Clear image data
      editedData = null; // Reset editedData
    });
  }

  // Method untuk mengedit data
  void _editData(Map<String, dynamic> data) {
    setState(() {
      _controllerName.text = data['name'];
      _controllerPhoneNumber.text = data['PhoneNumber'];
      _controllerDate.text = data['date'];
      _currentColor = data['color'];
      _imageBytes = data['image'];
      _dataFile = data['file'];
      _dueDate = DateFormat('dd-MM-yyyy').parse(data['date']);
      editedData = data;
    });
  }

  // Method untuk menghapus data
  void _deleteData(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Data'),
          content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _myDataList.remove(data);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  // Method pick file
  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = result.files.first;

      // Jika file adalah gambar, gunakan bytes
      if (file.extension == 'jpg' ||
          file.extension == 'png' ||
          file.extension == 'jpeg') {
        setState(() {
          _imageBytes = file.bytes; // Simpan bytes dari file
        });
      }

      // Simpan nama file untuk ditampilkan
      setState(() {
        _dataFile = file.name;
      });
    }
  }

  // Validasi nama
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama harus diisi';
    }
    List<String> words = value.trim().split(' ');
    if (words.length < 2) {
      return 'Nama harus terdiri dari minimal 2 kata';
    }
    for (var word in words) {
      if (word.isEmpty || !RegExp(r'^[A-Z]').hasMatch(word[0])) {
        return 'Setiap kata harus dimulai dengan huruf kapital';
      }
    }
    if (RegExp(r'[^a-zA-Z\s]').hasMatch(value)) {
      return 'Nama tidak boleh mengandung angka atau karakter khusus';
    }
    return null;
  }

  // Validasi nomor telepon
  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor telepon harus diisi';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Nomor telepon hanya boleh terdiri dari angka';
    }
    if (value.length < 8 || value.length > 13) {
      return 'Nomor telepon harus terdiri dari 8 hingga 13 digit';
    }
    if (!value.startsWith('62')) {
      return 'Nomor telepon harus diawali dengan 62';
    }
    return null;
  }

  // Validasi tanggal
  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tanggal harus diisi';
    }
    return null;
  }

  // Menampilkan date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(1990),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (selectedDate != null) {
      setState(() {
        _dueDate = selectedDate;
        _controllerDate.text =
            DateFormat('dd-MM-yyyy').format(selectedDate); // Format tanggal
      });
    }
  }

  // Widget Color Picker
  Widget buildColorPicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Color'),
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
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Pick your color'),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ColorPicker(
                            pickerColor: _currentColor,
                            onColorChanged: (color) {
                              setState(() {
                                _currentColor = color;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Pick Color'),
          ),
        )
      ],
    );
  }

  // Widget file picker
  Widget buildFilePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Pick file'),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.brown[300], // Ganti 'primary' dengan 'backgroundColor'
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              _pickFile();
            },
            child: const Text('Pick and open file'),
          ),
        ),
        if (_dataFile != null) Text('File Name: $_dataFile'),
        const SizedBox(height: 10),
        if (_imageBytes != null)
          Image.memory(
            _imageBytes!,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          )
      ],
    );
  }

  // Widget UI input
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Actor'),
        backgroundColor: Color.fromARGB(255, 160, 118, 109),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controllerPhoneNumber,
                    validator: _validatePhoneNumber,
                    decoration: const InputDecoration(
                      hintText: 'Write your phone number here...',
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      fillColor: Color.fromARGB(255, 245, 214, 208),
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controllerName,
                    validator: _validateName,
                    decoration: const InputDecoration(
                      hintText: 'Write your name here...',
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      fillColor: Color.fromARGB(255, 245, 214, 208),
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controllerDate,
                    validator: _validateDate, // Validasi tanggal
                    decoration: InputDecoration(
                      hintText: 'Input date here',
                      labelText: 'Date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      fillColor: Color.fromARGB(255, 245, 214, 208),
                      filled: true,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () =>
                            _selectDate(context), // Panggil _selectDate
                      ),
                    ),
                    readOnly: true, // Agar field tidak bisa diedit manual
                  ),
                ),
                buildColorPicker(context),
                const SizedBox(height: 20),
                buildFilePicker(context),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (editedData != null)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[
                              300], // Ganti 'primary' dengan 'backgroundColor'
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            // Reset form to initial values
                            _controllerPhoneNumber.clear();
                            _controllerName.clear();
                            _controllerDate.clear();
                            _imageBytes = null;
                            _dataFile = null;
                            _currentColor = const Color.fromARGB(208, 162, 99,
                                72); // reset color to initial state
                            editedData = null;
                          });
                        },
                        child: const Text('Cancel'),
                      ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[
                            300], // Ganti 'primary' dengan 'backgroundColor'
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addData();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Pastikan semua form telah diisi.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Text(editedData != null ? "Update" : "Submit"),
                    ),//button submit 
                  ],
                ),
                // untuk contact list 
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'List Contact:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _myDataList.length,
                  itemBuilder: (context, index) {
                    final data = _myDataList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: data['image'] != null
                                ? MemoryImage(data['image'])
                                : null, // Tampilkan gambar jika ada
                            child: data['image'] == null
                                ? Text('ULBI')
                                : null, // Tampilkan text jika tidak ada gambar
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data['name'] ?? ''),
                                Text(data['PhoneNumber'] ?? ''),
                                Text(data['date'] ?? ''),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Menjaga posisi di tengah
                                  children: [
                                    Container(
                                      width: 300, // Menentukan lebar Container
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: data['color'], // Tampilkan warna
                                        borderRadius: BorderRadius.circular(
                                            10), // Sudut membulat
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _editData(data);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              _deleteData(data);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
