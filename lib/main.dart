import 'package:flutter/material.dart';

import 'app_router.dart';

void main() {
  runApp(MainApp(appRouter: AppRouter()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick And Morty',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          color: Colors.amberAccent[700],
          foregroundColor: Colors.grey[900],
        ),
      ),
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
