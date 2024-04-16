import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class UserWithoutModel extends StatefulWidget {
  const UserWithoutModel({super.key});

  @override
  State<UserWithoutModel> createState() => _UserWithoutModelState();
}

class _UserWithoutModelState extends State<UserWithoutModel> {

  var data;
  Future<void> getUserWithout() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
    } else {

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
              future: getUserWithout(), 
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(),);
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            BuildRow(title: 'Id', value: data[index]['Id'].toString()),
                            BuildRow(title: 'Name', value: data[index]['name'].toString()),
                            BuildRow(title: 'Address', value: data[index]['address']['suite'].toString()),
                            BuildRow(title: 'geo', value: data[index]['address']['geo']['lng'].toString()),
                          ],
                        ),
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

class BuildRow extends StatelessWidget {
  String title, value;
  BuildRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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