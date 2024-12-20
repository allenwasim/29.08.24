import 'package:flutter/material.dart';

class GymScreen extends StatelessWidget {
  const GymScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture Section
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person, size: 50, color: Colors.grey[700]),
              ),
              SizedBox(height: 8),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.camera_alt, color: Colors.teal),
              ),
              SizedBox(height: 16),

              // User Information
              Text(
                'allen',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('allen', style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text(
                '+91 9188223629',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text(
                'allenwasimk@gmail.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              SizedBox(height: 24),

              // Options Section
              ListTile(
                leading: Icon(Icons.view_list, color: Colors.teal),
                title: Text('Plans'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.teal),
                title: Text('Services'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.report_problem, color: Colors.teal),
                title: Text('Request An Feature/Report an issue'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.phone, color: Colors.teal),
                title: Text('Contact us'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.help, color: Colors.teal),
                title: Text('How to use GymBook?'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
