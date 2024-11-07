import 'package:bhakti_app/config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    loadSavedBooks(); // Call this when the widget is initialized
  }

  Future<void> loadSavedBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('bookList');

    if (jsonString != null) {
      List<dynamic> jsonData = jsonDecode(jsonString);

      appArray.localBookList =
          jsonData.map((e) => Map<String, dynamic>.from(e)).toList();
    }

    setState(() {}); // Update the state after loading data
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeScreenProvider, BottomNavProvider>(
        builder: (context1, homeScreenPvr, bottomPvr, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(DurationsClass.ms50)
              .then((value) => homeScreenPvr.onReady(context)),
          child: SafeArea(
              child: Stack(children: [
            Scaffold(
                drawer: const DrawerScreen(),
                extendBody: true,
                body: RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 1))
                          .then((value) {
                        homeScreenPvr.getData(context, isTap: true);
                      });
                    },
                    child: GestureDetector(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: CommonBgWidget().commonBgImage(
                            SingleChildScrollView(
                                child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                              HomeAppBar(),
                              VSpace(Insets.i20),
                              HomeScreenSection()
                            ]).paddingOnly(
                                    top: MediaQuery.of(context).size.height *
                                        0.01,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.05,
                                    left: Insets.i20,
                                    right: Insets.i20)))))),
            if (homeScreenPvr.isLoading) const CommonLoading()
          ])));
    });
  }
}
