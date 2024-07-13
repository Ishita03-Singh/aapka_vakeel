import 'package:aapka_vakeel/screens/notaryScreen.dart';
import 'package:aapka_vakeel/screens/videoCall.dart';
import 'package:flutter/material.dart';

class AsyncLoader extends StatelessWidget {
  const AsyncLoader({super.key});

  @override
  Widget build(BuildContext context) {
     return  Scaffold(
      body: FutureBuilder<String>(
        future: fetchData(),
        builder: (context, snapshot) {
          print("FutureBuilder state: ${snapshot.connectionState}");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return WaitingArea();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              print("Data received: ${snapshot.data}");
              // Navigate to the next screen once data is received
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => VideoCall(data: snapshot.data!),
                  ),
                );
              });
              return Container(); // Empty container while waiting for navigation
            } else if (snapshot.hasError) {
              print("Error: ${snapshot.error}");
              return Center(child: Text('Error: ${snapshot.error}'));
            }
          }
          return Center(child: Text('Unexpected state'));
        },
      ),
    );
  }

  Future<String> fetchData() async {
    print("Fetching data...");
    // Simulate a network call
    await Future.delayed(Duration(seconds: 3));
    print("Data fetched");
    return 'Data received';
  }
}