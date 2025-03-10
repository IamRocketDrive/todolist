import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'todolist.dart';

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
  String profileName = "";

  String showPosition() {
    return "Programmer";
  }

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      profileName = prefs.getString('proflieName') ?? 'ยังไม่ระบุชื่อ';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    print("โหลดหน้าเสร็จละ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'), // ชื่อแถบ AppBar'
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.cyan),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWLZEsfViVN8geWZAoruA5nVopbk7Tdl8pBQ&s'),
                  ),
                  SizedBox(height: 8),
                  const Text(
                    'Panukorn Puripanyanan',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Profile page'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Todo List'),
              onTap: () {},
            )
          ],
        ),
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
            if (profileName == "")
              Text(
                "ยังไม่ระบุ", // ชื่อผู้ใช้
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold), // กำหนดขนาดและน้ำหนักของฟอนต์
              )
            else
              Text(
                profileName, // ชื่อผู้ใช้
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
            ElevatedButton(onPressed: _loadData, child: const Text('Load data'))
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
  final TextEditingController profilenameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('proflieName', profilenameController.text);
    prefs.setString('position', positionController.text);
    prefs.setString('phone', phoneController.text);

    print("บันทึกเรียบร้อย");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green, // กำหนดสีพื้นหลัง
        content: Text('เซฟเรียบร้อย'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูล'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: profilenameController,
                decoration: InputDecoration(
                    hintText: 'ชื่อ สกุล', labelText: 'Enter your name'),
              ),
              TextField(
                controller: positionController,
                decoration: InputDecoration(labelText: "ตำแหน่ง"),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'หมายเลขโทรศัพท์'),
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  _saveData();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfilePage()));
                },
                child: const Text('บันทึก'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
