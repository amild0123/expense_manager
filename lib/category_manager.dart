// 🔹 Exercise 1: Category Management (MUDAH)
// Izinkan pengguna membuat kategori custom

class CategoryManager {
  final List<String> _categories = [
    'Makanan',
    'Transportasi',
    'Tagihan',
  ];

  // Tambah kategori baru
  void addCategory(String category) {
    if (category.isEmpty) {
      throw Exception('Nama kategori tidak boleh kosong');
    }

    if (_categories.contains(category)) {
      throw Exception('Kategori "$category" sudah ada');
    }

    _categories.add(category);
    print('✅ Kategori "$category" berhasil ditambahkan');
  }

  // Hapus kategori
  void removeCategory(String category) {
    if (_categories.contains(category)) {
      _categories.remove(category);
      print('✅ Kategori "$category" berhasil dihapus');
    } else {
      throw Exception('Kategori "$category" tidak ditemukan');
    }
  }

  // Dapatkan semua kategori (immutable list)
  List<String> get allCategories => List.unmodifiable(_categories);

  // Cek kategori ada atau tidak
  bool hasCategory(String category) {
    return _categories.contains(category);
  }

  // Tampilkan semua kategori
  void displayCategories() {
    print('📂 DAFTAR KATEGORI YANG TERSEDIA:');
    for (int i = 0; i < _categories.length; i++) {
      print('   ${i + 1}. ${_categories[i]}');
    }
    print('   Total: ${_categories.length} kategori\n');
  }
}
