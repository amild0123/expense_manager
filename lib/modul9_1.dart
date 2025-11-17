class CategoryManager {
  final List<String> _categories = ['Makanan', 'Transportasi', 'Tagihan'];

  /// Tambahkan kategori baru
  void addCategory(String category) {
    if (category.trim().isEmpty) {
      print('❌ Nama kategori tidak boleh kosong');
      return;
    }

    if (_categories.contains(category)) {
      print('⚠ Kategori "$category" sudah ada');
      return;
    }

    _categories.add(category);
    print('✅ Kategori "$category" berhasil ditambahkan');
  }

  /// Hapus kategori yang sudah ada
  void removeCategory(String category) {
    if (!_categories.contains(category)) {
      print('❌ Kategori "$category" tidak ditemukan');
      return;
    }

    _categories.remove(category);
    print('🗑 Kategori "$category" telah dihapus');
  }

  /// Mengembalikan semua kategori (read-only)
  List<String> get allCategories => List.unmodifiable(_categories);
}

void main() {
  var manager = CategoryManager();

  print('📋 Kategori awal: ${manager.allCategories}');

  manager.addCategory('Hiburan');
  manager.addCategory('Makanan'); // kategori duplikat
  manager.addCategory(''); // kategori kosong

  print('📋 Setelah penambahan: ${manager.allCategories}');

  manager.removeCategory('Transportasi');
  manager.removeCategory('Pendidikan'); // kategori tidak ada

  print('📋 Setelah penghapusan: ${manager.allCategories}');
}