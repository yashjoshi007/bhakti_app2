import 'package:bhakti_app/customise/wheelcustom/homepage.dart';
import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  const MyTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Center(child: HomePage()),
    );
  }
}