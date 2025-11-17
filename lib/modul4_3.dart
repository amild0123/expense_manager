class BankAccount {
  String _accountHolder;
  double _balance;
  String _pin;

  BankAccount({
    required String accountHolder,
    required String pin,
    double initialBalance = 0,
  }) : _accountHolder = accountHolder,
       _pin = pin,
       _balance = initialBalance {
    if (_pin.length != 4) {
      throw Exception('PIN harus 4 digit');
    }
    if (_balance < 0) {
      throw Exception('Saldo awal tidak boleh negatif');
    }
  }

  // Getter
  String get accountHolder => _accountHolder;
  double get balance => _balance;  // Read-only, tidak ada setter!

  // Method deposit
  void deposit(double amount) {
    if (amount <= 0) {
      print('❌ Jumlah deposit harus positif');
      return;
    }
    _balance += amount;
    print('✅ Deposit Rp${amount.toStringAsFixed(2)}. Saldo baru: Rp${_balance.toStringAsFixed(2)}');
  }

  // Method withdraw dengan validasi PIN
  bool withdraw(double amount, String pin) {
    if (pin != _pin) {
      print('❌ PIN salah');
      return false;
    }

    if (amount <= 0) {
      print('❌ Jumlah penarikan harus positif');
      return false;
    }

    if (amount > _balance) {
      print('❌ Saldo tidak cukup. Saldo: Rp${_balance.toStringAsFixed(2)}');
      return false;
    }

    _balance -= amount;
    print('✅ Tarik Rp${amount.toStringAsFixed(2)}. Saldo baru: Rp${_balance.toStringAsFixed(2)}');
    return true;
  }

  // Ganti PIN
  bool changePin(String oldPin, String newPin) {
    if (oldPin != _pin) {
      print('❌ PIN lama salah');
      return false;
    }

    if (newPin.length != 4) {
      print('❌ PIN baru harus 4 digit');
      return false;
    }

    _pin = newPin;
    print('✅ PIN berhasil diubah');
    return true;
  }

  void cetakRekening() {
    print('─────────────────────────────');
    print('Pemilik Rekening: $_accountHolder');
    print('Saldo: Rp${_balance.toStringAsFixed(2)}');
    print('─────────────────────────────');
  }
}

void main() {
  var rekening = BankAccount(
    accountHolder: 'Budi',
    pin: '1234',
    initialBalance: 1000.0,
  );

  rekening.cetakRekening();

  print('\n--- Transaksi ---');
  rekening.deposit(500.0);
  rekening.withdraw(200.0, '1234');
  rekening.withdraw(200.0, '0000');  // PIN salah
  rekening.withdraw(2000.0, '1234');  // Saldo tidak cukup

  print('\n--- Ganti PIN ---');
  rekening.changePin('0000', '5678');  // PIN lama salah
  rekening.changePin('1234', '5678');  // Berhasil

  print('');
  rekening.cetakRekening();
}