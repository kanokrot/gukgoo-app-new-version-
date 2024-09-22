import 'package:flutter/material.dart';
import 'package:gukgoo/screens/chat_room.dart'; // Ensure this imports the ChatRoom class
import 'package:gukgoo/screens/chat_screen.dart'; // Ensure this imports ChatScreen
import 'notifications.dart';
import 'profile.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;
  late final ChatRoom chatRoom; // Declare a ChatRoom instance

  @override
  void initState() {
    super.initState();
    
    // Create a sample ChatRoom instance
    chatRoom = ChatRoom(
      id: '1',
      name: 'General Chat',
      participants: ['user1', 'user2', 'user3'],
    );

    _pages = [
      ChatScreen(chatRoom: chatRoom), // Pass the ChatRoom instance here
      NotificationScreen(),
      ProfileScreen(username: widget.username),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'Chat'
              : _selectedIndex == 1
                  ? 'Notifications'
                  : 'Profile',
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
