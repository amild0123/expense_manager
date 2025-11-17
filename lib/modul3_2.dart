class Expense {
  String description;
  double amount;
  String category;
  DateTime date;
  String? notes;

  Expense(this.description, this.amount, this.category, this.date, {this.notes});

  // Constructor split bill
  Expense.splitBill(
    String desc,
    double totalAmount,
    int people,
  ) : description = '$desc (patungan $people orang)',
      amount = totalAmount / people,
      category = 'Makanan',
      date = DateTime.now(),
      notes = 'Patungan dengan $people orang';

  // Constructor kalkulator tip
  Expense.tip(
    String desc,
    double baseAmount,
    double tipPercent,
  ) : description = desc,
      amount = baseAmount * (1 + tipPercent / 100),
      category = 'Makanan',
      date = DateTime.now(),
      notes = 'Termasuk tip ${tipPercent}%';

  // Constructor expense berulang
  Expense.recurring(
    this.description,
    this.amount,
    String frequency,
  ) : category = 'Tagihan',
      date = DateTime.now(),
      notes = 'Berulang: $frequency';
}

void main() {
  var dinner = Expense.splitBill('Makan malam di restoran', 120.00, 4);
  var lunch = Expense.tip('Makan siang', 25.00, 20);
  var gym = Expense.recurring('Membership gym', 45.00, 'bulanan');

  print('${dinner.description}: \$${dinner.amount.toStringAsFixed(2)} - ${dinner.notes}');
  print('${lunch.description}: \$${lunch.amount.toStringAsFixed(2)} - ${lunch.notes}');
  print('${gym.description}: \$${gym.amount.toStringAsFixed(2)} - ${gym.notes}');
}