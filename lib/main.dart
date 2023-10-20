import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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
        theme: ThemeData().copyWith(
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
        ),
        home: const OnboardingScreen(),
      ),
    );
  }
}

Future<void> _firebasePushHandler(RemoteMessage message) async {
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}
