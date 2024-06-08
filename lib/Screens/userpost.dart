import 'dart:convert';
import 'package:flutter/material.dart';
import '../modelforstories.dart';
import 'package:http/http.dart'as http;
class userpost extends StatefulWidget {
  const userpost({Key? key}) : super(key: key);

  @override
  State<userpost> createState() => _userpostState();
}
class _userpostState extends State<userpost> {
  @override
  List <Modelforstories> picsdata=[];
  Future<List<Modelforstories>> getter()
  async {
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200)
    {
      for(Map i in data)
      {
        picsdata.add(Modelforstories.fromJson(i));
      }
    }
    return picsdata;
  }
  Widget build(BuildContext context) {
    return Container(
      height:530,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index)
          {
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(picsdata[index].url.toString()),
                  ),
                  title:  Text(picsdata[index].title.toString(),style: TextStyle(color: Colors.white),),
                  trailing: const Icon(Icons.menu,color: Colors.white,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 400,
                    decoration:  BoxDecoration(

                        image: DecorationImage(

                            image: NetworkImage(picsdata[index].url.toString()))
                    ),
                  ),
                )

              ],
            );


          }),
    );
  }
}

