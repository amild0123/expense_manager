import 'package:intl/intl.dart';

// 🔹 Class dasar Expense
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

  // Format jumlah ke rupiah
  String getFormattedAmount() {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    return formatter.format(amount);
  }

  // Method untuk menampilkan detail pengeluaran
  void printDetails() {
    print('🧾 DETAIL PENGELUARAN');
    print('   Deskripsi : $description');
    print('   Kategori  : $category');
    print('   Jumlah    : ${getFormattedAmount()}');
    print('   Tanggal   : ${DateFormat('dd MMM yyyy').format(date)}');
  }
}

// 🔹 Class turunan BusinessExpense
class BusinessExpense extends Expense {
  String client;
  bool isReimbursable;

  BusinessExpense({
    required String description,
    required double amount,
    required String category,
    required this.client,
    this.isReimbursable = true,
  }) : super(
          description: description,
          amount: amount,
          category: category,
          date: DateTime.now(),
        );

  // Override method printDetails()
  @override
  void printDetails() {
    print('💼 PENGELUARAN BISNIS');
    super.printDetails(); // panggil versi parent (Expense)
    print('   Klien     : $client');
    print('   Reimburse : ${isReimbursable ? "Ya ✅" : "Tidak ❌"}');
  }
}

// 🔹 Fungsi utama
void main() {
  var expense = BusinessExpense(
    description: 'Makan siang klien',
    amount: 85.0,
    category: 'Makan',
    client: 'PT Acme',
    isReimbursable: true,
  );

  expense.printDetails();
}