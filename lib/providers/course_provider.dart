
import 'package:flutter/material.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';

// Nama: Neza Aulia Safitri
// NIM: 2415051035

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  CourseProvider(this.repository);

  List<Course> courses = [];

  bool isLoading = false;
  bool isSaving = false;
  String? error;

  final Set<String> favorites = {};

  // Memuat data mata kuliah.
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

  // Menyimpan course baru.
  Future<Course> createCourse(Course course) async {
    if (isSaving) {
      throw Exception('Penyimpanan sedang berlangsung.');
    }

    isSaving = true;
    notifyListeners();

    try {
      final createdCourse =
          await repository.createCourse(course);

      await loadCourses();

      if (error != null) {
        throw Exception(
          'Course berhasil dibuat, tetapi daftar gagal diperbarui: $error',
        );
      }

      return createdCourse;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }
    // Memperbarui course yang sudah ada.
  Future<void> updateCourse(int id, Course course) async {
    if (isSaving) {
      throw Exception('Penyimpanan sedang berlangsung.');
    }

    isSaving = true;
    notifyListeners();

    try {
      await repository.updateCourse(id, course);

      await loadCourses();

      if (error != null) {
        throw Exception(
          'Course berhasil diperbarui, tetapi daftar gagal dimuat: $error',
        );
      }
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }
    // Menghapus course yang dipilih.
  Future<void> deleteCourse(int id, String code) async {
    if (isSaving) {
      throw Exception('Proses penyimpanan sedang berlangsung.');
    }

    isSaving = true;
    notifyListeners();

    try {
      await repository.deleteCourse(id);

      // Hapus course dari daftar Favorites.
      favorites.remove(code);

      // Muat ulang daftar course.
      await loadCourses();

      if (error != null) {
        throw Exception(
          'Course berhasil dihapus, tetapi daftar gagal dimuat: $error',
        );
      }
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  bool isFavorite(String code) {
    return favorites.contains(code);
  }

  void toggleFavorite(String code) {
    if (favorites.contains(code)) {
      favorites.remove(code);
    } else {
      favorites.add(code);
    }

    notifyListeners();
  }
}
