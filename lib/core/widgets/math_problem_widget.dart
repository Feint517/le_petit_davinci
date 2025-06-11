import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';

class MathProblem {
  final int firstNumber;
  final int secondNumber;
  final List<int> answerChoices;
  final String operator;
  
  MathProblem({
    required this.firstNumber,
    required this.secondNumber,
    required this.answerChoices,
    this.operator = '+', // Default to addition
  });
  
  int get correctAnswer {
    switch (operator) {
      case '+':
        return firstNumber + secondNumber;
      case '-':
        return firstNumber - secondNumber;
      default:
        return firstNumber + secondNumber;
    }
  }
}

class MathProblemWidget extends StatefulWidget {
  final List<MathProblem>? problems;
  
  const MathProblemWidget({
    super.key,
    this.problems,
  });

  @override
  State<MathProblemWidget> createState() => _MathProblemWidgetState();
}

class _MathProblemWidgetState extends State<MathProblemWidget> {
  // Current math problem data
  int firstNumber = 2;
  int secondNumber = 3;
  int correctAnswer = 5;
  List<int> answerChoices = [8, 5, 6];
  String operator = '+';
  String? selectedAnswer;
  bool showResult = false;
  
  // Problem management
  List<MathProblem> problems = [];
  int currentProblemIndex = 0;
  List<Map<String, dynamic>> problemHistory = [];

  @override
  void initState() {
    super.initState();
    // Use provided problems or generate default ones
    problems = widget.problems ?? _getDefaultProblems();
    
    // Load the first problem
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCurrentProblem();
    });
  }
  
  List<MathProblem> _getDefaultProblems() {
    return [
      MathProblem(firstNumber: 2, secondNumber: 3, answerChoices: [5, 8, 6]),
      MathProblem(firstNumber: 4, secondNumber: 1, answerChoices: [5, 3, 7]),
      MathProblem(firstNumber: 3, secondNumber: 4, answerChoices: [7, 6, 9]),
      MathProblem(firstNumber: 1, secondNumber: 6, answerChoices: [7, 5, 8]),
      MathProblem(firstNumber: 5, secondNumber: 2, answerChoices: [7, 9, 6]),
      MathProblem(firstNumber: 6, secondNumber: 3, answerChoices: [9, 8, 10]),
      MathProblem(firstNumber: 7, secondNumber: 2, answerChoices: [9, 8, 10]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [        
        Column(
          children: [
            // Math equation tiles row
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Tile 1: First number
                  _buildMathTile(firstNumber.toString()),
                  // Tile 2: Operator
                  _buildMathTile(operator),
                  // Tile 3: Second number
                  _buildMathTile(secondNumber.toString()),
                  // Tile 4: "="
                  _buildMathTile('='),
                  // Tile 5: Result tile
                  _buildMathTile(selectedAnswer ?? ''),
                ],
              ),
            ),
            
            // Answer choice buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: answerChoices.map((number) => 
                  _buildAnswerButton(number.toString())
                ).toList(),
              ),
            ),
          ],
        ),
        
        // Feedback panel at bottom (only shown when result is displayed)
        if (showResult)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildFeedbackPanel(),
          ),
      ],
    );
  }

  // Build the feedback panel with mascot and message
  Widget _buildFeedbackPanel() {
    bool isCorrect = selectedAnswer == correctAnswer.toString();
    
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Mascot illustration (left)
          SvgPicture.asset(
            SvgAssets.croco,
            height: 120,
            width: 80,
          ),
          const SizedBox(width: 16),
          
          // Message bubble (right)
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Status icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isCorrect ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isCorrect ? Icons.check : Icons.close,
                      color: AppColors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Message text
                  Expanded(
                    child: Text(
                      isCorrect 
                        ? 'Super ! Tu as raison.'
                        : 'Dommage, ce n\'est pas la bonne réponse.',
                      style: TextStyle(
                        color: AppColors.bluePrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build individual math tiles
  Widget _buildMathTile(String content) {
    // Check if it's an operator (+, -, or =)
    bool isOperator = content == '+' || content == '-' || content == '=';
    
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isOperator 
          ? Colors.transparent // No background for operators
          : AppColors.orangeAccentDark, // Darker orange for numbers and empty tile
        borderRadius: BorderRadius.circular(12),
        boxShadow: isOperator ? null : [
          BoxShadow(
            color: AppColors.orangeAccentDark.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          content,
          style: TextStyle(
            color: isOperator ? AppColors.darkGrey : AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Helper method to build circular answer buttons
  Widget _buildAnswerButton(String number) {
    bool isSelected = selectedAnswer == number;
    bool isCorrect = number == correctAnswer.toString();
    
    return GestureDetector(
      onTap: () => _onAnswerSelected(number),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: showResult 
            ? (isCorrect ? Colors.green.shade100 : isSelected ? Colors.red.shade100 : AppColors.white)
            : (isSelected ? AppColors.secondary.withOpacity(0.2) : AppColors.white),
          shape: BoxShape.circle,
          border: showResult && isCorrect 
            ? Border.all(color: Colors.green, width: 2)
            : isSelected 
              ? Border.all(color: AppColors.secondary, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withOpacity(0.4),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              color: showResult && isCorrect 
                ? Colors.green.shade700
                : showResult && isSelected && !isCorrect
                  ? Colors.red.shade700
                  : AppColors.secondary,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Handle answer selection
  void _onAnswerSelected(String answer) {
    // Store current problem in history
    problemHistory.add({
      'firstNumber': firstNumber,
      'secondNumber': secondNumber,
      'correctAnswer': correctAnswer,
      'userAnswer': int.tryParse(answer),
      'isCorrect': answer == correctAnswer.toString(),
    });
    
    setState(() {
      selectedAnswer = answer;
      showResult = true;
    });
    
    // Show result for 1.5 seconds, then move to next problem
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        if (currentProblemIndex < problems.length - 1) {
          setState(() {
            currentProblemIndex++;
          });
          _loadCurrentProblem();
        } else {
          _showProblemSetComplete();
        }
      }
    });
  }

  // Load the current problem from the list
  void _loadCurrentProblem() {
    if (currentProblemIndex < problems.length) {
      final problem = problems[currentProblemIndex];
      setState(() {
        firstNumber = problem.firstNumber;
        secondNumber = problem.secondNumber;
        operator = problem.operator;
        correctAnswer = problem.correctAnswer;
        answerChoices = List.from(problem.answerChoices); // Copy the list
        selectedAnswer = null;
        showResult = false;
      });
    }
  }

  // Show completion message and stats
  void _showProblemSetComplete() {
    int correctAnswers = problemHistory.where((p) => p['isCorrect'] == true).length;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.star, color: AppColors.secondary, size: 28),
              const SizedBox(width: 8),
              Text(
                'Bravo!',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tu as terminé ${problems.length} problèmes!',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.darkGrey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '$correctAnswers/${problems.length} correctes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _startNewProblemSet();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Continuer',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Start a new set of problems
  void _startNewProblemSet() {
    setState(() {
      currentProblemIndex = 0;
      problemHistory.clear();
    });
    _loadCurrentProblem();
  }
}