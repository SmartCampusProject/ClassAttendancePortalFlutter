enum Faculty {
  agriculture("Agriculture"),
  businessStudies("Business Studies"),
  computerScienceAndEngineering("Computer Science and Engineering"),
  engineering("Engineering"),
  fisheries("Fisheries"),
  postgraduateStudies("Postgraduate Studies"),
  science("Science"),
  socialScienceAndHumanities("Social Science and Humanities"),
  veterinaryAndAnimalScience("Veterinary and Animal Science");

  final String name;

  const Faculty(this.name);

  @override
  String toString() => name;
}
