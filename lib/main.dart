import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ==================== CUSTOM HELPER FUNCTIONS ====================
List<double> getNumericList(List<dynamic>? rows) {
  if (rows == null || rows.isEmpty) {
    return [];
  }
  return List<double>.generate(rows.length, (index) => (index + 1).toDouble());
}

int getUniqueActiveDays(List<dynamic>? logs) {
  if (logs == null || logs.isEmpty) {
    return 0;
  }

  final uniqueDates = logs
      .where((row) => row['createdAt'] != null)
      .map((row) {
        final date = row['createdAt'] is DateTime 
            ? row['createdAt'] as DateTime 
            : DateTime.parse(row['createdAt'].toString());
        return DateTime(date.year, date.month, date.day);
      })
      .toSet();

  return uniqueDates.length;
}

int? calculateActiveDays(List<dynamic>? logs) {
  if (logs == null || logs.isEmpty) return 0;

  final uniqueDates = logs
      .map((log) {
        final createdAt = log['createdAt']?.toString();
        if (createdAt == null) return null;
        return createdAt.split('T')[0].split(' ')[0];
      })
      .where((date) => date != null)
      .toSet();

  return uniqueDates.length;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al-haras',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPageWidget(),
        '/signup': (context) => const SignUpPageWidget(),
        '/home': (context) => const HomePageWidget(),
        '/profile': (context) => const ProfilePageWidget(),
        '/activityLog': (context) => const ActivityLogPageWidget(),
        '/analytics': (context) => const AnalyticsPageWidget(),
        '/settings': (context) => const SettingsPageWidget(),
        '/updatePassword': (context) => const UpdatePasswordPageWidget(),
      },
    );
  }
}

// ==================== LOGIN PAGE ====================
class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisibility = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F4F8),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Al-haras Compliance',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.teal, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.teal, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: !_passwordVisibility,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.teal, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.teal, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: InkWell(
                        onTap: () => setState(() => _passwordVisibility = !_passwordVisibility),
                        child: Icon(
                          _passwordVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/signup'),
                  child: const Text(
                    "Don't have an account? Sign Up.",
                    style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== SIGN UP PAGE ====================
class SignUpPageWidget extends StatelessWidget {
  const SignUpPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up'), backgroundColor: const Color(0xFF0FD1B2)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: () => Navigator.pop(context),
              child: const Text('Create Account & Back to Login', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== HOME PAGE ====================
class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Welcome back, Admin User',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                    child: const Icon(Icons.logout, size: 24),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                  children: [
                    _buildMenuCard(context, Icons.person, 'My Profile', '/profile'),
                    _buildMenuCard(context, Icons.list_sharp, 'Activity Log', '/activityLog'),
                    _buildMenuCard(context, Icons.bar_chart, 'Analytics', '/analytics'),
                    _buildMenuCard(context, Icons.settings_outlined, 'App Settings', '/settings'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, IconData icon, String title, String routeName) {
    return Material(
      color: const Color(0xFF4EE2C0),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: Colors.black87),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== PROFILE PAGE ====================
class ProfilePageWidget extends StatelessWidget {
  const ProfilePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1F26),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        elevation: 2,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: Image.network('https://picsum.photos/seed/633/600', fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(child: Text('admin@alharas.com', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            const SizedBox(height: 8),
            const Center(child: Text('UID: user_admin_001', style: TextStyle(fontSize: 14, color: Colors.grey))),
            const SizedBox(height: 32),
            Center(
              child: SizedBox(
                width: 160,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text('Log Out', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== ACTIVITY LOG PAGE ====================
class ActivityLogPageWidget extends StatelessWidget {
  const ActivityLogPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> mockActivities = [
      {'title': 'Security Policy Review', 'createdAt': 'Today, 10:45 AM'},
      {'title': 'Access Control Audit', 'createdAt': 'Yesterday, 04:15 PM'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1F26),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('View your Activities', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        elevation: 2,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: Text('Recent Activity', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: mockActivities.length,
                itemBuilder: (context, index) {
                  final activity = mockActivities[index];
                  return Card(
                    color: Colors.white,
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      title: Text(activity['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      subtitle: Text(activity['createdAt']!, style: const TextStyle(color: Colors.grey)),
                      trailing: const Icon(Icons.delete_rounded, color: Colors.grey, size: 24),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== ADD ACTIVITY BOTTOM SHEET ====================
class AddActivityBottomSheetWidget extends StatefulWidget {
  const AddActivityBottomSheetWidget({super.key});

  @override
  State<AddActivityBottomSheetWidget> createState() => _AddActivityBottomSheetWidgetState();
}

class _AddActivityBottomSheetWidgetState extends State<AddActivityBottomSheetWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(
              width: 250,
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Activity title',
                  isDense: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 250,
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Activity details',
                  isDense: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(200, 44),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Activity "${_titleController.text}" saved!')),
                );
                Navigator.pop(context);
              },
              child: const Text('Save Activity', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== ANALYTICS PAGE ====================
class AnalyticsPageWidget extends StatelessWidget {
  const AnalyticsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mockData = [
      {'createdAt': '2026-10-27T10:00:00Z'},
      {'createdAt': '2026-10-26T14:30:00Z'},
      {'createdAt': '2026-10-26T09:15:00Z'},
    ];
    final numericList = getNumericList(mockData);
    final activeDaysCount = calculateActiveDays(mockData) ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1F26),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Analytics', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        elevation: 2,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: const AddActivityBottomSheetWidget(),
            ),
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Total Activities', style: TextStyle(color: Colors.grey, fontSize: 14)),
                            const SizedBox(height: 4),
                            Text('${numericList.length}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Active Days', style: TextStyle(color: Colors.grey, fontSize: 14)),
                            const SizedBox(height: 4),
                            Text('$activeDaysCount', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Activity Trends', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Calculated Active Days: $activeDaysCount',
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== SETTINGS PAGE ====================
class SettingsPageWidget extends StatelessWidget {
  const SettingsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1F26),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Settings', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Account Settings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  title: const Text('admin@alharas.com', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  subtitle: const Text('Account Profile', style: TextStyle(color: Colors.grey)),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.grey),
                  onTap: () => Navigator.pushNamed(context, '/profile'),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  leading: const Icon(Icons.lock, color: Colors.black87),
                  title: const Text('Change Password', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  subtitle: const Text('Update your credentials', style: TextStyle(color: Colors.grey)),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.grey),
                  onTap: () => Navigator.pushNamed(context, '/updatePassword'),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  leading: const Icon(Icons.logout, color: Colors.redAccent),
                  title: const Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.redAccent)),
                  subtitle: const Text('Sign out of your session', style: TextStyle(color: Colors.grey)),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.grey),
                  onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== UPDATE PASSWORD PAGE ====================
class UpdatePasswordPageWidget extends StatefulWidget {
  const UpdatePasswordPageWidget({super.key});

  @override
  State<UpdatePasswordPageWidget> createState() => _UpdatePasswordPageWidgetState();
}

class _UpdatePasswordPageWidgetState extends State<UpdatePasswordPageWidget> {
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisibility = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F4F8),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A1F26),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Change Password', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          elevation: 2,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: !_passwordVisibility,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    hintText: 'Enter new password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisibility = !_passwordVisibility;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1F26),
                    foregroundColor: Colors.tealAccent,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password updated successfully!')),
                    );
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text('Update Password', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
