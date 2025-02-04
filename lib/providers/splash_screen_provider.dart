import 'dart:developer';

import 'package:bhakti_app/config.dart';

class SplashScreenProvider extends ChangeNotifier {
  Future<void> fetchSpiritualMasters(context) async {
    final setupPvr = Provider.of<SetUpProfileProvider>(context, listen: false);
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(minutes: 5)));
      await remoteConfig.fetchAndActivate();
      String getLinkOfDrawerURL = remoteConfig.getString('SpiritualMasters');

      // Parse the JSON string into a dynamic object
      dynamic jsonResult = jsonDecode(getLinkOfDrawerURL);

      // Check if the parsed JSON is a List<dynamic>
      if (jsonResult is List<dynamic>) {
        // Extract the names from the parsed JSON
        List<String> spiritualMasters = jsonResult
            .map((item) => item['spiritual_master_name'] as String)
            .toList();

        setupPvr.masterItems = spiritualMasters;

        notifyListeners();
      } else {
        log('Error: JSON result is not a list');
      }
    } catch (e) {
      log('Error fetching remote config: $e');
    }
  }

  checkLocalData(context) async {
    final firebaseFCMToken =
        Provider.of<FirebaseFCMToken>(context, listen: false);
    await firebaseFCMToken.initNotification();

    fetchSpiritualMasters(context);

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? name = pref.getString('name');

    if (name != null && name.isNotEmpty) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const CommonBottomNavigationBar()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SetUpProfile()));
    }

    if (pref.getString(session.user) != null) {
      userModel =
          UserModel.fromJson(json.decode(pref.getString(session.user)!));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const CommonBottomNavigationBar()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginAuthScreen()));
    }
  }
}
