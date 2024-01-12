import 'package:flutter/material.dart';
import 'package:lettutor20120205/app.dart';
import 'package:lettutor20120205/providers/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
