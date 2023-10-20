/*import 'package:flutter/material.dart';
import 'package:medication_tracking_app/read%20data/get_user_name.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}
//will have an horizontal scroll

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4.0),
              child: Container(
                height: 200,
               decoration: BoxDecoration(
                color: Colors.red[400],
                borderRadius: BorderRadius.circular(15.0)
               ),
                
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Hello \n Welcome to the medication \ntracking app!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4.0),
              child: Container(
                height: 200,
                color: Colors.pink[400],
                child: const Medications(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4.0),
              child: Container(
                height: 200,
                color: Colors.pink[400],
                child: GetUserName(documentId: '',),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4.0),
              child: Container(
                height: 200,
                color: Colors.pink[400],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4.0),
              child: Container(
                height: 200,
                color: Colors.pink[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/