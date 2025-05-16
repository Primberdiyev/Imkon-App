class CompetitorModel {
  final String fullName;
  final String imagePath;
  final int score;
  final String joinedFields;

  const CompetitorModel({
    required this.fullName,
    required this.imagePath,
    required this.score,
    required this.joinedFields,
  });
}

List<CompetitorModel> competitors = [
  CompetitorModel(
    fullName: 'Abdullajon Karimov',
    imagePath: 'assets/images/compo1.jpg',
    joinedFields: 'Matematika',
    score: 55,
  ),
  CompetitorModel(
    fullName: 'Dilshod Toshpo‘latov',
    imagePath: 'assets/images/compo9.jpg',
    joinedFields: 'Matematika',
    score: 78,
  ),
  CompetitorModel(
    fullName: 'Ziyoda Abduvaliyeva',
    imagePath: 'assets/images/compo3.jpg',
    joinedFields: 'Matematika',
    score: 62,
  ),
  CompetitorModel(
    fullName: 'Jamshid Qodirov',
    imagePath: 'assets/images/compo4.jpg',
    joinedFields: 'Matematika',
    score: 88,
  ),
  CompetitorModel(
    fullName: 'Malika Ergasheva',
    imagePath: 'assets/images/compo5.jpg',
    joinedFields: 'Matematika',
    score: 73,
  ),
  CompetitorModel(
    fullName: 'Mohira Yo‘ldosheva',
    imagePath: 'assets/images/compo6.jpg',
    joinedFields: 'Ona tili',
    score: 67,
  ),
  CompetitorModel(
    fullName: 'Shahzod Bekmurodov',
    imagePath: 'assets/images/compo1.jpg',
    joinedFields: 'Ona tili',
    score: 59,
  ),
  CompetitorModel(
    fullName: 'Rayhona Jo‘rayeva',
    imagePath: 'assets/images/compo8.jpg',
    joinedFields: 'Ona tili',
    score: 91,
  ),
  CompetitorModel(
    fullName: 'Ulug‘bek Rahimov',
    imagePath: 'assets/images/compo9.jpg',
    joinedFields: 'Ona tili',
    score: 84,
  ),
  CompetitorModel(
    fullName: 'Dilnoza Mahmudova',
    imagePath: 'assets/images/compo10.jpg',
    joinedFields: 'Ona tili',
    score: 76,
  ),
];

List<String> fields = ['Matematika', 'Ona Tili'];
