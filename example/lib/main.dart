import 'package:flutter/material.dart';
import 'package:ui_mate/ui_mate.dart';
import 'package:ui_mate/widgets/btn.dart';
import 'package:ui_mate/widgets/txt.dart';
import 'package:ui_mate/widgets/txt_input.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Mate Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("UI Mate Example")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Txt Example
              const Txt(
                "👋 Welcome to UI Mate",
                textColor: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 20),

              // TextInput Example
              TxtFormInput(
                controller: _controller,
                hintText: "Enter your name",
                preFix: const Icon(Icons.person, color: Colors.grey),
                onChanged: (val) {
                  debugPrint("Input changed: $val");
                },
              ),
              const SizedBox(height: 20),

              // Button Example
              Btn(
                text: "Submit",
                bgColor: Colors.blue,
                textColor: Colors.white,
                radius: 8,
                onPressed: () {
                  if (_controller.text.isEmpty) {
                    pSnackBar(
                      context: context, // ✅ context is now required
                      message: "⚠️ Please enter your name",
                    );
                  } else {
                    pShowToast(
                      message: "✅ Hello, ${_controller.text}!",
                    );
                  }
                },
              ),
              const SizedBox(height: 20),

              // Another Button Example
              Btn(
                text: "Show Info Snackbar",
                bgColor: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  pSnackBar(
                    context: context, // ✅ pass context here
                    message: "ℹ️ This is an info snackbar",
                    backgroundColor: Colors.green,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
