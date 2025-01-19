import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  final int id;
  final String username;
  final String email;
  final String password;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  _UserManagementScreenState createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  Future<List<User>> fetchUsers() async {
    const String baseUrl = 'http://192.168.117.131:5000/api/users';
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> usersJson = jsonDecode(response.body);
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        centerTitle: true,
        backgroundColor: const Color(0xFFEC818D), // Warna AppBar
      ),
      body: Container(
        color: const Color(0xFFFFF5F5), // Warna background
        child: FutureBuilder<List<User>>(
          future: futureUsers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Color(0xFFDA6976)), // Warna teks error
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No users found.',
                  style: TextStyle(color: Color(0xFFDA6976)), // Warna teks kosong
                ),
              );
            } else {
              final users = snapshot.data!;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Total Users: ${users.length}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFDA6976), // Warna teks judul
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return Card(
                          color: const Color(0xFFF7BCC2), // Warna card
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: const Color(0xFFDA6976), // Warna avatar
                              child: Text(
                                user.username[0].toUpperCase(),
                                style: const TextStyle(color: Colors.white), // Warna teks avatar
                              ),
                            ),
                            title: Text(
                              user.username,
                              style: const TextStyle(color: Colors.white), // Warna teks nama
                            ),
                            subtitle: Text(
                              'Email: ${user.email}\nPassword: ${user.password}',
                              style: const TextStyle(color: Colors.white), // Warna teks subtitle
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit, color: Colors.white), // Warna ikon edit
                              onPressed: () {
                                // Navigate to the edit user page
                              },
                            ),
                            onTap: () {
                              // Navigate to the user detail page
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
