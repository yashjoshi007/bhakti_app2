import 'package:bhakti_app/config.dart';

class WorshipLayout extends StatelessWidget {
  const WorshipLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        MangalaContainer(homeScreenPvr),
        const HSpace(Insets.i15),
        SandhyaContainer(homeScreenPvr)
      ]);
    });
  }
}
