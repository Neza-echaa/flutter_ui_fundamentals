
// 2415051035_Neza Aulia Safitri
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/course.dart';
import 'course_data_source.dart';

class CourseApiService implements CourseDataSource {
  static const String baseUrl =
      'https://course-api-pearl.vercel.app/courses';
@override
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

  @override// Membuat course baru menggunakan HTTP POST.
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
   @override // Memperbarui course menggunakan HTTP PUT.
  Future<void> updateCourse(int id, Course course) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'code': course.code,
        'title': course.title,
        'credits': course.credits,
        'status': course.status,
        'description': course.description,
      }),
    );

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw Exception(
        'Gagal memperbarui course: HTTP ${response.statusCode}',
      );
    }
  }
  @override  // Menghapus course menggunakan HTTP DELETE.
  Future<void> deleteCourse(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
    );

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw Exception(
        'Gagal menghapus course: HTTP ${response.statusCode}',
      );
    }
  }
}
