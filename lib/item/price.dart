class Price {
  Price(
      {this.name = '',
      required this.day,
      required this.month,
      required this.week,
      required this.year,
      required this.isActive});
  String name;
  double day;
  double week;
  double month;
  double year;
  bool isActive;
}
