import 'package:flutter/material.dart';

class TokoHadiahPage extends StatelessWidget {
  const TokoHadiahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Toko Hadiah", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        children: [
          _buildHadiahCard("Es Krim", "100 ⭐", Icons.icecream),
          _buildHadiahCard("Mainan Lego", "1000 ⭐", Icons.toys),
          _buildHadiahCard("Buku Gambar", "300 ⭐", Icons.menu_book),
          _buildHadiahCard("Main Game", "200 ⭐", Icons.videogame_asset),
        ],
      ),
    );
  }

  Widget _buildHadiahCard(String title, String points, IconData icon) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5)]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.indigo),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(points, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}