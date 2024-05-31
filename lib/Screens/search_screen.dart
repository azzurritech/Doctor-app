import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Model class for Doctor
class Doctor {
  final int id;
  final String name;
  final String speciality;
  final String address;
  final String experience;
  final String image;

  Doctor({
    required this.id,
    required this.name,
    required this.speciality,
    required this.address,
    required this.experience,
    required this.image,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      speciality: json['speciality'],
      address: json['address'],
      experience: json['experience'],
      image: json['image'],
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<Doctor> doctors;
  late List<Doctor> filteredDoctors = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://doclive.info/api/doctors'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        doctors = data.map((json) => Doctor.fromJson(json)).toList();
        filteredDoctors = doctors;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void filterDoctors(String query) {
    setState(() {
      filteredDoctors = doctors
          .where((doctor) => doctor.speciality.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                filterDoctors(value);
              },
              decoration: InputDecoration(
                labelText: 'Search by speciality',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                return ListTile(

                  title: Text(filteredDoctors[index].name),
                  subtitle: Text(filteredDoctors[index].speciality),
                  onTap: () {
                    // Handle doctor selection
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

