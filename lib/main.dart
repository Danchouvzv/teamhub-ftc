import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Инициализация русской локали для DateFormat
  await initializeDateFormatting('ru_RU', null);
  runApp(
    const ProviderScope(
      child: FTCTeamHubApp(),
    ),
  );
}

class FTCTeamHubApp extends StatelessWidget {
  const FTCTeamHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FTC TeamHub',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
