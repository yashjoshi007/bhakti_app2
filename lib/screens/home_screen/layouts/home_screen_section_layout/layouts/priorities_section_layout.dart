import 'package:bhakti_app/config.dart';

Widget prioritiesSection(BuildContext context, Map<String, dynamic> section) {
  if (section['isOn'] == true) {
    if (language(context, section['name']) ==
        language(context, appFonts.sleep)) {
      return const SleepSection();
    } else if (language(context, section['name']) ==
        language(context, appFonts.worship)) {
      return const WorshipSection();
    } else if (language(context, section['name']) ==
        language(context, appFonts.chanting)) {
      return const ChantingSection();
    } else if (language(context, section['name']) ==
        language(context, appFonts.regulations)) {
      return const RegulationSection();
    } else if (language(context, section['name']) ==
        language(context, appFonts.association)) {
      return const AssociationSection();
    } else if (language(context, section['name']) ==
        language(context, appFonts.bookReading)) {
      return const BookSection();
    } else if (language(context, section['name']) ==
        language(context, appFonts.bookDistribution)) {
      return const BookDistributionSection();
    } else if (language(context, section['name']) ==
        language(context, appFonts.notes)) {
      return const NotesSection();
    } else {
      return Container();
    }
  } else {
    return Container();
  }
}
