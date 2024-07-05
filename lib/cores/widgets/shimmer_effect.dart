import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListTile extends StatelessWidget {
  const ShimmerListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 11,
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey[800]!,
            child: ListTile(
              leading: const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
              ),
              title: Container(
                width: double.infinity,
                height: 12.0,
                color: Colors.white,
              ),
              subtitle: Container(
                width: double.infinity,
                height: 10.0,
                margin: const EdgeInsets.only(top: 8.0),
                color: Colors.white,
              ),
              trailing: Container(
                width: 44.0,
                height: 14.0,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
