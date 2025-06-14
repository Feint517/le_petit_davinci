import 'package:le_petit_davinci/features/french/model/check_error_model.dart';

final List<CheckError> exercicecheckErrors = [
  CheckError(
    sentence: "J'écris sur un rocher",
    options: ['Murs', 'Nuages', 'Livres'],
    correctAnswer: 'Murs',
  ),
  CheckError(
    sentence: "Je dessine sur le tableau",
    options: ['Cahier', 'Tableau', 'Fenêtre'],
    correctAnswer: 'Tableau',
  ),
  CheckError(
    sentence: "Elle peint sur la toile",
    options: ['Papier', 'Toile', 'Porte'],
    correctAnswer: 'Toile',
  ),
  CheckError(
    sentence: "Nous écrivons dans le carnet",
    options: ['Carnet', 'Bureau', 'Chaise'],
    correctAnswer: 'Carnet',
  ),
  CheckError(
    sentence: "Il grave sur le bois",
    options: ['Pierre', 'Métal', 'Bois'],
    correctAnswer: 'Bois',
  ),
];
