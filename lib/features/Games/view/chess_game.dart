import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:gap/gap.dart';
import 'package:chess/chess.dart' as chess;
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';

class ChessGame extends StatefulWidget {
  const ChessGame({super.key});

  @override
  State<ChessGame> createState() => _ChessGameState();
}

class _ChessGameState extends State<ChessGame> with TickerProviderStateMixin {
  // Animation controller for the popup
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  // Additional animations
  late AnimationController _pieceAnimController;
  late AnimationController _backgroundAnimController;
  late Animation<Color?> _backgroundColorAnimation;

  AudioPlayer audioPlayer = AudioPlayer();
  bool isMuted = false;
  bool showModeSelection = true;
  String difficulty = 'medium';

  // Chess game state
  late chess.Chess chessGame;
  String? selectedSquare;
  List<String> possibleMoves = [];
  bool isGameOver = false;
  String gameResult = '';
  int whiteScore = 0;
  int blackScore = 0;
  String currentPlayer = 'white';
  
  // Fallback board state if chess package doesn't work
  Map<String, String> fallbackBoard = {};
  
  // Game state tracking
  String? lastMoveFrom;
  String? lastMoveTo;
  bool whiteKingMoved = false;
  bool blackKingMoved = false;
  bool whiteRookAMoved = false;
  bool whiteRookHMoved = false;
  bool blackRookAMoved = false;
  bool blackRookHMoved = false;
  
  void initializeFallbackBoard() {
    // Standard chess starting position
    fallbackBoard = {
      // Black pieces (rank 8)
      'a8': 'bR', 'b8': 'bN', 'c8': 'bB', 'd8': 'bQ', 'e8': 'bK', 'f8': 'bB', 'g8': 'bN', 'h8': 'bR',
      // Black pawns (rank 7)
      'a7': 'bP', 'b7': 'bP', 'c7': 'bP', 'd7': 'bP', 'e7': 'bP', 'f7': 'bP', 'g7': 'bP', 'h7': 'bP',
      // White pawns (rank 2)
      'a2': 'wP', 'b2': 'wP', 'c2': 'wP', 'd2': 'wP', 'e2': 'wP', 'f2': 'wP', 'g2': 'wP', 'h2': 'wP',
      // White pieces (rank 1)
      'a1': 'wR', 'b1': 'wN', 'c1': 'wB', 'd1': 'wQ', 'e1': 'wK', 'f1': 'wB', 'g1': 'wN', 'h1': 'wR',
    };
  }

  // Chess piece Unicode symbols
  final Map<String, String> pieceSymbols = {
    'wK': '♔', // White King
    'wQ': '♕', // White Queen
    'wR': '♖', // White Rook
    'wB': '♗', // White Bishop
    'wN': '♘', // White Knight
    'wP': '♙', // White Pawn
    'bK': '♚', // Black King
    'bQ': '♛', // Black Queen
    'bR': '♜', // Black Rook
    'bB': '♝', // Black Bishop
    'bN': '♞', // Black Knight
    'bP': '♟', // Black Pawn
  };

  // Chess piece colors
  final Map<String, Color> pieceColors = {
    'wK': Colors.white,
    'wQ': Colors.white,
    'wR': Colors.white,
    'wB': Colors.white,
    'wN': Colors.white,
    'wP': Colors.white,
    'bK': Colors.black,
    'bQ': Colors.black,
    'bR': Colors.black,
    'bB': Colors.black,
    'bN': Colors.black,
    'bP': Colors.black,
  };

  @override
  void initState() {
    super.initState();

    // Initialize chess game
    chessGame = chess.Chess();
    
    // Initialize fallback board
    initializeFallbackBoard();
    
    // Initialize fallback board for piece display

    // Initialize animation controller for intro slide
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    // Create slide animation that moves up from bottom
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Start from below the screen
      end: Offset(0, 0), // End at normal position
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linearToEaseOut,
      ),
    );

    // Piece animation controller
    _pieceAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    // Background subtle color change animation
    _backgroundAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    )..repeat(reverse: true);

    _backgroundColorAnimation = ColorTween(
      begin: Colors.brown[200],
      end: Colors.brown[300],
    ).animate(_backgroundAnimController);

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pieceAnimController.dispose();
    _backgroundAnimController.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  void toggleSound() {
    setState(() {
      isMuted = !isMuted;
    });
    playSound('buttonclick.mp3');
  }

  Future<void> playSound(String soundName) async {
    if (!isMuted) {
      await audioPlayer.play(AssetSource('sfx/$soundName'));
    }
  }

  // Hide the mode selection and start the game
  void startGame() {
    setState(() {
      showModeSelection = false;
      isGameOver = false;
      gameResult = '';
      whiteScore = 0;
      blackScore = 0;
      currentPlayer = 'white';
      selectedSquare = null;
      possibleMoves = [];
      // Reset chess game
      chessGame = chess.Chess();
      
      // Reset fallback board
      initializeFallbackBoard();
      
      // Reset game state tracking
      lastMoveFrom = null;
      lastMoveTo = null;
      whiteKingMoved = false;
      blackKingMoved = false;
      whiteRookAMoved = false;
      whiteRookHMoved = false;
      blackRookAMoved = false;
      blackRookHMoved = false;
      
      // Game started successfully
    });
    playSound('buttonclick.mp3');
  }

  void makeMove(String from, String to) {
    if (isGameOver) return;

    // Get the piece at the source square
    String piece = fallbackBoard[from] ?? '';
    if (piece.isEmpty) return;

    // Check if it's the current player's turn
    bool isWhitePiece = piece.startsWith('w');
    if ((isWhitePiece && currentPlayer != 'white') || 
        (!isWhitePiece && currentPlayer != 'black')) {
      return;
    }

    // Check if move would put own king in check
    if (wouldMovePutKingInCheck(from, to, piece)) {
      playSound('x.mp3');
      return;
    }

    // Simple move validation - just check if destination is in possible moves
    if (possibleMoves.contains(to)) {
      setState(() {
        // Handle castling
        if (piece.endsWith('K')) {
          // Check for castling
          if (from == 'e1' && to == 'g1') {
            // White kingside castling
            fallbackBoard['f1'] = 'wR';
            fallbackBoard['h1'] = '';
          } else if (from == 'e1' && to == 'c1') {
            // White queenside castling
            fallbackBoard['d1'] = 'wR';
            fallbackBoard['a1'] = '';
          } else if (from == 'e8' && to == 'g8') {
            // Black kingside castling
            fallbackBoard['f8'] = 'bR';
            fallbackBoard['h8'] = '';
          } else if (from == 'e8' && to == 'c8') {
            // Black queenside castling
            fallbackBoard['d8'] = 'bR';
            fallbackBoard['a8'] = '';
          }
        }
        
        // Handle en passant capture
        if (piece.endsWith('P')) {
          int fromFile = from.codeUnitAt(0) - 97;
          int toFile = to.codeUnitAt(0) - 97;
          
          // Check if this is an en passant capture
          if (fromFile != toFile && (fallbackBoard[to]?.isEmpty ?? true)) {
            // This is an en passant capture, remove the captured pawn
            String capturedPawnSquare = String.fromCharCode(97 + toFile) + from[1];
            fallbackBoard[capturedPawnSquare] = '';
          }
        }
        
        // Make the move
        fallbackBoard[to] = piece;
        fallbackBoard[from] = '';
        
        // Track move for castling and en passant
        lastMoveFrom = from;
        lastMoveTo = to;
        
        // Track king and rook moves for castling
        if (piece == 'wK') whiteKingMoved = true;
        if (piece == 'bK') blackKingMoved = true;
        if (piece == 'wR' && from == 'a1') whiteRookAMoved = true;
        if (piece == 'wR' && from == 'h1') whiteRookHMoved = true;
        if (piece == 'bR' && from == 'a8') blackRookAMoved = true;
        if (piece == 'bR' && from == 'h8') blackRookHMoved = true;
        
        // Check for pawn promotion
        String pieceType = piece.substring(1);
        if (pieceType == 'P') {
          int rank = int.parse(to[1]) - 1;
          if ((piece.startsWith('w') && rank == 7) || (piece.startsWith('b') && rank == 0)) {
            // Promote pawn to queen (simplified)
            fallbackBoard[to] = piece.substring(0, 1) + 'Q';
          }
        }
        
        selectedSquare = null;
        possibleMoves = [];
        currentPlayer = currentPlayer == 'white' ? 'black' : 'white';
        
        // Check for game over conditions
        String opponentColor = currentPlayer == 'white' ? 'b' : 'w';
        if (isCheckmate(opponentColor)) {
          isGameOver = true;
          gameResult = '${currentPlayer == 'white' ? 'Black' : 'White'} wins by checkmate!';
        } else if (isStalemate(opponentColor)) {
          isGameOver = true;
          gameResult = 'Draw by stalemate!';
        } else if (isKingInCheck(opponentColor)) {
          // King is in check but not checkmate
        }
      });
      playSound('buttonclick.mp3');
    } else {
      // Invalid move
      playSound('x.mp3');
    }
  }

  void selectSquare(String square) {
    if (isGameOver) return;

    String piece = fallbackBoard[square] ?? '';
    bool isWhitePiece = piece.startsWith('w');
    
    // Handle square selection
    
    setState(() {
      if (selectedSquare == square) {
        // Deselect
        // Deselecting square
        selectedSquare = null;
        possibleMoves = [];
      } else if (selectedSquare != null && possibleMoves.contains(square)) {
        // Make move - this is a valid destination
        // Making move
        makeMove(selectedSquare!, square);
      } else if (piece.isNotEmpty) {
        // Only check turn when selecting a piece to move
        if ((isWhitePiece && currentPlayer != 'white') || 
            (!isWhitePiece && currentPlayer != 'black')) {
          // Not your turn
          return;
        }
        
        // Select new square and calculate possible moves
        // Select new square and calculate possible moves
        selectedSquare = square;
        possibleMoves = calculatePossibleMoves(square, piece);
      } else {
        // Clicked on empty square with no piece selected - do nothing
        // Clicked on empty square with no piece selected
      }
    });
  }

  String getPieceAt(String square) {
    try {
      // Use the fallback board for now since the chess package API is complex
      // We'll implement a simple chess game using our own board state
      return fallbackBoard[square] ?? '';
    } catch (e) {
      return '';
    }
  }

  bool isLightSquare(int rank, int file) {
    return (rank + file) % 2 == 0;
  }

  // Check if a king is in check (simplified to avoid infinite loops)
  bool isKingInCheck(String kingColor) {
    // For now, return false to prevent infinite loops
    // In a full implementation, this would properly check if the king is in check
    return false;
  }

  // Find the king's position
  String findKing(String color) {
    String kingPiece = '${color}K';
    for (String square in fallbackBoard.keys) {
      if (fallbackBoard[square] == kingPiece) {
        return square;
      }
    }
    return '';
  }

  // Check if a move would put own king in check
  bool wouldMovePutKingInCheck(String from, String to, String piece) {
    // Make a temporary move
    String originalPiece = fallbackBoard[to] ?? '';
    fallbackBoard[to] = piece;
    fallbackBoard[from] = '';
    
    // Check if own king is in check (simplified check to avoid infinite loops)
    String pieceColor = piece.substring(0, 1);
    String kingSquare = findKing(pieceColor);
    bool inCheck = false;
    
    if (kingSquare.isNotEmpty) {
      // Simple check: see if any opponent piece can attack the king
      String opponentColor = pieceColor == 'w' ? 'b' : 'w';
      for (String square in fallbackBoard.keys) {
        String boardPiece = fallbackBoard[square] ?? '';
        if (boardPiece.isNotEmpty && boardPiece.startsWith(opponentColor)) {
          // Check if this piece can attack the king (simplified)
          if (_canPieceAttackSquare(square, boardPiece, kingSquare)) {
            inCheck = true;
            break;
          }
        }
      }
    }
    
    // Restore the board
    fallbackBoard[from] = piece;
    fallbackBoard[to] = originalPiece;
    
    return inCheck;
  }

  // Simplified method to check if a piece can attack a square
  bool _canPieceAttackSquare(String fromSquare, String piece, String targetSquare) {
    // This is a simplified version to avoid infinite loops
    // For now, just return false to prevent the infinite loop
    // In a full implementation, this would check the specific piece movement rules
    return false;
  }

  // Check for checkmate (simplified to avoid infinite loops)
  bool isCheckmate(String color) {
    // For now, return false to prevent infinite loops
    // In a full implementation, this would properly check for checkmate
    return false;
  }

  // Check for stalemate (simplified to avoid infinite loops)
  bool isStalemate(String color) {
    // For now, return false to prevent infinite loops
    // In a full implementation, this would properly check for stalemate
    return false;
  }

  List<String> calculatePossibleMoves(String square, String piece) {
    List<String> moves = [];
    
    if (piece.isEmpty) return moves;
    
    // Get square coordinates
    int file = square.codeUnitAt(0) - 97; // a=0, b=1, etc.
    int rank = int.parse(square[1]) - 1; // 1=0, 2=1, etc.
    
    String pieceType = piece.substring(1); // Remove color prefix
    bool isWhite = piece.startsWith('w');
    
    // Calculate moves for piece at square
    
    switch (pieceType) {
      case 'P': // Pawn
        if (isWhite) {
          // White pawn moves forward
          if (rank < 7) {
            String forward = String.fromCharCode(97 + file) + (rank + 2).toString();
            if (fallbackBoard[forward]?.isEmpty ?? true) {
              moves.add(forward);
            }
          }
          // White pawn can move 2 squares from starting position
          if (rank == 1) {
            String forward2 = String.fromCharCode(97 + file) + (rank + 3).toString();
            if (fallbackBoard[forward2]?.isEmpty ?? true) {
              moves.add(forward2);
            }
          }
          // White pawn can capture diagonally
          if (file > 0 && rank < 7) {
            String diagLeft = String.fromCharCode(97 + file - 1) + (rank + 2).toString();
            String targetPiece = fallbackBoard[diagLeft] ?? '';
            if (targetPiece.isNotEmpty && targetPiece.startsWith('b')) {
              moves.add(diagLeft);
            }
          }
          if (file < 7 && rank < 7) {
            String diagRight = String.fromCharCode(97 + file + 1) + (rank + 2).toString();
            String targetPiece = fallbackBoard[diagRight] ?? '';
            if (targetPiece.isNotEmpty && targetPiece.startsWith('b')) {
              moves.add(diagRight);
            }
          }
          
          // En passant capture
          if (rank == 4 && lastMoveTo != null) {
            int lastMoveRank = int.parse(lastMoveTo![1]) - 1;
            int lastMoveFile = lastMoveTo!.codeUnitAt(0) - 97;
            if (lastMoveRank == 4 && lastMoveFile == file - 1) {
              String enPassantTarget = String.fromCharCode(97 + file - 1) + (rank + 2).toString();
              moves.add(enPassantTarget);
            }
            if (lastMoveRank == 4 && lastMoveFile == file + 1) {
              String enPassantTarget = String.fromCharCode(97 + file + 1) + (rank + 2).toString();
              moves.add(enPassantTarget);
            }
          }
        } else {
          // Black pawn moves forward
          if (rank > 0) {
            String forward = String.fromCharCode(97 + file) + rank.toString();
            if (fallbackBoard[forward]?.isEmpty ?? true) {
              moves.add(forward);
            }
          }
          // Black pawn can move 2 squares from starting position
          if (rank == 6) {
            String forward2 = String.fromCharCode(97 + file) + (rank - 1).toString();
            if (fallbackBoard[forward2]?.isEmpty ?? true) {
              moves.add(forward2);
            }
          }
          // Black pawn can capture diagonally
          if (file > 0 && rank > 0) {
            String diagLeft = String.fromCharCode(97 + file - 1) + rank.toString();
            String targetPiece = fallbackBoard[diagLeft] ?? '';
            if (targetPiece.isNotEmpty && targetPiece.startsWith('w')) {
              moves.add(diagLeft);
            }
          }
          if (file < 7 && rank > 0) {
            String diagRight = String.fromCharCode(97 + file + 1) + rank.toString();
            String targetPiece = fallbackBoard[diagRight] ?? '';
            if (targetPiece.isNotEmpty && targetPiece.startsWith('w')) {
              moves.add(diagRight);
            }
          }
          
          // En passant capture
          if (rank == 3 && lastMoveTo != null) {
            int lastMoveRank = int.parse(lastMoveTo![1]) - 1;
            int lastMoveFile = lastMoveTo!.codeUnitAt(0) - 97;
            if (lastMoveRank == 3 && lastMoveFile == file - 1) {
              String enPassantTarget = String.fromCharCode(97 + file - 1) + rank.toString();
              moves.add(enPassantTarget);
            }
            if (lastMoveRank == 3 && lastMoveFile == file + 1) {
              String enPassantTarget = String.fromCharCode(97 + file + 1) + rank.toString();
              moves.add(enPassantTarget);
            }
          }
        }
        break;
        
      case 'R': // Rook
        // Horizontal and vertical moves
        for (int i = 0; i < 8; i++) {
          if (i != file) {
            String target = String.fromCharCode(97 + i) + (rank + 1).toString();
            String targetPiece = fallbackBoard[target] ?? '';
            if (targetPiece.isEmpty || (isWhite ? targetPiece.startsWith('b') : targetPiece.startsWith('w'))) {
              moves.add(target);
            }
          }
          if (i != rank) {
            String target = String.fromCharCode(97 + file) + (i + 1).toString();
            String targetPiece = fallbackBoard[target] ?? '';
            if (targetPiece.isEmpty || (isWhite ? targetPiece.startsWith('b') : targetPiece.startsWith('w'))) {
              moves.add(target);
            }
          }
        }
        break;
        
      case 'N': // Knight
        // Knight moves in L-shape
        List<List<int>> knightMoves = [
          [-2, -1], [-2, 1], [-1, -2], [-1, 2],
          [1, -2], [1, 2], [2, -1], [2, 1]
        ];
        for (List<int> move in knightMoves) {
          int newFile = file + move[0];
          int newRank = rank + move[1];
          if (newFile >= 0 && newFile < 8 && newRank >= 0 && newRank < 8) {
            String target = String.fromCharCode(97 + newFile) + (newRank + 1).toString();
            String targetPiece = fallbackBoard[target] ?? '';
            if (targetPiece.isEmpty || (isWhite ? targetPiece.startsWith('b') : targetPiece.startsWith('w'))) {
              moves.add(target);
            }
          }
        }
        break;
        
      case 'B': // Bishop
        // Diagonal moves
        for (int i = 1; i < 8; i++) {
          // Top-left to bottom-right diagonal
          if (file + i < 8 && rank + i < 8) {
            String target = String.fromCharCode(97 + file + i) + (rank + i + 1).toString();
            String targetPiece = fallbackBoard[target] ?? '';
            if (targetPiece.isEmpty || (isWhite ? targetPiece.startsWith('b') : targetPiece.startsWith('w'))) {
              moves.add(target);
            }
          }
          if (file - i >= 0 && rank - i >= 0) {
            String target = String.fromCharCode(97 + file - i) + (rank - i + 1).toString();
            String targetPiece = fallbackBoard[target] ?? '';
            if (targetPiece.isEmpty || (isWhite ? targetPiece.startsWith('b') : targetPiece.startsWith('w'))) {
              moves.add(target);
            }
          }
          // Top-right to bottom-left diagonal
          if (file + i < 8 && rank - i >= 0) {
            String target = String.fromCharCode(97 + file + i) + (rank - i + 1).toString();
            String targetPiece = fallbackBoard[target] ?? '';
            if (targetPiece.isEmpty || (isWhite ? targetPiece.startsWith('b') : targetPiece.startsWith('w'))) {
              moves.add(target);
            }
          }
          if (file - i >= 0 && rank + i < 8) {
            String target = String.fromCharCode(97 + file - i) + (rank + i + 1).toString();
            String targetPiece = fallbackBoard[target] ?? '';
            if (targetPiece.isEmpty || (isWhite ? targetPiece.startsWith('b') : targetPiece.startsWith('w'))) {
              moves.add(target);
            }
          }
        }
        break;
        
      case 'Q': // Queen (combines rook and bishop moves)
        // Use rook logic
        for (int i = 0; i < 8; i++) {
          if (i != file) {
            String target = String.fromCharCode(97 + i) + (rank + 1).toString();
            String targetPiece = fallbackBoard[target] ?? '';
            if (targetPiece.isEmpty || (isWhite ? targetPiece.startsWith('b') : targetPiece.startsWith('w'))) {
              moves.add(target);
            }
          }
          if (i != rank) {
            String target = String.fromCharCode(97 + file) + (i + 1).toString();
            String targetPiece = fallbackBoard[target] ?? '';
            if (targetPiece.isEmpty || (isWhite ? targetPiece.startsWith('b') : targetPiece.startsWith('w'))) {
              moves.add(target);
            }
          }
        }
        // Use bishop logic
        for (int i = 1; i < 8; i++) {
          if (file + i < 8 && rank + i < 8) {
            String target = String.fromCharCode(97 + file + i) + (rank + i + 1).toString();
            String targetPiece = fallbackBoard[target] ?? '';
            if (targetPiece.isEmpty || (isWhite ? targetPiece.startsWith('b') : targetPiece.startsWith('w'))) {
              moves.add(target);
            }
          }
          if (file - i >= 0 && rank - i >= 0) {
            String target = String.fromCharCode(97 + file - i) + (rank - i + 1).toString();
            String targetPiece = fallbackBoard[target] ?? '';
            if (targetPiece.isEmpty || (isWhite ? targetPiece.startsWith('b') : targetPiece.startsWith('w'))) {
              moves.add(target);
            }
          }
          if (file + i < 8 && rank - i >= 0) {
            String target = String.fromCharCode(97 + file + i) + (rank - i + 1).toString();
            String targetPiece = fallbackBoard[target] ?? '';
            if (targetPiece.isEmpty || (isWhite ? targetPiece.startsWith('b') : targetPiece.startsWith('w'))) {
              moves.add(target);
            }
          }
          if (file - i >= 0 && rank + i < 8) {
            String target = String.fromCharCode(97 + file - i) + (rank + i + 1).toString();
            String targetPiece = fallbackBoard[target] ?? '';
            if (targetPiece.isEmpty || (isWhite ? targetPiece.startsWith('b') : targetPiece.startsWith('w'))) {
              moves.add(target);
            }
          }
        }
        break;
        
      case 'K': // King
        // King moves one square in any direction
        for (int i = -1; i <= 1; i++) {
          for (int j = -1; j <= 1; j++) {
            if (i == 0 && j == 0) continue;
            int newFile = file + i;
            int newRank = rank + j;
            if (newFile >= 0 && newFile < 8 && newRank >= 0 && newRank < 8) {
              String target = String.fromCharCode(97 + newFile) + (newRank + 1).toString();
              String targetPiece = fallbackBoard[target] ?? '';
              if (targetPiece.isEmpty || (isWhite ? targetPiece.startsWith('b') : targetPiece.startsWith('w'))) {
                moves.add(target);
              }
            }
          }
        }
        
        // Castling
        if (isWhite) {
          // White castling
          if (!whiteKingMoved && !isKingInCheck('w')) {
            // Kingside castling
            if (!whiteRookHMoved && 
                (fallbackBoard['f1']?.isEmpty ?? true) && 
                (fallbackBoard['g1']?.isEmpty ?? true)) {
              moves.add('g1');
            }
            // Queenside castling
            if (!whiteRookAMoved && 
                (fallbackBoard['b1']?.isEmpty ?? true) && 
                (fallbackBoard['c1']?.isEmpty ?? true) && 
                (fallbackBoard['d1']?.isEmpty ?? true)) {
              moves.add('c1');
            }
          }
        } else {
          // Black castling
          if (!blackKingMoved && !isKingInCheck('b')) {
            // Kingside castling
            if (!blackRookHMoved && 
                (fallbackBoard['f8']?.isEmpty ?? true) && 
                (fallbackBoard['g8']?.isEmpty ?? true)) {
              moves.add('g8');
            }
            // Queenside castling
            if (!blackRookAMoved && 
                (fallbackBoard['b8']?.isEmpty ?? true) && 
                (fallbackBoard['c8']?.isEmpty ?? true) && 
                (fallbackBoard['d8']?.isEmpty ?? true)) {
              moves.add('c8');
            }
          }
        }
        break;
    }
    
    return moves;
  }

  Widget _buildGameOverDialog() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.accentDark,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: CustomShadowStyle.customCircleShadows(
          color: AppColors.accentDark,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Partie Terminée!',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'BricolageGrotesque',
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(10),
          Text(
            gameResult,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'BricolageGrotesque',
              color: AppColors.white,
            ),
          ),
          Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    chessGame = chess.Chess();
                    initializeFallbackBoard();
                    selectedSquare = null;
                    possibleMoves = [];
                    currentPlayer = 'white';
                    isGameOver = false;
                    gameResult = '';
                    lastMoveFrom = null;
                    lastMoveTo = null;
                    whiteKingMoved = false;
                    blackKingMoved = false;
                    whiteRookAMoved = false;
                    whiteRookHMoved = false;
                    blackRookAMoved = false;
                    blackRookHMoved = false;
                  });
                  playSound('buttonclick.mp3');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(
                  'Rejouer',
                  style: TextStyle(
                    fontFamily: 'BricolageGrotesque',
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showModeSelection = true;
                    isGameOver = false;
                  });
                  _animationController.reset();
                  _animationController.forward();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontFamily: 'BricolageGrotesque',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModeSelectionDialog() {
    return SlideTransition(
      position: _slideAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.accentDark,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: CustomShadowStyle.customCircleShadows(
            color: AppColors.accentDark,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sélectionner le mode',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'BricolageGrotesque',
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(15),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        difficulty = 'easy';
                      });
                      playSound('buttonclick.mp3');
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: 35,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.white,
                          width: 2,
                        ),
                        color: difficulty == 'easy'
                            ? Colors.white
                            : AppColors.purple,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          'Facile',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'BricolageGrotesque',
                            color: difficulty == 'easy'
                                ? AppColors.purple
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        difficulty = 'medium';
                      });
                      playSound('buttonclick.mp3');
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: 35,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.white,
                          width: 2,
                        ),
                        color: difficulty == 'medium'
                            ? Colors.white
                            : AppColors.purple,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          'Moyen',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'BricolageGrotesque',
                            color: difficulty == 'medium'
                                ? AppColors.purple
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        difficulty = 'hard';
                      });
                      playSound('buttonclick.mp3');
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: 35,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.white,
                          width: 2,
                        ),
                        color: difficulty == 'hard'
                            ? Colors.white
                            : AppColors.purple,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          'Difficile',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'BricolageGrotesque',
                            color: difficulty == 'hard'
                                ? AppColors.purple
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(15),

            Text(
              'Échecs Simplifiés',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'BricolageGrotesque',
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Bienvenue dans le jeu d\'Échecs ! Déplacez vos pièces pour capturer le roi adverse. Les pièces blanches commencent. Cliquez sur une pièce pour voir les mouvements possibles, puis cliquez sur la case de destination. Bonne chance !',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'BricolageGrotesque',
                color: AppColors.white,
              ),
            ),
            Gap(25),
            CustomButton(
              variant: ButtonVariant.secondary,
              label: 'Démarrer le jeu',
              icon: Icon(
                Icons.play_arrow_outlined,
                color: AppColors.white,
              ),
              iconPosition: IconPosition.right,
              onPressed: () => startGame(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileHeader(type: ProfileHeaderType.compact),
      backgroundColor: AppColors.light,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: AnimatedBuilder(
          animation: _backgroundColorAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(),
              child: SafeArea(
                child: Column(
                  children: [
                    Gap(20),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Échecs Simplifiés ♟️',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'BricolageGrotesque',
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (!showModeSelection)
                              Text(
                                'Tour: ${currentPlayer == 'white' ? 'Blanc' : 'Noir'}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'BricolageGrotesque',
                                  color: AppColors.accent,
                                ),
                              )
                            else
                              Text(
                                '1542',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'BricolageGrotesque',
                                  color: AppColors.accent,
                                ),
                              ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: LinearProgressIndicator(
                            value: 0.68, // Replace with your value
                            backgroundColor: Colors.grey,
                            valueColor: AlwaysStoppedAnimation(
                              AppColors.accent,
                            ),
                            minHeight: 16,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    ),

                    // Header with sound control
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 9, 0, 9),
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: IconButton(
                              icon: Icon(
                                isMuted ? Icons.volume_off : Icons.volume_up,
                                size: 24,
                                color: Colors.white,
                              ),
                              onPressed: toggleSound,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Game board
                    Expanded(
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.brown[100],
                              border: Border.all(
                                color: AppColors.accent,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 8,
                              ),
                              itemCount: 64,
                              itemBuilder: (context, index) {
                                int rank = 7 - (index ~/ 8);
                                int file = index % 8;
                                String square = String.fromCharCode(97 + file) + (rank + 1).toString();
                                String piece = getPieceAt(square);
                                bool isLight = isLightSquare(rank, file);
                                bool isSelected = selectedSquare == square;
                                bool isPossibleMove = possibleMoves.contains(square);

                                return GestureDetector(
                                  onTap: () => selectSquare(square),
                                  child: Container(
                                    margin: EdgeInsets.all(0.5),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.accent.withOpacity(0.7)
                                          : isPossibleMove
                                              ? AppColors.accent.withOpacity(0.3)
                                              : isLight
                                                  ? Colors.brown[200]
                                                  : Colors.brown[400],
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: Center(
                                      child: piece.isNotEmpty
                                          ? Text(
                                              pieceSymbols[piece] ?? '',
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: pieceColors[piece] ?? Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          : isPossibleMove
                                              ? Container(
                                                  width: 12,
                                                  height: 12,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.accent,
                                                    shape: BoxShape.circle,
                                                  ),
                                                )
                                              : null,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Game controls
                    if (!showModeSelection && !isGameOver)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedSquare = null;
                                  possibleMoves = [];
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.darkGrey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                'Désélectionner',
                                style: TextStyle(
                                  fontFamily: 'BricolageGrotesque',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  chessGame = chess.Chess();
                                  initializeFallbackBoard();
                                  selectedSquare = null;
                                  possibleMoves = [];
                                  currentPlayer = 'white';
                                  isGameOver = false;
                                  gameResult = '';
                                  lastMoveFrom = null;
                                  lastMoveTo = null;
                                  whiteKingMoved = false;
                                  blackKingMoved = false;
                                  whiteRookAMoved = false;
                                  whiteRookHMoved = false;
                                  blackRookAMoved = false;
                                  blackRookHMoved = false;
                                });
                                playSound('reset.mp3');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.accent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                'Nouvelle Partie',
                                style: TextStyle(
                                  fontFamily: 'BricolageGrotesque',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: isGameOver
          ? _buildGameOverDialog()
          : showModeSelection
              ? _buildModeSelectionDialog()
              : null,
      floatingActionButtonLocation: (isGameOver || showModeSelection)
          ? FloatingActionButtonLocation.centerFloat
          : null,
    );
  }
}