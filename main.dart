import 'package:flutter/material.dart';

void main() => runApp(const MyApp()); // ฟังก์ชัน main เริ่มต้นการทำงานของแอป

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // สร้าง MaterialApp ซึ่งเป็นแอปหลัก
      debugShowCheckedModeBanner: false, // ปิดแถบ Debug ที่แสดงในโหมด Debug
      title: 'To-Do List', // กำหนดชื่อของแอป
      theme: ThemeData(primarySwatch: Colors.blue), // กำหนดธีมหลักของแอปให้ใช้สีฟ้า
      home: const HomePage(), // ตั้งหน้าหลักของแอปเป็น HomePage
    );
  }
}

class HomePage extends StatefulWidget { 
  const HomePage({super.key}); // สร้างคลาส HomePage ซึ่งเป็น StatefulWidget

  @override
  State<HomePage> createState() => _HomePageState(); // เชื่อมโยงกับคลาส _HomePageState
}

class _HomePageState extends State<HomePage> { 
  final List<String> _tasks = []; // ตัวแปรเก็บรายการ Task
  final TextEditingController _controller = TextEditingController(); // ควบคุมข้อความใน TextField

  // ฟังก์ชันเพิ่ม Task
  void _addTask(String task) {
    if (task.isNotEmpty) { // ตรวจสอบหากข้อความไม่ว่าง
      setState(() { // อัปเดต UI
        _tasks.add(task); // เพิ่ม Task ใหม่ในรายการ
      });
      _controller.clear(); // ล้างข้อความใน TextField
    }
  }

  // ฟังก์ชันลบ Task
  void _removeTask(int index) {
    setState(() { // อัปเดต UI
      _tasks.removeAt(index); // ลบ Task ที่ตำแหน่ง index
    });
  }

  @override
  Widget build(BuildContext context) { // ฟังก์ชันที่สร้าง UI
    return Scaffold( // ใช้ Scaffold ซึ่งเป็น layout พื้นฐาน
      appBar: AppBar( // สร้าง AppBar
        title: const Text('To-Do List'), // ชื่อของแอปใน AppBar
        backgroundColor: Colors.amber, // สีพื้นหลังของ AppBar
        elevation: 10, // เพิ่มเงาให้ AppBar
        shadowColor: Colors.black.withOpacity(0.5), // เพิ่มสีเงาเป็นสีดำและโปร่งใส
      ),
      body: SingleChildScrollView( // ใช้ SingleChildScrollView เพื่อให้สามารถเลื่อนหน้าจอได้
        child: Padding( 
          padding: const EdgeInsets.all(8.0), // กำหนดขอบของเนื้อหาภายใน
          child: Column( // ใช้ Column ในการจัดวาง UI
            crossAxisAlignment: CrossAxisAlignment.start, // จัดตำแหน่ง widget ภายใน column
            children: [
              Row( // ใช้ Row สำหรับจัดเรียง TextField และ ElevatedButton ในแถวเดียวกัน
                children: [
                  Expanded( // ใช้ Expanded เพื่อให้ TextField ขยายเต็มพื้นที่
                    child: TextField( // สร้าง TextField สำหรับกรอก Task
                      controller: _controller, // ใช้ controller เพื่อควบคุมข้อความ
                      decoration: const InputDecoration( // ลักษณะของ TextField
                        hintText: 'Add a new task', // ข้อความแนะนำ
                        border: OutlineInputBorder(), // กรอบของ TextField
                      ),
                    ),
                  ),
                  const SizedBox(width: 8), // เพิ่มช่องว่างระหว่าง TextField และปุ่ม
                  ElevatedButton( // สร้างปุ่ม ElevatedButton
                    onPressed: () => _addTask(_controller.text), // เมื่อกดปุ่มให้เรียกฟังก์ชัน _addTask
                    child: const Text('Add'), // ข้อความในปุ่ม
                  ),
                ],
              ),
              const SizedBox(height: 16), // ช่องว่างระหว่างส่วนบนและ ListView
              ListView.builder( // สร้าง ListView สำหรับแสดงรายการ Task
                shrinkWrap: true, // ทำให้ ListView ใช้พื้นที่แค่ที่จำเป็น
                physics: NeverScrollableScrollPhysics(), // ปิดการเลื่อนใน ListView
                itemCount: _tasks.length, // จำนวนรายการ Task
                itemBuilder: (context, index) => ListTile( // สร้าง ListTile สำหรับแต่ละ Task
                  title: Text(_tasks[index]), // ข้อความใน ListTile เป็น Task ที่ตำแหน่ง index
                  trailing: IconButton( // สร้างปุ่ม Icon ที่ใช้ในการลบ Task
                    icon: const Icon(Icons.delete), // ใช้ไอคอนลบ
                    onPressed: () => _removeTask(index), // เมื่อกดปุ่มจะเรียกฟังก์ชัน _removeTask
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
