import 'package:bhakti_app/config.dart';

class NotesSection extends StatelessWidget {
  const NotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const VSpace(Insets.i10),
      CommonLeftSideText(text: language(context,appFonts.notes)),
      const VSpace(Insets.i10),
      const NotesLayout()
    ]);
  }
}
