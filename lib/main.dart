import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {

  List data;
  var dataPost;

  Future<String> getData() async {
    var response = await http.get(
      Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
      headers: { "Accept": "application/json" }
    );
    data = jsonDecode(response.body);

    for (var item in data) {
      print(item['id']);
      print(item['title']);
      print("\n");
    }

    return "Success!";
  }

  Future<String> postData() async {
    var url = "https://cryptizy.com/api/connexion";
    var response = await http.post(
        Uri.encodeFull(url), 
        headers: { "Accept": "application/json" },
        body: {"email": "lockpassero@gmail.com", "password": "052102362020"}
      );
    
    dataPost = jsonDecode(response.body);

    print(dataPost);

    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(
                child: new Text("Get data"),
                onPressed: getData,
              ),
              new RaisedButton(
                child: new Text("Post data"),
                onPressed: postData,
              ),
            ]
        )
      ),
    );
  }
}
