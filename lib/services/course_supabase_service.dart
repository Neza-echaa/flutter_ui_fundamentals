// Nama: Neza Aulia Safitri
// NIM: 2415051035

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/course.dart';
import 'course_data_source.dart';

class CourseSupabaseService implements CourseDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<Course>> getCourses() async {
    final data = await supabase
        .from('courses')
        .select()
        .order('id');

    return (data as List)
        .map(
          (e) => Course.fromJson(
            e as Map<String, dynamic>,
          ),
        )
        .toList();
  }

@override
Future<Course> createCourse(Course course) async {
  final row = await supabase
      .from('courses')
      .insert({
        'code': course.code,
        'title': course.title,
        'credits': course.credits,
        'status': course.status,
      })
      .select()
      .single();

  return Course.fromJson(row);
}
 @override
Future<void> updateCourse(int id, Course course) async {
  await supabase
      .from('courses')
      .update({
        'code': course.code,
        'title': course.title,
        'credits': course.credits,
        'status': course.status,
      })
      .eq('id', id);
}

  @override
  Future<void> deleteCourse(int id) {
    throw UnimplementedError();
  }
}