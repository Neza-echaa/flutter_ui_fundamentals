
import 'package:flutter/material.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';
// Nama: Neza Aulia Safitri
// NIM: 2415051035

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  CourseProvider(this.repository);

  // Data mata kuliah.
  List<Course> courses = [];

  // State untuk loading dan error.
  bool isLoading = false;
  String? error;

  // Menyimpan kode course yang ditandai sebagai favorit.
  final Set<String> favorites = {};

  // Memuat data mata kuliah dari Repository.
  Future<void> loadCourses() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      courses = await repository.getCourses();
    } catch (e) {
      error = e.toString();
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
