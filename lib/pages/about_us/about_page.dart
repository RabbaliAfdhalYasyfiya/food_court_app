import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../menu_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white),
          ),
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => const MenuPage(),
              ),
            );
          },
        ),
        title: const Text(
          'About',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/splash-screen.png',
                        height: 75,
                      ),
                    ),
                    const Gap(20),
                    const Text(
                      'CourtFinder',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                const Gap(15),
                textWithoutBold(
                  'Selamat datang di aplikasi pencarian dan pembayaran CourtFinder!',
                ),
                const Gap(5),
                textWithoutBold(
                  'Dikembangkan sebagai bagian dari Laporan Informatika Capstone Project, program inovatif ini menerapkan solusi kompleks untuk memfasilitasi pencarian tempat dan pembayaran ditempat.',
                ),
                const Gap(10),
                textWithBold(
                  'Fitur Utama:',
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    children: [
                      textWithoutBold(
                        '1. Pencarian Cepat: aplikasi ini dilengkapi dengan mesin pencari canggih yang memastikan pengguna dapat dengan cepat menemukan produk atau layanan yang mereka inginkan. Algoritme pencarian  cerdas membantu memfilter hasil berdasarkan preferensi dan kebutuhan pengguna.',
                      ),
                      textWithoutBold(
                        '2. Informasi Produk Terperinci: Menyediakan informasi produk terperinci seperti gambar, deskripsi, dan ulasan pengguna. Ini membantu pengguna membuat keputusan yang lebih tepat sebelum melakukan pembelian.',
                      ),
                      textWithoutBold(
                        '3. Pembayaran Aman dan Mudah: Aplikasi ini menawarkan metode pembayaran yang aman dan mudah. Pengguna dapat memilih  berbagai metode pembayaran digital, termasuk QRIS dan e-Wallet.',
                      ),
                      textWithoutBold(
                        '4. Riwayat Pembayaran: Pengguna dapat melacak riwayat pembayaran mereka menggunakan fitur ini. Hal ini memungkinkan mereka untuk mengelola transaksi, melacak pengeluaran dan mengakses informasi terkini tentang transaksi.',
                      ),
                    ],
                  ),
                ),
                const Gap(10),
                textWithBold(
                  'Keamanan dan Privasi:',
                ),
                textWithoutBold(
                  'Selalu berkomitmen untuk melindungi keamanan dan privasi pengguna. Data pribadi dan data transaksi dienkripsi menggunakan teknologi terkini untuk menjamin keamanan  maksimal.',
                ),
                const Gap(10),
                textWithBold(
                  'Dukungan untuk pengguna:',
                ),
                textWithoutBold(
                  'Aplikasi pencarian dan pembayaran ini dibangun dengan fokus pada keamanan, kenyamanan, dan pengalaman pengguna yang luar biasa. Dan berharap aplikasi ini memenuhi kebutuhan dan harapan Anda.',
                ),
                const Gap(5),
                textWithoutBold(
                  'Terima kasih telah menggunakan aplikasi Pencarian dan Pembayaran CourtFinder!',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textWithoutBold(String text) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget textWithBold(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
