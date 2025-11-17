class Budget {
  String category;
  double limit;
  int month;
  int year;

  Budget(this.category, this.limit, this.month, this.year);

  Budget.monthly(this.category, this.limit)
    : month = DateTime.now().month,
      year = DateTime.now().year;

  void printDetails() {
    print('$category: \$${limit.toStringAsFixed(2)} untuk $month/$year');
  }
}

void main() {
  var foodBudget = Budget.monthly('Makanan', 500.0);
  var rentBudget = Budget('Sewa', 1200.0, 10, 2025);

  foodBudget.printDetails();
  rentBudget.printDetails();
}