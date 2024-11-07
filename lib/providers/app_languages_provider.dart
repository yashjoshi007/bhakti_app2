import '../config.dart';

class AppLanguageProvider extends ChangeNotifier {

  // Map of translations (if needed)
  Map<String, dynamic>? translations;

  // List of supported languages
  List<String> languages = ['hindi', 'english', 'russian'];

  // Selected language
  String selectedLanguage = 'english';

  // Default locale for the app
  Locale _appLocale = const Locale("en");

  // Getter for app locale
  Locale get appLocal => _appLocale;

  // SharedPreferences instance to store language preferences
  final SharedPreferences? data;

  // Function to handle language change
  void onChanged(value) {
    notifyListeners();
    // Change language based on the selected value
    if (value == 'english') {
      changeLanguage(const Locale("en"));
    } else if (value == 'hindi') {
      changeLanguage(const Locale("hi"));
    } else if (value == 'russian') {
      changeLanguage(const Locale("ru"));
    } else {
      changeLanguage(const Locale("en"));
    }
    // Update selected language
    selectedLanguage = value;
    // Notify listeners again after language change
    notifyListeners();
  }



  // Initialize app locale based on saved preferences
  AppLanguageProvider(this.data) {
    var selectedLocale = data!.getString("selectedLocale");
    if (selectedLocale != null) {
      _appLocale = Locale(selectedLocale);
    } else {
      selectedLocale = "english";
      _appLocale = const Locale("en");
    }
    changeLanguage(_appLocale);
  }

  // Fetch and initialize locale from SharedPreferences
  Future<void> fetchLocale() async {
    if (data!.getString('language_code') == null) {
      _appLocale = const Locale('en');
    } else {
      _appLocale = Locale(data!.getString('language_code')!);
    }
    notifyListeners();
  }

  // Change app language based on the selected locale
  Future<void> changeLanguage(type) async {
    if (type == const Locale("hi")) {
      _appLocale = const Locale("hi");
      selectedLanguage = "hindi";
      await data!.setString('language_code', 'hi');
      await data!.setString('countryCode', 'IN');
    } else if (type == const Locale("en")) {
      _appLocale = const Locale("en");
      selectedLanguage = "english";
      await data!.setString('language_code', 'en');
      await data!.setString('countryCode', 'US');
    } else if (type == const Locale("ru")) {
      _appLocale = const Locale("ru");
      selectedLanguage = "russian";
      await data!.setString('language_code', 'ru');
      await data!.setString('countryCode', 'RU');
    } else {
      _appLocale = const Locale("en");
      selectedLanguage = "english";
      await data!.setString('language_code', 'en');
      await data!.setString('countryCode', 'US');
    }
    data!.setString('selectedLocale', _appLocale.languageCode.toString());
    notifyListeners();
  }
}
