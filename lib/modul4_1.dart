class Category {
  String _name;
  String _icon;
  double _budget;

  Category({
    required String name,
    required String icon,
    required double budget,
  }) : _name = name,
       _icon = icon,
       _budget = budget {
    if (_budget < 0) {
      throw Exception('Budget tidak boleh negatif');
    }
  }

  // Getter
  String get name => _name;
  String get icon => _icon;
  double get budget => _budget;

  // Setter dengan validasi
  set budget(double value) {
    if (value < 0) {
      throw Exception('Budget tidak boleh negatif');
    }
    _budget = value;
  }

  // Method
  bool isOverBudget(double spent) {
    return spent > _budget;
  }

  void cetakStatus(double spent) {
    String status = isOverBudget(spent) ? '❌ Melebihi budget!' : '✅ Masih dalam budget';
    print('$_icon $_name: Rp${spent.toStringAsFixed(2)} / Rp${_budget.toStringAsFixed(2)} - $status');
  }
}

void main() {
  var makanan = Category(
    name: 'Makanan',
    icon: '🍔',
    budget: 500.0,
  );

  makanan.cetakStatus(350.0);  // Masih dalam budget
  makanan.cetakStatus(550.0);  // Melebihi budget

  // Test validasi
  try {
    makanan.budget = -100;
  } catch (e) {
    print('Error: $e');
  }
}