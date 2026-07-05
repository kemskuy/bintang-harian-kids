import 'package:flutter/material.dart';
import 'toko_hadiah_page.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
      print("Image path: ${_selectedImage?.path}");
    }
  }

  //Gunakan Getter untuk mengakses halaman yang dipilih
  List<Widget> get _pages => [
        _buildBerandaPage(),
        _buildHistoryPage(),
        _buildRewardPage(),
        _buildProfilePage(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // --- DESAIN HALAMAN BERANDA ---
  Widget _buildBerandaPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),

          // --- BARIS FOTO PROFIL & NAMA ---
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.indigo,
                backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
                child: _selectedImage == null ? const Icon(Icons.person, color: Colors.white) : null,
              ),
              const SizedBox(width: 15),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Halo, Aisyah! 👋",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Semangat hari ini",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 1. Card Progress
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 10),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    value: 0.75,
                    color: Colors.amber,
                    strokeWidth: 8,
                  ),
                ),
                const SizedBox(width: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "75%",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("3 / 4 Tugas Selesai"),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          const Text(
            "Tugas Hari Ini",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          // 2. Item Tugas dengan parameter baru: time
          _buildTaskItem("Membaca 15 Menit", "Wajib Foto", "08:00 WIB", true),
          _buildTaskItem("Latihan Menggambar", "Wajib Foto", "14:00 WIB", true),
          _buildTaskItem(
            "PR Matematika",
            "Kerjakan halaman 23-24",
            "16:00 WIB",
            false,
          ),
        ],
      ),
    );
  }

  // Helper untuk membuat item tugas yang sudah diperbarui
  Widget _buildTaskItem(
    String title,
    String subtitle,
    String time,
    bool isDone,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // Ikon Buku & Pensil (Ikon Material yang mewakili)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.menu_book_rounded, color: Colors.indigo),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                // Penunjuk waktu WIB
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_filled,
                      size: 12,
                      color: Colors.indigo,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.indigo,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Logika tombol
          isDone
              ? const Icon(Icons.check_circle, color: Colors.green, size: 30)
              : ElevatedButton(
                  onPressed: () {
                    _showTaskConfirmation(title);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Kerjakan"),
                ),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan Pop-Up konfirmasi (Emoji Berpikir)
  void _showTaskConfirmation(String taskName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🤔', style: TextStyle(fontSize: 60)),
                const SizedBox(height: 15),
                const Text(
                  "Tugas Selesai?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "Apakah kamu sudah menyelesaikan '$taskName' dengan baik?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey[600],
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          "Belum",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          "Selesai!",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Tambahkan fungsi-fungsi di bawah ini ke dalam kelas _HomePageState,
  // --- HALAMAN HISTORI TUGAS (DESAIN DETAIL) ---
  Widget _buildHistoryPage() {
    return Column(
      children: [
        const SizedBox(height: 50),
        // Filter Tabs
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              _buildFilterChip("Semua", true),
              _buildFilterChip("Selesai", false),
              _buildFilterChip("Belum", false),
            ],
          ),
        ),
        // List Item
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildDateHeader("Hari ini"),
              _buildHistoryItem("PR Matematika", "16:00 WIB", "+20", true),
              _buildHistoryItem("Membaca 15 Menit", "15:30 WIB", "+10", true),
            ],
          ),
        ),
      ],
    );
  }

  // --- HALAMAN REWARD (DENGAN 4 KATEGORI) ---
  Widget _buildRewardPage() {
    return Column(
      children: [
        const SizedBox(height: 50),
        // 4 Kategori Poin
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  _buildPointCard("Total Poin", "1240", Colors.indigo),
                  _buildPointCard("Poin Hari Ini", "+150", Colors.green),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildPointCard("Poin Ditukar", "-300", Colors.red),
                  _buildPointCard("Sisa Poin", "940", Colors.orange),
                ],
              ),
            ],
          ),
        ),

        // --- TAMBAHKAN TOMBOL DI SINI ---
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity, // Agar tombol memanjang selebar layar
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TokoHadiahPage(),
                  ),
                );
              },
              icon: const Icon(Icons.storefront_rounded),
              label: const Text("Buka Toko Hadiah"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
        // --------------------------------
        const SizedBox(height: 20),
        // List Histori
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildDateHeader("Hari ini"),
              _buildRewardItem("Es Krim", "12:30 WIB", "-100", Icons.icecream),
              _buildRewardItem("Bonus Tugas", "10:00 WIB", "+50", Icons.star),
            ],
          ),
        ),
      ],
    );
  }

  // Widget Card untuk 4 kategori
  Widget _buildPointCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- KOMPONEN UI DETAIL ---
  Widget _buildHistoryItem(
    String title,
    String time,
    String points,
    bool isSuccess,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Icon(Icons.menu_book_rounded, color: Colors.indigo),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  time,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            points,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 10),
          Icon(
            isSuccess ? Icons.check_circle : Icons.cancel,
            color: isSuccess ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildRewardItem(
    String title,
    String time,
    String points,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.amber),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  time,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            points,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: points.startsWith("-") ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        date,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.indigo : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.indigo),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.indigo,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // --- HALAMAN PROFIL (DENGAN AVATAR CLICKABLE) ---
  Widget _buildProfilePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 50),

          // Tambahkan Gesture Detector di sini agar bisa di-klik
          GestureDetector(
            onTap: _pickImage, // Sekarang langsung memanggil galeri
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.indigo,
                  // Jika _selectedImage ada, tampilkan gambarnya, jika tidak gunakan icon default
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : null,
                  child: _selectedImage == null
                      ? const Icon(Icons.person, size: 60, color: Colors.white)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),
          const Text(
            "Aisyah",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Text("Pelajar Pintar", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 30),

          _buildProfileMenu(Icons.edit, "Edit Profil"),
          _buildProfileMenu(Icons.notifications, "Notifikasi"),
          _buildProfileMenu(Icons.settings, "Pengaturan"),
          _buildProfileMenu(Icons.logout, "Keluar", isLogout: true),
        ],
      ),
    );
  }

  // --- FUNGSI UNTUK MEMILIH AVATAR ---
  void _showAvatarPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Pilih Avatar"),
        content: Wrap(
          spacing: 15,
          runSpacing: 15,
          children:
              [
                Icons.face,
                Icons.face_3,
                Icons.emoji_emotions,
                Icons.face_retouching_natural,
              ].map((icon) {
                return IconButton(
                  icon: Icon(icon, size: 40, color: Colors.indigo),
                  onPressed: () {
                    // Di sinilah nanti Anda akan menyimpan pilihan ke Firebase/State
                    Navigator.pop(context);
                  },
                );
              }).toList(),
        ),
      ),
    );
  }

  // Widget Menu Profil
  Widget _buildProfileMenu(
    IconData icon,
    String title, {
    bool isLogout = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: isLogout ? Colors.red : Colors.indigo),
          const SizedBox(width: 15),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isLogout ? Colors.red : Colors.black,
            ),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildBerandaPage(),
      _buildHistoryPage(),
      _buildRewardPage(),
      _buildProfilePage(),
    ];
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Histori Tugas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Reward',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
