import 'package:flutter/material.dart';
import 'package:paainet/features/Presentation/router/router.dart';
import 'package:paainet/utils/themeData/theme_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  // Load .env file
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const PaaiNet());
}

class PaaiNet extends StatelessWidget {
  const PaaiNet({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Paainet',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
