
import 'package:flutter/material.dart';

const String studentName = 'Neza Aulia Safitri';
const String studentId = '2415051035';

class StudentIdentityCard extends StatelessWidget {
  const StudentIdentityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(
          studentName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('NIM: $studentId'),
      ),
    );
  }
}
