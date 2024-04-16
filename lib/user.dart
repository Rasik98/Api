import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/UserModel.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final response = await http.get(Uri.parse(
      'https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(Map i in data){
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text('Api Services'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(), 
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if(!snapshot.hasData){
                  return const Center(child: CircularProgressIndicator(),);
                } else {
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Card(   
                        child: Column(
                          children: [
                            ReusRow(title: 'id', value: snapshot.data![index].id.toString()),
                            ReusRow(title: 'UserName', value: snapshot.data![index].username.toString()),
                            ReusRow(title: 'Email', value: snapshot.data![index].email.toString()),
                            ReusRow(title: 'City', value: snapshot.data![index].address!.city.toString()),
                            ReusRow(title: 'Lat', value: snapshot.data![index].address!.geo!.lat.toString()),
                          ],
                        )
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReusRow extends StatelessWidget {
  String title, value;
  ReusRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}