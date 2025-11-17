class User {
  String _name;
  String _email;
  int _age;

  User({
    required String name,
    required String email,
    required int age,
  }) : _name = name,
       _email = email,
       _age = age {
    if (!_email.contains('@')) {
      throw Exception('Format email tidak valid');
    }
    if (_age < 13 || _age > 120) {
      throw Exception('Usia harus antara 13 dan 120');
    }
  }

  // Getter
  String get name => _name;
  String get email => _email;
  int get age => _age;

  // Computed getter
  bool get isAdult => _age >= 18;

  String get kategoriUsia {
    if (_age < 18) return 'Anak';
    if (_age < 65) return 'Dewasa';
    return 'Lansia';
  }

  String get displayName => '$_name ($kategoriUsia, $_age)';

  // Setter dengan validasi
  set email(String value) {
    if (!value.contains('@')) {
      throw Exception('Format email tidak valid');
    }
    _email = value;
  }

  set age(int value) {
    if (value < 13 || value > 120) {
      throw Exception('Usia harus antara 13 dan 120');
    }
    _age = value;
  }

  void cetakProfil() {
    print('👤 $displayName');
    print('📧 $_email');
    print('Status: ${isAdult ? "Dewasa ✅" : "Anak ❌"}');
  }
}

void main() {
  var user = User(
    name: 'Budi',
    email: 'budi@example.com',
    age: 25,
  );
  user.cetakProfil();

  print('\\n--- Uji validasi ---');

  try {
    user.email = 'emailtidakvalid';
  } catch (e) {
    print('❌ $e');
  }

  try {
    user.age = 150;
  } catch (e) {
    print('❌ $e');
  }
}