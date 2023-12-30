import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:sevin_rm/language/language_store.dart';
import 'package:sevin_rm/language/local_modual.dart';
import 'package:sevin_rm/language/repository.dart';
import 'package:sevin_rm/language/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared_prefs/shared_prefs.dart';

import 'package:get_storage/get_storage.dart';

final getIt = GetIt.instance;

class DIManager {
  DIManager._();

  static Future<void> setUpLocator() async {
    getIt.registerSingletonAsync<SharedPreferences>(
        () => LocalModule.provideSharedPreferences());
    getIt.registerSingleton(
        SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));
    getIt.registerSingleton(Repository(getIt<SharedPreferenceHelper>()));
    getIt.registerSingleton(LanguageStore(getIt<Repository>()));
  }

  static Future<void> initDI() async {
    /// Shared Prefs
    await _setupSharedPreference();
  }

  static _setupSharedPreference() async {
    await GetStorage.init();
    _injectDep(SharedPrefs());
  }

  static T _injectDep<T extends Object>(T dependency) {
    getIt.registerSingleton<T>(dependency);
    return getIt<T>();
  }

  static void _injectDepLazy<T extends Object>(T dependency) {
    getIt.registerLazySingleton<T>(() => dependency);
  }

  static Future<void> _injectDepLazyAsync<T extends Object>(
    T dependency,
  ) async {
    getIt.registerLazySingletonAsync<T>(() async => dependency);
    return null;
  }

  static T findDep<T extends Object>() {
    return getIt<T>();
  }

  static Dio setupDio() {
    if (getIt.isRegistered<Dio>()) {
      return getIt<Dio>();
    }
    return getIt.registerSingleton<Dio>(Dio());
  }

  static Future<T> findDepAsync<T extends Object>() async {
    return getIt.getAsync<T>();
  }
}
