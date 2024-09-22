import 'package:flutter/material.dart';

// Class to represent a chat room
class ChatRoom {
  final String id; // Unique identifier for the chat room
  final String name; // Name of the chat room
  final List<String> participants; // List of user IDs or names participating in the chat
  final List<Message> messages; // List of messages sent in the chat room

  ChatRoom({
    required this.id,
    required this.name,
    required this.participants,
    this.messages = const [],
  });
}

// Class to represent a message
class Message {
  final String senderId; // ID of the message sender
  final String content; // Content of the message
  final DateTime timestamp; // Time when the message was sent

  Message({
    required this.senderId,
    required this.content,
    required this.timestamp,
  });
}

// Widget to display the chat room
class ChatRoomWidget extends StatelessWidget {
  final ChatRoom chatRoom; // Instance of ChatRoom to display

  const ChatRoomWidget({super.key, required this.chatRoom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatRoom.name), // Display the name of the chat room
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatRoom.messages.length,
              itemBuilder: (context, index) {
                final message = chatRoom.messages[index];
                return ListTile(
                  title: Text(message.senderId), // Display sender ID
                  subtitle: Text(message.content), // Display message content
                );
              },
            ),
          ),
          // Add other input fields or buttons here for sending messages
        ],
      ),
    );
  }
}
