
class Expense {
  final String description;
  final double amount;
  final String category;
  final DateTime date;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
  });

  // Metode dasar untuk mencetak detail
  void printDetails() {
    print('📝 Deskripsi: $description');
    print('   Jumlah: Rp${_formatRupiah(amount)}');
    print('   Kategori: $category');
    print('   Tanggal: ${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}');
  }

  // Helper untuk format Rupiah sederhana (tanpa koma ribuan, hanya 2 desimal)
  String _formatRupiah(double value) {
    return value.toStringAsFixed(2);
  }
}

class TravelExpense extends Expense {
  final String destination;
  final int tripDuration;

  TravelExpense({
    required String description,
    required double amount,
    required this.destination,
    required this.tripDuration,
    DateTime? date,
  }) : super(
          description: description,
          amount: amount,
          category: 'Perjalanan',
          date: date ?? DateTime.now(),
        );

  double getDailyCost() {
    // Jika durasi 0 atau negatif, kembalikan total amount (atau 0, tergantung kebijakan)
    if (tripDuration <= 0) return amount;
    return amount / tripDuration;
  }

  bool isInternational() {
    // Cek berdasarkan negara umum
    final internationalCountries = [
      'Jepang', 'Singapura', 'Malaysia', 'Korea',
      'Thailand', 'Vietnam', 'Amerika', 'Inggris', 'Prancis', 'Jerman'
    ];
    return internationalCountries.any(destination.contains);
  }

  @override
  void printDetails() {
    print('✈ PENGELUARAN PERJALANAN');
    super.printDetails();
    print('   Destinasi: $destination');
    print('   Durasi: $tripDuration hari');
    print('   Biaya harian: Rp${_formatRupiah(getDailyCost())}');
    print('   Internasional: ${isInternational() ? "Ya 🌍" : "Tidak 🏠"}');
  }

  // Reuse formatter dari parent
  String _formatRupiah(double value) {
    return value.toStringAsFixed(2);
  }
}