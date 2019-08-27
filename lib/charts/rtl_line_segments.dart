import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class RTLLineSegments extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  RTLLineSegments(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory RTLLineSegments.withSampleData() {
    return new RTLLineSegments(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    // Charts will determine if RTL is enabled by checking the directionality by
    // requesting Directionality.of(context). This returns the text direction
    // from the closest instance of that encloses the context passed to build
    // the chart. A [TextDirection.rtl] will be treated as a RTL chart. This
    // means that the directionality widget does not have to directly wrap each
    // chart. It is show here as an example only.
    //
    // By default, when a chart detects RTL:
    // Measure axis positions are flipped. Primary measure axis is on the right
    // and the secondary measure axis is on the left (when used).
    // Domain axis' first domain starts on the right and grows left.
    return new Directionality(
        textDirection: TextDirection.ltr,
        child: new charts.TimeSeriesChart(
          seriesList,
          defaultRenderer:
              new charts.LineRendererConfig(includeArea: true, stacked: true),
          animate: animate,
        ));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, DateTime>> _createSampleData() {
    // Series of data with static dash pattern and stroke width. The colorFn
    // accessor will colorize each datum (for all three series).
    final colorChangeData = [
      new LinearSales(new DateTime(2019, 7, 2), 5, null, 2.0),
      new LinearSales(new DateTime(2019, 7, 3), 15, null, 2.0),
      new LinearSales(new DateTime(2019, 7, 4), 25, null, 2.0),
      new LinearSales(new DateTime(2019, 7, 5), 75, null, 2.0),
      new LinearSales(new DateTime(2019, 7, 6), 100, null, 2.0),
      new LinearSales(new DateTime(2019, 7, 7), 90, null, 2.0),
      new LinearSales(new DateTime(2019, 7, 8), 75, null, 2.0),
    ];

    // Series of data with changing color and dash pattern.
    final dashPatternChangeData = [
      new LinearSales(new DateTime(2019, 7, 2), 5, null, 2.0),
      new LinearSales(new DateTime(2019, 7, 3), 15, null, 2.0),
      new LinearSales(new DateTime(2019, 7, 4), 25, null, 2.0),
      new LinearSales(new DateTime(2019, 7, 5), 75, null, 2.0),
      new LinearSales(new DateTime(2019, 7, 6), 100, null, 2.0),
      new LinearSales(new DateTime(2019, 7, 7), 90, null, 2.0),
      new LinearSales(new DateTime(2019, 7, 8), 75, null, 2.0),
    ];

    // Generate 2 shades of each color so that we can style the line segments.
    final blue = charts.MaterialPalette.blue.makeShades(2);

    return [
      new charts.Series<LinearSales, DateTime>(
        id: 'Color Change',
        // Light shade for even years, dark shade for odd.
        colorFn: (LinearSales sales, _) => blue[1],
        dashPatternFn: (LinearSales sales, _) => sales.dashPattern,
        strokeWidthPxFn: (LinearSales sales, _) => sales.strokeWidthPx,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: colorChangeData,
      ),
      new charts.Series<LinearSales, DateTime>(
        id: 'Dash Pattern Change',
        // Light shade for even years, dark shade for odd.
        colorFn: (LinearSales sales, _) => blue[0],
        dashPatternFn: (LinearSales sales, _) => sales.dashPattern,
        strokeWidthPxFn: (LinearSales sales, _) => sales.strokeWidthPx,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: dashPatternChangeData,
      ),
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final DateTime year;
  final int sales;
  final List<int> dashPattern;
  final double strokeWidthPx;

  LinearSales(this.year, this.sales, this.dashPattern, this.strokeWidthPx);
}
