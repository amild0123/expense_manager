import 'package:intl/intl.dart';

/// --------------------
/// INTERFACE REFUNDABLE
/// --------------------
abstract class Refundable {
  bool canRefund();
  void processRefund(double amount);
}

/// --------------------
/// KELAS ABSTRAK PAYMENT
/// --------------------
abstract class PaymentMethod {
  String get name;
  String get icon;

  void processPayment(double amount);

  void showReceipt(double amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    print('✅ Pembayaran sebesar ${formatter.format(amount)} menggunakan $name berhasil!');
  }
}

/// --------------------
/// KELAS CREDIT CARD
/// --------------------
class CreditCard extends PaymentMethod implements Refundable {
  final String cardNumber;
  final String cardHolder;
  final List<double> transactions = [];

  CreditCard({
    required this.cardNumber,
    required this.cardHolder,
  });

  @override
  String get name => 'Kartu Kredit';

  @override
  String get icon => '💳';

  @override
  void processPayment(double amount) {
    transactions.add(amount);
    print('$icon Mendebet Rp ${amount.toStringAsFixed(2)}');
    showReceipt(amount);
  }

  @override
  bool canRefund() {
    return transactions.isNotEmpty;
  }

  @override
  void processRefund(double amount) {
    if (!canRefund()) {
      print('❌ Tidak ada transaksi untuk direfund');
      return;
    }

    print('🔄 Memproses refund Rp ${amount.toStringAsFixed(2)}');
    print('   Refund akan muncul dalam 3–5 hari kerja');
    transactions.add(-amount); // negatif = refund
  }
}

/// --------------------
/// KELAS CASH (tidak refundable)
/// --------------------
class Cash extends PaymentMethod {
  @override
  String get name => 'Tunai';

  @override
  String get icon => '💵';

  @override
  void processPayment(double amount) {
    print('$icon Pembayaran tunai: Rp ${amount.toStringAsFixed(2)}');
    showReceipt(amount);
  }
}

/// --------------------
/// MAIN FUNCTION
/// --------------------
void main() {
  var card = CreditCard(
    cardNumber: '4532123456789012',
    cardHolder: 'John Doe',
  );

  var cash = Cash();

  // Transaksi kartu kredit
  card.processPayment(100000.0);

  // ✅ Bisa refund (karena CreditCard implements Refundable)
  if (card is Refundable) {
    card.processRefund(50000.0);
  }

  print('----------------------');

  // Transaksi tunai
  cash.processPayment(50000.0);

  // ❌ Tidak bisa refund tunai
  if (cash is Refundable) {
    (cash as Refundable).processRefund(25000.0);
  } else {
    print('❌ Pembayaran tunai tidak dapat direfund');
 }
}