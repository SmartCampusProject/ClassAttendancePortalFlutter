enum Credits {
  credit0_50("0.50"),
  credit0_75("0.75"),
  credit1_00("1.00"),
  credit1_50("1.50"),
  credit1_75("1.75"),
  credit2_00("2.00"),
  credit3_00("3.00");

  final String name;
  const Credits(this.name);

  @override
  String toString() => name;
}
