import 'package:equatable/equatable.dart';

class CoinEntity extends Equatable {
  final String id;
  final String symbol;
  final String name;
  final String icon;
  final num price;
  final String links;
  final num change;
  final num change1d;
  final num change1w;
  final num volume;

  CoinEntity({
    required this.id,
    required this.symbol,
    required this.name,
    required this.icon,
    required this.price,
    required this.links,
    required this.change,
    required this.change1d,
    required this.change1w,
    required this.volume,
  });

  @override
  List<Object?> get props => [
        id,
        symbol,
        name,
        icon,
        price,
        links,
        change,
      ];
}
