import 'package:flutter/material.dart';

void main() =>
    runApp(const MyApp()); // เริ่มแอปด้วยฟังก์ชัน main() และเรียกใช้ MyApp

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // สร้าง MyApp class เป็น StatelessWidget

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ซ่อน debug banner
      title: 'Simple UI Design', // กำหนดชื่อแอป
      theme:
          ThemeData(primarySwatch: Colors.blue), // กำหนดธีมสีหลักเป็นสีน้ำเงิน
      home: const UserProfilePage(), // กำหนดหน้าแรกของแอป
    );
  }
}

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  // สร้างหน้าของโปรไฟล์ผู้ใช้
  String username = "Super X";
  String showPosition() {
    return "Programmer";
  }

  int calOnePlusOne() {
    return 1 + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'), // ชื่อแถบ AppBar
      ),
      body: Center(
        // ใช้ Center widget เพื่อจัดตำแหน่งทั้งหมดให้อยู่ตรงกลาง
        child: Column(
          // ใช้ Column เพื่อจัดเรียง widget แนวตั้ง
          mainAxisAlignment: MainAxisAlignment.center, // จัดกลางตามแนวตั้ง
          crossAxisAlignment: CrossAxisAlignment.center, // จัดกลางตามแนวนอน
          children: [
            CircleAvatar(
              radius: 50, // กำหนดขนาดของวงกลมรูปภาพ
              backgroundImage: NetworkImage(
                  'https://www.example.com/profile.jpg'), // ใช้รูปโปรไฟล์จาก URL
            ),
            SizedBox(height: 16), // เพิ่มช่องว่างระหว่างรูปภาพและข้อความ
            Text(
              username, // ชื่อผู้ใช้
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold), // กำหนดขนาดและน้ำหนักของฟอนต์
            ),
            SizedBox(height: 8), // เพิ่มช่องว่างระหว่างชื่อและอาชีพ
            Text(
              showPosition(), // อาชีพของผู้ใช้
              style: TextStyle(
                  fontSize: 18, color: Colors.grey), // กำหนดขนาดและสีของฟอนต์
            ),
            SizedBox(height: 16), // เพิ่มช่องว่างระหว่างอาชีพและเบอร์โทร
            Text(
              '+123 456 7890', // เบอร์โทรของผู้ใช้
              style: TextStyle(fontSize: 18), // กำหนดขนาดฟอนต์
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, // ใช้ context เพื่อเข้าถึง Navigator
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(), // ไปหน้า Edit
                  ),
                );
              },
              child: const Text('แก้ไข'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูล'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: 'ชื่อ สกุล', labelText: 'Enter your name'),
            ),
            TextField(
              decoration: InputDecoration(labelText: "ตำแหน่ง"),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'หมายเลขโทรศัพท์'),
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, // ใช้ context เพื่อเข้าถึง Navigator
                  MaterialPageRoute(
                    builder: (context) => UserProfilePage(), // ไปหน้า แรก
                  ),
                );
              },
              child: const Text('บันทึก'),
            ),
          ],
        ),
      ),
    );
  }
}
