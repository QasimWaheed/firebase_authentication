import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/services/auth.dart';
import 'package:testing_app/ui/screens/home_screen.dart';
import 'package:testing_app/ui/screens/login.dart';
import 'package:testing_app/ui/screens/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserAuthentication>(
      create: (context) => UserAuthentication(),
      child: Consumer<UserAuthentication>(
        builder: (context, themeProvider, child) => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            inputDecorationTheme: InputDecorationTheme(
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue.shade700,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              filled: true,
            ),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
            ),
          ),
          home: AuthGate(),
        ),
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: UserAuthentication().user,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoginScreen();
          }
          return HomeScreen();
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splash Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Route route =
                    MaterialPageRoute(builder: (_) => RegisterScreen());
                Navigator.push(context, route);
              },
              child: Text("Register"),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                Route route = MaterialPageRoute(builder: (_) => LoginScreen());
                Navigator.pushReplacement(context, route);
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

class Contact {
  final String name;

  const Contact({required this.name});
}

class ContactBook extends ValueNotifier<List<Contact>> {
  ContactBook._sharedInstance() : super([]);
  static final ContactBook _share = ContactBook._sharedInstance();
  factory ContactBook() => _share;

  final List<Contact> _contacts = [];

  int get length => value.length;

  void addContact({required Contact contact}) {
    final contacts = value;
    contacts.add(contact);
    notifyListeners();
  }

  void remove({required Contact contact}) {
    final contacts = value;
    if (contacts.contains(contact))
    _contacts.remove(contact);
    notifyListeners();
  }
 Contact? contact({required int atIndex}) => value.length > atIndex ? value[atIndex] : null;
}
