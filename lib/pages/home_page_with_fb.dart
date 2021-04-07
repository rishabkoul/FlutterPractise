import 'package:flutter/material.dart';
import 'package:hello_world/utils/Constants.dart';
import 'package:hello_world/widgets/drawer.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

class HomePageFB extends StatelessWidget {
  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

  Future getData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/photos');
    var data;
    var res = await http.get(url);
    data = jsonDecode(res.body);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Awesome App"),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Constants.prefs.setBool("LoggedIn", false);
                Navigator.pushReplacementNamed(context, '/login');
              })
        ],
      ),
      body: FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Text("Fetch Someting"),
              );
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              print(snapshot.hasError);
              if (snapshot.hasError) {
                print('hello');
                return Center(child: Text("Some error has Occured"));
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(snapshot.data[index]["title"]),
                      subtitle: Text("ID: ${snapshot.data[index]['id']}"),
                      leading: Image.network(snapshot.data[index]["url"]),
                    ),
                  );
                },
                itemCount: snapshot.data.length,
              );
          }
          return null;
        },
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // myText = _nameController.text;
          // setState(() {});
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
