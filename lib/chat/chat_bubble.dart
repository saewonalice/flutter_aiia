import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(this.message, this.isMe, this.userName, {Key? key}) : super(key: key);

  final String message;
  final String userName;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
         Container(
          decoration: BoxDecoration(
             color: isMe ? Colors.green[300] : Colors.grey[300],
             borderRadius: BorderRadius.only(
                 topRight: Radius.circular(12),
                 topLeft: Radius.circular(12),
                 bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                bottomLeft:  isMe ? Radius.circular(12) : Radius.circular(0)
             ),
           ),
           width: 145,
           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
           margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
           child: Column(
             crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
             children: [
               Text(
                    userName,
                    style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black,
                    ),
                  ),
               Text(
                 message,
                 style: TextStyle(
                   fontFamily: 'ShantellSans',
                     color: isMe ? Colors.black : Colors.black
                 ),
               ),
             ],
           ),
         ),


      ],
    );
  }
}