class Category {
  String name;
  String icon;
  String color;

  Category({
    required this.name,
    required this.icon,
    required this.color,
  });

  String getLabel() {
    return '$icon $name';
  }
}

void main() {
  var food = Category(name: 'Makanan', icon: '🍔', color: 'green');
  var transport = Category(name: 'Transport', icon: '🚗', color: 'blue');

  print(food.getLabel());
  print(transport.getLabel());
}
