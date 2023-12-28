import 'package:hive/hive.dart';

part 'member.g.dart';

@HiveType(typeId: 1)
class Member {
  @HiveField(0)
  final String fullname;

  @HiveField(1)
  final String membership;

  @HiveField(2)
  final int price;

  @HiveField(3)
  final DateTime date;

  Member(
      {required this.fullname,
      required this.membership,
      required this.price,
      required this.date});
}
