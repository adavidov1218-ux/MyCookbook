import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mycookbook_gemini/data/database/database.dart';
import 'package:mycookbook_gemini/data/repositories/recipe_repository_impl.dart';
import 'package:mycookbook_gemini/domain/repositories/recipe_repository.dart';
import 'package:mycookbook_gemini/presentation/providers/recipe_provider.dart';
import 'package:mycookbook_gemini/presentation/screens/recipe_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => AppDatabase()),
        ProxyProvider<AppDatabase, RecipeRepository>(
          update: (_, db, __) => RecipeRepositoryImpl(db),
        ),
        ChangeNotifierProxyProvider<RecipeRepository, RecipeProvider>(
          create: (context) => RecipeProvider(context.read<RecipeRepository>()),
          update: (_, repo, previous) => previous!..updateRepository(repo),
        ),
      ],
      child: MaterialApp(
        title: 'MyCookbook Gemini',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const RecipeListScreen(),
      ),
    );
  }
}
