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

  bool isThisMonth(){
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  bool isMajorExpense() {
    return amount > 100.0;
  }

  String getSummary() {
    return '$description: \$${amount.toStringAsFixed(2)} (${category}, ${date.toLocal()})';
  }
}

void main() {
  var expenses = [
    Expense( 
      description: 'Sewa',
      amount: 1200.00,
      category: 'Tagihan',
      date: DateTime(2025, 10, 1),
    ),
    Expense(
      description: 'Makan siang',
      amount: 15.50,
      category: 'Makanan',
      date: DateTime(2025, 10, 5),
    ),
    Expense(
      description: 'Kopi',
      amount: 4.50,
      category: 'Makanan',
      date: DateTime(2025, 10, 6),
    ),
    Expense(
      description: 'Belanja',
      amount: 89.30,
      category: 'Makanan',
      date: DateTime(2025, 10, 7),
    ),
    Expense(
      description: 'Uber',
      amount: 12.00,
      category: 'Transport',
      date: DateTime(2025, 10, 8),
    ),
  ];

  // 1. Print expenses bulan ini
  print('PENGELUARAN BULAN INI:');
  for (var expense in expenses) {
    if (expense.isThisMonth()) {
      print(expense.getSummary());
    }
  }

  // 2. Total expense makanan
  double foodTotal = 0;
  for (var expense in expenses) {
    if (expense.category == 'Makanan') {
      foodTotal += expense.amount;
    }
  }
  print('\nTotal makanan: \$${foodTotal.toStringAsFixed(2)}');

  // 3. Temukan expense terbesar
  Expense? largest;
  for (var expense in expenses) {
    if (largest == null || expense.amount > largest.amount) {
      largest = expense;
    }
  }
  print('Terbesar: ${largest?.getSummary()}');

  // 4. Hitung pengeluaran besar
  int majorCount = 0;
  for (var expense in expenses) {
    if (expense.isMajorExpense()) {
      majorCount++;
    }
  }
  print('Pengeluaran besar: $majorCount');
}
