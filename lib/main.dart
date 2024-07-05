import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:haash_moving_chart/cores/theme/provider/theme_provider.dart';
import 'package:haash_moving_chart/features/chart/presentation/provider/entry_provider.dart';
import 'package:haash_moving_chart/features/chart/presentation/screens/home.dart';
import 'package:haash_moving_chart/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EntryProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Moving Chart',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.themeData,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
