import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<dynamic, dynamic> list = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  void fetch() async {
    var response = await http.get(Uri.parse("https://dummyjson.com/products"));
    var body = jsonDecode(response.body);
    Map<dynamic, dynamic> map = body;

    setState(() {
      Map<dynamic, dynamic> list1 = map["products"][0];
      list = list1;
      print(list["price"]);
    });
  }

  void post(String name, int id) async {
    await http.post(Uri.parse("url"), headers: {"": ""}, body: {"": " "});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App"),
      ),
      body: Container(
        height: 700,
        child: Column(
          children: [
            textfield("Select vendor"),
            SizedBox(
              height: 8,
            ),
            textfield("Select Product"),
            SizedBox(
              height: 8,
            ),
            textfield("Enter comission"),
            SizedBox(
              height: 8,
            ),
            textfield("Transfer pricing"),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black, // Background Color
                  ),
                  onPressed: fetch,
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            if (list.isNotEmpty) details(),
            SizedBox(
              height: 10,
            ),
            name("Abhinav", "isdischarged"),
          ],
        ),
      ),
    );
  }

  Widget textfield(String s) {
    String k = s;
    return TextFormField(
      decoration: InputDecoration(
        hintText: k,
        border: OutlineInputBorder(
          borderSide: new BorderSide(),
        ),
      ),
    );
  }

  Widget details() {
    return ListTile(
      leading: CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(list["thumbnail"]),
      ),
      subtitle: Text(list["description"]),
    );
  }

  Widget name(String name, String status) {
    String namee = name;
    String status1 = status;
    Color color;
    if (status == "isdischarged") {
      color = Colors.black;
    } else {
      color = Colors.amber;
    }
    return Card(
      child: ListTile(
        leading: Text(
          namee ?? "Pateint",
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}
