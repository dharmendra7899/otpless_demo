import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key,required this.isFirstTime});
  final bool isFirstTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: []),
      ),
    );
  }
}
