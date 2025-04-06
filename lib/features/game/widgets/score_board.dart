import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants/assets.dart';
import '../providers/game_provider.dart';
import '../models/enums.dart';
import '../../../core/utils/theme/app_theme.dart';
import '../../../core/utils/responsive_util.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        if (gameProvider.gamePhase == GamePhase.notStarted) {
          return SizedBox(
            height: ResponsiveUtil.getResponsiveValue(
              context: context,
              defaultValue: 80,
              mobileValue: 60,
            ),
          );
        }

        final bool isMobile = ResponsiveUtil.isMobileScreen(context);

        return Container(
          margin: EdgeInsets.all(isMobile ? 4.0 : 10.0),
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 8.0 : 10.0,
            horizontal: isMobile ? 12.0 : 20.0,
          ),
          decoration: BoxDecoration(
            color: AppTheme.darkBackgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildScoreDisplay(
                context: context,
                label: 'Your Score',
                score: gameProvider.userScore,
                isActive: gameProvider.gamePhase == GamePhase.userBatting,
                icon: 'assets/images/batting.png',
              ),
              _buildScoreDisplay(
                context: context,
                label: 'Bot Score',
                score: gameProvider.botScore,
                isActive: gameProvider.gamePhase == GamePhase.botBatting,
                icon: 'assets/images/ball.png',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScoreDisplay({
    required BuildContext context,
    required String label,
    required int score,
    required bool isActive,
    required String icon,
  }) {
    final bool isMobile = ResponsiveUtil.isMobileScreen(context);

    return Column(
      children: [
        Row(
          children: [
            if (isActive)
              Image.asset(
                icon,
                width: isMobile ? 20 : 24,
                height: isMobile ? 20 : 24,
              ),
            SizedBox(width: isMobile ? 3 : 5),
            Text(
              label,
              style: TextStyle(
                fontSize: isMobile ? 12 : 14,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.orange : Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: isMobile ? 2 : 4),
        Text(
          score.toString(),
          style: TextStyle(
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.orange : Colors.white,
          ),
        ),
      ],
    );
  }
}
