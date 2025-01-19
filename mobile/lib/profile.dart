import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _username = "John Doe"; // Default username

  // Dialog untuk mengubah nama pengguna
  Future<void> _changeUsername(BuildContext context) async {
    final TextEditingController _usernameController =
        TextEditingController(text: _username);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Change Username"),
          content: TextField(
            controller: _usernameController,
            decoration: const InputDecoration(hintText: "Enter new username"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _username = _usernameController.text;
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEBEE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFEBEE),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Foto profil statis
              CircleAvatar(
                radius: 60,
                backgroundImage: const AssetImage('image/profile.png'),
              ),
              const SizedBox(height: 16),
              // Username
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _username ?? "John Doe",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Color(0xFFD4696E)),
                    onPressed: () => _changeUsername(context),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Tombol simpan
              ElevatedButton(
                onPressed: () {
                  // Simpan perubahan
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Changes saved!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4696E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
