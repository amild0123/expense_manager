// 🔹 Exercise 3: Multi-User Support (SULIT)
// Tambahkan akun pengguna sehingga banyak orang bisa melacak pengeluaran mereka
//MODUL9_3
class UserProfile {
  final String userId;
  final String name;
  final String email;
  final Map<String, String> settings = {
    'theme': 'light',
    'currency': 'IDR',
    'notifications': 'true',
  };
  final DateTime createdAt;
  DateTime lastLogin;

  UserProfile({
    required this.userId,
    required this.name,
    required this.email,
  })  : createdAt = DateTime.now(),
        lastLogin = DateTime.now();

  // Update pengaturan user
  void updateSetting(String key, String value) {
    settings[key] = value;
    print('✅ Pengaturan "$key" diubah menjadi "$value"');
  }

  // Tampilkan profile
  void displayProfile() {
    print('👤 PROFIL USER');
    print('   ID       : $userId');
    print('   Nama     : $name');
    print('   Email    : $email');
    print('   Dibuat   : $createdAt');
    print('   Login    : $lastLogin');
    print('   Settings : ${settings.entries.map((e) => '${e.key}=${e.value}').join(', ')}');
    print('');
  }
}

class User {
  final String userId;
  final String name;
  final String email;
  final String _password; // In real app, hash this!
  final UserProfile profile;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required String password,
  })  : _password = password,
        profile = UserProfile(userId: userId, name: name, email: email);

  // Verifikasi password
  bool verifyPassword(String password) {
    return _password == password; // In production, use proper hashing!
  }
}

class MultiUserSystem {
  final Map<String, User> users = {};
  User? currentUser;

  // Register user baru
  void registerUser(String userId, String name, String email, String password) {
    if (users.containsKey(userId)) {
      throw Exception('User ID "$userId" sudah terdaftar');
    }

    if (userId.isEmpty || password.isEmpty) {
      throw Exception('User ID dan password tidak boleh kosong');
    }

    users[userId] = User(
      userId: userId,
      name: name,
      email: email,
      password: password,
    );
    print('✅ User "$userId" ($name) berhasil didaftarkan');
  }

  // Login user
  void loginUser(String userId, String password) {
    if (!users.containsKey(userId)) {
      throw Exception('User "$userId" tidak ditemukan');
    }

    final user = users[userId]!;
    if (!user.verifyPassword(password)) {
      throw Exception('Password salah untuk user "$userId"');
    }

    currentUser = user;
    user.profile.lastLogin = DateTime.now();
    print('✅ User "${user.name}" berhasil login');
  }

  // Logout user
  void logoutUser() {
    if (currentUser == null) {
      throw Exception('Tidak ada user yang sedang login');
    }
    print('✅ User "${currentUser!.name}" berhasil logout');
    currentUser = null;
  }

  // Cek user login
  bool isLoggedIn() {
    return currentUser != null;
  }

  // Dapatkan current user ID
  String? getCurrentUserId() {
    return currentUser?.userId;
  }

  // Tampilkan semua user
  void displayAllUsers() {
    print('👥 DAFTAR SEMUA USER:');
    if (users.isEmpty) {
      print('   Belum ada user terdaftar');
    } else {
      users.forEach((userId, user) {
        final status = currentUser?.userId == userId ? ' 🟢 (Online)' : '';
        print('   • $userId - ${user.name} (${user.email})$status');
      });
    }
    print('   Total: ${users.length} user\n');
  }
}
