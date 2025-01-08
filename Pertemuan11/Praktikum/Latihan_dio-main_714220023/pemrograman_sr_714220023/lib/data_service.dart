import 'package:dio/dio.dart';

import 'user.dart';

class DataService {
  final Dio dio = Dio();
  final String baseUrl = 'https://reqres.in/api';// link apinya 

  // function get user
  Future getUsers() async {
    try
    {
      final response = await dio.get('$baseUrl/users');
      
      if(response.statusCode ==200){
        return response.data;// kenapa data karena di apinya data nya itu daplemnya adda isi dari apinya 
      }
    }catch(e)
    {
      rethrow;
    }

  }

  Future<UserCreate?> postUser(UserCreate user) async {
    try
    {
      final response = await dio.post(
        '$baseUrl/Users',
        data: user .toMap(),
        
      );

      if(response.statusCode ==201){
        return UserCreate.fromJson(response.data);// kenapa data karena di apinya data nya itu daplemnya adda isi dari apinya 
      }
    }catch(e)
    {
      rethrow;
    }
  }
  
Future<UserCreate?> putUser(String id, String name, String job) async {
  final response = await dio.put(
    '$baseUrl/users/$id',
    data: {'name': name, 'job': job},
  );

  if (response.statusCode == 200) {
    // Ubah data JSON dari respons menjadi objek UserCreate
    return UserCreate.fromJson(response.data);
  } else {
    throw Exception('Failed to update user');
  }
}
  // Future putUser(String idUser, String name, String job) async {
  //   try
  //   {
  //     final response = await dio.put(
  //       '$baseUrl/Users/$idUser',
  //       data: {'name': name, 'job' : job},
        
  //     );

  //     if(response.statusCode ==200){
  //       return response.data;// kenapa data karena di apinya data nya itu daplemnya adda isi dari apinya 
  //     }
  //   }catch(e)
  //   {
  //     rethrow;
  //   }
  // }

  Future deleteUser(String idUser) async {
    try
    {
      final response = await dio.delete('$baseUrl/Users/$idUser');

      if(response.statusCode ==204){
        return 'Delete data berhasil';// kenapa data karena di apinya data nya itu daplemnya adda isi dari apinya 
      }
      return null;
    }catch(e)
    {
      rethrow;
    }
  }

  Future<Iterable<User>?> getUserModel() async {
    try{
      var response =  await dio.get('$baseUrl/api/users');
      if(response.statusCode == 200) {
      final users =  (response.data['data'] as List)
      .map((user) => User.fromJson(user))
      .toList();

      return users;
      }
      return null;
    }catch(e){
      rethrow;
    }
  
  }
}
