import 'package:flutter/material.dart';
import 'chat_screen.dart'; // Import the chat screen
import 'chat_room.dart'; // Import the chat room model

class ChatRoomListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final chatRooms = [
      ChatRoom(id: '1', name: 'General Chat', participants: ['user1', 'user2']),
      ChatRoom(id: '2', name: 'Flutter Devs', participants: ['user3', 'user4']),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Rooms'),
      ),
      body: ListView.builder(
        itemCount: chatRooms.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(chatRooms[index].name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(chatRoom: chatRooms[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
