import 'budget_manager.dart';

void main() {
  print('\n' + '=' * 70);
  print('🎯 SISTEM MANAJEMEN BUDGET TERINTEGRASI');
  print('Mendemonstrasikan 3 Latihan: Category Management, Budget System, Multi-User');
  print('=' * 70 + '\n');

  // ========================================================================
  // EXERCISE 1: CATEGORY MANAGEMENT (MUDAH)
  // ========================================================================
  print('\n🔷 EXERCISE 1: CATEGORY MANAGEMENT\n');
  print('Menunjukkan cara mengelola kategori custom\n');

  final categoryManager = CategoryManager();
  categoryManager.displayCategories();

  print('Menambah kategori baru...');
  categoryManager.addCategory('Kecantikan');
  categoryManager.addCategory('Olahraga');
  categoryManager.removeCategory('Kesehatan');

  categoryManager.displayCategories();

  // ========================================================================
  // EXERCISE 2 & 3: BUDGET SYSTEM + MULTI-USER
  // ========================================================================
  print('\n🔷 EXERCISE 2 & 3: BUDGET SYSTEM + MULTI-USER SUPPORT\n');

  // Inisialisasi sistem
  final userSystem = MultiUserSystem();
  final budgetManager = BudgetManager(
    categoryManager: categoryManager,
    userSystem: userSystem,
  );

  // ========================================================================
  // STEP 1: Register Users
  // ========================================================================
  print('📍 STEP 1: REGISTER PENGGUNA BARU\n');

  userSystem.registerUser('user001', 'Budi Santoso', 'budi@email.com', 'password123');
  userSystem.registerUser('user002', 'Siti Nurhaliza', 'siti@email.com', 'password456');
  userSystem.registerUser('user003', 'Ahmad Wijaya', 'ahmad@email.com', 'password789');

  userSystem.displayAllUsers();

  // ========================================================================
  // STEP 2: User Budi Login & Set Budget
  // ========================================================================
  print('📍 STEP 2: LOGIN & SET BUDGET (User: Budi)\n');

  userSystem.loginUser('user001', 'password123');
  userSystem.currentUser?.profile.displayProfile();

  budgetManager.setBudget('Makanan', 1500000);
  budgetManager.setBudget('Transportasi', 800000);
  budgetManager.setBudget('Tagihan', 2000000);
  budgetManager.setBudget('Hiburan', 500000);

  // ========================================================================
  // STEP 3: Add Expenses & Trigger Alerts
  // ========================================================================
  print('📍 STEP 3: TAMBAH PENGELUARAN & TRIGGER ALERTS (User: Budi)\n');

  budgetManager.addExpense('Makanan', 'Sarapan pagi', 50000);
  budgetManager.addExpense('Makanan', 'Makan siang', 75000);
  budgetManager.addExpense('Makanan', 'Makan malam', 85000);
  budgetManager.addExpense('Makanan', 'Snack sore', 45000);
  budgetManager.addExpense('Makanan', 'Kopi dan roti', 35000);
  budgetManager.addExpense('Makanan', 'Makan bersama keluarga', 250000);
  budgetManager.addExpense('Makanan', 'Delivery makanan', 125000); // 60% - INFO ALERT
  budgetManager.addExpense('Makanan', 'Restaurant fancy', 350000); // 83% - WARNING ALERT
  budgetManager.addExpense('Makanan', 'Catering', 200000); // EXCEEDED - CRITICAL ALERT

  print('');
  budgetManager.addExpense('Transportasi', 'Bensin', 100000);
  budgetManager.addExpense('Transportasi', 'Parkir', 50000);
  budgetManager.addExpense('Transportasi', 'Taksi online', 150000);

  print('');
  budgetManager.addExpense('Tagihan', 'Listrik', 500000);
  budgetManager.addExpense('Tagihan', 'Air', 150000);
  budgetManager.addExpense('Tagihan', 'Internet', 350000);

  // ========================================================================
  // STEP 4: Generate Budget Report (Budi)
  // ========================================================================
  print('\n📍 STEP 4: GENERATE LAPORAN BUDGET (User: Budi)\n');
  budgetManager.generateBudgetReport();

  // ========================================================================
  // STEP 5: User Siti Login & Set Own Budget
  // ========================================================================
  print('\n📍 STEP 5: LOGOUT BUDI, LOGIN SITI (Multi-User Demo)\n');

  userSystem.logoutUser();
  print('');

  userSystem.loginUser('user002', 'password456');
  userSystem.currentUser?.profile.displayProfile();

  budgetManager.setBudget('Makanan', 1200000);
  budgetManager.setBudget('Transportasi', 600000);
  budgetManager.setBudget('Kecantikan', 400000);

  // ========================================================================
  // STEP 6: Siti Add Expenses
  // ========================================================================
  print('\n📍 STEP 6: TAMBAH PENGELUARAN (User: Siti)\n');

  budgetManager.addExpense('Makanan', 'Sarapan', 40000);
  budgetManager.addExpense('Makanan', 'Lunch box', 55000);
  budgetManager.addExpense('Transportasi', 'Busway', 30000);
  budgetManager.addExpense('Kecantikan', 'Salon rambut', 200000); // 50% budget
  budgetManager.addExpense('Kecantikan', 'Skincare', 150000); // 87.5% - WARNING

  print('');
  budgetManager.generateBudgetReport();

  // ========================================================================
  // STEP 7: User Ahmad Login (Third User)
  // ========================================================================
  print('\n📍 STEP 7: LOGOUT SITI, LOGIN AHMAD (Third User Demo)\n');

  userSystem.logoutUser();
  print('');

  userSystem.loginUser('user003', 'password789');
  userSystem.currentUser?.profile.displayProfile();

  budgetManager.setBudget('Makanan', 1000000);
  budgetManager.setBudget('Olahraga', 300000);

  print('\n📍 STEP 8: TAMBAH PENGELUARAN (User: Ahmad)\n');

  budgetManager.addExpense('Makanan', 'Coffee', 35000);
  budgetManager.addExpense('Olahraga', 'Gym membership', 250000); // 83% - WARNING

  print('');
  budgetManager.generateBudgetReport();

  // ========================================================================
  // STEP 9: Advanced Features Demo
  // ========================================================================
  print('\n📍 STEP 9: FITUR LANJUTAN\n');

  // Tampilkan semua kategori
  budgetManager.listCategories();

  // Get specific budget summary
  print('Detail Budget Makanan (Ahmad):');
  var summary = budgetManager.getBudgetSummary('Makanan');
  print('  • Budget: ${summary['budget']}');
  print('  • Spent: ${summary['spent']}');
  print('  • Remaining: ${summary['remaining']}');
  print('  • Usage: ${summary['percentage'].toStringAsFixed(1)}%');
  print('  • Expenses: ${summary['expenses']}\n');

  // Change user settings
  print('Mengubah pengaturan user Ahmad:');
  userSystem.currentUser?.profile.updateSetting('theme', 'dark');
  userSystem.currentUser?.profile.updateSetting('currency', 'USD');
  print('');

  // Reset monthly expenses
  print('Reset pengeluaran untuk bulan baru:');
  budgetManager.resetMonthlyExpenses();

  // ========================================================================
  // SUMMARY
  // ========================================================================
  print('\n' + '=' * 70);
  print('✨ DEMO SELESAI!');
  print('=' * 70);
  print('\n📚 Fitur yang Ditdemonstrasikan:');
  print('   ✅ Exercise 1: Category Management');
  print('      - Menambah kategori custom');
  print('      - Menghapus kategori');
  print('      - Validasi kategori\n');
  print('   ✅ Exercise 2: Budget System');
  print('      - Set budget per kategori');
  print('      - Track pengeluaran vs budget');
  print('      - Alert system (Info, Warning, Critical)\n');
  print('   ✅ Exercise 3: Multi-User Support');
  print('      - User registration & authentication');
  print('      - User login/logout');
  print('      - Profile management');
  print('      - Separate budgets per user');
  print('      - Password management\n');
  print('   ✅ Fitur Tambahan:');
  print('      - Comprehensive budget reporting');
  print('      - Budget summary per kategori');
  print('      - Monthly expense reset');
  print('      - User settings/preferences\n');
  print('=' * 70 + '\n');
}
