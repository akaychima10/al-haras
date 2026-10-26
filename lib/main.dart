import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
      home: const HomePageWidget(),
    );
  }
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      appBar: AppBar(
        title: const Text('Al-haras'),
        backgroundColor: const Color(0xFF0FD1B2),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back, Admin',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    _buildMenuCard(context, Icons.person, 'My Profile', const ProfileScreen()),
                    _buildMenuCard(context, Icons.list_alt, 'Activity Log', const ActivityLogScreen()),
                    _buildMenuCard(context, Icons.bar_chart, 'Analytics', const AnalyticsScreen()),
                    _buildMenuCard(context, Icons.settings, 'App Settings', const AppSettingsScreen()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, IconData icon, String title, Widget destinationPage) {
    return Material(
      color: const Color(0xFF4EE2C0),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationPage),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black87),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 1. Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile'), backgroundColor: const Color(0xFF0FD1B2)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('User Profile Details', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            ListTile(leading: Icon(Icons.person), title: Text('Name'), subtitle: Text('Admin User')),
            ListTile(leading: Icon(Icons.badge), title: Text('Role'), subtitle: Text('Compliance Officer')),
            ListTile(leading: Icon(Icons.email), title: Text('Email'), subtitle: Text('admin@alharas.com')),
          ],
        ),
      ),
    );
  }
}

// 2. Activity Log Screen
class ActivityLogScreen extends StatelessWidget {
  const ActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = [
      {'title': 'Security Policy Review', 'time': 'Today, 10:45 AM', 'status': 'Passed'},
      {'title': 'Access Control Audit', 'time': 'Yesterday, 04:15 PM', 'status': 'Flagged'},
      {'title': 'Data Encryption Check', 'time': 'Oct 24, 09:30 AM', 'status': 'Passed'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Activity Log'), backgroundColor: const Color(0xFF0FD1B2)),
      body: ListView.builder(
        itemCount: logs.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final log = logs[index];
          final isPassed = log['status'] == 'Passed';
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(Icons.history, color: isPassed ? Colors.teal : Colors.orange),
              title: Text(log['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(log['time']!),
              trailing: Chip(
                label: Text(log['status']!, style: const TextStyle(color: Colors.white)),
                backgroundColor: isPassed ? Colors.teal : Colors.deepOrange,
              ),
            ),
          );
        },
      ),
    );
  }
}

// 3. Analytics Screen
class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics'), backgroundColor: const Color(0xFF0FD1B2)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Compliance Metrics', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _metricCard('Compliance Score', '98.2%', Colors.teal)),
                const SizedBox(width: 12),
                Expanded(child: _metricCard('Open Issues', '2', Colors.orange)),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Audit Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text('Chart Placeholder: Monthly Compliance Trends', style: TextStyle(color: Colors.black54)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _metricCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// 4. App Settings Screen
class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkMode = false;
  bool _autoLock = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Settings'), backgroundColor: const Color(0xFF0FD1B2)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Preferences', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
          const SizedBox(height: 10),
          SwitchListTile(
            title: const Text('Push Notifications'),
            subtitle: const Text('Receive compliance alert notifications'),
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
          ),
          SwitchListTile(
            title: const Text('Dark Mode Theme'),
            subtitle: const Text('Switch app appearance'),
            value: _darkMode,
            onChanged: (val) => setState(() => _darkMode = val),
          ),
          SwitchListTile(
            title: const Text('Auto-Lock Session'),
            subtitle: const Text('Secure app after inactivity'),
            value: _autoLock,
            onChanged: (val) => setState(() => _autoLock = val),
          ),
        ],
      ),
    );
  }
}
