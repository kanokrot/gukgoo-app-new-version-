import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  final String username;

  const ProfileScreen({Key? key, required this.username}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  TextEditingController _noteController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // ไม่มีเงา
        actions: [
          Positioned(
            top: 16,
            right: 16,
            child: TextButton(
              onPressed: () {
                // เพิ่มฟังก์ชันการออกจากระบบ
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // พื้นหลังสีชมพูที่ครึ่งบน
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: const Color.fromARGB(255, 247, 185, 196),
              height: MediaQuery.of(context).size.height * 0.6, // 70% ของความสูงหน้าจอ
            ),
          ),
          Positioned(
            top: 20,
            left: 25,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // กรอบวงกลมสีชมพู
                Container(
                  width: 90, // ขนาดรวมของกรอบ
                  height: 90,
                  
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(255, 247, 185, 196), // สีของกรอบ
                  ),
                ),
                // รูปโปรไฟล์
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? const Icon(Icons.person, size: 40, color: Colors.white)
                      : null,
                ),
                // Feather icon สำหรับอัพโหลดรูป
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(Icons.create, size: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft, // จัดให้ชิดซ้าย
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40), // เว้นระยะทางซ้าย
                    child: Text(
                      widget.username,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // เว้นระยะห่าง
                // กล่องโน้ต
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 252, 253),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _noteController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Note',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white, // สีพื้นหลังหลักเป็นสีขาว
    );
  }
}
