
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'course_state.dart';

const String studentName = 'Neza Aulia Safitri';
const String studentId = '2415051035';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseState(),
      child: const CourseExplorerApp(),
    ),
  );
}

// ============================================================
// MODEL COURSE
// ============================================================

class Course {
  final String title;
  final String code;
  final int credits;
  final String status;
  final String description;

  const Course({
    required this.title,
    required this.code,
    required this.credits,
    required this.status,
    required this.description,
  });
}

// ============================================================
// DATA COURSE
// ============================================================

const List<Course> courses = [
  Course(
    title: 'Pemrograman Mobile',
    code: 'PMB101',
    credits: 3,
    status: 'Aktif',
    description:
        'Mempelajari pengembangan aplikasi mobile menggunakan Flutter dan Dart.',
  ),
  Course(
    title: 'Basis Data',
    code: 'BD201',
    credits: 3,
    status: 'Aktif',
    description:
        'Mempelajari konsep basis data, SQL, relasi, dan pengelolaan data.',
  ),
  Course(
    title: 'Pemrograman Web',
    code: 'WEB201',
    credits: 3,
    status: 'Aktif',
    description:
        'Mempelajari pengembangan aplikasi berbasis web menggunakan teknologi modern.',
  ),
  Course(
    title: 'Kecerdasan Buatan',
    code: 'AI301',
    credits: 3,
    status: 'Aktif',
    description:
        'Mempelajari konsep dasar kecerdasan buatan dan penerapannya.',
  ),
  Course(
    title: 'Metode Penelitian',
    code: 'MP301',
    credits: 2,
    status: 'Aktif',
    description:
        'Mempelajari metode dan proses penelitian dalam bidang teknologi informasi.',
  ),
  Course(
    title: 'Design Thinking',
    code: 'DT201',
    credits: 2,
    status: 'Aktif',
    description:
        'Mempelajari proses pemecahan masalah secara kreatif dan berorientasi pengguna.',
  ),
];

// ============================================================
// APP
// ============================================================

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const ResponsiveShell(),
    );
  }
}

// ============================================================
// RESPONSIVE SHELL
// ============================================================

class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});

  @override
  State<ResponsiveShell> createState() =>
      _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int selectedIndex = 0;

  // Shared state untuk course favorit.
  final Set<String> favoriteCourses = {};

  // State sederhana menggunakan ValueNotifier.
  final ValueNotifier<int> favoriteCounter =
      ValueNotifier<int>(0);

  void toggleFavorite(Course course) {
    setState(() {
      if (favoriteCourses.contains(course.code)) {
        favoriteCourses.remove(course.code);
      } else {
        favoriteCourses.add(course.code);
      }
    });
  }

  void showFeedbackSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Feedback berhasil dikirim!'),
      ),
    );
  }

  @override
  void dispose() {
    favoriteCounter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        favoriteCourses: favoriteCourses,
        onToggleFavorite: toggleFavorite,
        favoriteCounter: favoriteCounter,
        onOpenCourses: () {
          setState(() {
            selectedIndex = 1;
          });
        },
      ),
      CoursesPage(
        favoriteCourses: favoriteCourses,
        onToggleFavorite: toggleFavorite,
      ),
      ProfilePage(
        onSubmitFeedback: showFeedbackSuccess,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 840) {
          return Scaffold(
            body: pages[selectedIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.school_outlined),
                  selectedIcon: Icon(Icons.school),
                  label: 'Courses',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        }

        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                labelType: NavigationRailLabelType.all,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.school_outlined),
                    selectedIcon: Icon(Icons.school),
                    label: Text('Courses'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person),
                    label: Text('Profile'),
                  ),
                ],
              ),
              const VerticalDivider(width: 1),
              Expanded(
                child: pages[selectedIndex],
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================
// REUSABLE WIDGET 1: COURSE CARD
// ============================================================

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
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
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

// ============================================================
// HOME PAGE
// ============================================================

class HomePage extends StatelessWidget {
  final VoidCallback onOpenCourses;
  final Set<String> favoriteCourses;
  final Function(Course) onToggleFavorite;
  final ValueNotifier<int> favoriteCounter;

  const HomePage({
    super.key,
    required this.onOpenCourses,
    required this.favoriteCourses,
    required this.onToggleFavorite,
    required this.favoriteCounter,
  });

  @override
  Widget build(BuildContext context) {
    final firstCourse = courses.first;
    final firstCourseIsFavorite =
        favoriteCourses.contains(firstCourse.code);

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

            // Ringkasan course favorit.
            Card(
              child: ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Course Favorit'),
                subtitle: Text(
                  '${favoriteCourses.length} course ditandai sebagai favorit',
                ),
                trailing: IconButton(
                  tooltip: 'Toggle favorite',
                  icon: Icon(
                    firstCourseIsFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  onPressed: () {
                    onToggleFavorite(firstCourse);
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Latihan ValueNotifier.
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

// ============================================================
// REUSABLE WIDGET 2: STUDENT IDENTITY CARD
// ============================================================

class StudentIdentityCard extends StatelessWidget {
  const StudentIdentityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(
          studentName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('NIM: $studentId'),
      ),
    );
  }
}

// ============================================================
// COURSES PAGE
// ============================================================

class CoursesPage extends StatelessWidget {
  final Set<String> favoriteCourses;
  final Function(Course) onToggleFavorite;

  const CoursesPage({
    super.key,
    required this.favoriteCourses,
    required this.onToggleFavorite,
  });

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          if (width < 600) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: courses.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final course = courses[index];
                final isFavorite =
                    favoriteCourses.contains(course.code);

                return CourseCard(
                  course: course,
                  isFavorite: isFavorite,
                  onFavorite: () {
                    showFavoriteMessage(
                      context,
                      course,
                      isFavorite,
                    );
                    onToggleFavorite(course);
                  },
                );
              },
            );
          }

          final columns = width < 840 ? 2 : 3;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.25,
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              final isFavorite =
                  favoriteCourses.contains(course.code);

              return CourseCard(
                course: course,
                isFavorite: isFavorite,
                onFavorite: () {
                  showFavoriteMessage(
                    context,
                    course,
                    isFavorite,
                  );
                  onToggleFavorite(course);
                },
              );
            },
          );
        },
      ),
    );
  }
}

// ============================================================
// COURSE DETAIL PAGE
// ============================================================

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
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
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

// ============================================================
// PROFILE PAGE + FEEDBACK FORM
// ============================================================

class ProfilePage extends StatefulWidget {
  final VoidCallback onSubmitFeedback;

  const ProfilePage({
    super.key,
    required this.onSubmitFeedback,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController nimController;

  final TextEditingController commentController =
      TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: studentName,
    );

    nimController = TextEditingController(
      text: studentId,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    nimController.dispose();
    commentController.dispose();
    super.dispose();
  }

  Future<void> submitFeedback() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text(
            'Apakah Anda yakin ingin mengirim feedback?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                processFeedback();
              },
              child: const Text('Kirim'),
            ),
          ],
        );
      },
    );
  }

  Future<void> processFeedback() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    widget.onSubmitFeedback();
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Feedback'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profile Mahasiswa',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const StudentIdentityCard(),
              const SizedBox(height: 28),

              const Text(
                'Feedback',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: nimController,
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'NIM wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: commentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Komentar',
                  hintText:
                      'Masukkan komentar minimal 5 karakter',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Komentar wajib diisi';
                  }

                  if (value.trim().length < 5) {
                    return 'Komentar minimal 5 karakter';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed:
                      isLoading ? null : submitFeedback,
                  icon: const Icon(Icons.send),
                  label: const Text('Kirim Feedback'),
                ),
              ),

              const SizedBox(height: 24),

              if (isLoading)
                const Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 12),
                      Text('Mengirim feedback...'),
                    ],
                  ),
                ),

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 12),

              const Text(
                'Nama: Neza Aulia Safitri',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text('NIM: 2415051035'),
            ],
          ),
        ),
      ),
    );
  }
}
