import 'package:flutter/material.dart';
class stories extends StatelessWidget {
  String picurl,name;
  stories({Key? key,required this.picurl,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration:  BoxDecoration(
                border:Border.all(
                    color: Colors.orange,
                    width: 2

                ),
                shape: BoxShape.circle,
                image: DecorationImage(image: NetworkImage(picurl))
            ),

          ),
          Text(name,style: const TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
}







