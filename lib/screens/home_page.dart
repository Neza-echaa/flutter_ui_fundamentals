
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';
import '../models/course.dart';
import '../widgets/student_identity_card.dart';

// Nama: Neza Aulia Safitri
// NIM: 2415051035

class HomePage extends StatelessWidget {
  final VoidCallback onOpenCourses;
  final ValueNotifier<int> favoriteCounter;

  const HomePage({
    super.key,
    required this.onOpenCourses,
    required this.favoriteCounter,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    final sampleJson = <String, dynamic>{
      'code': 'PTI101',
      'title': 'Pemrograman Dasar',
      'credits': 3,
      'status': 'Aktif',
    };

    final sampleCourse = Course.fromJson(sampleJson);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat Datang!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Temukan berbagai course yang tersedia.',
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 24),

            const StudentIdentityCard(),

            const SizedBox(height: 24),

            Card(
              child: ListTile(
                leading: const Icon(Icons.data_object),
                title: Text(sampleCourse.title),
                subtitle: Text(
                  'Kode: ${sampleCourse.code} • '
                  '${sampleCourse.credits} SKS • '
                  'Status: ${sampleCourse.status}',
                ),
              ),
            ),

            const SizedBox(height: 24),

            Card(
              child: ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Course Favorit'),
                subtitle: Text(
                  '${provider.favorites.length} course ditandai sebagai favorit',
                ),
                trailing: Consumer<CourseProvider>(
                  builder: (context, state, child) {
                    final firstCourse = state.courses.isNotEmpty
                        ? state.courses.first
                        : null;

                    final isFavorite = firstCourse != null &&
                        state.favorites.contains(firstCourse.code);

                    return IconButton(
                      tooltip: 'Toggle favorite',
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      onPressed: firstCourse == null
                          ? null
                          : () {
                              context
                                  .read<CourseProvider>()
                                  .toggleFavorite(firstCourse.code);
                            },
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Latihan ValueNotifier',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ValueListenableBuilder<int>(
                      valueListenable: favoriteCounter,
                      builder: (context, value, child) {
                        return Text(
                          'Jumlah favorite: $value',
                          style: const TextStyle(fontSize: 16),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        favoriteCounter.value++;
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Tambah jumlah'),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: () {
                        favoriteCounter.value = 0;
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset jumlah'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.explore,
                      size: 40,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Course Explorer',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Aplikasi untuk melihat daftar course, '
                      'detail course, favorite, dan feedback.',
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: onOpenCourses,
                      icon: const Icon(Icons.school),
                      label: const Text('Lihat Courses'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
