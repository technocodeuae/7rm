import 'dart:async';

import 'package:sevin_rm/language/shared_preference.dart';


class Repository {

  // api objects
  // final AppApi _appApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository( this._sharedPrefsHelper);



  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;
}