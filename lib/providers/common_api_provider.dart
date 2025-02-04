//self api
import 'dart:developer';
import 'package:bhakti_app/config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CommonApiProvider extends ChangeNotifier {
  // Initialize Firebase Messaging instance
  final firebaseMessaging = FirebaseMessaging.instance;

  // Variables to store FCM token and device ID
  String? getFCMToken;
  String deviceId = "";

  // Function for social login
  socialLogin(context, token) async {
    // Retrieve FCM token
    final fcmToken = await firebaseMessaging.getToken();
    getFCMToken = fcmToken;

    // Retrieve device ID based on platform
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var android = await deviceInfoPlugin.androidInfo;
        deviceId = android.id; // Android device ID
      } else if (Platform.isIOS) {
        var ios = await deviceInfoPlugin.iosInfo;
        deviceId = ios.identifierForVendor!; // iOS device ID
      }
    } on PlatformException {
      log("Failed to get platform version");
    }

    notifyListeners();

    // Construct request body
    var body = {
      'FirebaseAccessToken': token,
      'FCMToken': getFCMToken,
      'DeviceId': deviceId
    };

    log("fcm token of the user for notification $body");
    log("fcm token of the user for notification $getFCMToken");
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      // Perform API call for social login
      await apiServices
          .postApi(context, api.exchangeToken, body)
          .then((value) async {
        notifyListeners();
        if (value.isSuccess!) {
          // Save access token and user ID in SharedPreferences
          await pref.setString(session.accessToken, value.data['AccessToken']);
          await pref.setString(session.id, value.data['uid']);
          notifyListeners();
          // Call self API to fetch user details
          await selfApi(context);
        } else {
          // Show error message if API call fails
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.message)));
        }
      });
    } catch (e) {
      notifyListeners();
    }
  }

  // Function to fetch user details
  selfApi(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      // Perform API call to get user profile
      await apiServices
          .getApi(context, api.getProfile, [], isToken: true)
          .then((value) {
        if (value.isSuccess!) {
          // Save user details in SharedPreferences
          pref.setString(
              session.user, json.encode(UserModel.fromJson(value.data)));
          pref.setString(
              'BhaktiStepsAccessKey', value.data['bhakti_steps_access_key']);
          pref.setString('Name', value.data['name']);
          pref.setInt('LoggedInId', value.data['id']);
          // Notify listeners about data update
          notifyListeners();
          // Update userModel with fetched data
          userModel = UserModel.fromJson(value.data);
        }
      });
    } catch (e) {
      notifyListeners();
    }
  }
}
