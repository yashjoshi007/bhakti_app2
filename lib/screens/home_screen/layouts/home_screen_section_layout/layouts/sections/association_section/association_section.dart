import 'package:bhakti_app/config.dart';

class AssociationSection extends StatelessWidget {
  const AssociationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const VSpace(Insets.i10),
      CommonLeftSideText(text: language(context,appFonts.association)),
      const VSpace(Insets.i10),
      const AssociationLayout()
    ]);
  }
}
