import 'package:flutter/material.dart';

import '../utilities/custom_text.dart';
// import 'package:video_call/utils/custom_text.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
            children: [
              Expanded(child: Container(
                color: Colors.black,
                child: Column(
                  children: [
                    CustomText.taskBtnText("My Reward Points"),
                    
                  ],
                ),
              ))
            ],
          ),
        )
      
    );
  }
}