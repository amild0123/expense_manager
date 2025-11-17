import 'package:intl/intl.dart';

// ============================================================================
// EXERCISE 1: KATEGORI MANAGEMENT (MUDAH)
// ============================================================================

/// Class untuk mengelola kategori custom
class CategoryManager {
  final List<String> _categories = [
    'Makanan',
    'Transportasi',
    'Tagihan',
    'Hiburan',
    'Kesehatan'
  ];

  /// Tambah kategori baru
  void addCategory(String category) {
    if (category.isEmpty) {
      throw Exception('Kategori tidak boleh kosong');
    }
    if (_categories.contains(category)) {
      throw Exception('Kategori "$category" sudah ada');
    }
    _categories.add(category);
    print('✅ Kategori "$category" berhasil ditambahkan');
  }

  /// Hapus kategori
  void removeCategory(String category) {
    if (_categories.remove(category)) {
      print('✅ Kategori "$category" berhasil dihapus');
    } else {
      throw Exception('Kategori "$category" tidak ditemukan');
    }
  }

  /// Dapatkan semua kategori (read-only)
  List<String> get allCategories => List.unmodifiable(_categories);

  /// Cek apakah kategori ada
  bool categoryExists(String category) => _categories.contains(category);

  /// Tampilkan semua kategori
  void displayCategories() {
    print('\n📂 DAFTAR KATEGORI:');
    for (var i = 0; i < _categories.length; i++) {
      print('   ${i + 1}. ${_categories[i]}');
    }
    print('');
  }
}

// ============================================================================
// EXERCISE 2: BUDGET SYSTEM (SEDANG) - Already Implemented Above
// ============================================================================

// 🔹 Enum untuk level alert
enum AlertLevel { info, warning, critical }

// 🔹 Class untuk menyimpan informasi alert
class BudgetAlert {
  final String category;
  final AlertLevel level;
  final String message;
  final double spent;
  final double budget;
  final DateTime timestamp;

  BudgetAlert({
    required this.category,
    required this.level,
    required this.message,
    required this.spent,
    required this.budget,
    required this.timestamp,
  });

  @override
  String toString() {
    String emoji = level == AlertLevel.critical
        ? '🚨'
        : level == AlertLevel.warning
            ? '⚠️'
            : 'ℹ️';
    return '$emoji [$category] $message (Rp${spent.toStringAsFixed(2)} / Rp${budget.toStringAsFixed(2)})';
  }
}

// 🔹 Class untuk expense per kategori
class Expense {
  final String description;
  final double amount;
  final DateTime date;
  final String? userId; // untuk multi-user support

  Expense({
    required this.description,
    required this.amount,
    required this.date,
    this.userId,
  });
}

// 🔹 Class untuk budget per kategori
class CategoryBudget {
  final String category;
  double budgetAmount;
  final List<Expense> expenses = [];
  final List<BudgetAlert> alerts = [];

  CategoryBudget({
    required this.category,
    required this.budgetAmount,
  });

  // Hitung total pengeluaran bulan ini
  double getTotalSpent() {
    return expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  // Hitung sisa budget
  double getRemainingBudget() {
    return budgetAmount - getTotalSpent();
  }

  // Hitung persentase penggunaan budget
  double getUsagePercentage() {
    if (budgetAmount == 0) return 0;
    return (getTotalSpent() / budgetAmount) * 100;
  }

  // Tambah expense dan check alert
  void addExpense(String description, double amount, {String? userId}) {
    expenses.add(Expense(
      description: description,
      amount: amount,
      date: DateTime.now(),
      userId: userId,
    ));
  }

  // Cek dan buat alert jika diperlukan
  BudgetAlert? checkAlert() {
    double spent = getTotalSpent();
    double usage = getUsagePercentage();

    if (spent > budgetAmount) {
      // Critical: sudah melebihi budget
      final alert = BudgetAlert(
        category: category,
        level: AlertLevel.critical,
        message: 'MELEBIHI BUDGET! Pengeluaran sudah melampaui batas.',
        spent: spent,
        budget: budgetAmount,
        timestamp: DateTime.now(),
      );
      alerts.add(alert);
      return alert;
    } else if (usage >= 80) {
      // Warning: sudah mencapai 80% budget
      final alert = BudgetAlert(
        category: category,
        level: AlertLevel.warning,
        message: 'MENDEKATI BATAS! Pengeluaran sudah ${usage.toStringAsFixed(1)}% dari budget.',
        spent: spent,
        budget: budgetAmount,
        timestamp: DateTime.now(),
      );
      alerts.add(alert);
      return alert;
    } else if (usage >= 60) {
      // Info: sudah mencapai 60% budget
      final alert = BudgetAlert(
        category: category,
        level: AlertLevel.info,
        message: 'Informasi: Pengeluaran sudah ${usage.toStringAsFixed(1)}% dari budget.',
        spent: spent,
        budget: budgetAmount,
        timestamp: DateTime.now(),
      );
      alerts.add(alert);
      return alert;
    }
    return null;
  }

  // Reset pengeluaran (untuk bulan baru)
  void resetExpenses() {
    expenses.clear();
  }
}

// ============================================================================
// EXERCISE 3: MULTI-USER SUPPORT (SULIT)
// ============================================================================

/// Class untuk menyimpan profil user
class UserProfile {
  final String username;
  final String email;
  final DateTime createdAt;
  final Map<String, dynamic> settings = {
    'notificationsEnabled': true,
    'currency': 'IDR',
    'theme': 'light',
  };

  UserProfile({
    required this.username,
    required this.email,
  }) : createdAt = DateTime.now();

  void updateSetting(String key, dynamic value) {
    settings[key] = value;
    print('✅ Pengaturan "$key" berhasil diperbarui');
  }

  void displayProfile() {
    print('\n� PROFIL USER:');
    print('   Username    : $username');
    print('   Email       : $email');
    print('   Dibuat      : ${DateFormat('dd MMM yyyy HH:mm').format(createdAt)}');
    print('   Notifikasi  : ${settings['notificationsEnabled']}');
    print('   Mata Uang   : ${settings['currency']}');
    print('   Tema        : ${settings['theme']}');
    print('');
  }
}

/// Class untuk merepresentasikan user
class User {
  final String userId;
  final UserProfile profile;
  String _password;
  bool _isLoggedIn = false;

  User({
    required this.userId,
    required this.profile,
    required String password,
  }) : _password = password;

  /// Login user
  bool login(String password) {
    if (password == _password) {
      _isLoggedIn = true;
      print('✅ User "${profile.username}" berhasil login');
      return true;
    } else {
      print('❌ Password salah');
      return false;
    }
  }

  /// Logout user
  void logout() {
    _isLoggedIn = false;
    print('✅ User "${profile.username}" berhasil logout');
  }

  /// Cek apakah user sedang login
  bool get isLoggedIn => _isLoggedIn;

  /// Ubah password
  void changePassword(String oldPassword, String newPassword) {
    if (oldPassword != _password) {
      throw Exception('Password lama tidak sesuai');
    }
    _password = newPassword;
    print('✅ Password user "${profile.username}" berhasil diubah');
  }
}

/// Class untuk sistem multi-user
class MultiUserSystem {
  final Map<String, User> _users = {};
  String? _currentUserId;
  final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

  /// Register user baru
  void registerUser(String userId, String username, String email, String password) {
    if (_users.containsKey(userId)) {
      throw Exception('User dengan ID "$userId" sudah terdaftar');
    }
    if (password.length < 6) {
      throw Exception('Password minimal 6 karakter');
    }

    final profile = UserProfile(username: username, email: email);
    _users[userId] = User(userId: userId, profile: profile, password: password);
    print('✅ User "$username" berhasil terdaftar dengan ID: $userId');
  }

  /// Login user
  bool loginUser(String userId, String password) {
    if (!_users.containsKey(userId)) {
      throw Exception('User dengan ID "$userId" tidak ditemukan');
    }

    if (_users[userId]!.login(password)) {
      _currentUserId = userId;
      return true;
    }
    return false;
  }

  /// Logout user saat ini
  void logoutUser() {
    if (_currentUserId != null) {
      _users[_currentUserId]!.logout();
      _currentUserId = null;
    }
  }

  /// Dapatkan user yang sedang login
  User? get currentUser =>
      _currentUserId != null ? _users[_currentUserId] : null;

  /// Cek apakah ada user yang login
  bool get isUserLoggedIn => _currentUserId != null;

  /// Tampilkan semua user terdaftar (admin only)
  void displayAllUsers() {
    print('\n👥 DAFTAR USER:');
    _users.forEach((id, user) {
      String status = user.isLoggedIn ? '✅ Login' : '❌ Logout';
      print('   • $id (${user.profile.username}) - $status');
    });
    print('');
  }
}

// ============================================================================
// BUDGET MANAGER DENGAN SUPPORT MULTI-USER
// ============================================================================

class BudgetManager {
  final Map<String, CategoryBudget> categories = {};
  final CategoryManager categoryManager;
  final MultiUserSystem userSystem;
  final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

  BudgetManager({
    required this.categoryManager,
    required this.userSystem,
  });

  // Set budget untuk kategori
  void setBudget(String category, double amount) {
    if (amount < 0) {
      throw Exception('Budget tidak boleh negatif');
    }

    if (!categoryManager.categoryExists(category)) {
      throw Exception('Kategori "$category" tidak tersedia. Silakan tambahkan terlebih dahulu.');
    }

    categories[category] = CategoryBudget(
      category: category,
      budgetAmount: amount,
    );
    String user = userSystem.currentUser?.profile.username ?? 'Admin';
    print('✅ Budget "$category" berhasil diset: ${currencyFormatter.format(amount)} (User: $user)');
  }

  // Tambah expense
  void addExpense(String category, String description, double amount) {
    if (!categories.containsKey(category)) {
      throw Exception(
          'Kategori "$category" belum memiliki budget. Silakan set budget terlebih dahulu.');
    }

    if (amount < 0) {
      throw Exception('Jumlah expense tidak boleh negatif');
    }

    String? userId = userSystem.currentUser?.userId;
    categories[category]!.addExpense(description, amount, userId: userId);
    String user = userSystem.currentUser?.profile.username ?? 'Admin';
    print(
        '📝 Pengeluaran "$description" pada "$category": ${currencyFormatter.format(amount)} (User: $user)');

    // Check alert
    final alert = categories[category]!.checkAlert();
    if (alert != null) {
      print(alert.toString());
    }
  }

  // Dapatkan summary budget saat ini
  Map<String, dynamic> getBudgetSummary(String category) {
    if (!categories.containsKey(category)) {
      throw Exception('Kategori "$category" tidak ditemukan');
    }

    final budget = categories[category]!;
    return {
      'category': category,
      'budget': budget.budgetAmount,
      'spent': budget.getTotalSpent(),
      'remaining': budget.getRemainingBudget(),
      'percentage': budget.getUsagePercentage(),
      'expenses': budget.expenses.length,
    };
  }

  // Generate laporan budget lengkap
  void generateBudgetReport() {
    print('\n' + '=' * 70);
    print('📊 LAPORAN MANAJEMEN BUDGET');
    print('=' * 70);
    String user = userSystem.currentUser?.profile.username ?? 'Admin';
    print('Pengguna   : $user');
    print('Tanggal    : ${DateFormat('dd MMM yyyy HH:mm').format(DateTime.now())}\n');

    double totalBudget = 0;
    double totalSpent = 0;
    int totalAlerts = 0;

    // Summary per kategori
    print('📋 RINGKASAN PER KATEGORI:');
    print('-' * 70);

    categories.forEach((category, budget) {
      totalBudget += budget.budgetAmount;
      totalSpent += budget.getTotalSpent();
      totalAlerts += budget.alerts.length;

      final percentage = budget.getUsagePercentage();
      final statusEmoji = percentage > 100
          ? '🔴'
          : percentage >= 80
              ? '🟠'
              : percentage >= 60
                  ? '🟡'
                  : '🟢';

      print('$statusEmoji $category');
      print('   Budget      : ${currencyFormatter.format(budget.budgetAmount)}');
      print('   Pengeluaran : ${currencyFormatter.format(budget.getTotalSpent())}');
      print('   Sisa        : ${currencyFormatter.format(budget.getRemainingBudget())}');
      print(
          '   Penggunaan  : ${percentage.toStringAsFixed(1)}% [${'█' * ((percentage.toInt()) ~/ 10)}${('░' * (10 - (percentage.toInt()) ~/ 10))}]');
      print('   Jumlah Item : ${budget.expenses.length}');
      print('');
    });

    // Total summary
    print('-' * 70);
    print('💰 TOTAL KESELURUHAN:');
    print('   Total Budget    : ${currencyFormatter.format(totalBudget)}');
    print('   Total Pengeluaran: ${currencyFormatter.format(totalSpent)}');
    print('   Total Sisa      : ${currencyFormatter.format(totalBudget - totalSpent)}');
    print(
        '   Penggunaan Total: ${totalBudget > 0 ? ((totalSpent / totalBudget) * 100).toStringAsFixed(1) : '0.0'}%');
    print('   Total Kategori  : ${categories.length}');
    print('   Total Alert     : $totalAlerts\n');

    // Detail pengeluaran per kategori
    print('📝 DETAIL PENGELUARAN:');
    print('-' * 70);
    categories.forEach((category, budget) {
      if (budget.expenses.isNotEmpty) {
        print('$category:');
        for (var i = 0; i < budget.expenses.length; i++) {
          final expense = budget.expenses[i];
          String userInfo =
              expense.userId != null ? ' (User: ${expense.userId})' : '';
          print('   ${i + 1}. ${expense.description}');
          print(
              '      Jumlah: ${currencyFormatter.format(expense.amount)} | Tanggal: ${DateFormat('dd/MM/yyyy').format(expense.date)}$userInfo');
        }
        print('');
      }
    });

    // Alert summary
    if (totalAlerts > 0) {
      print('⚠️  RINGKASAN ALERT:');
      print('-' * 70);
      categories.forEach((category, budget) {
        if (budget.alerts.isNotEmpty) {
          for (var alert in budget.alerts) {
            print(alert.toString());
          }
        }
      });
      print('');
    }

    print('=' * 70 + '\n');
  }

  // Reset semua pengeluaran (untuk bulan baru)
  void resetMonthlyExpenses() {
    categories.forEach((category, budget) {
      budget.resetExpenses();
    });
    print('🔄 Semua pengeluaran telah direset untuk bulan baru.');
  }

  // Tampilkan kategori yang tersedia
  void listCategories() {
    categoryManager.displayCategories();
  }
}

