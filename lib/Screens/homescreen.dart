import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instagram/modelforstories.dart';
import 'STORIES.dart';
import 'messagesscreen.dart';
import 'notificatonsscreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  List<Modelforstories> picsdata = [];
  Future<List<Modelforstories>> getter() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        picsdata.add(Modelforstories.fromJson(i));
      }
    }
    return picsdata;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Instagram",
            style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const messagescreen()));
              },
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    Icons.message,
                    color: Colors.white,
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const notificationscreen()));
              },
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  )),
            )
          ],
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: FutureBuilder(
          future: getter(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            } else {
              return Column(
                children: [
                  Container(
                    height: 130,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: picsdata.length,
                        itemBuilder: (context, index) {
                          return stories(
                            picurl: picsdata[index].url.toString(),
                            name: 'Bull bear',
                          );
                        }),
                  ),
                  Container(
                    height: 530,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                picsdata[index]
                                                    .url
                                                    .toString()),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6),
                                            child: Text(
                                              "Bull vs Bear Game",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.menu,
                                        color: Colors.white,
                                      ),
                                    ]),
                              ),
                              Container(
                                  height: 400,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(picsdata[index]
                                              .url
                                              .toString())))),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.comment_bank,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.send,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.bookmark,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                        }),
                  )
                ],
              );
            }
          },
        ));
  }
}
