import 'package:flutter/material.dart';
import 'package:hand_game/core/utils/theme/app_theme.dart';
import '../../../core/utils/constants/assets.dart';
import '../../../core/utils/responsive_util.dart';
import '../providers/game_provider.dart';

class HandGestureDisplay extends StatelessWidget {
  final GameProvider gameProvider;

  const HandGestureDisplay({
    super.key,
    required this.gameProvider,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveUtil.isMobileScreen(context);
    final bool showHands =
        gameProvider.userChoice != 0 || gameProvider.botChoice != 0;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: showHands ? 1.0 : 0.0,
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppTheme.darkBackgroundColor.withOpacity(0.4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: isMobile ? 10 : 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Player's hand

            gameProvider.userChoice != 0
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.14159),
                    child: Image.asset(
                      Assets.getHandNumberAsset(gameProvider.userChoice),
                      width: isMobile ? 100 : 100,
                      height: isMobile ? 100 : 95,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Center(
                    child: Text(
                      '?',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),

            // VS T ext

            Text(
              'VS',
              style: TextStyle(
                color: Colors.orange,
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Bot's hand

            gameProvider.botChoice != 0
                ? Image.asset(
                    Assets.getHandNumberAsset(gameProvider.botChoice),
                    width: isMobile ? 100 : 100,
                    height: isMobile ? 100 : 95,
                    fit: BoxFit.cover,
                  )
                : const Center(
                    child: Text(
                      '?',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
