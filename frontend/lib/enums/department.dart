enum Department {
  accounting("Accounting"),
  agriculturalAndIndustrialEngineering("Agricultural & Industrial Engineering"),
  agriculturalChemistry("Agricultural Chemistry"),
  agriculturalExtension("Agricultural Extension"),
  agronomy("Agronomy"),
  anatomyAndHistology("Anatomy & Histology"),
  animalScienceAndNutrition("Animal Science & Nutrition"),
  aquaculture("Aquaculture"),
  architecture("Architecture"),
  biochemistryAndMolecularBiology("Biochemistry & Molecular Biology"),
  businessManagement("Management"),
  chemistry("Chemistry"),
  civilEngineering("Civil Engineering"),
  computerScienceAndEngineering("Computer Science and Engineering"),
  cropPhysiologyAndEcologoy("Crop Physiology & Ecology"),
  dairyAndPoultryScience("Dairy & Poultry Science"),
  developmentStudies("Development Studies"),
  economics("Economics"),
  electricalAndElectronicEngineering("Electrical and Electronic Engineering"),
  electronicsAndCommunicationEngineering(
    "Electronics and Communication Engineering",
  ),
  english("English"),
  entomology("Entomology"),
  financeAndBanking("Finance and Banking"),
  fisheriesBiologyAndGenetics("Fisheries Biology & Genetics"),
  fisheriesManagement("Fisheries Management"),
  fisheriesTechnology("Fisheries Technology"),
  foodEngineeringAndTechnology("Food Engineering & Technology"),
  foodProcessingAndPreservation("Food Processing & Preservation"),
  foodScienceAndNutrition("Food Science & Nutrition"),
  geneticsAndAnimalBreeding("Genetics & Animal Breeding"),
  geneticsAndPlantBreeding("Genetics & Plant Breeding"),
  horticulture("Horticulture"),
  marketing("Marketing"),
  mathematics("Mathematics"),
  mechanicalEngineering("Mechanical Engineering"),
  medicineSurgeryAndObstetrics("Medicine, Surgery and Obstetrics"),
  microbiology("Microbiology"),
  pathologyAndParasitology("Pathology & Parasitology"),
  physics("Physics"),
  physiologyAndPharmacology("Physiology & Pharmacology"),
  plantPathology("Plant Pathology"),
  sociology("Sociology"),
  soilScience("Soil Science"),
  statistics("Statistics");

  final String name;

  const Department(this.name);

  @override
  String toString() => name;
}
