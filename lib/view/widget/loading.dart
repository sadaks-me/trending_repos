import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Column(
            children: List.generate(
              15,
              (index) => Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      minRadius: 20,
                      maxRadius: 20,
                      backgroundColor: Colors.grey.shade100,
                    ),
                    title: Container(
                      height: 60,
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            height: 8.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade50,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade50,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 0.5,
                    color: Colors.grey.shade100,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
