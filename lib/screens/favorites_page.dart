import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
import '../widgets/error_view.dart';
// Nama: Neza Aulia Safitri
// NIM: 2415051035

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    final favoriteCourses = provider.courses
        .where((course) => provider.isFavorite(course.code))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: provider.isLoading
    ? const Center(
        child: CircularProgressIndicator(),
      )
    : provider.error != null
        ? ErrorView(
            message: provider.error!,
            onRetry: provider.loadCourses,
          )
        : favoriteCourses.isEmpty
            ? const Center(
                child: Text('Belum ada mata kuliah favorit.'),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: favoriteCourses.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final course = favoriteCourses[index];

                  return CourseCard(
                    course: course,
                    isFavorite: provider.isFavorite(course.code),
                    onFavorite: () {
                      context
                          .read<CourseProvider>()
                          .toggleFavorite(course.code);
                    },
                  );
                },
              ),
    );
  }
}