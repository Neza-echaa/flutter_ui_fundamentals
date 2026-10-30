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
}