import 'package:flutter/material.dart';

void main() {
  runApp(const SignIn());
}

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("LangAlarmv1"),
      ),
      body: Builder(
          builder: (context) => Center(
                  child: Column(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const MyApp(data: "Signed in")));
                    },
                    child: const Text('Sign In'),
                  ),
                ],
              ))),
    ));
  }
}

class MyApp extends StatelessWidget {
  final String data;
  const MyApp({
    super.key,
    required this.data,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(data),
        ),
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
