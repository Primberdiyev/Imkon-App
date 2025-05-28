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
    fullName: 'Dilshoda Toshpo‘latova',
    imagePath: 'assets/images/compo9.jpg',
    joinedFields: 'Matematika',
    score: 78,
  ),
  CompetitorModel(
    fullName: 'Suhrobjon Abduvaliyev',
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
    fullName: 'Mohirbek Yo‘ldoshev',
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
    fullName: 'Sardor Jo‘rayev',
    imagePath: 'assets/images/compo8.jpg',
    joinedFields: 'Ona tili',
    score: 91,
  ),
  CompetitorModel(
    fullName: 'Ruxshona Rahimova',
    imagePath: 'assets/images/compo9.jpg',
    joinedFields: 'Ona tili',
    score: 84,
  ),
  CompetitorModel(
    fullName: 'Nodirbek Mahmudov',
    imagePath: 'assets/images/compo10.jpg',
    joinedFields: 'Ona tili',
    score: 76,
  ),
];

List<String> fields = ['Matematika', 'Ona Tili'];
