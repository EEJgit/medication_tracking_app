// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InteractionsPage extends StatefulWidget {
  const InteractionsPage({super.key});

  @override
  _InteractionsPageState createState() => _InteractionsPageState();
}

class _InteractionsPageState extends State<InteractionsPage> {
  TextEditingController query1Controller = TextEditingController();
  TextEditingController query2Controller = TextEditingController();

  String apiKey = 'AIzaSyBVM4XqNuvtHhyAHuNVw3FKPDTxOWn-Wbw';
  String customSearchId =
      '56d53c9dfb117444d'; // Replace with your custom search engine ID

  List<dynamic> searchResults = [];

  Future<void> performSearch(String query1, String query2) async {
    final url =
        'https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=$customSearchId&q=$query1+$query2';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        searchResults = data['items'];
      });
    } else {
      throw Exception('Failed to load search results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          'Medication Interactions Search',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.green[400],
              fontSize: 20.0,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Do not rely on MedSense to make decisions regarding medical care. While we make every effort to ensure that data is accurate, you should assume all results are unvalidated",
              style: TextStyle(color: Colors.red[600]),
            ),
            TextField(
              controller: query1Controller,
              decoration: InputDecoration(
                labelText: 'Medication one',
                labelStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            TextField(
              controller: query2Controller,
              decoration: InputDecoration(
                labelText: 'Medication two',
                labelStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                String query1 = query1Controller.text;
                String query2 = query2Controller.text;
                performSearch(query1, query2);
              },
              child: Text(
                'Search Interactions 🔍',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[400],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      searchResults[index]['title'],
                      style: GoogleFonts.lato(
                        textStyle:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          searchResults[index]
                              ['snippet'], // Display additional details here
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        Text(
                          searchResults[index]['link'],
                          style: GoogleFonts.lato(
                            textStyle:  TextStyle(
                              color: Colors.green[400],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
