export 'package:bhakti_app/common/common_path_list.dart';
export '../screens/path_list.dart';
export 'package:bhakti_app/widgets/widget_path_list.dart';
export '../../../../package_list.dart';
export 'dart:convert';
export 'package:bhakti_app/services/sadhana_api_data.dart';
export 'package:bhakti_app/models/user_model.dart';
export 'package:bhakti_app/customise/scrollable_positioned_list/scrollable_positioned_list.dart';
export '../providers/index.dart';
export 'package:flutter/material.dart';
export '../routes/index.dart';
export 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bhakti_app/services/api_methods.dart';
import 'package:bhakti_app/services/api_service.dart';
import 'package:bhakti_app/config.dart';
import 'common/languages/app_localizations.dart';
import 'package:bhakti_app/common/session.dart';

Session session = Session();
AppFonts appFonts = AppFonts();
ApiServices apiServices = ApiServices();
AppArray appArray = AppArray();
UserModel? userModel;

AppCss appCss = AppCss();
ApiMethods api = ApiMethods();

ThemeService appColor(context) {
  final themeServices = Provider.of<ThemeService>(context, listen: false);
  return themeServices;
}

showLoading(context) async {
  Provider.of<LoadingProvider>(context, listen: false).showLoading();
}

hideLoading(context) async {
  Provider.of<LoadingProvider>(context, listen: false).hideLoading();
}

Future<bool> isNetworkConnection() async {
  var connectivityResult = await Connectivity()
      .checkConnectivity(); //Check For Wifi or Mobile data is ON/OFF
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  } else {
    final result = await InternetAddress.lookup(
        'google.com'); //Check For Internet Connection
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

String language(context, text) {
  return AppLocalizations.of(context)!.translate(text);
}
