import 'package:intl/intl.dart';

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

  Expense({
    required this.description,
    required this.amount,
    required this.date,
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
  void addExpense(String description, double amount) {
    expenses.add(Expense(
      description: description,
      amount: amount,
      date: DateTime.now(),
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

// 🔹 Class utama untuk manajemen budget
class BudgetManager {
  final Map<String, CategoryBudget> categories = {};
  final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

  // Set budget untuk kategori
  void setBudget(String category, double amount) {
    if (amount < 0) {
      throw Exception('Budget tidak boleh negatif');
    }
    categories[category] = CategoryBudget(
      category: category,
      budgetAmount: amount,
    );
    print('✅ Budget "$category" berhasil diset: ${currencyFormatter.format(amount)}');
  }

  // Tambah expense
  void addExpense(String category, String description, double amount) {
    if (!categories.containsKey(category)) {
      throw Exception('Kategori "$category" belum memiliki budget. Silakan set budget terlebih dahulu.');
    }

    if (amount < 0) {
      throw Exception('Jumlah expense tidak boleh negatif');
    }

    categories[category]!.addExpense(description, amount);
    print('📝 Pengeluaran "$description" pada kategori "$category": ${currencyFormatter.format(amount)}');

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
    print('Tanggal Laporan: ${DateFormat('dd MMM yyyy HH:mm').format(DateTime.now())}\n');

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
      print('   Penggunaan  : ${percentage.toStringAsFixed(1)}% [${'█' * ((percentage.toInt()) ~/ 10)}${('░' * (10 - (percentage.toInt()) ~/ 10))}]');
      print('   Jumlah Item : ${budget.expenses.length}');
      print('');
    });

    // Total summary
    print('-' * 70);
    print('💰 TOTAL KESELURUHAN:');
    print('   Total Budget    : ${currencyFormatter.format(totalBudget)}');
    print('   Total Pengeluaran: ${currencyFormatter.format(totalSpent)}');
    print('   Total Sisa      : ${currencyFormatter.format(totalBudget - totalSpent)}');
    print('   Penggunaan Total: ${totalBudget > 0 ? ((totalSpent / totalBudget) * 100).toStringAsFixed(1) : '0.0'}%');
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
          print('   ${i + 1}. ${expense.description}');
          print('      Jumlah: ${currencyFormatter.format(expense.amount)} | Tanggal: ${DateFormat('dd/MM/yyyy').format(expense.date)}');
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
    if (categories.isEmpty) {
      print('Belum ada kategori yang diset.');
      return;
    }
    print('\n📂 KATEGORI YANG TERSEDIA:');
    categories.forEach((category, budget) {
      print('   • $category: ${currencyFormatter.format(budget.budgetAmount)}');
    });
    print('');
  }
}
