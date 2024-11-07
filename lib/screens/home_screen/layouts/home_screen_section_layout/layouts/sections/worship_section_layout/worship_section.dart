import 'package:bhakti_app/config.dart';

class WorshipSection extends StatelessWidget {
  const WorshipSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const VSpace(Insets.i10),
          CommonLeftSideText(text: language(context,appFonts.worship)),
          const VSpace(Insets.i10),
          const WorshipLayout()
        ]
    );
  }
}
