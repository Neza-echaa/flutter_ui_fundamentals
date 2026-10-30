
import 'package:flutter/material.dart';
import '../models/course.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import 'edit_course_page.dart';
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
  Future<void> confirmDelete(Course course) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Course?'),
          content: Text(
            'Apakah kamu yakin ingin menghapus '
            '${course.title}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (!mounted || confirmed != true) return;

    final id = course.id;

    if (id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ID course tidak ditemukan.'),
        ),
      );
      return;
    }

    final provider = context.read<CourseProvider>();
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      await provider.deleteCourse(id, course.code);

      if (!mounted) return;

      messenger.showSnackBar(
        const SnackBar(
          content: Text('Course berhasil dihapus!'),
          backgroundColor: Colors.green,
        ),
      );

      navigator.pop();
    } catch (e) {
      if (!mounted) return;

      messenger.showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus course: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

final course = provider.courses.firstWhere(
  (item) => item.code == widget.course.code,
  orElse: () => widget.course,
);

final isFavorite = provider.isFavorite(course.code);
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

// Tombol Favorite
SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    onPressed: () {
      context
          .read<CourseProvider>()
          .toggleFavorite(course.code);
    },
    icon: Icon(
      isFavorite
          ? Icons.favorite
          : Icons.favorite_border,
    ),
    label: Text(
      isFavorite
          ? 'Hapus dari Favorit'
          : 'Pilih / Favorite Course',
    ),
  ),
),

const SizedBox(height: 12),

// Tombol Edit
SizedBox(
  width: double.infinity,
  child: OutlinedButton.icon(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditCoursePage(
            course: course,
          ),
        ),
      );
    },
    icon: const Icon(Icons.edit),
    label: const Text('Edit Course'),
  ),
),
const SizedBox(height: 12),

SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    onPressed: provider.isSaving
        ? null
        : () => confirmDelete(course),
    icon: const Icon(Icons.delete),
    label: const Text('Hapus Course'),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
    ),
  ),
),
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
