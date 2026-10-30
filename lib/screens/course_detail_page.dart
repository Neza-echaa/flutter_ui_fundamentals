
import 'package:flutter/material.dart';
import '../models/course.dart';

// Nama: Neza Aulia Safitri
// NIM: 2415051035

class CourseDetailPage extends StatefulWidget {
  final Course course;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const CourseDetailPage({
    super.key,
    required this.course,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  State<CourseDetailPage> createState() =>
      _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  bool showDescription = true;

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.school,
              size: 70,
            ),
            const SizedBox(height: 20),
            Text(
              course.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Kode: ${course.code}',
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 8),
            Text(
              'SKS: ${course.credits}',
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${course.status}',
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Deskripsi',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      showDescription = !showDescription;
                    });
                  },
                  child: Text(
                    showDescription
                        ? 'Sembunyikan'
                        : 'Tampilkan',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (showDescription)
              Text(
                course.description,
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  widget.onToggleFavorite();
                  Navigator.pop(context);
                },
                icon: Icon(
                  widget.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                label: Text(
                  widget.isFavorite
                      ? 'Hapus dari Favorit'
                      : 'Pilih / Favorite Course',
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 12),
            const Text(
              'Identitas Mahasiswa',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Nama: Neza Aulia Safitri'),
            const SizedBox(height: 4),
            const Text('NIM: 2415051035'),
          ],
        ),
      ),
    );
  }
}
