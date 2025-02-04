import 'package:bhakti_app/config.dart';

class BottomNavProvider with ChangeNotifier {
  TabController?
      tabController; // Tab controller for managing bottom navigation tabs
  List dashList = []; // List to hold bottom navigation items

  // Function to handle tab selection
  onTapTab(val) {
    FocusManager.instance.primaryFocus?.unfocus();
    tabController!.index = val; // Set the index of the tab controller
    notifyListeners();
  }

  // Function to initialize bottom navigation
  onInit(TickerProvider vsync) {
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners(); // Notify listeners
    dashList = appArray
        .bottomNavyList; // Initialize dashList with bottom navigation items
    tabController = TabController(
        length: dashList.length, vsync: vsync); // Initialize tab controller
    notifyListeners(); // Notify listeners again
  }

  // List of screens corresponding to bottom navigation items
  final List<Widget> screens = [
    const HomeScreen(), // Home screen
    const DashBoardScreen(), // Dashboard screen
    const MonitoringScreen(), // Monitoring screen
    const SettingScreen() // Setting screen
  ];
}
