import 'package:bhakti_app/config.dart';

class TableCalendarLayout extends StatefulWidget {
  const TableCalendarLayout({super.key});

  @override
  State<TableCalendarLayout> createState() => _TableCalendarLayoutState();
}

class _TableCalendarLayoutState extends State<TableCalendarLayout> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, dashboardPvr, child) {
      String fromDateFormatted = dashboardPvr.fromDate != null
          ? dashboardPvr.dateFormat.format(dashboardPvr.fromDate)
          : appFonts.fromDate;
      String toDateFormatted = dashboardPvr.toDate != null
          ? dashboardPvr.dateFormat.format(dashboardPvr.toDate)
          : appFonts.toDate;
      return Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Expanded(
              child: CommonContainerTile(
                      paddingArea: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 5),
                      child: Row(children: [
                        const Icon(Icons.calendar_month),
                        const HSpace(Insets.i5),
                        Text(fromDateFormatted)
                      ]))
                  .inkWell(
                      onTap: () async => dashboardPvr.fromDateOnTap(context))),
          const HSpace(Insets.i10),
          Expanded(
              child: CommonContainerTile(
                  paddingArea:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  child: Row(children: [
                    const Icon(Icons.calendar_month),
                    const HSpace(Insets.i5),
                    Text(toDateFormatted)
                  ])).inkWell(onTap: () => dashboardPvr.toDateOnTap(context))),
          const HSpace(Insets.i10),
          CommonButton(
              bColor: dashboardPvr.isButtonDisabled == true
                  ? appColor(context).appTheme.primary.withOpacity(0.5)
                  : appColor(context).appTheme.primary,
              width: Sizes.s50,
              text: language(context, appFonts.go),
              onTap: dashboardPvr.isButtonDisabled
                  ? null
                  : () => dashboardPvr.goButtonOnTap(context))
        ]),
        const VSpace(Insets.i15)
      ]);
    });
  }
}
