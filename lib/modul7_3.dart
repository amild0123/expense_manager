import 'package:intl/intl.dart';

// Kelas induk dasar
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

  void printDetails() {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    print('Deskripsi: $description');
    print('Kategori: $category');
    print('Jumlah: ${formatter.format(amount)}');
    print('Tanggal: ${DateFormat('dd-MM-yyyy').format(date)}');
  }
}

// Kelas turunan untuk pengeluaran berulang
class RecurringExpense extends Expense {
  String frequency; // Harian, Mingguan, Bulanan

  RecurringExpense({
    required String description,
    required double amount,
    required String category,
    required this.frequency,
  }) : super(
          description: description,
          amount: amount,
          category: category,
          date: DateTime.now(),
        );

  double yearlyTotal() {
    switch (frequency.toLowerCase()) {
      case 'harian':
        return amount * 365;
      case 'mingguan':
        return amount * 52;
      case 'bulanan':
        return amount * 12;
      default:
        return amount;
    }
  }

  @override
  void printDetails() {
    super.printDetails();
    print('Frekuensi: $frequency');
    print('Total per tahun: Rp ${yearlyTotal().toStringAsFixed(2)}');
  }
}

// Kelas langganan yang meng-extend RecurringExpense
class SubscriptionExpense extends RecurringExpense {
  String provider;
  String plan;
  DateTime startDate;
  DateTime? endDate;

  SubscriptionExpense({
    required String description,
    required double amount,
    required this.provider,
    required this.plan,
    required this.startDate,
    this.endDate,
  }) : super(
          description: description,
          amount: amount,
          category: 'Langganan',
          frequency: 'bulanan',
        );

  bool isActive() {
    DateTime now = DateTime.now();
    if (endDate == null) return true; // Tidak ada end date = aktif
    return now.isBefore(endDate!);
  }

  int getRemainingMonths() {
    if (endDate == null) return -1; // Unlimited
    DateTime now = DateTime.now();
    if (now.isAfter(endDate!)) return 0;

    int months = (endDate!.year - now.year) * 12 + (endDate!.month - now.month);
    return months;
  }

  double getTotalCost() {
    if (endDate == null) {
      // Jika tidak ada end date, hitung untuk 1 tahun
      return yearlyTotal();
    }

    int months = (endDate!.year - startDate.year) * 12 +
        (endDate!.month - startDate.month);
    return amount * months;
  }

  @override
  void printDetails() {
    print('📱 LANGGANAN');
    print('$description ($provider - $plan)');
    print('Biaya: Rp ${amount.toStringAsFixed(2)}/bulan');
    print('Mulai: ${DateFormat('dd-MM-yyyy').format(startDate)}');

    if (endDate != null) {
      print('Berakhir: ${DateFormat('dd-MM-yyyy').format(endDate!)}');
      print('Sisa: ${getRemainingMonths()} bulan');
    } else {
      print('Berakhir: Tidak pernah (berkelanjutan)');
    }

    print('Status: ${isActive() ? "Aktif ✅" : "Expired ❌"}');
    print('Total biaya: Rp ${getTotalCost().toStringAsFixed(2)}');
  }
}

void main() {
  var netflix = SubscriptionExpense(
    description: 'Netflix Premium',
    amount: 186000,
    provider: 'Netflix',
    plan: 'Premium 4K',
    startDate: DateTime(2024, 1, 1),
    endDate: null, // Berkelanjutan
  );

  var adobe = SubscriptionExpense(
    description: 'Adobe Creative Cloud',
    amount: 800000,
    provider: 'Adobe',
    plan: 'Semua Apps',
    startDate: DateTime(2025, 9, 1),
    endDate: DateTime(2025, 12, 31),
  );

  netflix.printDetails();
  print('');
  adobe.printDetails();
}