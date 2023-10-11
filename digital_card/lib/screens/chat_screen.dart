import 'dart:convert';

import 'package:digital_card/cards/message_chat_card.dart';
import 'package:digital_card/main.dart';
import 'package:digital_card/models/employee_model.dart';
import 'package:digital_card/models/message_model.dart';
import 'package:digital_card/services/messages_service.dart';
import 'package:flutter/material.dart';

final messageService = MessageService();

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.employee});
  final Employee employee;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final scrollController = ScrollController();
  int page = 1;
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    getMessagesByPage();
    listenNewMessage();
    scrollController.addListener(() {
      if (scrollController.position.pixels == 0.0) {
        getMessagesByPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff161716),
      appBar: AppBar(
        // Configuración de la barra de aplicación
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Column(
          children: [
            Icon(
              Icons.food_bank,
              size: 40,
              color: Colors.white,
            ),
            Text("Cocina", style: TextStyle(fontSize: 13))
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: messages
                  .map((message) => MessageChatCard(
                      isSender: message.employee.dni == widget.employee.dni,
                      message: message))
                  .toList(),
            ),
          )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white24,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: messageController,
                      style: const TextStyle(color: Colors.white),
                      scrollPadding: EdgeInsets.zero,
                      textAlignVertical: TextAlignVertical.top,
                      maxLines: 5,
                      minLines: 1,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: "Message..",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (messageController.text.trim().isNotEmpty) {
                      sendMessage(messageController.text.trim());
                      messageController.text = "";
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(15),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getMessagesByPage() async {
    const int limit = 10;
    final newMessages = await messageService.getMessages(page);
    List<Message> tempMessages = [];
    tempMessages.addAll(newMessages.reversed);
    tempMessages.addAll(messages);
    setState(() {
      if (page == 1) scrollToLastItem();
      page++;
      if (newMessages.length <= limit) {
        messages = tempMessages;
      }
    });
  }

  void listenNewMessage() {
    socketService.socket.on("SendMessage", (data) {
      Map<String, dynamic> message = json.decode(json.encode(data));
      if (mounted) {
        setState(() {
          messages.add(Message.fromJson(message));
        });
        scrollToLastItem();
      }
    });
  }

  void sendMessage(String content) {
    socketService.socket.emit(
      "SendMessage",
      <String, dynamic>{
        "EmployeeDni": widget.employee.dni,
        "Content": content,
      },
    );
    scrollToLastItem();
  }

  void scrollToLastItem() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 200,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }
}
