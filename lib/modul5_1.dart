

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

  // 1️⃣ Nomor minggu dalam tahun
  int getWeekNumber() {
    // Compute day-of-year without relying on `intl` DateFormat.
    // DateTime.difference returns the duration between Jan 1st of the year
    // and the given date; add 1 because Jan 1st is day 1.
    int dayOfYear = date.difference(DateTime(date.year, 1, 1)).inDays + 1;
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  // 2️⃣ Kuartal (1-4)
  int getQuarter() {
    return ((date.month - 1) / 3).floor() + 1;
  }

  // 3️⃣ Apakah akhir pekan?
  bool isWeekend() {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }
}

void main() {
  var expense = Expense(
    description: 'Brunch akhir pekan',
    amount: 45.00,
    category: 'Makanan',
    date: DateTime(2025, 10, 11), // Sabtu
  );

  print('Nomor minggu: ${expense.getWeekNumber()}');
  print('Kuartal: ${expense.getQuarter()}');
  print('Akhir pekan? ${expense.isWeekend()}');
}