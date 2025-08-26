import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLockScreen extends StatefulWidget {
  final VoidCallback onUnlocked;
  const AppLockScreen({super.key, required this.onUnlocked});

  @override
  State<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends State<AppLockScreen> {
  final _storage = const FlutterSecureStorage();
  final _controller = TextEditingController();
  final LocalAuthentication _auth = LocalAuthentication();

  String? _storedPassword;
  bool _isFirstTime = false;
  bool _biometricTried = false;
  bool _biometricEnabled = false;

  @override
  void initState() {
    super.initState();
    _initLock();
  }

  Future<void> _initLock() async {
    await _loadPassword();
    await _loadBiometricPreference();

    // If biometrics are enabled, try it only once
    if (_biometricEnabled && !_biometricTried) {
      _biometricTried = true;
      _authenticateWithBiometrics();
    }
  }

  Future<void> _loadPassword() async {
    String? password = await _storage.read(key: 'app_password');
    setState(() {
      _storedPassword = password;
      _isFirstTime = password == null;
    });
  }

  Future<void> _loadBiometricPreference() async {
    final prefs = await SharedPreferences.getInstance();
    bool enabled = prefs.getBool('biometric_enabled') ?? false;
    setState(() {
      _biometricEnabled = enabled;
    });
  }

  Future<void> _setPassword(String password) async {
    await _storage.write(key: 'app_password', value: password);
  }

  void _validate() async {
    if (_isFirstTime) {
      if (_controller.text.isNotEmpty) {
        await _setPassword(_controller.text);
        widget.onUnlocked();
      }
    } else {
      if (_controller.text == _storedPassword) {
        widget.onUnlocked();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Incorrect Password',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: const Color(0xFFB8D8C1),
          ),
        );
      }
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    try {
      bool canCheck = await _auth.canCheckBiometrics;
      List<BiometricType> available = await _auth.getAvailableBiometrics();

      if (!canCheck || available.isEmpty) return;

      bool authenticated = await _auth.authenticate(
        localizedReason: 'Authenticate to unlock the app',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        widget.onUnlocked();
      }
    } catch (e) {
      debugPrint('Biometric error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock, size: 64, color: const Color(0xFFB8D8C1)),
              const SizedBox(height: 24),
              Text(
                _isFirstTime ? 'Set New Password' : 'Enter App Password',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white12,
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _validate,
                child: Text(_isFirstTime ? 'Set Password' : 'Unlock'),
              ),
              const SizedBox(height: 10),
              if (_biometricEnabled)
                ElevatedButton.icon(
                  onPressed: _authenticateWithBiometrics,
                  icon: const Icon(Icons.fingerprint),
                  label: const Text('Unlock with Biometrics'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB8D8C1),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
