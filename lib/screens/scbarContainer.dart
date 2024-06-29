import 'package:aapka_vakeel/utilities/strings.dart';
import 'package:flutter/material.dart';

class ScBar extends StatelessWidget {
  const ScBar({super.key});

  @override
  Widget build(BuildContext context) {
   
    return 
       Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(StrLiteral.home_filled,width:28),
            Image.asset(StrLiteral.note,width:28),
            Image.asset(StrLiteral.advocate,width:30),
            Image.asset(StrLiteral.setting,width:28),
            Image.asset(StrLiteral.profile,width:28),

        
        ],),
      
    );
  }
  
}