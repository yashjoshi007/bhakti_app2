import 'package:bhakti_app/config.dart';

class BookSection extends StatelessWidget {
  const BookSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
     
      return Column(children: [
        const VSpace(Insets.i10),
        CommonLeftSideText(
            rightText: language(context, appFonts.addBooks),
            isRightText: true,
            text: language(context, appFonts.bookReading),
            onTap: () => homeScreenPvr.bookReadingPresentlyNavigate(context)),
        const VSpace(Insets.i10),
        const BookLayout()
      ]);
    });
  }
}
