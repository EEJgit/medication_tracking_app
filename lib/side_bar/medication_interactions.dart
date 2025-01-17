// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:medication_tracking_app/pages/home_page.dart';

class MedicationInteractionScreen extends StatefulWidget {
  const MedicationInteractionScreen({Key? key}) : super(key: key);

  @override
  State<MedicationInteractionScreen> createState() =>
      _MedicationInteractionScreenState();
}

class _MedicationInteractionScreenState
    extends State<MedicationInteractionScreen> {
  List _items = [];
  final int maxTextLength = 150; // Define the maximum length of the text
  final int maxHeadlineLength =
      350; // Define the maximum length of the headline
  final int maxPublisherLength =
      20; // Define the maximum length of the publisher's name
  final int maxDescriptionLength =
      100; // Define the maximum length of the description
  final int maxPublishedAtLength =
      20; // Define the maximum length for the "Published At" date

  Future<void> fetchNews() async {
    const apiKey = "b98573aa652945d4b03e0573c20cc6cb";
    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=sa&category=health&apiKey=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _items = data['articles'];
        print("Fetched ${_items.length} news articles");
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...'; // Truncate text
  }

  double calculateTextSize(double containerWidth) {
    if (containerWidth > 200) {
      return 18.0; // Full-size text for wider containers
    } else {
      return 14.0; // Smaller text for narrower containers
    }
  }

//#######################Bottom Navigation
  int __selectedIndex = 0; //the bottom navigation index
  void _navigateBottomBar(int index) {
    setState(() {
      __selectedIndex = index;
    });
  }

  final List<Widget> pages = [
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            const SizedBox(height: 19),
            Row(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                        height: 300,
                        width: 370,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Center(child: Text("Stay Updated", style: TextStyle(fontSize: 28),))),
                  ),
                )
                /*
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Hello",
                    style: TextStyle(
                        color: Colors.green[400],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )
                */
              ],
            ),
            Center(
              child: _items.isEmpty
                  ? const CircularProgressIndicator() // Show a loading indicator until data is fetched
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        return CarouselSlider.builder(
                          itemCount: _items.length,
                          options: CarouselOptions(
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            pauseAutoPlayOnTouch: true,
                            enlargeCenterPage: true,
                          ),
                          itemBuilder: (context, index, realIndex) {
                            final containerWidth = constraints.maxWidth;

                            return Container(
                              width: double.infinity,
                              height: 400,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: SingleChildScrollView(
                                child: Card(
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Color.fromARGB(255, 26, 27,
                                      27), // Set the background color to a modern color
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          truncateText(
                                            _items[index]['title'] ??
                                                'No title',
                                            maxHeadlineLength,
                                          ),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: calculateTextSize(
                                                  containerWidth),
                                              color: Colors.green[400]),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          truncateText(
                                            _items[index]['description'] ?? '',
                                            maxDescriptionLength,
                                          ),
                                          style: TextStyle(
                                            fontSize: calculateTextSize(
                                                containerWidth),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            const Icon(Icons.calendar_today),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Published: ${truncateText(_items[index]['publishedAt'] ?? 'N/A', maxPublishedAtLength)}',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
