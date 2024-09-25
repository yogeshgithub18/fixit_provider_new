import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../backend/api_end_points.dart';
import '../../backend/base_api.dart';

class ChooseLanguageController extends GetxController {
  final RxString selectedLanguage = 'en'.obs;
  @override
  void onInit() {
    super.onInit();
    _loadLanguage();
  }

  void setLanguage(String languageCode) {
    selectedLanguage(languageCode);
    _saveLanguage(languageCode);
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString('language');
    if (savedLanguage != null) {
      selectedLanguage(savedLanguage);
    }
  }

  Future<void> _saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
  }

  Future<void> updateLanguage(String code)async{
    await BaseAPI().post(url:ApiEndPoints().updateLanguage,data: {"lang_id":code=='en'?1:code=='ar'?2:3});
  }
}
