import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              "Selamat Datang!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            // Ganti dengan ilustrasi dari image_bee9fe.jpg
            Image.asset(
              'assets/images/Logo_login_page.png',
              width: 200, // Kamu bisa atur lebarnya sesuai kebutuhan
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 40),
            _loginButton(
              "Masuk dengan Google",
              Icons.g_mobiledata,
              Colors.grey.shade200,
            ),
            const SizedBox(height: 15),
            _loginButton(
              "Masuk dengan Email",
              Icons.email,
              Colors.grey.shade200,
            ),
            const SizedBox(height: 15),
            _loginButton("Daftar Akun Baru", null, Colors.indigo.shade50),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text("Masuk sebagai anak?"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(String text, IconData? icon, Color color) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: icon != null ? Icon(icon, color: Colors.black) : const SizedBox(),
        label: Text(text, style: const TextStyle(color: Colors.black)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.all(16),
        ),
        onPressed: () {},
      ),
    );
  }
}
