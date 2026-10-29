
import 'package:flutter/material.dart';

// Nama: Neza Aulia Safitri
// NIM: 2415051035

class CourseState extends ChangeNotifier {
  // Menyimpan kode course yang ditandai sebagai favorit.
  final Set<String> favorites = {};

  // Menambahkan atau menghapus course dari favorit.
  void toggleFavorite(String id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }

    // Memberi tahu widget listener bahwa state berubah.
    notifyListeners();
  }
}
