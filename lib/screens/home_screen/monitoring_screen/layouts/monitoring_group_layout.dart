import 'package:bhakti_app/config.dart';

class MonitoringGroupUserLayout extends StatefulWidget {
  const MonitoringGroupUserLayout({super.key});

  @override
  State<MonitoringGroupUserLayout> createState() =>
      _MonitoringGroupUserLayoutState();
}

class _MonitoringGroupUserLayoutState extends State<MonitoringGroupUserLayout> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<MonitoringProvider, SettingProvider>(
        builder: (context, monitoringPvr, settingPvr, child) {
      final screenWidth = MediaQuery.of(context).size.width;
      final userToDoRanges = monitoringPvr.calculateUserToDoRanges(screenWidth);

      return Column(children: [
        // Text("$screenWidth"),
        Container(
            height: Sizes.s50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.r8),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x0F000000),
                      blurRadius: 16,
                      offset: Offset(0, 2))
                ]),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: monitoringPvr.userToDo.length,
                itemBuilder: (context, index) {
                  return CommonPopInkwell(
                      text: language(context, monitoringPvr.userToDo[index]),
                      onTap: () {
                        int startIndex = userToDoRanges[index][0];
                        monitoringPvr.scrollToRange(startIndex, context, index);
                        // monitoringPvr.selectedCategory(index, context);
                      },
                      index: index,
                      selectedIndex: monitoringPvr.isSelected);
                })),
        const VSpace(Insets.i15),
        const AllGroupDataLayouts()
      ]);
    });
  }
}
