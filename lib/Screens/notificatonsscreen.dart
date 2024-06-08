import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../modelforstories.dart';
class notificationscreen extends StatefulWidget {
  const notificationscreen({Key? key}) : super(key: key);

  @override
  State<notificationscreen> createState() => _notificationscreenState();
}

class _notificationscreenState extends State<notificationscreen> {
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: getter(),
        builder: (context,snapshot)
        {
          if(!snapshot.hasData)
            {
              return CircularProgressIndicator();
            }
          else
            {
              return ListView.builder(
                  itemCount: 50,
                  itemBuilder: (context,index)
              {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(picsdata[index].url.toString()),
                    ),
                    title: Text(picsdata[index].title.toString(),style: TextStyle(color: Colors.white),),

                  ),
                );
              });
            }
        },
      )
    );
  }
}
