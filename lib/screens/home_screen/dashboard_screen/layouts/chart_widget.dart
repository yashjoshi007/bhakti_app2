import 'dart:developer';

import 'package:bhakti_app/config.dart';
import 'package:intl/intl.dart';

class ChartWidget {
  //  this is association chart common widgets
  Widget buildChart(BuildContext context, DashboardProvider dashboardPvr,
      LinearGradient linearGradient) {
    return SfCartesianChart(
        tooltipBehavior: TooltipBehavior(
            enable: true,
            canShowMarker: true,
            color: Colors.white,
            format: 'point.x : point.y',
            builder: (dynamic data, dynamic point, dynamic series,
                int pointIndex, int seriesIndex) {
              final SalesData salesData = data;
              final String formattedY =
                  DateFormat('HH:mm a').format(salesData.y);
              final String formattedY1 =
                  DateFormat('HH:mm a').format(salesData.y1);
              final String formattedY2 =
                  DateFormat('HH:mm a').format(salesData.y2);

              String tooltipText;
              switch (seriesIndex) {
                case 0:
                  tooltipText = 'Reading: $formattedY';
                  break;
                case 1:
                  tooltipText = 'Listening: $formattedY1';
                  break;
                case 2:
                  tooltipText = 'Other Activities: $formattedY2';
                  break;
                default:
                  tooltipText = '';
              }

              return Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0)),
                  child: Text(tooltipText,
                      style: appCss.dmDenseMedium12
                          .textColor(const Color(0xffA3A3A3))));
            }),
        zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true, enablePanning: true, zoomMode: ZoomMode.x),
        legend: Legend(
            legendItemBuilder: (legendText, series, point, seriesIndex) {
              List<String> legendTxt = [
                appFonts.reading,
                appFonts.listening,
                appFonts.otherActivities
              ];
              return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: seriesIndex == 0
                                    ? appColor(context).appTheme.red
                                    : seriesIndex == 1
                                        ? appColor(context).appTheme.green
                                        : appColor(context).appTheme.blue),
                            width: 10,
                            height: 10),
                        const SizedBox(width: 5),
                        Expanded(
                            child: Text(
                                language(context, legendTxt[seriesIndex]),
                                overflow: TextOverflow.ellipsis))
                      ]));
            },
            isVisible: true,
            alignment: ChartAlignment.center,
            position: LegendPosition.bottom),
        enableSideBySideSeriesPlacement: true,
        palette: [appColor(context).appTheme.black],
        plotAreaBorderColor: appColor(context).appTheme.trans,
        plotAreaBorderWidth: 0,
        enableAxisAnimation: true,
        primaryXAxis: buildPrimaryXAxis(context),
        primaryYAxis: buildPrimaryYAxis(context, dashboardPvr),
        series: buildSeries(context, dashboardPvr));
  }

  TextStyle textStyle(BuildContext context) {
    return appCss.dmDenseMedium12
        .textColor(appColor(context).appTheme.lightText);
  }

  CategoryAxis buildPrimaryXAxis(context) {
    return CategoryAxis(
        interval: 1,
        labelStyle:
            appCss.dmDenseExtraBold12.textColor(const Color(0xffA3A3A3)),
        majorTickLines: const MajorTickLines(size: 0),
        majorGridLines: const MajorGridLines(width: 0));
  }

  DateTimeAxis buildPrimaryYAxis(context, DashboardProvider dashboardPvr) {
    return DateTimeAxis(
        labelStyle: appCss.dmDenseMedium12.textColor(const Color(0xffA3A3A3)),
        isVisible: true,
        majorTickLines: const MajorTickLines(size: 0),
        minorTickLines: const MinorTickLines(size: 0),
        axisLine: const AxisLine(width: 0),
        majorGridLines: const MajorGridLines(
            color: Color(0xffA3A3A3), dashArray: <double>[4, 2]),
        minorGridLines: const MinorGridLines(
            color: Color(0xffA3A3A3), dashArray: <double>[4, 2]));
  }

  List<CartesianSeries> buildSeries(
      BuildContext context, DashboardProvider dashboardPvr) {
    return [
      buildAreaSeries(
        context,
        dashboardPvr.salesData,
        appColor(context).appTheme.red,
        (SalesData time, _) => time.x,
        (SalesData data, _) => data.y.millisecondsSinceEpoch.toDouble(),
      ),
      buildAreaSeries(
        context,
        dashboardPvr.salesData,
        appColor(context).appTheme.green,
        (SalesData time, _) => time.x,
        (SalesData data, _) => data.y1.millisecondsSinceEpoch.toDouble(),
      ),
      buildAreaSeries(
          context,
          dashboardPvr.salesData,
          appColor(context).appTheme.blue,
          (SalesData time, _) => time.x,
          (SalesData data, _) => data.y2.millisecondsSinceEpoch.toDouble())
    ];
  }

  AreaSeries<SalesData, dynamic> buildAreaSeries(
      BuildContext context,
      List<SalesData> dataSource,
      Color color,
      dynamic Function(SalesData, int) xValueMapper,
      dynamic Function(SalesData, int) yValueMapper) {
    return AreaSeries<SalesData, dynamic>(
        isVisibleInLegend: true,
        legendIconType: LegendIconType.circle,
        markerSettings: MarkerSettings(
            color: color,
            isVisible: true,
            height: 7,
            width: 7,
            borderColor: color),
        color: color,
        borderColor: color,
        borderWidth: 2,
        gradient: LinearGradient(
            colors: [color.withOpacity(0), color.withOpacity(0)]),
        // Transparent gradient
        dataSource: dataSource,
        xValueMapper: xValueMapper,
        yValueMapper: (SalesData data, int index) {
          return yValueMapper(data, index);
        });
  }

  // this is chanting chart common widgets

  List<StackedColumnSeries<ChartData, String>> generateSeries(
      List<ChartData> data, context) {
    return [
      for (var i = 1; i <= 5; i++)
        StackedColumnSeries<ChartData, String>(
            spacing: 0.1,
            legendItemText: language(context, getAppFont(i)),
            legendIconType: LegendIconType.circle,
            color: getColor(i),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(2), topRight: Radius.circular(2)),
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => getYValue(data, i))
    ];
  }

  Widget buildTooltipContent(BuildContext context, ChartData chartData) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        padding: const EdgeInsets.all(10.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${language(context, appFonts.date)} ${chartData.x}',
                style:
                    appCss.dmDenseMedium12.textColor(const Color(0xffA3A3A3)),
              ),
              const SizedBox(height: 5),
              for (var i = 1; i <= 5; i++)
                Text(
                    style: appCss.dmDenseMedium12
                        .textColor(const Color(0xffA3A3A3)),
                    '${language(context, getAppFont(i))} - ${getYValue(chartData, i)}')
            ]));
  }

  int getYValue(ChartData data, int index) {
    switch (index) {
      case 1:
        return data.y1;
      case 2:
        return data.y2;
      case 3:
        return data.y3;
      case 4:
        return data.y4;
      case 5:
        return data.y5;
      default:
        return 0;
    }
  }

  String getAppFont(int index) {
    switch (index) {
      case 1:
        return "< 6:30 AM";
      case 2:
        return "< 8:30 AM";
      case 3:
        return "< 10:00 AM";
      case 4:
        return "< 9:30 AM";
      case 5:
        return "> 9:30 AM";
      default:
        return '';
    }
  }

  Color getColor(int index) {
    switch (index) {
      case 1:
        return const Color(0xff541F5C);
      case 2:
        return const Color(0xff794F7F);
      case 3:
        return const Color(0xffA081A4);
      case 4:
        return const Color(0xffDAC4D8);
      case 5:
        return const Color(0xffDAC4D8).withOpacity(0.5);
      default:
        return Colors.transparent;
    }
  }

  ZoomPanBehavior getSleepZoomPanBehavior() {
    return ZoomPanBehavior(
        enablePinching: true, enablePanning: true, zoomMode: ZoomMode.x);
  }

  TooltipBehavior getSleepTooltipBehavior(List<ChartsData> chartData, context) {
    return TooltipBehavior(
        enable: true,
        header: '',
        canShowMarker: true,
        builder: (data, point, series, pointIndex, seriesIndex) {
          if (seriesIndex == 0) {
            final chartDataPoint = chartData[pointIndex];
            final sleepTime = DateTime.fromMillisecondsSinceEpoch(
                chartDataPoint.sleptTime.toInt());
            final wakeUpTime = DateTime.fromMillisecondsSinceEpoch(
                chartDataPoint.wokeUpTime.toInt());
            return buildSleepTooltipContent(
                context, chartDataPoint.x, sleepTime, wakeUpTime);
          }
          return Container();
        });
  }

  Widget buildSleepTooltipContent(BuildContext context, String date,
      DateTime sleepTime, DateTime wakeUpTime) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2))
            ]),
        padding: const EdgeInsets.all(10.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${language(context, appFonts.date)} $date',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(
                  '${language(context, appFonts.sleptTimes)} ${formatTime(sleepTime, context)}'),
              Text(
                  '${language(context, appFonts.wokeUpTimes)} ${formatTime(wakeUpTime, context)}')
            ]));
  }

  String formatTime(DateTime time, context) {
    String period = language(context, appFonts.am);
    int hour = time.hour;
    if (hour >= 12) {
      period = language(context, appFonts.pm);
      if (hour > 12) {
        hour -= 12;
      }
    }
    if (hour == 0) {
      hour = 12;
    }
    return '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period';
  }

  DateTimeAxis getPrimaryYAxis(BuildContext context) {
    return DateTimeAxis(
        majorTickLines: const MajorTickLines(size: 2),
        minorTickLines: const MinorTickLines(size: 2),
        axisLine: const AxisLine(width: 0),
        majorGridLines: const MajorGridLines(
            color: Color(0xffA3A3A3), dashArray: <double>[4, 2]),
        minorGridLines: const MinorGridLines(
            color: Color(0xffA3A3A3), dashArray: <double>[4, 2]),
        intervalType: DateTimeIntervalType.hours,
        isInversed: true,
        labelStyle: appCss.dmDenseMedium12.textColor(const Color(0xffA3A3A3)));
  }

  CategoryAxis getPrimaryXAxis(context) {
    return CategoryAxis(
        labelStyle: appCss.dmDenseMedium12
            .textColor(appColor(context).appTheme.lightText),
        interval: 1,
        majorTickLines: const MajorTickLines(size: 0),
        majorGridLines: const MajorGridLines(width: 0));
  }

  Legend getLegend(BuildContext context) {
    return Legend(
        legendItemBuilder: (legendText, series, point, seriesIndex) {
          final screenWidth = MediaQuery.of(context).size.width;
          final circleSize =
              screenWidth * 0.02; // Adjust the circle size as needed
          final spaceBetween = screenWidth *
              0.015; // Adjust the space between elements as needed

          return SizedBox(
              width: screenWidth * 0.5, // Adjust the width as needed
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFF541F5C)),
                          width: circleSize,
                          height: circleSize),
                      SizedBox(width: spaceBetween),
                      SizedBox(
                          width: screenWidth * 0.2,
                          child: Text(language(context, appFonts.sleptTime),
                              overflow: TextOverflow.ellipsis))
                    ]),
                    Row(children: [
                      Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFDAC4D8)),
                          width: circleSize,
                          height: circleSize),
                      SizedBox(width: spaceBetween),
                      SizedBox(
                          width: screenWidth * 0.2,
                          child: Text(language(context, appFonts.wokeUpTime),
                              overflow: TextOverflow.ellipsis))
                    ])
                  ]));
        },
        isVisible: true,
        alignment: ChartAlignment.values.last,
        position: LegendPosition.top);
  }

  List<RangeColumnSeries<ChartsData, String>> getSeries(
      List<ChartsData> data, context) {
    return [
      RangeColumnSeries<ChartsData, String>(
          dashArray: const <double>[5, 5],
          spacing: 0.3,
          legendItemText: language(context, appFonts.sleptTime),
          isVisibleInLegend: true,
          legendIconType: LegendIconType.circle,
          enableTooltip: true,
          markerSettings: const MarkerSettings(
              height: 10,
              // isVisible: data.isEmpty,
              width: 1,
              shape: DataMarkerType.verticalLine,
              borderColor: Colors.black,
              borderWidth: 1,
              color: Colors.black),
          borderRadius: BorderRadius.circular(2),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              colors: [Color(0xFFDAC4D8), Color(0xFF541F5C)]),
          dataSource: data,
          xValueMapper: (ChartsData data, _) => data.x,
          lowValueMapper: (ChartsData data, _) {
            log('message sleptTime ${data.sleptTime}');
            return data.sleptTime;
          },
          highValueMapper: (ChartsData data, _) {
            log('message wokeUpTime ${data.wokeUpTime}');
            return data.wokeUpTime;
          },
          emptyPointSettings:
              const EmptyPointSettings(mode: EmptyPointMode.average))
    ];
  }
}
