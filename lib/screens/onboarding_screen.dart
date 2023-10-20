
import 'package:flutter/material.dart';
import 'package:medication_tracking_app/auth/auth.dart';
import 'package:medication_tracking_app/intro_screens/intro_screen1.dart';
import 'package:medication_tracking_app/intro_screens/intro_screen2.dart';
import 'package:medication_tracking_app/intro_screens/intro_screen3.dart';
//import 'package:medication_tracking_app/pages/home_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //THE SMOOTHPAGE CONTROLLER TO KEEP TRACK OF THE PAGE YOURE ON
  final PageController _pageController = PageController();
  //we need to check if we are on the last page or not.
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            //The page view controller to keep track of the page when switched the dot must move too.
            controller: _pageController,
            //checks state if we are on the last page or not.
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2); //2 is the index for the last page of the onBoarding screen.
              });
            },
            children: const [
              //intro screen screen one
              IntroScreenOne(),
              //intro screen two
              IntroScreenTwo(),
              //intro screen there
              IntroScreenThree(),
            ],
          ),
          //smooth page controller//These are the dot indicators.
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //++++++++++++++++++++++++++++++++++++
                //Skip Button to skip to the homepage.
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          //this line helps jump to the last screen on the onBoarding screeens of which is the third.
                          _pageController.jumpToPage(2);
                        },
                        child: const Text("  "),
                      )
                    : GestureDetector(
                        onTap: () {
                          //this line helps jump to the last screen on the onBoarding screeens of which is the third.
                          _pageController.jumpToPage(2);
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),

                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: const WormEffect(
                    // Customize the effect
                    activeDotColor: Colors.white, // Change the active dot color
                    dotColor: Colors.grey, // Change the inactive dot color
                  ),
                ),

                //+++++++++++++++++++++++++++++++++++
                //Next Button to see the next screen or done if we are on the last page
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          //We go to the login page when this is done
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              ///++++++++======HERE CHANGE IS NEEDED=======+++++
                              return const AuthPage();//this is where the decision page should be HomePage() has been moved.
                            },
                          ));
                        },
                        child: Text(
                          "done",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[200]),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          //this line is used to get to next screen of the onBoarding screens
                          _pageController.nextPage(
                            duration: const Duration(microseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text(
                          "next",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
