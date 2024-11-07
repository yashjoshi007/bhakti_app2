import 'package:bhakti_app/config.dart';

class SleepLayout extends StatelessWidget {
  const SleepLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      return Row(children: [
        SleptAtContainer(homeScreenPvr), // slept At Container in home screen
        const HSpace(Insets.i15),
        WokeUpAtContainer(homeScreenPvr) // wokeup At Container in home screen
      ]);
    });
  }
}
