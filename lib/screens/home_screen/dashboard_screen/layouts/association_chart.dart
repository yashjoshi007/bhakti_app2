import 'package:bhakti_app/config.dart';

class AssociationChart extends StatelessWidget {
  const AssociationChart({super.key});

  @override
  Widget build(BuildContext context) {
    final LinearGradient linearGradient = LinearGradient(colors: <Color>[
      appColor(context).appTheme.whiteBg,
      appColor(context).appTheme.whiteBg,
      appColor(context).appTheme.whiteBg
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

    return Consumer<DashboardProvider>(builder: (context, dashboardPvr, child) {
      return ChartWidget().buildChart(context, dashboardPvr, linearGradient);
    });
  }
}

class SalesData {
  SalesData(this.x, this.y, this.y1, this.y2);

  final String x;
  final DateTime y;
  final DateTime y1;
  final DateTime y2;
}
