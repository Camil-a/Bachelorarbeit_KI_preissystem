import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:usecar_ki_system/shared/constants/colors.dart';
import 'package:usecar_ki_system/shared/constants/sizes.dart';

/// Visualizes the AI-predicted car price with two sub-widgets:
///
/// 1. **Bar chart** – compares [predictedPrice] against market reference
///    averages for four mileage brackets. The bracket that matches the
///    entered [mileage] is highlighted in a darker shade so the user can
///    instantly see how their car compares.
///
/// 2. **Price zone bar** – a coloured horizontal bar (Budget / Mid-range /
///    Premium) with a black tick showing where [predictedPrice] falls.
class PricePredictionChart extends StatelessWidget {
  final double predictedPrice;

  /// Used car's mileage in km — determines which reference bracket is active.
  final double mileage;

  const PricePredictionChart({
    super.key,
    required this.predictedPrice,
    required this.mileage,
  });

  // ---------------------------------------------------------------------------
  // Reference data (estimated market averages from the dataset)
  // ---------------------------------------------------------------------------

  /// Average market prices per mileage segment, used as reference bars.
  static const List<double> _refPrices = [22000, 15500, 10000, 6000];

  /// Short labels for the four reference bars (shown on the x-axis).
  static const List<String> _mileageLabels = [
    '<50k\nkm',
    '50–100k\nkm',
    '100–150k\nkm',
    '>150k\nkm',
  ];

  /// Price zones for the horizontal zone bar (max 40 000 €).
  static const double _zoneMax = 40000;

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Index of the reference bar that matches the entered mileage.
  int get _activeBracket {
    if (mileage < 50000) return 0;
    if (mileage < 100000) return 1;
    if (mileage < 150000) return 2;
    return 3;
  }

  /// Y-axis ceiling, rounded up to the next 5 000 € step.
  double get _maxY {
    final max = [..._refPrices, predictedPrice].reduce((a, b) => a > b ? a : b);
    return ((max / 5000).ceil() * 5000 + 2000).toDouble();
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.radiusCard)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header('Price Analysis', Icons.bar_chart_outlined),
            const SizedBox(height: 4),
            Text(
              'Your car vs. market averages by mileage',
              style: const TextStyle(fontSize: 11, color: AppColors.chartAxisLabel),
            ),
            const SizedBox(height: 16),

            // ── Bar chart ────────────────────────────────────────────────────
            SizedBox(height: 200, child: BarChart(_buildChartData())),
            const SizedBox(height: 8),

            // ── Legend ───────────────────────────────────────────────────────
            _buildLegend(),
            const SizedBox(height: 20),

            // ── Price zone bar ───────────────────────────────────────────────
            _header('Price Zone', Icons.linear_scale_rounded),
            const SizedBox(height: 10),
            _buildZoneBar(),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bar chart
  // ---------------------------------------------------------------------------

  BarChartData _buildChartData() {
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: _maxY,
      barGroups: _buildBarGroups(),
      titlesData: _buildTitles(),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 5000,
        getDrawingHorizontalLine: (value) =>
            FlLine(color: AppColors.chartGridLine, strokeWidth: 1),
      ),
      borderData: FlBorderData(show: false),
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          // Tooltip background colour
          getTooltipColor: (_) => AppColors.chartTooltipBg,
          getTooltipItem: (group, groupIndex, rod, rodIndex) => BarTooltipItem(
            '€ ${rod.toY.toStringAsFixed(0)}',
            const TextStyle(
              color: AppColors.chartTooltipText,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    final groups = <BarChartGroupData>[];

    // Four reference bars
    for (int i = 0; i < _refPrices.length; i++) {
      // Highlight the bracket that matches the entered mileage
      final isActive = i == _activeBracket;
      groups.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: _refPrices[i],
            color: isActive ? AppColors.chartActiveBar : AppColors.chartRefBar,
            width: 26,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(Sizes.radiusChip)),
          ),
        ],
      ));
    }

    // Fifth bar — predicted price, always red to stand out
    groups.add(BarChartGroupData(
      x: 4,
      barRods: [
        BarChartRodData(
          toY: predictedPrice,
          color: AppColors.primary,
          width: 26,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(Sizes.radiusChip)),
        ),
      ],
    ));

    return groups;
  }

  FlTitlesData _buildTitles() {
    final allLabels = [..._mileageLabels, 'Your\nCar'];

    return FlTitlesData(
      // Y-axis: price in k€
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 48,
          interval: 5000,
          getTitlesWidget: (value, meta) => Text(
            '€${(value / 1000).toStringAsFixed(0)}k',
            style: const TextStyle(fontSize: 9, color: AppColors.chartAxisLabel),
          ),
        ),
      ),
      // X-axis: mileage labels + "Your Car"
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 36,
          getTitlesWidget: (value, meta) {
            final i = value.toInt();
            if (i < 0 || i >= allLabels.length) return const SizedBox();
            return Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                allLabels[i],
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: i == 4 ? FontWeight.bold : FontWeight.normal,
                  color: i == 4 ? AppColors.primary : AppColors.chartAxisLabel,
                ),
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
      ),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  Widget _buildLegend() {
    // Wrap instead of Row so labels don't overflow on narrow Android screens
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 4,
      children: [
        _legendItem(AppColors.chartRefBar, 'Market avg.'),
        _legendItem(AppColors.chartActiveBar, 'Your bracket'),
        _legendItem(AppColors.primary, 'Your car'),
      ],
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _dot(color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: AppColors.chartAxisLabel)),
      ],
    );
  }

  Widget _dot(Color color) => Container(
        width: 11,
        height: 11,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(Sizes.radiusXSmall),
        ),
      );

  // ---------------------------------------------------------------------------
  // Price zone bar
  // ---------------------------------------------------------------------------

  Widget _buildZoneBar() {
    // Clamp the indicator position between 0 and 1
    final fraction = (predictedPrice / _zoneMax).clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalW = constraints.maxWidth;
        // Keep indicator fully inside the bar (3 px wide)
        final tickLeft = (fraction * totalW).clamp(1.5, totalW - 1.5);

        return Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Coloured zone bar — explicit widths avoid unbounded-constraint
                // issues that Flexible can cause inside a Stack child.
                ClipRRect(
                  borderRadius: BorderRadius.circular(Sizes.radiusChip),
                  child: SizedBox(
                    width: totalW,
                    height: 20,
                    child: Row(
                      children: [
                        Container(width: totalW * 0.20, color: AppColors.chartZoneBudget),
                        Container(width: totalW * 0.30, color: AppColors.chartZoneMid),
                        Container(width: totalW * 0.50, color: AppColors.chartZonePremium),
                      ],
                    ),
                  ),
                ),

                // Black tick marking the predicted price
                Positioned(
                  left: tickLeft - 1.5,
                  top: -7,
                  child: Container(
                    width: 3,
                    height: 34,
                    decoration: BoxDecoration(
                      color: AppColors.chartIndicator,
                      borderRadius: BorderRadius.circular(Sizes.radiusTick),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),

            // Zone labels aligned to their segments
            Row(
              children: [
                Expanded(
                  flex: 20,
                  child: Text(
                    'Budget\n<€8k',
                    style: const TextStyle(fontSize: 9, color: AppColors.chartAxisLabel),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: Text(
                    'Mid-range\n€8k–20k',
                    style: const TextStyle(fontSize: 9, color: AppColors.chartAxisLabel),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 50,
                  child: Text(
                    'Premium\n>€20k',
                    style: const TextStyle(fontSize: 9, color: AppColors.chartAxisLabel),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Shared header row (icon + label)
  // ---------------------------------------------------------------------------

  Widget _header(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.sectionIcon),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.sectionLabel,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(width: 8),
        const Expanded(child: Divider(color: AppColors.sectionDivider, thickness: 1)),
      ],
    );
  }
}
