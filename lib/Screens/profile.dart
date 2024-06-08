import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:instagram/Tabs/maintab.dart';
import 'package:instagram/Tabs/reels.dart';
import 'package:instagram/Tabs/tab3.dart';
import '../modelforstories.dart';
import 'package:http/http.dart' as http;

import 'STORIES.dart';
class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);
  @override
  State<profile> createState() => _profileState();
}
class _profileState extends State<profile> {
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
    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Bull Vs Bear"),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.menu),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            )
          ],
        ),
        backgroundColor: Colors.black,
        body:FutureBuilder(
          future: getter(),
          builder: (context,snapshot)
          {
            if(!snapshot.hasData)
              {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              }
            else
              {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration:  BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.pink,
                                    border: Border.all(
                                        color: Colors.orange,
                                        width: 2
                                    )
                                ),
                              ),

                            ),
                            const Text("Bull vs Bear",style: TextStyle(color: Colors.white),),
                          ],
                        ),
                        const Expanded(child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text('237',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                                Text("Posts",style: TextStyle(color: Colors.white),)
                              ],
                            ),
                            Column(
                              children: [
                                Text('1056',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                                Text("Followers",style: TextStyle(color: Colors.white),)
                              ],
                            ),
                            Column(
                              children: [
                                Text('1',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                                Text("Following",style: TextStyle(color: Colors.white),)
                              ],
                            )
                          ],
                        ))
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Programming is my Passion\nTrading is love\n",style: TextStyle(color: Colors.white),),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Colors.grey
                                  )
                              ),
                              padding: const EdgeInsets.all(8),
                              child: const Center(
                                child: Text('Edit Profile',style: TextStyle(color: Colors.white),),

                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Colors.grey
                                  )
                              ),
                              padding: const EdgeInsets.all(8),
                              child: const Center(
                                child: Text('Share Profile',style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                     const TabBar(tabs: [
                      Tab(
                        child: Icon(Icons.grid_4x4_outlined),
                      ),
                      Tab(
                        child: Icon(Icons.slow_motion_video),
                      ),
                      Tab(
                        child: Icon(Icons.person),
                      )
                    ]),
                    const Expanded(
                      child: TabBarView(children: [
                        maintab(),
                        reelstab(),
                        tab3()

                      ]),
                    ),

                  ],
                );
              }
          },
        )


      ),
    );
  }
}
