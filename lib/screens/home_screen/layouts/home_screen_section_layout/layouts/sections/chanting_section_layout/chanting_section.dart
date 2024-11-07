import 'package:bhakti_app/config.dart';

class ChantingSection extends StatelessWidget {
  const ChantingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const VSpace(Insets.i10),
      CommonLeftSideText(text: language(context,appFonts.chanting)),
      const VSpace(Insets.i10),
      const ChantingCommon()
    ]);
  }
}
