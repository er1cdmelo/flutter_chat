import 'package:app_testes/feature/chat/page/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<DropdownMenuEntry> entries = [];

  void addEntries() {
    if (entries.isNotEmpty) return;
    for (int i = 0; i < 5; i++) {
      DropdownMenuEntry entry = DropdownMenuEntry(
        value: i,
        label: "Valor ${i.toString()}",
      );

      entries.add(entry);
    }
  }

  @override
  Widget build(context) {
    addEntries();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ChatPage(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Chat"),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.chat),
                  ],
                ),
              ),
              DropdownMenu(
                dropdownMenuEntries: entries,
                width: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
