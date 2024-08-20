import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MySecureStorage extends LocalStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  MySecureStorage()
      : super(
          initialize: () async {
            // No specific initialization needed for flutter_secure_storage
            print("MySecureStorage initialized");
          },
          hasAccessToken: () async {
            final hasToken = await const FlutterSecureStorage().containsKey(key: supabasePersistSessionKey);
            print("Has accessToken: $hasToken");
            return hasToken;
          },
          accessToken: () async {
            final token = await const FlutterSecureStorage().read(key: supabasePersistSessionKey);
            print("Retrieved accessToken: $token");
            return token;
          },
          removePersistedSession: () async {
            await const FlutterSecureStorage().delete(key: supabasePersistSessionKey);
            print("Session removed");
          },
          persistSession: (persistSessionString) async {
            await const FlutterSecureStorage().write(key: supabasePersistSessionKey, value: persistSessionString);
            print("Session persisted: $persistSessionString");
          },
        );
}

