import 'dart:convert';
import 'package:flutter/material.dart';
import '../modelforstories.dart';
import 'package:http/http.dart' as http;
class searchscreen extends StatefulWidget {
  const searchscreen({Key? key}) : super(key: key);
  @override
  State<searchscreen> createState() => _searchscreenState();
}
class _searchscreenState extends State<searchscreen> {
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
    return  Scaffold(
appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  title: Row(
    children: [
      Icon(Icons.search,color: Colors.white,),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Search',style: TextStyle(color: Colors.grey[500]),),
      )
    ],
  )
),
      backgroundColor: Colors.black,
      body: FutureBuilder(
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
              return 
              GridView.builder(itemCount: picsdata.length,
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
        }
        ,
      )
      
     
    );
  }
}