enum LevelSemester {
  l1s1("L1S1"),
  l1s2("L1S2"),
  l2s1("L2S1"),
  l2s2("L2S2"),
  l3s1("L3S1"),
  l3s2("L3S2"),
  l4s1("L4S1"),
  l4s2("L4S2");

  final String name;

  const LevelSemester(this.name);

  @override
  String toString() => name;
}
