import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AuthPage.dart';
import 'Dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        appId: '1:127813002960:android:2dafea14f67efee1eba0d5',
        apiKey: "AIzaSyCeet5bcvL6r2LP75AUzWRaKfS0EljWGrA",
        messagingSenderId: 'my_messagingSenderId',
        projectId: 'jose-35ba3',
        storageBucket: 'gs://jose-35ba3.appspot.com/',
        // Use your bucket link here
      ),
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor:
            SystemUiOverlayStyle.dark.systemNavigationBarColor,
      ),
    );
  }
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: '', theme: ThemeData(), home: (MainPage()));
  }
}

@override
class MainPage extends StatelessWidget {
  late final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            } else if (snapshot.hasData) {
              String user_email =
                  FirebaseAuth.instance.currentUser!.email.toString();
              return Dashboard(user_email);
            } else {
              return AuthPage();
            }
          },
        ),
      );
}



