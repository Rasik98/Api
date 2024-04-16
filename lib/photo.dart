import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Photo extends StatefulWidget {
  const Photo({super.key});

  @override
  State<Photo> createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos() async {
    final response = await http.get(Uri.parse(
      'https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(Map i in data){
        Photos photos = Photos(id: i['id'], title: i['title'], url: i['url']);
        photosList.add(photos);
      }
      return photosList;
    } else{
      return photosList;
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
              future: getPhotos(), 
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: photosList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data![index].url.toString()),
                      ),
                      subtitle: Text(snapshot.data![index].title.toString()),
                      title: Text('Note id:${snapshot.data![index].id}'),
                    );
                  },
                  );
              },
              ),
          ),
        ],
      ),
    );
  }
}


class Photos{
  int id;
  String title, url;

  Photos({required this.id, required this.title, required this.url});
}