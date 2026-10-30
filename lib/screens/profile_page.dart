import 'package:flutter/material.dart';
import '../widgets/student_identity_card.dart';

// Nama: Neza Aulia Safitri
// NIM: 2415051035
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
