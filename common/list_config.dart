import 'dart:convert'; // Import this to use jsonDecode
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigFetcher {
  // Declare the variables to hold the values
  static bool sleep = true;
  static bool worship = false;
  static bool chanting = true;
  static bool regulations = true;
  static bool association = true;
  static bool bookReading = true;
  static bool bookDistribution = true;
  static bool notes = true;

  // Fetch the remote config values and assign them to the variables
  static Future<void> fetchConfigValues() async {
    final remoteConfig =  FirebaseRemoteConfig.instance;
    try {
      // Fetch and activate the configuration
      await remoteConfig.fetchAndActivate();

      // Fetch the entire HomePageSectionList config as a JSON string
      String? homePageSectionListJson = remoteConfig.getString('HomePageSectionList');

      if (homePageSectionListJson.isNotEmpty) {
        // Decode the JSON string into a Map<String, dynamic>
        Map<String, dynamic> homePageSectionList = jsonDecode(homePageSectionListJson);

        // Assign each section value based on the fetched config
        sleep = homePageSectionList['sleep'] ?? true;
        worship = homePageSectionList['worship'] ?? true;
        chanting = homePageSectionList['chanting'] ?? true;
        regulations = homePageSectionList['regulations'] ?? true;
        association = homePageSectionList['association'] ?? true;
        bookReading = homePageSectionList['bookReading'] ?? true;
        bookDistribution = homePageSectionList['bookDistribution'] ?? true;
        notes = homePageSectionList['notes'] ?? true;
  
      }
    } catch (e) {
      print('Error fetching remote config: $e');
    }
  }
}