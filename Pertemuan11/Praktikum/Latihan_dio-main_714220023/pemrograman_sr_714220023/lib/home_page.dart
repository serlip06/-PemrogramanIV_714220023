import 'package:flutter/material.dart';
import 'package:pemrograman_sr_714220023/data_service.dart';
import 'package:pemrograman_sr_714220023/user.dart';
import 'package:pemrograman_sr_714220023/user_put_card.dart';
//import 'package:pemrograman_sr_714220023/user_put_card.dart'; // Impor file UserPutCard

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataService _dataService = DataService();
  final _formKey = GlobalKey<FormState>();
  final _nameCtl = TextEditingController();
  final _jobCtl = TextEditingController();
  String _result = '-';
  List<User> _users = [];
  UserCreate? usCreate;

  @override
  void dispose() {
    _nameCtl.dispose();
    _jobCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API (DIO)'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameCtl,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Name',
                  suffixIcon: IconButton(
                    onPressed: _nameCtl.clear,
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _jobCtl,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Job',
                  suffixIcon: IconButton(
                    onPressed: _jobCtl.clear,
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final res = await _dataService.getUsers();
                        if (res != null) {
                          setState(() {
                            _result = res.toString();
                          });
                        } else {
                          // displaySnackbar('Failed to get data');
                        }
                      },
                      child: const Text('GET'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_nameCtl.text.isEmpty || _jobCtl.text.isEmpty) {
                          displaySnackbar('Semua field harus diisi');
                          return;
                        }
                        final postModel = UserCreate(
                          name: _nameCtl.text,
                          job: _jobCtl.text,
                        );
                        UserCreate? res =
                            await _dataService.postUser(postModel);
                        setState(() {
                          _result = res.toString();
                          usCreate = res;
                        });
                        _nameCtl.clear();
                        _jobCtl.clear();
                      },
                      child: const Text('POST'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_nameCtl.text.isEmpty || _jobCtl.text.isEmpty) {
                          displaySnackbar('Semua field harus diisi');
                          return;
                        }

                        final putModel = UserCreate(
                          name: _nameCtl.text,
                          job: _jobCtl.text,
                        );

                        try {
                          // Panggil API PUT
                          UserCreate? res = await _dataService.putUser('123', putModel.name, putModel.job);
                          if (res != null) {
                            setState(() {
                              _result = res.toString();
                              usCreate = res; // Tetapkan objek UserCreate ke usCreate
                            });
                            displaySnackbar('User updated successfully');
                          } else {
                            displaySnackbar('Failed to update user');
                          }
                        } catch (e) {
                          displaySnackbar('Error: ${e.toString()}');
                        }

                        _nameCtl.clear();
                        _jobCtl.clear();
                      },
                      child: const Text('PUT'),
                    ),
                    ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final res = await _dataService.deleteUser('5');
                        setState(() {
                          _result = res.toString();
                        });
                      },
                      child: const Text('DELETE'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final users = await _dataService.getUserModel();
                        setState(() {
                          _users = users!.toList();
                        });
                      },
                      child: const Text('Model Class User Example'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _result = '-';
                        _users.clear();
                        usCreate = null;
                      });
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 1.0),
              const Text(
                'Result',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: _users.isEmpty ? Text(_result) : _buildListUser(),
              ),
              hasilCard(context),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamic displaySnackbar(String msg) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  Widget _buildListUser() {
    return ListView.separated(
        itemBuilder: (context, index) {
          final user = _users[index];
          return Card(
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(user.avatar),
              ),
              title: Text('${user.firstName} ${user.lastName}'),
              subtitle: Text(user.email),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10.0),
        itemCount: _users.length);
  }

  Widget hasilCard(BuildContext context) {
  return Column(
    children: [
      if (usCreate != null)
        UserUpdateCard(
          updatedUser: usCreate!,
        )
      else
        const Text('No data available'),
    ],
  );
}
}