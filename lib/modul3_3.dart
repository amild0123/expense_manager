class User {
  String name;
  String email;
  String currency;
  double monthlyBudget;
  bool notifications;

  User({
    required this.name,
    required this.email,
    required this.currency,
    required this.monthlyBudget,
    this.notifications = true,
  });

  User.quick(this.name, this.email)
    : currency = 'USD',
      monthlyBudget = 2000.0,
      notifications = true;

  User.premium(this.name, this.email, this.monthlyBudget)
    : currency = 'USD',
      notifications = true;

  void printProfile() {
    String notif = notifications ? '✅' : '❌';
    print('─────────────────');
    print('👤 $name');
    print('📧 $email');
    print('💵 Budget: $currency \$${monthlyBudget.toStringAsFixed(2)}/bulan');
    print('🔔 Notifikasi: $notif');
  }
}

void main() {
  var user1 = User.quick('John Doe', 'john@example.com');
  var user2 = User.premium('Jane Smith', 'jane@example.com', 3500.0);
  var user3 = User(
    name: 'Bob Wilson',
    email: 'bob@example.com',
    currency: 'EUR',
    monthlyBudget: 2500.0,
    notifications: false,
  );

  user1.printProfile();
  user2.printProfile();
  user3.printProfile();
}