class Expense{
  String category;
  DateTime date;
  double amount;

Expense(this.category, this.date, this.amount);
  bool isThisMonth() {
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  bool isFood() {
    return category == 'Makanan';
  }

  int getDaysAgo() {
    DateTime now = DateTime.now();
    return now.difference(date).inDays;
  }
}

void main(){
  Expense e1 = Expense('makanan', DateTime(2025, 10, 19), 50000);
  print(e1.isThisMonth());
  print(e1.isFood());
  print(e1.getDaysAgo());
}