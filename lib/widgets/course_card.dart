import 'package:flutter/material.dart';
import '../models/course.dart';
import '../screens/course_detail_page.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final bool isFavorite;
  final VoidCallback onFavorite;

  const CourseCard({
    super.key,
    required this.course,
    required this.isFavorite,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CourseProvider>(context);
    final favoriteStatus = provider.isFavorite(course.code);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CourseDetailPage(
                course: course,
                isFavorite: isFavorite,
                onToggleFavorite: onFavorite,
              ),
            ),
          );
        },
        onLongPress: () {
          showDialog(
            context: context,
            builder: (dialogContext) {
              return AlertDialog(
                title: Text(course.title),
                content: Text(course.description),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    child: const Text('Tutup'),
                  ),
                ],
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.school),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      course.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onFavorite,
                    tooltip: 'Favorite',
                    icon: Icon(
                      favoriteStatus
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favoriteStatus ? Colors.red : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '${course.code} • ${course.credits} SKS',
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                course.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Chip(
                label: Text(course.status),
                avatar: const Icon(
                  Icons.check_circle,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
