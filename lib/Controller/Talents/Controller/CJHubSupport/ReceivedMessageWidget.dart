import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ReceivedMessageWidget extends StatelessWidget {
  final String? content;
  final String? time;
  const ReceivedMessageWidget({
    Key? key,
    this.content,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding:
          const EdgeInsets.only(right: 75.0, left: 8.0, top: 8.0, bottom: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)),
            child: Container(
              color: Colors.black12,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 8.0, left: 8.0, top: 8.0, bottom: 15.0),
                    child: /*Text(
                      content,
                      style: TextStyle(
                          fontSize: 15, color: Colors.white),
                    ),*/Html(data:content),
                  ),
                  Positioned(
                    bottom: 1,
                    right: 10,
                    child: Text(
                      time!,
                      style: TextStyle(
                          fontSize: 10, color: Colors.black38.withOpacity(0.6)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}