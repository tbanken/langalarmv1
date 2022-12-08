import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'db.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongdart;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SignInPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => const HomePage()
      },
    );
  }
}

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoTextFormFieldRow(
                placeholder: 'Email',
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                placeholderStyle: const TextStyle(
                  color: CupertinoColors.inactiveGray,
                ),
                style: const TextStyle(
                  color: CupertinoColors.white,
                ),
                cursorColor: CupertinoColors.white,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
                validator: (value) {
                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value!)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              CupertinoTextFormFieldRow(
                placeholder: 'Password',
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                obscureText: true,
                placeholderStyle: const TextStyle(
                  color: CupertinoColors.inactiveGray,
                ),
                style: const TextStyle(
                  color: CupertinoColors.white,
                ),
                cursorColor: CupertinoColors.white,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              _isLoading
                  ? const CupertinoActivityIndicator(
                      animating: true,
                      radius: 20.0,
                      color: Color.fromARGB(255, 156, 156, 156),
                    )
                  : CupertinoButton.filled(
                      child: const Text('Sign In'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          // Sign in with email and password
                          Navigator.pushNamed(context, '/home');
                        }
                      },
                    ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the SignUpScreen when the button is pressed
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            CupertinoTextFormFieldRow(
              placeholder: 'Email',
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
              keyboardType: TextInputType.emailAddress,
              placeholderStyle: const TextStyle(
                color: CupertinoColors.inactiveGray,
              ),
              style: const TextStyle(
                color: CupertinoColors.white,
              ),
              cursorColor: CupertinoColors.white,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: CupertinoColors.white,
                  ),
                ),
              ),
              validator: (value) {
                if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value!)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            CupertinoTextFormFieldRow(
              placeholder: 'Password',
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              obscureText: true,
              placeholderStyle: const TextStyle(
                color: CupertinoColors.inactiveGray,
              ),
              style: const TextStyle(
                color: CupertinoColors.white,
              ),
              cursorColor: CupertinoColors.white,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: CupertinoColors.white,
                  ),
                ),
              ),
              validator: (value) {
                if (value!.length < 8) {
                  return 'Password must be at least 8 characters';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  var db = mongdart.Db("mongodb://localhost:27017/users");
                  await db.open();
                  var collection = db.collection("users");
                  collection
                      .insertOne({"email": _email, 'password': _password});
                  Navigator.pop(context);
                }
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Hi"),
        ),
        // body: const AlarmHomePage(),
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(
              label: "Sleep", icon: Icon(Icons.mode_night_outlined)),
          BottomNavigationBarItem(label: "Lang", icon: Icon(Icons.abc)),
          BottomNavigationBarItem(label: "Settings", icon: Icon(Icons.settings))
        ]),
      ),
    );
  }
}
