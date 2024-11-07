import 'dart:developer';

import 'package:bhakti_app/config.dart';

class SleepPatternChart extends StatefulWidget {
  const SleepPatternChart({super.key});

  @override
  State<SleepPatternChart> createState() => _SleepPatternChartState();
}

class _SleepPatternChartState extends State<SleepPatternChart> {
  DateTime? sleepTime;
  DateTime? wakeUpTime;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashboardProvider>(context, listen: false).onInit(context);
    });

    sleepTime = DateTime(0, 1, 1, 0, 0, 0);
    wakeUpTime = DateTime(0, 1, 1, 0, 0, 0);
    log("sleepTime sleepTime 1234 $sleepTime");
    log("wakeUpTime wakeUpTime 5678 $wakeUpTime");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, dashboardPvr, child) {
      return SfCartesianChart(
          tooltipBehavior: ChartWidget()
              .getSleepTooltipBehavior(dashboardPvr.sleepChartData, context),
          primaryXAxis: ChartWidget().getPrimaryXAxis(context),
          primaryYAxis: ChartWidget().getPrimaryYAxis(context),
          zoomPanBehavior: ZoomPanBehavior(
              enablePinching: true, enablePanning: true, zoomMode: ZoomMode.x),
          legend: ChartWidget().getLegend(context),
          plotAreaBorderWidth: 0,
          series:
              ChartWidget().getSeries(dashboardPvr.sleepChartData, context));
    });
  }
}

class ChartsData {
  ChartsData(this.x, this.wokeUpTime, this.sleptTime);

  final String x;
  final double wokeUpTime;
  final double sleptTime;
}
