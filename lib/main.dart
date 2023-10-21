import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medication_tracking_app/constants.dart';
import 'package:medication_tracking_app/data/medication_Data.dart';
import 'package:medication_tracking_app/firebase_options.dart';
import 'package:medication_tracking_app/screens/onboarding_screen.dart';
import 'package:medication_tracking_app/pages/new_entry/new_entry_bloc.dart';
import 'package:medication_tracking_app/global_bloc.dart'; // Import the GlobalBloc
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// The color themes of the entire app
var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 52, 69, 165));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferences.getInstance();
  FirebaseMessaging.onBackgroundMessage(_firebasePushHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MedicationData()),
        Provider<NewEntryBloc>(create: (context) => NewEntryBloc()),
        // Add the GlobalBloc provider
        Provider<GlobalBloc>(create: (context) => GlobalBloc()),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        /*theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.onSecondary,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.onPrimaryContainer,
            margin: const EdgeInsets.all(16),
          ),
        ),*/
        theme:ThemeData.dark().copyWith(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: kScaffoldColor,
            //appbar theme
            appBarTheme: AppBarTheme(
              backgroundColor:  const Color.fromARGB(255, 52, 69, 165),
              elevation: 0,
              iconTheme: const IconThemeData(
                color: kSecondaryColor,),
              titleTextStyle: GoogleFonts.mulish(
                color: kTextColor,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.normal,
                fontSize: 18,
              ),
            ),
            textTheme: TextTheme(
              displaySmall: const TextStyle(
                                color: kSecondaryColor,
                fontWeight: FontWeight.w500,
              ),
              headlineMedium: const TextStyle( fontWeight: FontWeight.w800,
                color: kTextColor,
              ),
              headlineSmall: const TextStyle(                fontWeight: FontWeight.w900,
                color: kTextColor,
              ),
              titleLarge: GoogleFonts.poppins(color: kTextColor,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
              titleMedium:
                  GoogleFonts.poppins( color: kPrimaryColor),
              titleSmall:
                  GoogleFonts.poppins( color: kTextLightColor),
              bodySmall: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                color: kTextLightColor,
              ),
              labelMedium: const TextStyle(               fontWeight: FontWeight.w500,
                color: kTextColor,
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kTextLightColor,
                  width: 0.7,
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: kTextLightColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
              ),
            ),
            //lets customize the timePicker theme
            timePickerTheme: TimePickerThemeData(
              backgroundColor: kScaffoldColor,
              hourMinuteColor: kTextColor,
              hourMinuteTextColor: kScaffoldColor,
              dayPeriodColor: kTextColor,
              dayPeriodTextColor: kScaffoldColor,
              dialBackgroundColor: kTextColor,
              dialHandColor: kPrimaryColor,
              dialTextColor: kScaffoldColor,
              entryModeIconColor: kOtherColor,
              dayPeriodTextStyle: GoogleFonts.aBeeZee(
                              ),
            ),
          ),
        home: const OnboardingScreen(),
      ),
    );
  }
}

Future<void> _firebasePushHandler(RemoteMessage message) async {
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}
