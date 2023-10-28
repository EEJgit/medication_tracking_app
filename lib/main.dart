import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cron/cron.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart' as mailer;
import 'package:mailer/smtp_server/gmail.dart';
import 'package:medication_tracking_app/constants.dart';
import 'package:medication_tracking_app/data/medication_Data.dart';
import 'package:medication_tracking_app/firebase_api.dart';
import 'package:medication_tracking_app/firebase_options.dart';
import 'package:medication_tracking_app/google_auth_api.dart';
import 'package:medication_tracking_app/local%20notifications/local_notifications.dart';
import 'package:medication_tracking_app/screens/onboarding_screen.dart';
import 'package:medication_tracking_app/pages/new_entry/new_entry_bloc.dart';
import 'package:medication_tracking_app/global_bloc.dart'; // Import the GlobalBloc
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';

//tIME IMPORTS
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// The color themes of the entire app
var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 52, 69, 165));

///############################
///
///THIS IS THE PART DEALING WITH TELEPHONY AND ANDROID ALARM SCHEDULER
///
///

///This is the mail sending demo
Future<void> sendEmail() async {
  //from the video

  final user = await GoogleAuthApi.signIn();
  //we check if the user is not null
  if (user == null) return;

  final email =
      user.email; //to get the user from google sign in instead of hard coding
  final auth = await user.authentication; //to get the right token
  final token = auth.accessToken!;

  final smtpServer = gmailSaslXoauth2(email, token);
  final message = mailer.Message()
    ..from = mailer.Address(email, "Mambwe") // Replace with your email
    ..recipients.add('mikeapple056@gmail.com') // Replace with the recipient's email
    ..subject = 'Missed Medication Dose'
    ..text = 'We wanted to let you know that there was a missed dosage today for [Patients Name].Please make sure to administer the medication as soon as possible. If you have any questions or need further instructions, please feel free to reach out to us. Thank you for your attention to the patients care.';
  try {
    await mailer.send(message, smtpServer);
    print("sent successfully");
  } on mailer.MailerException catch (e) {
    print(e);
  }

  /*
  final smtpServer = gmail('engineermambwe@gmail.com',
      'prodig'); // Replace with your email and app password
  
  final message = mailer.Message()
    ..from =
        mailer.Address(email,"Mambwe") // Replace with your email
    ..recipients
        .add('mikeapple056@gmai') // Replace with the recipient's email
    ..subject = 'Scheduled Email'
    ..text = 'This is a scheduled email sent from Flutter.';

  try {
    final sendReport = await mailer.send(message, smtpServer);
    print('Email sent: ${sendReport.toString()}');
  } catch (e) {
    print('Email sending failed: $e');
  }
  */
}

//We try using the telephony package again
Future<void> sendSMS(String phoneNumber, String message) async {
  final telephony = Telephony.instance;
  await telephony.sendSms(
    to: phoneNumber,
    message: message,
  );
  print('SMS sent');
}

void sendScheduledSMS() {
  const recipientPhoneNumber =
      "0975854067"; // Replace with the recipient's phone number
  const smsMessage = "Scheduled SMS content"; // Replace with your SMS content

  sendSMS(recipientPhoneNumber, smsMessage);
}

void scheduleSMSSend() {
  AndroidAlarmManager.periodic(
    const Duration(minutes: 1), // Schedule every hour
    0, // Unique ID
    sendScheduledSMS,
    exact: true,
    wakeup: true,
  );
  print("sent message ");
}

//ends here
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferences.getInstance();
  FirebaseMessaging.onBackgroundMessage(_firebasePushHandler);
  await FirebaseApi()
      .initNotification(); //call the firebaseNotificatiosn method from the firebase_api file
  //flutter notifications second try
  await LocalNotifications.init();
  //aweesome Notifications

//TODO:

  //Cron scheduler for sending emails
  final cron = Cron();
  //we schedule here
  cron.schedule(Schedule.parse('*/1 * * * *'), () async {
   print('every 1');
    //scheduleSMSSend();
    //await sendEmail();
  });

  ///cron ends here
  ///
 
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Time to take your medication',
      )
    ],
    debug: true,
  );
  //The android alarm sending sms try out
  await AndroidAlarmManager.initialize();
   //Schedule the SMS sending function
  scheduleSMSSend();

  //Time Methods
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('America/New_York'));
  
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
        theme: ThemeData.dark().copyWith(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kScaffoldColor,
          //appbar theme
          appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromARGB(255, 52, 69, 165),
            elevation: 0,
            iconTheme: const IconThemeData(
              color: kSecondaryColor,
            ),
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
            headlineMedium: const TextStyle(
              fontWeight: FontWeight.w800,
              color: kTextColor,
            ),
            headlineSmall: const TextStyle(
              fontWeight: FontWeight.w900,
              color: kTextColor,
            ),
            titleLarge: GoogleFonts.poppins(
              color: kTextColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
            titleMedium: GoogleFonts.poppins(color: kPrimaryColor),
            titleSmall: GoogleFonts.poppins(color: kTextLightColor),
            bodySmall: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              color: kTextLightColor,
            ),
            labelMedium: const TextStyle(
              fontWeight: FontWeight.w500,
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
            dayPeriodTextStyle: GoogleFonts.aBeeZee(),
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
