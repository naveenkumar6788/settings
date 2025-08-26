import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text("Terms & Conditions"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ListView(
          children: const [
            Text(
              "1. Introduction",
              style: TextStyle(
                color: const Color(0xFFB8D8C1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "By using this app, you agree to be bound by these terms and conditions. If you do not agree, please do not use the app.",
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),

            Text(
              "2. User Responsibilities",
              style: TextStyle(
                color: const Color(0xFFB8D8C1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "You agree to use the app only for lawful purposes and not to misuse any features, attempt to hack, reverse engineer, or disrupt the service.",
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),

            Text(
              "3. Privacy",
              style: TextStyle(
                color: const Color(0xFFB8D8C1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "We respect your privacy. Your personal data will only be used as outlined in our Privacy Policy.",
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),

            Text(
              "4. Intellectual Property",
              style: TextStyle(
                color: const Color(0xFFB8D8C1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "All content, code, and design are the intellectual property of the developer. You may not copy, modify, or reuse without permission.",
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),

            Text(
              "5. Limitation of Liability",
              style: TextStyle(
                color: const Color(0xFFB8D8C1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "The app is provided 'as is' without warranty. We are not responsible for any loss or damage arising from its use.",
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),

            Text(
              "6. Updates and Modifications",
              style: TextStyle(
                color: const Color(0xFFB8D8C1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "We may update these terms at any time. Continued use of the app means you accept the new terms.",
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 32),
            Center(
              child: Text(
                "Last updated: June 25, 2025",
                style: TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
