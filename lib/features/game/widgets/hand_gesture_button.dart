import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants/assets.dart';
import '../providers/game_provider.dart';

class HandGestureButton extends StatefulWidget {
  final int number;

  const HandGestureButton({
    super.key,
    required this.number,
  });

  @override
  State<HandGestureButton> createState() => _HandGestureButtonState();
}

class _HandGestureButtonState extends State<HandGestureButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        final bool isSelected =
            gameProvider.userChoice == widget.number && gameProvider.isTimerActive;

        return GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          onTap: () {
            if (gameProvider.isTimerActive) {
              gameProvider.makeUserChoice(widget.number);
            }
          },
          child: Transform.scale(
            scale: _isPressed ? 0.95 : 1.0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 80,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isSelected ? Colors.orange : Colors.white.withOpacity(0.9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  Assets.getNumberAsset(widget.number),
                  width: 80,
                  height: 80,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
