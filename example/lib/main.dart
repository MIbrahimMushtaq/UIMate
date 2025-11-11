import 'package:flutter/material.dart';
import 'package:ui_mate/ui_mate.dart';
import 'package:ui_mate/widgets/btn.dart';
import 'package:ui_mate/widgets/divider.dart';
import 'package:ui_mate/widgets/get_image.dart';
import 'package:ui_mate/widgets/loader.dart';
import 'package:ui_mate/widgets/txt.dart';
import 'package:ui_mate/widgets/txt_input.dart';
import 'package:ui_mate/dialogs/overlay_loading.dart';

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
  bool isLoading = true;

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
                fontWeight: FontWeight.w600,
              ),
              const MyDivider(height: 20),

              // TextInput Example
              TxtFormInput(
                controller: _controller,
                hintText: "Enter your name",
                onChanged: (val) {
                  debugPrint("Input changed: $val");
                },
              ),
              MyDivider(),
              MyDivider(),

              // Button Example
              Btn(
                text: "",
                textColor: Colors.red,
                radius: 100,
                hasBorder: false,
                borderColor: Colors.red,
                preFix: Icon(Icons.access_alarm_outlined,size: 28,),
                isLoading: true,
                loadingColor: Colors.red,
                onPressed: () {
                  if (_controller.text.isEmpty) {
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
                onPressed: () async {
                  LoadingOverlay.show(context,backgroundColor: Colors.black.withOpacity(0.8),body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Loading, please wait...',style: TextStyle(color: Colors.white),),
                      MyDivider(),
                      LoadingPro(valueColor: Colors.white,)
                    ],
                  ),);
                  await Future.delayed(const Duration(seconds: 6));
                  LoadingOverlay.hide();

                },
              ),
              const SizedBox(height: 20),
              GetImage(
                imagePath: 'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=2069',
                width: double.infinity,
                height: 400,
                radius: 20,
                fit: BoxFit.cover,
                isAssets: false,
                appBar: AppBar(title: Text('my app bar'),backgroundColor: Colors.black,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
