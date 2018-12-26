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

  Map dataGet;
  List userData;

  Future<String> getData() async {
    await new Future.delayed(new Duration(seconds: 5));
    var response = await http.get(
      Uri.encodeFull("https://reqres.in/api/users?page=2"),
      headers: { "Accept": "application/json" }
    );
    dataGet = jsonDecode(response.body);

    setState(() {
      userData = dataGet["data"];
    });

    // for (var item in data) {
    //   print(item['id']);
    //   print(item['title']);
    //   print("\n");
    // }

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
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Request GET|POST "),
        backgroundColor: Colors.green,
      ),
      body: new RefreshIndicator(
        child: ListView.builder(
            itemCount: userData == null ? 0 : userData.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(userData[index]["avatar"]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("${userData[index]["first_name"]} ${userData[index]["last_name"]}",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),),
                      )
                    ],
                  ),
                ),
              );
            },
        ),
        onRefresh: getData,
      ), 
    );
  }
}
