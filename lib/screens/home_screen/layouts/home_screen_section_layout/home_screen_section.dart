import 'package:bhakti_app/config.dart';

class HomeScreenSection extends StatelessWidget {
  const HomeScreenSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      return Center(
          child: Stack(alignment: Alignment.center, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const WeekCalendar(),
          const VSpace(Insets.i5),
          for (final section in appArray.homePageSectionList)
            prioritiesSection(context, section)
        ])
      ]));
    });
  }
}
