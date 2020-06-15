import 'package:flutter/material.dart';

class TextBuble extends StatelessWidget {
  TextBuble({
    Key key,
    @required this.text,
    @required this.sender,
    this.isMe,
  }) : super(key: key);

  final String text;
  final String sender;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(color: Colors.black54, fontSize: 12.0),
          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft:isMe? Radius.circular(30):Radius.circular(0),
              topRight:isMe? Radius.circular(0):Radius.circular(30),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            elevation: 5.0,
            color: isMe?  Colors.lightBlueAccent:Colors.white,
            child: Padding(
              child: Text(
                text,
                style: TextStyle(color: isMe?Colors.white:Colors.black54, fontSize: 15),
              ),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            ),
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
    );
  }
}
