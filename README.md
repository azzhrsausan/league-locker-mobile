# league_locker

#  Tugas 7 

1. Apa itu widget tree pada Flutter dan bagaimana hubungan parent–child (induk–anak) bekerja antar widget?
Widget tree itu ibarat pohon yang menunjukkan hubungan 
antar widget di Flutter. Setiap aplikasi Flutter tersusun dari 
banyak widget yang saling bertingkat. Di paling atas ada 
widget induk (parent), dan di dalamnya ada widget lain (child).
Misalnya, MaterialApp bisa dianggap induk besar, di 
dalamnya ada Scaffold, lalu AppBar, Text, dan sebagainya.
Hubungan parent–child ini penting karena parent bisa
mengatur bagaimana child ditampilkan, dan child bisa 
menyesuaikan diri berdasarkan aturan dari parent-nya.

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
   Beberapa widget yang aku pakai di proyek ini antara lain:
- MaterialApp → jadi wadah utama aplikasi Flutter, ngatur tema dan navigasi.
- Scaffold → struktur dasar tampilan, kayak kerangka yang punya app bar, body, dan floating button.
- AppBar → buat menampilkan judul di bagian atas aplikasi.
- Center → untuk menaruh widget lain tepat di tengah layar.
- Column → buat menata beberapa widget secara vertikal.
- Text → menampilkan tulisan di layar.
- FloatingActionButton → tombol melayang yang biasanya buat aksi cepat, kayak menambah angka di counter app.
  Widget-widget ini bekerja sama untuk membentuk tampilan aplikasi yang rapi dan mudah digunakan.

3. Apa fungsi dari widget MaterialApp? Mengapa widget ini sering digunakan sebagai widget root?
   MaterialApp adalah widget utama yang menyediakan fitur dasar dari desain Material milik Google. Dia mengatur tema, routing (navigasi antar halaman), serta title aplikasi. Biasanya MaterialApp ditempatkan di paling atas (root) karena semua widget lain butuh berada di bawahnya biar bisa mengikuti aturan desain dan konteks aplikasi.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
   StatelessWidget itu widget yang tampilannya tidak akan berubah selama aplikasi berjalan — cocok buat tampilan statis seperti teks atau logo. Sedangkan StatefulWidget bisa berubah tampilannya ketika ada interaksi, misalnya tombol diklik atau data diperbarui. Jadi kalau tampilannya tetap, pakai StatelessWidget, tapi kalau ada yang bisa berubah (misalnya counter atau form input), pakai StatefulWidget.

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
   BuildContext itu semacam “identitas” posisi widget di dalam widget tree. Dengan BuildContext, Flutter tahu widget ini berada di mana dan siapa parent-nya. BuildContext juga dipakai buat ngakses hal-hal penting kayak tema, navigasi, atau ukuran layar dari parent widget. Biasanya kita lihat BuildContext sebagai parameter di dalam metode build(BuildContext context) — dan dari situ kita bisa pakai context untuk memanggil fungsi seperti Navigator.of(context) atau Theme.of(context).

6. Jelaskan konsep “hot reload” di Flutter dan bagaimana bedanya dengan “hot restart”.
   “Hot reload” itu fitur keren di Flutter yang memungkinkan kita melihat perubahan kode hampir seketika tanpa harus menjalankan ulang aplikasi dari awal. Jadi pas kita ubah UI, langsung kelihatan hasilnya. Sedangkan “hot restart” memulai ulang aplikasi dari nol, jadi semua data atau state yang lagi aktif bakal hilang. Biasanya aku pakai hot reload waktu cuma ubah tampilan, dan pakai hot restart kalau ubah kode yang lebih besar atau nyangkut di logika program.





#  Tugas 8

1. Navigator.push() itu dipakai buat pindah ke halaman baru tanpa nutup halaman sebelumnya. Jadi nanti user masih bisa balik lagi dengan tombol back. Misalnya di Football Shop, pas dari halaman Home ke Detail Produk atau ke halaman tambah produk, pakainya push() biar gampang balik lagi. Nah, kalau Navigator.pushReplacement() itu beda — dia langsung ganti halaman yang sekarang dan hapus riwayat sebelumnya. Biasanya dipakai setelah login atau setelah submit form produk, supaya user nggak bisa balik ke halaman lama yang udah selesai dipakai.

2. Supaya semua halaman di Football Shop kelihatan rapi dan seragam, aku pakai struktur dasar dari Scaffold. Di situ ada AppBar buat judul dan tombol-tombol kecil kayak ikon, terus ada Drawer yang jadi menu samping biar user bisa pindah halaman dengan mudah. Jadi, kerangkanya tetap sama di setiap halaman, cuma bagian body aja yang ganti-ganti isinya. Cara ini bikin aplikasi kelihatan konsisten, simpel, dan gampang dipakai.

3. Kalau bikin form, aku pakai Padding, SingleChildScrollView, dan ListView biar tampilannya enak dilihat dan nggak bikin capek mata. Padding ngasih jarak di tiap field supaya nggak terlalu dempet, SingleChildScrollView bantu kalau layar kecil atau pas keyboard muncul biar form-nya tetap bisa digulir, dan ListView dipakai kalau field-nya banyak biar scroll-nya lebih smooth. Contohnya di form tambah produk, field kayak nama, harga, dan deskripsi aku bungkus pake Padding, terus semuanya dimasukin ke ListView biar tetap bisa discroll dengan nyaman.

4. Biar aplikasi Football Shop punya warna yang konsisten sama identitas brand-nya, aku ngatur tema lewat ThemeData. Aku pakai ColorScheme.fromSeed dengan warna utama brand, terus warna itu dipakai buat AppBar, DrawerHeader, tombol, dan ikon. Jadi semua bagian kelihatan nyatu dan seragam tanpa perlu ubah warna satu-satu. Hasilnya, tampilannya lebih profesional dan punya ciri khas sendiri.