
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
import '../widgets/error_view.dart';
import 'add_course_page.dart';
// Nama: Neza Aulia Safitri
// NIM: 2415051035

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  void showFavoriteMessage(
    BuildContext context,
    Course course,
    bool wasFavorite,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          wasFavorite
              ? '${course.title} dihapus dari favorit'
              : '${course.title} ditambahkan ke favorit',
        ),
      ),
    );
  }
//2415051035_Neza Aulia Safitri
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    return Scaffold(
      appBar: AppBar(
  title: const Text('Courses'),
  actions: [
    IconButton(
      tooltip: 'Tambah Course',
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AddCoursePage(),
          ),
        );
      },
    ),
  ],
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
              : provider.courses.isEmpty
                  ? const Center(
                      child: Text('Belum ada data mata kuliah.'),
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth;
                        final columns = width < 840 ? 2 : 3;

                        Widget buildCourseCard(Course course) {
                          final isFavorite = provider.isFavorite(course.code);

                          return CourseCard(
                            course: course,
                            isFavorite: isFavorite,
                            onFavorite: () {
                              showFavoriteMessage(
                                context,
                                course,
                                isFavorite,
                              );

                              context
                                  .read<CourseProvider>()
                                  .toggleFavorite(course.code);
                            },
                          );
                        }

                        if (width < 600) {
                          return ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount: provider.courses.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              return buildCourseCard(
                                provider.courses[index],
                              );
                            },
                          );
                        }

                        return GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: columns,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.25,
                          ),
                          itemCount: provider.courses.length,
                          itemBuilder: (context, index) {
                            return buildCourseCard(
                              provider.courses[index],
                            );
                          },
                        );
                      },
                    ),
    );
  }
}
