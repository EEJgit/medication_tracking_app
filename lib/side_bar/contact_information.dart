import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medication_tracking_app/pages/home_page.dart';

class COntactInformation extends StatefulWidget {
  const COntactInformation({super.key});

  @override
  _COntactInformationState createState() => _COntactInformationState();
}

class _COntactInformationState extends State<COntactInformation> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text(
          "Emergency Contacts",
          style: TextStyle(color: Colors.white),
        ),

          actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
            },
            icon: Icon(
              Icons.home,
              color: Colors.green[600],
              size: 30,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          // You can add any logic here to refresh the data
          setState(() {});
        },
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users/${user?.email}/emergency')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            List<Widget> contactWidgets = [];
            final contacts = snapshot.data?.docs ?? [];

            for (var contact in contacts) {
              String name = contact['name'];
              String phone = contact['phone'];
              String email = contact['email'];
              String location = contact['location'];
              String relationship = contact['relationship'];
              String sex = contact['sex'];

              Widget contactCard = ListTile(
                title: Center(
                    child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.green[400],
                    fontWeight: FontWeight.bold,
                  ),
                )),
                subtitle: Column(
                  children: [
                    Text(
                      "Phone: $phone",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Email: $email",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Location: $location",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(" Relationship: $relationship",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Sex: $sex",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              );
              contactWidgets.add(contactCard);
            }

            return ListView(
              children: contactWidgets,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _refreshIndicatorKey.currentState?.show();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
