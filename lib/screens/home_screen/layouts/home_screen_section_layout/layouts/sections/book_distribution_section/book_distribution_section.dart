import 'package:bhakti_app/config.dart';

class BookDistributionSection extends StatelessWidget {
  const BookDistributionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const VSpace(Insets.i10),
      CommonLeftSideText(text: language(context,appFonts.bookDistribution)),
      const VSpace(Insets.i10),
      const BookDistributionLayout()
    ]);
  }
}