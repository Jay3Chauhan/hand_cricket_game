import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/utils/theme/app_theme.dart';
import 'features/game/providers/game_provider.dart';
import 'features/game/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: MaterialApp(
        title: 'Hand Cricket',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
