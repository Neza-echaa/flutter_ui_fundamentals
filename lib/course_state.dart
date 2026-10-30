import 'package:flutter/material.dart';
import 'models/course.dart';
import 'repositories/course_repository.dart';
import 'services/course_api_service.dart';

// Nama: Neza Aulia Safitri
// NIM: 2415051035

class CourseState extends ChangeNotifier {
  CourseState({CourseRepository? repository})
      : _repository =
            repository ?? CourseRepository(CourseApiService());

  final CourseRepository _repository;

  // Menyimpan kode course yang ditandai sebagai favorit.
  final Set<String> favorites = {};

  // Menyimpan data course yang dimuat dari Repository.
  List<Course> courses = [];

  bool isLoading = false;
  String? errorMessage;

  // Memuat data melalui Repository.
  Future<void> loadCourses() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      courses = await _repository.getCourses();
    } catch (e) {
      errorMessage = 'Gagal memuat data mata kuliah: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Menambahkan atau menghapus course dari favorit.
  void toggleFavorite(String id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }

    notifyListeners();
  }
}