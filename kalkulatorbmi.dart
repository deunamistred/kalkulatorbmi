import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: KalkulatorBMI(),
  ));
}

class KalkulatorBMI extends StatefulWidget {
  const KalkulatorBMI({super.key});

  @override
  State<KalkulatorBMI> createState() => _KalkulatorBMIState();
}

class _KalkulatorBMIState extends State<KalkulatorBMI> {
  final _bbController = TextEditingController();
  final _tbController = TextEditingController();
  String gender = "Laki-laki";
  double? bmi;
  String hasil = "";

  void hitung() {
    final berat = double.tryParse(_bbController.text);
    final tinggi = double.tryParse(_tbController.text);

    if (berat == null || tinggi == null || berat <= 0 || tinggi <= 0) {
      setState(() {
        hasil = "Masukkan data yang valid";
      });
      return;
    }

    final tMeter = tinggi / 100;
    final nilai = berat / (tMeter * tMeter);

    String kategori;
    if (gender == "Laki-laki") {
      if (nilai < 18.5) {
        kategori = "Kurus";
      } else if (nilai < 25) {
        kategori = "Normal";
      } else if (nilai < 30) {
        kategori = "Kelebihan berat";
      } else {
        kategori = "Obesitas";
      }
    } else {
      if (nilai < 17.5) {
        kategori = "Kurus";
      } else if (nilai < 24) {
        kategori = "Normal";
      } else if (nilai < 29) {
        kategori = "Kelebihan berat";
      } else {
        kategori = "Obesitas";
      }
    }

    setState(() {
      bmi = nilai;
      hasil = "BMI Anda: ${nilai.toStringAsFixed(1)} ($kategori)";
    });
  }

  void reset() {
    setState(() {
      _bbController.clear();
      _tbController.clear();
      bmi = null;
      hasil = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text("Kalkulator BMI"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _bbController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Berat Badan (kg)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _tbController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Tinggi Badan (cm)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: gender,
              items: const [
                DropdownMenuItem(value: "Laki-laki", child: Text("Laki-laki")),
                DropdownMenuItem(value: "Perempuan", child: Text("Perempuan")),
              ],
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: hitung,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text("Hitung BMI"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: reset,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Reset"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (hasil.isNotEmpty)
              Card(
                color: Colors.orange[100],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    hasil,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
