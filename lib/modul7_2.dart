import 'package:intl/intl.dart';

// 🔹 Class induk Expense
class Expense {
  String description;
  double amount;
  String category;
  DateTime date;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
  });

  // Format jumlah ke dalam Rupiah
  String getFormattedAmount() {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    return formatter.format(amount);
  }

  // Tampilkan detail pengeluaran umum
  void printDetails() {
    print('🧾 DETAIL PENGELUARAN');
    print('   Deskripsi : $description');
    print('   Kategori  : $category');
    print('   Jumlah    : ${getFormattedAmount()}');
    print('   Tanggal   : ${DateFormat('dd MMM yyyy').format(date)}');
  }
}

// 🔹 Class turunan TravelExpense
class TravelExpense extends Expense {
  String destination;
  int tripDuration;

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

  // 1️⃣ Menghitung biaya per hari
  double getDailyCost() {
    if (tripDuration <= 0) return amount;
    return amount / tripDuration;
  }

  // 2️⃣ Mengecek apakah destinasi internasional
  bool isInternational() {
    // Contoh sederhana — bisa diganti dengan list negara sebenarnya
    return destination.contains('Jepang') ||
        destination.contains('Singapura') ||
        destination.contains('Malaysia') ||
        destination.contains('Korea') ||
        destination.contains('Thailand') ||
        destination.contains('Amerika') ||
        destination.contains('Eropa');
  }

  // 3️⃣ Override printDetails
  @override
  void printDetails() {
    print('✈ PENGELUARAN PERJALANAN');
    super.printDetails();
    print('   Destinasi : $destination');
    print('   Durasi    : $tripDuration hari');
    print('   Biaya/hari: Rp ${getDailyCost().toStringAsFixed(2)}');
    print('   Internasional: ${isInternational() ? "Ya 🌍" : "Tidak 🏠"}');
  }
}

void main() {
  var trip = TravelExpense(
    description: 'Liburan Tokyo',
    amount: 25000000.0,
    destination: 'Tokyo, Jepang',
    tripDuration: 7,
  );

  trip.printDetails();
}