import 'package:flutter/material.dart';
import 'package:imkon/core/services/hive_service.dart';
import 'package:imkon/features/splash/providers/auth_provider.dart';
import 'package:imkon/my_app.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.initHive();
  await initializeDateFormatting('uz', null);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
