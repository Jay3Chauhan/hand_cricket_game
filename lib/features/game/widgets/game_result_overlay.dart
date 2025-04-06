import 'package:flutter/material.dart';
import '../../../core/utils/constants/assets.dart';
import '../../../core/utils/responsive_util.dart';
import '../models/enums.dart';
import '../providers/game_provider.dart';

class GameResultOverlay extends StatefulWidget {
  final GameProvider gameProvider;

  const GameResultOverlay({
    super.key,
    required this.gameProvider,
  });

  @override
  State<GameResultOverlay> createState() => _GameResultOverlayState();
}

class _GameResultOverlayState extends State<GameResultOverlay> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    // If it's just an out (not game over), auto-dismiss after delay
    if (widget.gameProvider.gamePhase != GamePhase.gameOver) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          setState(() => _visible = false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.gameProvider.gamePhase != GamePhase.gameOver && 
        !widget.gameProvider.isUserOut && 
        !widget.gameProvider.isBotOut) {
      return const SizedBox.shrink();
    }

    final bool isMobile = ResponsiveUtil.isMobileScreen(context);
    final bool isGameOver = widget.gameProvider.gamePhase == GamePhase.gameOver;
    final bool userWon = widget.gameProvider.winner == Player.user;
    
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: _visible ? 1.0 : 0.0,
      onEnd: () {
        // When fade out animation ends and this is not game over,
        // make sure overlay is completely gone
        if (!_visible && !isGameOver) {
          setState(() {}); // Trigger rebuild to remove overlay
        }
      },
      child: Visibility(
        visible: _visible,
        child: GestureDetector(
          onTap: isGameOver ? null : () {
            // Allow tapping to dismiss if it's not game over
            setState(() => _visible = false);
          },
          child: Container(
            color: Colors.black.withOpacity(0.85),
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 500),
                tween: Tween<double>(begin: 0.8, end: 1.0),
                builder: (context, double value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Result Image
                    Image.asset(
                      isGameOver ? (userWon ? Assets.youWon : Assets.out) : Assets.out,
                      width: isMobile ? 180 : 250,
                      height: isMobile ? 180 : 250,
                    ),
                    const SizedBox(height: 30),
                    // Result Message
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 20 : 40,
                        vertical: isMobile ? 15 : 20,
                      ),
                      decoration: BoxDecoration(
                        color: userWon ? Colors.green.withOpacity(0.8) : Colors.red.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Text(
                        widget.gameProvider.resultMessage,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isMobile ? 20 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Play Again Button (only show in game over state)
                    if (isGameOver)
                      ElevatedButton(
                        onPressed: () => widget.gameProvider.startNewGame(),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 30 : 40,
                            vertical: isMobile ? 15 : 20,
                          ),
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Play Again',
                          style: TextStyle(
                            fontSize: isMobile ? 18 : 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    if (!isGameOver)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Tap anywhere to continue',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: isMobile ? 14 : 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}