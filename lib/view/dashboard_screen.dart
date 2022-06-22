import 'dart:math' as math;

import 'package:cryptobook/blocs/bloc_dashboard.dart';
import 'package:cryptobook/model/cryptocurrency.dart';
import 'package:cryptobook/model/position/position.dart';
import 'package:cryptobook/utils/widgets/bottom_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Cryptobook'),
          bottom: const TabBar(tabs: [
            Tab(icon: Icon(Icons.dashboard)),
            Tab(icon: Icon(Icons.pie_chart)),
          ]),
        ),
        body: BlocProvider<DashboardBloc>(
          create: (_) => DashboardBloc(),
          child: const TabBarView(
            children: [
              NumberContent(),
              ChartContent(),
            ],
          ),
        ),
        bottomNavigationBar: const BottomBar(
          position: 0,
        ),
      ),
    );
  }
}

class NumberContent extends StatelessWidget {
  const NumberContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            PositionsContent(),
          ],
        ),
      ),
    );
  }
}

class ChartContent extends StatelessWidget {
  const ChartContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: const CoinChart(),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: const StableChart(),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: const DiffStableCryptoChart(),
          ),
        ],
      ),
    ));
  }
}

class CoinChart extends StatelessWidget {
  const CoinChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardBlocState>(
      buildWhen: (oldState, newState) => oldState.positions.isEmpty,
      builder: (_, DashboardBlocState state) {
        if (state.positions.isNotEmpty && state.mapChartCrypto.isNotEmpty) {
          return PieChart(
            PieChartData(
              pieTouchData: PieTouchData(),
              borderData: FlBorderData(show: false, border: Border.all(color: Colors.red)),
              sectionsSpace: 0,
              centerSpaceRadius: 0,
              sections: showingSections(state.mapChartCrypto, state.crypto),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }

  List<PieChartSectionData> showingSections(Map<Cryptocurrency, double> map, double totalCrypto) {
    List<PieChartSectionData> lst = [];
    map.forEach((key, value) {
      double percent = value / totalCrypto * 100;
      PieChartSectionData data = PieChartSectionData(
          value: percent,
          title: '${percent.round()} %',
          radius: 150,
          color: key.color != null
              ? HexColor.fromHex(key.color!)
              : Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
          badgeWidget: _Badge(
            key.urlImgThumb,
            borderColor: Colors.black,
            size: 40,
          ),
          badgePositionPercentageOffset: .90);
      lst.add(data);
    });
    return lst;
  }
}

class StableChart extends StatelessWidget {
  const StableChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardBlocState>(
      buildWhen: (oldState, newState) => oldState.positions.isEmpty,
      builder: (_, DashboardBlocState state) {
        if (state.positions.isNotEmpty && state.mapChartCrypto.isNotEmpty) {
          return PieChart(
            PieChartData(
              pieTouchData: PieTouchData(),
              borderData: FlBorderData(show: false, border: Border.all(color: Colors.red)),
              sectionsSpace: 0,
              centerSpaceRadius: 0,
              sections: showingSections(state.mapChartStable, state.stable),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }

  List<PieChartSectionData> showingSections(Map<Cryptocurrency, double> map, double totalCrypto) {
    List<PieChartSectionData> lst = [];
    map.forEach((key, value) {
      double percent = value / totalCrypto * 100;
      PieChartSectionData data = PieChartSectionData(
          value: percent,
          title: '${percent.round()} %',
          radius: 150,
          color: key.color != null
              ? HexColor.fromHex(key.color!)
              : Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
          badgeWidget: _Badge(
            key.urlImgThumb,
            borderColor: Colors.black,
            size: 40,
          ),
          badgePositionPercentageOffset: .90);
      lst.add(data);
    });
    return lst;
  }
}

class DiffStableCryptoChart extends StatelessWidget {
  const DiffStableCryptoChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardBlocState>(
      buildWhen: (oldState, newState) => oldState.positions.isEmpty,
      builder: (_, DashboardBlocState state) {
        if (state.positions.isNotEmpty && state.mapChartCrypto.isNotEmpty) {
          double percentStable = state.stable * 100 / state.total;
          double percentCrypto = state.crypto * 100 / state.total;

          return PieChart(
            PieChartData(
              pieTouchData: PieTouchData(),
              borderData: FlBorderData(show: false, border: Border.all(color: Colors.red)),
              sectionsSpace: 0,
              centerSpaceRadius: 0,
              sections: [
                PieChartSectionData(
                  value: percentStable,
                  title: '${percentStable.round()} % stable',
                  radius: 150,
                  color: Colors.blueGrey,
                ),
                PieChartSectionData(
                  value: percentCrypto,
                  title: '${percentCrypto.round()} % crypto',
                  radius: 150,
                  color: Colors.deepOrangeAccent,
                )
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}

class _Badge extends StatelessWidget {
  final String url;
  final double size;
  final Color borderColor;

  const _Badge(
    this.url, {
    Key? key,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Image.network(url),
      ),
    );
  }
}

class PositionsContent extends StatelessWidget {
  const PositionsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardBlocState>(
      buildWhen: (oldState, newState) => oldState.positions.isEmpty,
      builder: (_, DashboardBlocState state) {
        if (state.positions.isNotEmpty) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              runSpacing: 15,
              spacing: 10,
              alignment: WrapAlignment.spaceBetween,
              children: [
                InfoCard(
                  icon: const Icon(Icons.account_balance_wallet),
                  label: 'Total',
                  amount: state.total,
                  fullWidth: true,
                ),
                InfoCard(
                  icon: const Icon(Icons.currency_bitcoin),
                  label: 'Crypto',
                  amount: state.crypto,
                ),
                InfoCard(
                  icon: const Icon(Icons.attach_money),
                  label: 'Stable',
                  amount: state.stable,
                ),
                InfoCard(
                  icon: const Icon(Icons.savings),
                  label: 'Invested',
                  amount: state.invested,
                  round: 0,
                ),
                InfoCard(
                  icon: const Icon(Icons.real_estate_agent),
                  label: 'Loan',
                  amount: state.loan,
                  round: 0,
                ),
                InfoCard(
                  icon: const Icon(Icons.price_change),
                  label: 'Win/Lose',
                  amount: state.percentWinLose.toDouble(),
                  prefixAmount: state.percentWinLose > 0 ? '+' : '-',
                  suffixAmount: '%',
                  round: 0,
                  colorAmount: true,
                ),
                InfoCard(
                  icon: const Icon(Icons.price_change),
                  label: 'Farming 1Y',
                  amount: state.annualFarming,
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}

class ListPosition extends StatelessWidget {
  const ListPosition({Key? key, required this.lst}) : super(key: key);
  final List<Position> lst;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return Text(
            '${lst[index].remainingCoins} ${lst[index].coin.symbol.toUpperCase()}~ ${lst[index].currentValue}\$  opened: ${lst[index].isOpened.toString()}');
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: lst.length,
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.amount,
    this.colorAmount = false,
    this.prefixAmount = "\$",
    this.suffixAmount = "",
    this.round = 2,
    this.fullWidth = false,
  }) : super(key: key);
  final Icon icon;
  final String label;
  final String prefixAmount;
  final double amount;
  final String suffixAmount;
  final int round;
  final bool colorAmount;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: fullWidth ? double.infinity : 130),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Theme.of(context).backgroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          const SizedBox(
            height: 5,
          ),
          PrimaryText(
            text: label,
            size: 14.0,
          ),
          const SizedBox(
            height: 5,
          ),
          PrimaryText(
            text: '$prefixAmount${amount.toStringAsFixed(round)}$suffixAmount',
            size: 16,
            fontWeight: FontWeight.w800,
            color:
                colorAmount ? (amount > 0.0 ? Colors.green : Colors.red) : Theme.of(context).textTheme.bodyText1?.color,
          ),
        ],
      ),
    );
  }
}

class PrimaryText extends StatelessWidget {
  final double size;
  final FontWeight fontWeight;
  final Color? color;
  final String text;
  final double height;

  const PrimaryText({
    Key? key,
    required this.text,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.size = 20,
    this.height = 1.3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Theme.of(context).textTheme.bodyText1?.color,
        height: height,
        fontFamily: 'Poppins',
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
