import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PharmacyMap extends StatefulWidget {
  const PharmacyMap({super.key});

  @override
  _PharmacyMapScreenState createState() => _PharmacyMapScreenState();
}

class _PharmacyMapScreenState extends State<PharmacyMap> {
  final TextEditingController _queryController = TextEditingController();
  String _response = '';

  Future<void> getFirstAidTips(String query) async {
    const apiKey = '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';
    const endpoint =
        'https://api.openai.com/v1/engines/davinci-codex/completions';

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'prompt':
            'First aid tips for $query', // Include the query in the prompt
        'max_tokens': 150, // Adjust as needed
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _response = data['choices'][0]['text'];
      });
    } else {
      setState(() {
        _response = 'Error: ${response.reasonPhrase}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacy Map'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _queryController,
              decoration: const InputDecoration(
                hintText: 'Search for first aid tips...',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String query = _queryController.text;
                if (query.isNotEmpty) {
                  getFirstAidTips(query);
                }
              },
              child: const Text('Get First Aid Tips'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Response:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_response, style: const TextStyle(color:Colors.green),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
