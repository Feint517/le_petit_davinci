import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:le_petit_davinci/features/levels/models/letter_path_data.dart';
import 'package:le_petit_davinci/features/levels/services/tracing_validation_service.dart';
import 'package:le_petit_davinci/services/tracing_sound_service.dart';

class LetterTracingCanvas extends StatefulWidget {
  const LetterTracingCanvas({
    super.key,
    required this.letter,
    required this.onTracingCompleted,
  });

  final String letter;
  final VoidCallback onTracingCompleted;

  @override
  State<LetterTracingCanvas> createState() => _LetterTracingCanvasState();
}

class _LetterTracingCanvasState extends State<LetterTracingCanvas>
    with TickerProviderStateMixin {
  late LetterPathData _letterPathData;
  late List<Offset> _currentStroke;
  late List<List<Offset>> _allStrokes;
  late AnimationController _successController;
  late AnimationController _glowController;
  late AnimationController _feedbackController;
  late Animation<double> _glowAnimation;
  late Animation<double> _feedbackAnimation;
  
  bool _isTracing = false;
  bool _isCompleted = false;
  bool _isInitialized = false;
  double _accuracy = 0.0;
  TracingResult? _currentResult;
  RealTimeFeedback? _realTimeFeedback;
  final double _tolerance = 25.0;

  @override
  void initState() {
    super.initState();
    _initializeLetterPath();
    _currentStroke = [];
    _allStrokes = [];
    
    _successController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _feedbackController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));
    
    _feedbackAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _feedbackController,
      curve: Curves.easeOut,
    ));
  }

  void _initializeLetterPath() {
    // We'll initialize the path data when we have the canvas size
  }

  void _initializeLetterPathData(Size canvasSize) {
    final letter = widget.letter.isNotEmpty ? widget.letter : 'A';
    _letterPathData = LetterPathFactory.createLetterPath(letter, canvasSize);
  }


  @override
  void dispose() {
    _successController.dispose();
    _glowController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  void _resetTracing() {
    setState(() {
      _currentStroke.clear();
      _allStrokes.clear();
      _isCompleted = false;
      _accuracy = 0.0;
      _isTracing = false;
      _currentResult = null;
      _realTimeFeedback = null;
    });
    _successController.reset();
    _glowController.reset();
    _feedbackController.reset();
  }

  void _validateCurrentStroke() {
    if (_currentStroke.isEmpty) return;

    final result = TracingValidationService.validateStroke(
      _currentStroke,
      _letterPathData,
      customTolerance: _tolerance,
    );

    setState(() {
      _currentResult = result;
      _accuracy = result.accuracy;
    });

    // Provide haptic feedback based on accuracy
    if (result.accuracy >= 0.8) {
      HapticFeedback.lightImpact();
    } else if (result.accuracy < 0.4) {
      HapticFeedback.heavyImpact();
    }

    // Check if tracing is complete
    if (result.accuracy >= TracingValidationService.completionThreshold && !_isCompleted) {
      _completeTracing();
    }
  }

  void _updateRealTimeFeedback(Offset point) {
    final feedback = TracingValidationService.getRealTimeFeedback(
      point,
      _letterPathData,
      _currentStroke,
    );

    setState(() {
      _realTimeFeedback = feedback;
    });

    // Animate feedback
    _feedbackController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        _feedbackController.reverse();
      });
    });
  }

  void _completeTracing() {
    setState(() {
      _isCompleted = true;
    });

    // Provide haptic feedback
    HapticFeedback.mediumImpact();

    // Play completion sound
    TracingSoundService.playCompletionSound();

    // Start success animations
    _successController.forward();
    _glowController.repeat(reverse: true);

    // Call completion callback after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      widget.onTracingCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final canvasSize = Size(constraints.maxWidth, constraints.maxHeight);
        
        // Initialize letter path data when we have the canvas size
        if (!_isInitialized) {
          _initializeLetterPathData(canvasSize);
          _isInitialized = true;
        }

        return Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.pink.shade50,
                Colors.purple.shade50,
                Colors.blue.shade50,
              ],
            ),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(17.r),
            child: Stack(
              children: [
                // Main tracing canvas
                GestureDetector(
                  onPanStart: (details) {
                    setState(() {
                      _isTracing = true;
                      _currentStroke.clear();
                    });
                    // Play tracing start sound
                    TracingSoundService.playTracingStartSound();
                  },
                  onPanUpdate: (details) {
                    if (_isTracing && !_isCompleted) {
                      setState(() {
                        _currentStroke.add(details.localPosition);
                      });
                      _updateRealTimeFeedback(details.localPosition);
                      _validateCurrentStroke();
                    }
                  },
                  onPanEnd: (details) {
                    if (_isTracing) {
                      setState(() {
                        _isTracing = false;
                        _allStrokes.add(List.from(_currentStroke));
                      });
                    }
                  },
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: ImprovedLetterTracingPainter(
                      letterPathData: _letterPathData,
                      currentStroke: _currentStroke,
                      allStrokes: _allStrokes,
                      currentResult: _currentResult,
                      isCompleted: _isCompleted,
                      glowAnimation: _glowAnimation,
                      realTimeFeedback: _realTimeFeedback,
                      feedbackAnimation: _feedbackAnimation,
                    ),
                  ),
                ),
              
                // Success overlay
                if (_isCompleted)
                  AnimatedBuilder(
                    animation: _successController,
                    builder: (context, child) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment.center,
                            radius: _successController.value * 2,
                            colors: [
                              Colors.yellow.withValues(alpha: 0.3 * _successController.value),
                              Colors.orange.withValues(alpha: 0.2 * _successController.value),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                
                // Real-time feedback overlay
                if (_realTimeFeedback != null)
                  AnimatedBuilder(
                    animation: _feedbackAnimation,
                    builder: (context, child) {
                      return Positioned(
                        top: 100.h,
                        left: 20.w,
                        right: 20.w,
                        child: Opacity(
                          opacity: _feedbackAnimation.value,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: _realTimeFeedback!.color.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              _realTimeFeedback!.message,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                
                // Control buttons
                Positioned(
                  bottom: 20.h,
                  left: 20.w,
                  right: 20.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildControlButton(
                        icon: Icons.refresh,
                        onPressed: () {
                          TracingSoundService.playButtonClickSound();
                          _resetTracing();
                        },
                        color: Colors.orange,
                      ),
                      _buildControlButton(
                        icon: Icons.arrow_back,
                        onPressed: () {
                          // Previous letter functionality
                        },
                        color: Colors.blue,
                      ),
                      _buildControlButton(
                        icon: Icons.arrow_forward,
                        onPressed: () {
                          // Next letter functionality
                        },
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
                
                // Progress indicator
                Positioned(
                  top: 20.h,
                  left: 20.w,
                  right: 20.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Lettre ${widget.letter}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple.shade700,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${(_accuracy * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: _accuracy >= 0.8 ? Colors.green : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25.r),
          onTap: onPressed,
          child: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24.sp,
            ),
          ),
        ),
      ),
    );
  }
}

class ImprovedLetterTracingPainter extends CustomPainter {
  ImprovedLetterTracingPainter({
    required this.letterPathData,
    required this.currentStroke,
    required this.allStrokes,
    required this.currentResult,
    required this.isCompleted,
    required this.glowAnimation,
    required this.realTimeFeedback,
    required this.feedbackAnimation,
  });

  final LetterPathData letterPathData;
  final List<Offset> currentStroke;
  final List<List<Offset>> allStrokes;
  final TracingResult? currentResult;
  final bool isCompleted;
  final Animation<double> glowAnimation;
  final RealTimeFeedback? realTimeFeedback;
  final Animation<double> feedbackAnimation;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw letter outline (dotted path)
    _drawLetterOutline(canvas, size);
    
    // Draw all completed strokes
    _drawCompletedStrokes(canvas);
    
    // Draw current stroke
    _drawCurrentStroke(canvas);
    
    // Draw glow effect when completed
    if (isCompleted) {
      _drawGlowEffect(canvas, size);
    }
    
    // Draw real-time feedback indicator
    if (realTimeFeedback != null) {
      _drawFeedbackIndicator(canvas, size);
    }
  }

  void _drawLetterOutline(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw the letter path with dotted lines
    final path = letterPathData.path;
    final pathMetrics = path.computeMetrics();
    
    for (final metric in pathMetrics) {
      final dashLength = 15.0;
      final gapLength = 10.0;
      
      for (double d = 0; d < metric.length; d += dashLength + gapLength) {
        final start = metric.getTangentForOffset(d)?.position;
        final end = metric.getTangentForOffset(math.min(d + dashLength, metric.length))?.position;
        
        if (start != null && end != null) {
          canvas.drawLine(start, end, paint);
        }
      }
    }
  }

  void _drawCompletedStrokes(Canvas canvas) {
    for (final stroke in allStrokes) {
      if (stroke.length < 2) continue;
      
      final paint = Paint()
        ..strokeWidth = 12
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..color = Colors.blue; // Default color for completed strokes
      
      for (int i = 0; i < stroke.length - 1; i++) {
        canvas.drawLine(stroke[i], stroke[i + 1], paint);
      }
    }
  }

  void _drawCurrentStroke(Canvas canvas) {
    if (currentStroke.length < 2) return;

    final paint = Paint()
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Color based on current accuracy
    if (currentResult != null) {
      if (currentResult!.accuracy >= 0.8) {
        paint.color = Colors.green;
      } else if (currentResult!.accuracy >= 0.5) {
        paint.color = Colors.orange;
      } else {
        paint.color = Colors.red;
      }
    } else {
      paint.color = Colors.blue;
    }

    for (int i = 0; i < currentStroke.length - 1; i++) {
      canvas.drawLine(currentStroke[i], currentStroke[i + 1], paint);
    }
  }

  void _drawGlowEffect(Canvas canvas, Size size) {
    final glowPaint = Paint()
      ..color = Colors.yellow.withValues(alpha: 0.3 * glowAnimation.value)
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final path = letterPathData.path;
    final pathMetrics = path.computeMetrics();
    
    for (final metric in pathMetrics) {
      for (double d = 0; d < metric.length; d += 2) {
        final tangent = metric.getTangentForOffset(d);
        if (tangent != null) {
          final nextTangent = metric.getTangentForOffset(math.min(d + 2, metric.length));
          if (nextTangent != null) {
            canvas.drawLine(tangent.position, nextTangent.position, glowPaint);
          }
        }
      }
    }
  }

  void _drawFeedbackIndicator(Canvas canvas, Size size) {
    if (realTimeFeedback == null) return;

    final paint = Paint()
      ..color = realTimeFeedback!.color.withValues(alpha: 0.3 * feedbackAnimation.value)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw a circle around the current point
    if (currentStroke.isNotEmpty) {
      final currentPoint = currentStroke.last;
      canvas.drawCircle(currentPoint, 20 * feedbackAnimation.value, paint);
    }
  }

  @override
  bool shouldRepaint(ImprovedLetterTracingPainter oldDelegate) {
    return oldDelegate.currentStroke != currentStroke ||
           oldDelegate.allStrokes != allStrokes ||
           oldDelegate.currentResult != currentResult ||
           oldDelegate.isCompleted != isCompleted ||
           oldDelegate.glowAnimation != glowAnimation ||
           oldDelegate.realTimeFeedback != realTimeFeedback ||
           oldDelegate.feedbackAnimation != feedbackAnimation;
  }
}
