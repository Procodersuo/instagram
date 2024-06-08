import 'dart:convert';
import 'package:flutter/material.dart';
import '../modelforstories.dart';
import 'package:http/http.dart' as http;
class maintab extends StatefulWidget {
  const maintab({Key? key}) : super(key: key);

  @override
  State<maintab> createState() => _maintabState();
}

class _maintabState extends State<maintab> {
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
      body: FutureBuilder(
          future: getter(),
          builder: (context,snapshot)
          {
            if(!snapshot.hasData)
            {
              return const Center(
                child: CircularProgressIndicator(),
              );

            }
            else
            {
              return GridView.builder(itemCount: picsdata.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder: (context,index)
                  {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration:  BoxDecoration(
                            image: DecorationImage(image:
                            NetworkImage(picsdata[index].url.toString()))
                        ),
                      ),
                    );
                  });
            }
          }) ,
    );
  }
}
