import 'package:flutter/material.dart';
import 'package:flutter_rickandmorty/app_router.dart';

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
      ),
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
