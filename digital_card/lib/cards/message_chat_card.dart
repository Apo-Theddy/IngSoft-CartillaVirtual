import 'package:digital_card/models/message_model.dart';
import 'package:flutter/material.dart';

class MessageChatCard extends StatelessWidget {
  const MessageChatCard(
      {super.key, required this.isSender, required this.message});
  final bool isSender;
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(15), child: verifySender());
  }

  Widget verifySender() {
    String firstLetter = message.employee.names.split("")[0];

    if (isSender) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              margin: const EdgeInsets.only(right: 50),
              child: Text(message.employee.names,
                  style: const TextStyle(color: Colors.white))),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              containerContentMessage(message.content),
              const SizedBox(width: 5),
              CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    firstLetter,
                    style: const TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 49),
            child: Text(message.employee.names,
                style: const TextStyle(color: Colors.white))),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                firstLetter,
                style: const TextStyle(fontSize: 20),
              )),
          const SizedBox(width: 5),
          containerContentMessage(message.content),
        ]),
      ],
    );
  }

  Widget containerContentMessage(String message) {
    return Flexible(
      child: IntrinsicWidth(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(10),
            child: Text(message,
                style: const TextStyle(
                    fontFamily: "McLaren-Regular", fontSize: 17))),
      ),
    );
  }
}
