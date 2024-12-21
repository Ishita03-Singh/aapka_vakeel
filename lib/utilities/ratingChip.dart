import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomChip {
  
  

  static getRatingChip(double rating){
    return 
    Container(
      padding: EdgeInsets.fromLTRB(10,5,10,5),
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),
      color: rating>=4?Colors.green:rating>=3?Colors.amber:Colors.red,),
      child: Row(children: [
        Text(rating.toString(),style: TextStyle(fontSize: 14,color: Colors.white),),
        Icon(Icons.star,color: Colors.white,size: 10,)
      ],),
    );
  }

  static statusText(String text,bool status){
    return Row(children: [
    Icon(Icons.circle,color: status?Colors.green:Colors.grey,size: 8,),
    SizedBox(width: 5),
    Text(text,style: TextStyle(color: status?Colors.green:Colors.black,fontSize: 13 ),)
    ],);
  }
}