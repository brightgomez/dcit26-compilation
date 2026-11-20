import 'package:flutter/material.dart';

void main() {
  runApp(const StudentProfileApp());
}

class StudentProfileApp extends StatelessWidget {
  const StudentProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 2 - Student Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E5E3A)),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1E5E3A),
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Profile Card matching lab layout
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F2EC),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: const Color(0xFFA5D6A7),
                      child: Text(
                        'JB',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E5E3A),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Joneil Bright V. Gomez',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E5E3A),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'BSCS • 3rd Year • Section 1',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),

              // 1. Name
              _buildProfileField(
                label: 'Name',
                value: 'Joneil Bright V. Gomez',
              ),

              // 2. Age
              _buildProfileField(
                label: 'Age',
                value: '20',
              ),

              // 3. Course/Year/Section
              _buildProfileField(
                label: 'Course/Year/Section',
                value: 'Bachelor of Science in Computer Science / 3rd Year / BSCS 3-1',
              ),

              // 4. About me
              _buildProfileField(
                label: 'About me',
                value:
                    '3rd-year Computer Science student at Cavite State University focusing on software engineering, technical analysis, and UI/UX application development.',
              ),

              // 5. Achievements
              _buildProfileField(
                label: 'Achievements',
                value:
                    '• System Analyst & QA Lead for the Bureau of Debugging student development team\n• Lead Systems Analyst on the BayaniHub SK Operations Management System',
              ),

              // 6. Skills
              _buildProfileField(
                label: 'Skills',
                value:
                    'Flutter, Dart, Java, C++, PHP, JavaScript, MySQL, Git, UI Prototyping (Figma)',
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildProfileField({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5E3A),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF2C3E50),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}