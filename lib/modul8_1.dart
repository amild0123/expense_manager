import 'package:intl/intl.dart';

/// --------------------
/// KELAS DASAR PAYMENT
/// --------------------
abstract class PaymentMethod {
  String get name;
  String get icon;

  bool validate();
  void processPayment(double amount);

  void showReceipt(double amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    print('✅ Pembayaran sebesar ${formatter.format(amount)} dengan $name berhasil!');
  }
}
/// --------------------
/// KELAS EXPENSE
/// --------------------
class Expense {
  final String description;
  final double amount;
  final String category;
  final DateTime date;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  void payWith(PaymentMethod method) {
    print('🧾 Pembayaran untuk "$description" (${category})');
    method.processPayment(amount);
  }
}

/// --------------------
/// KELAS CRYPTOCURRENCY
/// --------------------
class Cryptocurrency extends PaymentMethod {
  final String walletAddress;
  final String coinType;

  Cryptocurrency({
    required this.walletAddress,
    required this.coinType,
  });

  @override
  String get name => 'Dompet $coinType';

  @override
  String get icon => '₿';

  @override
  bool validate() {
    // Wallet harus tidak kosong dan panjang > 20
    return walletAddress.isNotEmpty && walletAddress.length > 20;
  }

  @override
  void processPayment(double amount) {
    if (!validate()) {
      print('❌ Alamat wallet tidak valid');
      return;
    }

    print('$icon Memproses pembayaran dengan $coinType...');
    print('Wallet: ${walletAddress.substring(0, 6)}...${walletAddress.substring(walletAddress.length - 4)}');
    print('⏳ Menunggu konfirmasi blockchain...');
    showReceipt(amount);
  }
}

/// --------------------
/// MAIN FUNCTION
/// --------------------
void main() {
  var btc = Cryptocurrency(
    walletAddress: '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa',
    coinType: 'Bitcoin',
  );

  var expense = Expense(
    description: 'Pembelian online',
    amount: 250000,
    category: 'Belanja',
  );

  expense.payWith(btc);
}