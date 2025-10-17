import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartService {
  /// Create a line chart for user growth over time
  static LineChartData createUserGrowthChart(List<Map<String, dynamic>> data) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.3),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.3),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (double value, TitleMeta meta) {
              if (value.toInt() < data.length) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    data[value.toInt()]['month'] ?? '',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                );
              }
              return const Text('');
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (double value, TitleMeta meta) {
              return Text(
                value.toInt().toString(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              );
            },
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      minX: 0,
      maxX: (data.length - 1).toDouble(),
      minY: 0,
      lineBarsData: [
        LineChartBarData(
          spots: data.asMap().entries.map((entry) {
            return FlSpot(entry.key.toDouble(), entry.value['users'].toDouble());
          }).toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.8),
              Colors.blue.withOpacity(0.3),
            ],
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 4,
                color: Colors.blue,
                strokeWidth: 2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.3),
                Colors.blue.withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Create a bar chart for journey statistics
  static BarChartData createJourneyStatsChart(List<Map<String, dynamic>> data) {
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: data.fold(0.0, (max, item) => 
        item['count'] > max ? item['count'].toDouble() : max) + 10,
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              '${data[group.x]['status']}\n${rod.toY.toInt()} journeys',
              const TextStyle(color: Colors.white),
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              if (value.toInt() < data.length) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    data[value.toInt()]['status'] ?? '',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                );
              }
              return const Text('');
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (double value, TitleMeta meta) {
              return Text(
                value.toInt().toString(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      barGroups: data.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: item['count'].toDouble(),
              color: _getStatusColor(item['status']),
              width: 20,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  /// Create a pie chart for revenue breakdown
  static PieChartData createRevenueChart(List<Map<String, dynamic>> data) {
    return PieChartData(
      sectionsSpace: 2,
      centerSpaceRadius: 40,
      sections: data.map((item) {
        return PieChartSectionData(
          color: _getRevenueColor(item['category']),
          value: item['amount'].toDouble(),
          title: '${item['percentage']}%',
          radius: 50,
          titleStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      }).toList(),
    );
  }

  /// Get color for journey status
  static Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'in-progress':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  /// Get color for revenue category
  static Color _getRevenueColor(String category) {
    switch (category.toLowerCase()) {
      case 'transport':
        return Colors.blue;
      case 'commission':
        return Colors.green;
      case 'fees':
        return Colors.orange;
      case 'other':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  /// Sample data for user growth chart
  static List<Map<String, dynamic>> getSampleUserGrowthData() {
    return [
      {'month': 'Jan', 'users': 50},
      {'month': 'Feb', 'users': 75},
      {'month': 'Mar', 'users': 120},
      {'month': 'Apr', 'users': 180},
      {'month': 'May', 'users': 250},
      {'month': 'Jun', 'users': 320},
    ];
  }

  /// Sample data for journey statistics
  static List<Map<String, dynamic>> getSampleJourneyStatsData() {
    return [
      {'status': 'Pending', 'count': 15},
      {'status': 'In Progress', 'count': 8},
      {'status': 'Completed', 'count': 45},
      {'status': 'Cancelled', 'count': 3},
    ];
  }

  /// Sample data for revenue breakdown
  static List<Map<String, dynamic>> getSampleRevenueData() {
    return [
      {'category': 'Transport', 'amount': 1500000, 'percentage': 60},
      {'category': 'Commission', 'amount': 500000, 'percentage': 20},
      {'category': 'Fees', 'amount': 300000, 'percentage': 12},
      {'category': 'Other', 'amount': 200000, 'percentage': 8},
    ];
  }
}
