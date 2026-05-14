import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // STEP 14: SET PROFESSIONAL THEME
        // Setting the primary color to the requested hex code
        primaryColor: const Color(0xFFF6FE7DD),

        // Setting the background color to white
        scaffoldBackgroundColor: Colors.white,

        // Setting the accent color (using colorScheme for modern Flutter)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF6FE7DD),
          // Accent/Secondary color as requested
          secondary: const Color(0xFFFFFF4C2),
        ),

        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Professional theme use karne ke liye primary color apply kiya gaya hai
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.title),
      ),
      // Background color white pehle se theme me set kar diya gaya hai
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        // Accent color (secondary) yahan use ho raha hai
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
