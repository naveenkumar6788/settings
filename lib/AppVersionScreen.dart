import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionScreen extends StatefulWidget {
  const AppVersionScreen({super.key});

  @override
  State<AppVersionScreen> createState() => _AppVersionScreenState();
}

class _AppVersionScreenState extends State<AppVersionScreen> {
  String version = '';
  String buildNumber = '';

  @override
  void initState() {
    super.initState();
    loadAppInfo();
  }

  Future<void> loadAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      version = info.version;
      buildNumber = info.buildNumber;
    });
  }

  void _copyVersionInfo() {
    Clipboard.setData(ClipboardData(text: 'Version: $version+$buildNumber'));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Version info copied')));
  }

  void _showChangelog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: const Color(0xFF1E1E1E),
            title: const Text(
              "Changelog",
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              "- Added biometric lock\n"
              "- Improved app lock\n"
              "- Bug fixes\n"
              "- UI improvements",
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                child: const Text(
                  "Close",
                  style: TextStyle(color: const Color(0xFFB8D8C1)),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
    );
  }

  void _checkForUpdate() {
    // You can implement real version check logic via API if needed.
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: const Color(0xFF1E1E1E),
            title: const Text(
              "Check for Updates",
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              "You're using the latest version.",
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                child: const Text(
                  "OK",
                  style: TextStyle(color: const Color(0xFFB8D8C1)),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text("App Version"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onLongPress: _copyVersionInfo,
              child: Row(
                children: [
                  const Icon(Icons.info, color: const Color(0xFFB8D8C1)),
                  const SizedBox(width: 10),
                  Text(
                    "Version: $version+$buildNumber",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.notes),
              label: const Text("View Changelog"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB8D8C1),
              ),
              onPressed: _showChangelog,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.system_update_alt),
              label: const Text("Check for Updates"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB8D8C1),
              ),
              onPressed: _checkForUpdate,
            ),
          ],
        ),
      ),
    );
  }
}
