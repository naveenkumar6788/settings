import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiometricAuthScreen extends StatefulWidget {
  const BiometricAuthScreen({super.key});

  @override
  State<BiometricAuthScreen> createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends State<BiometricAuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  bool isBiometricAvailable = false;
  bool isBiometricEnrolled = false;
  bool isBiometricEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricStatus();
  }

  Future<void> _checkBiometricStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool available = await auth.canCheckBiometrics;
    List<BiometricType> biometrics = await auth.getAvailableBiometrics();
    bool enabled = prefs.getBool('biometric_enabled') ?? false;

    setState(() {
      isBiometricAvailable = available;
      isBiometricEnrolled = biometrics.isNotEmpty;
      isBiometricEnabled = enabled;
    });
  }

  Future<void> _toggleBiometric(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isBiometricEnabled = value;
    });
    await prefs.setBool('biometric_enabled', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text('Biometric Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Enable Biometric Login',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Switch(
                value: isBiometricEnabled,
                onChanged:
                    isBiometricAvailable && isBiometricEnrolled
                        ? _toggleBiometric
                        : null,
                activeColor: const Color(0xFFB8D8C1),
              ),
            ],
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(
              Icons.fingerprint,
              color: Color(0xFFB8D8C1),
            ),
            title: const Text(
              'Biometric Hardware Available',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(
              isBiometricAvailable ? Icons.check_circle : Icons.cancel,
              color: isBiometricAvailable ? Colors.green : Colors.red,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.verified_user,
              color: Color(0xFFB8D8C1),
            ),
            title: const Text(
              'Fingerprints Enrolled',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(
              isBiometricEnrolled ? Icons.check_circle : Icons.cancel,
              color: isBiometricEnrolled ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Note: Due to OS restrictions, we cannot show exact number of fingerprints added. "
            "But we can detect whether any are enrolled.",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
