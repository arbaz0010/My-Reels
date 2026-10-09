import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // 1. Supabase کا اِمپورٹ

import 'app.dart';
import 'core/error/error_handler.dart';
import 'core/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize global error handling
  GlobalErrorHandler.initialize();

  // 2. Supabase کو initialize کریں
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',       // یہاں اپنا Supabase URL ڈالیں
    anonKey: 'YOUR_SUPABASE_ANON_KEY', // یہاں اپنی Supabase Anon Key ڈالیں
  );
  
  // Remove the hash from URLs on web
  usePathUrlStrategy();
  
  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const App(),
    ),
  );
}
