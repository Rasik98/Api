import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/PostsModel.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  List<PostsModel> postList = [];

  Future<List<PostsModel>> getPostsApi() async {
    final response = await http.get(Uri.parse(
      'https://jsonplaceholder.typicode.com/posts'
    ));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      postList.clear();
      for(Map i in data){
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else{
      return postList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text('Api'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostsApi(), 
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  // return const Center(child: Text('Loading'));
                  return const  Center(
                    child: CircularProgressIndicator());
                } else{
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                          child: ListTile(
                            leading: Text(postList[index].id.toString()),
                            title: Text('title:\n${postList[index].title}'),
                            subtitle: Text('Description:\n${postList[index].body}'),
                          ),
                        ),
                        // child: Padding(
                        //   padding: const EdgeInsets.all(20.0),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text('id\n${postList[index].id}'),
                        //       Text('title\n${postList[index].title}'),
                        //       Text('Description\n${postList[index].body}'),
                        //     ],
                        //   ),
                        // ),
                      );
                    },);
                }
              },),
          ),
        ],
      ),
    );
  }
}
