import 'package:bhakti_app/config.dart';

class ChantingChart extends StatefulWidget {
  const ChantingChart({super.key});

  @override
  State<ChantingChart> createState() => _ChantingChartState();
}

class _ChantingChartState extends State<ChantingChart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, dashboardPvr, child) {
      return SfCartesianChart(
          tooltipBehavior: TooltipBehavior(
              enable: true,
              header: '',
              canShowMarker: true,
              builder: (data, point, series, pointIndex, seriesIndex) {
                final ChartData chartData = dashboardPvr.chartData[pointIndex];
                return ChartWidget().buildTooltipContent(context, chartData);
              }),
          zoomPanBehavior: ZoomPanBehavior(
              enablePinching: true, enablePanning: true, zoomMode: ZoomMode.x),
          legend: Legend(
              isVisible: true,
              textStyle: appCss.dmDenseLight14
                  .textColor(appColor(context).appTheme.black),
              alignment: ChartAlignment.near,
              width: '100%',
              position: LegendPosition.bottom),
          primaryYAxis: NumericAxis(
              labelStyle:
                  appCss.dmDenseMedium12.textColor(const Color(0xffA3A3A3)),
              majorTickLines: const MajorTickLines(size: 0),
              minorTickLines: const MinorTickLines(size: 0),
              axisLine: const AxisLine(width: 0),
              majorGridLines: const MajorGridLines(
                  color: Color(0xffA3A3A3), dashArray: <double>[4, 2]),
              minorGridLines: const MinorGridLines(
                  color: Color(0xffA3A3A3), dashArray: <double>[4, 2])),
          primaryXAxis: CategoryAxis(
              interval: 1,
              labelStyle:
                  appCss.dmDenseExtraBold12.textColor(const Color(0xffA3A3A3)),
              majorTickLines: const MajorTickLines(size: 0),
              majorGridLines: const MajorGridLines(width: 0)),
          plotAreaBorderWidth: 0,
          series:
              ChartWidget().generateSeries(dashboardPvr.chartData, context));
    });
  }
}

class ChartData {
  ChartData(this.x, this.y1, this.y2, this.y3, this.y4, this.y5);

  final String x;
  final int y1;
  final int y2;
  final int y3;
  final int y4;
  final int y5;
}
