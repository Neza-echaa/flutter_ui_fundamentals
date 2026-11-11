
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
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('Kamu harus login terlebih dahulu.');
    }

    final row = await supabase
        .from('courses')
        .insert({
          'code': course.code,
          'title': course.title,
          'credits': course.credits,
          'status': course.status,
          'owner_id': user.id,
        })
        .select()
        .single();

    return Course.fromJson(row);
  }

  @override
  Future<void> updateCourse(int id, Course course) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('Kamu harus login terlebih dahulu.');
    }

    final result = await supabase
        .from('courses')
        .update({
          'code': course.code,
          'title': course.title,
          'credits': course.credits,
          'status': course.status,
        })
        .eq('id', id)
        .select('id')
        .maybeSingle();

    if (result == null) {
      throw Exception(
        'Course tidak ditemukan atau kamu tidak memiliki akses untuk mengubahnya.',
      );
    }
  }

  @override
  Future<void> deleteCourse(int id) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('Kamu harus login terlebih dahulu.');
    }

    final result = await supabase
        .from('courses')
        .delete()
        .eq('id', id)
        .select('id')
        .maybeSingle();

    if (result == null) {
      throw Exception(
        'Course tidak ditemukan atau kamu tidak memiliki akses untuk menghapusnya.',
      );
    }
  }
}
