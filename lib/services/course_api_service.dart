
// 2415051035_Neza Aulia Safitri
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/course.dart';

class CourseApiService {
  static const String baseUrl =
      'https://course-api-pearl.vercel.app/courses';

  Future<List<Course>> getCourses() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map(
            (json) => Course.fromJson(
              json as Map<String, dynamic>,
            ),
          )
          .toList();
    }

    throw Exception(
      'Gagal mengambil data course: HTTP ${response.statusCode}',
    );
  }

  // Membuat course baru menggunakan HTTP POST.
  Future<Course> createCourse(Course course) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(course.toJson()),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      final data = jsonDecode(response.body);

      return Course.fromJson(
        data as Map<String, dynamic>,
      );
    }

    throw Exception(
      'Gagal membuat course: HTTP ${response.statusCode}',
    );
  }
}
