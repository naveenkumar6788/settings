import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _storage = const FlutterSecureStorage();
  final _oldController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _showOld = false;
  bool _showNew = false;
  bool _showConfirm = false;
  String? _storedPassword;
  String _strengthText = '';

  @override
  void initState() {
    super.initState();
    _getPassword();
    _newController.addListener(_checkPasswordStrength);
  }

  Future<void> _getPassword() async {
    String? pass = await _storage.read(key: 'app_password');
    setState(() {
      _storedPassword = pass;
    });
  }

  void _checkPasswordStrength() {
    final pwd = _newController.text;
    if (pwd.length < 4) {
      _strengthText = "Too short";
    } else if (!RegExp(r'[A-Z]').hasMatch(pwd)) {
      _strengthText = "Add uppercase letter";
    } else if (!RegExp(r'[0-9]').hasMatch(pwd)) {
      _strengthText = "Add number";
    } else {
      _strengthText = "Strong";
    }
    setState(() {});
  }

  Future<void> _updatePassword() async {
    if (_oldController.text != _storedPassword) {
      _showMessage("Old password is incorrect", Colors.red);
      return;
    }

    if (_newController.text != _confirmController.text) {
      _showMessage("Passwords do not match", Colors.orange);
      return;
    }

    await _storage.write(key: 'app_password', value: _newController.text);
    HapticFeedback.mediumImpact();
    _showMessage("Password updated successfully", Colors.green);
    Navigator.pop(context);
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  InputDecoration _inputStyle(String label, bool show, VoidCallback toggle) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.grey[900],
      suffixIcon: IconButton(
        icon: Icon(
          show ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey,
        ),
        onPressed: toggle,
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFB8D8C1)),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Change App Lock Password'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 12),
            TextField(
              controller: _oldController,
              obscureText: !_showOld,
              decoration: _inputStyle("Old Password", _showOld, () {
                setState(() => _showOld = !_showOld);
              }),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _newController,
              obscureText: !_showNew,
              decoration: _inputStyle("New Password", _showNew, () {
                setState(() => _showNew = !_showNew);
              }),
              style: const TextStyle(color: Colors.white),
            ),
            if (_strengthText.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Strength: $_strengthText',
                    style: TextStyle(
                      color:
                          _strengthText == "Strong"
                              ? Colors.green
                              : Colors.orangeAccent,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmController,
              obscureText: !_showConfirm,
              decoration: _inputStyle("Confirm New Password", _showConfirm, () {
                setState(() => _showConfirm = !_showConfirm);
              }),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _updatePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB8D8C1),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Update Password",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
