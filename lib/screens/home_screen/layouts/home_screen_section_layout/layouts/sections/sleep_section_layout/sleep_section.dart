import 'package:bhakti_app/config.dart';

class SleepSection extends StatelessWidget {
  const SleepSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const VSpace(Insets.i10),
      CommonLeftSideText(text: language(context,appFonts.sleep)),
      const VSpace(Insets.i10),
      const SleepLayout()
    ]);
  }
}
