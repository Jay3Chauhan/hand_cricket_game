import 'package:flutter/material.dart';
import '../../../core/utils/constants/assets.dart';
import '../providers/game_provider.dart';
import '../../../core/utils/theme/app_theme.dart';
import '../../../core/utils/responsive_util.dart';
import '../models/enums.dart';

class GameHeader extends StatelessWidget {
  final GameProvider gameProvider;

  const GameHeader({
    super.key,
    required this.gameProvider,
  });

  @override
  Widget build(BuildContext context) {
    const int totalBalls = 6;
    final bool isMobile = ResponsiveUtil.isMobileScreen(context);

    return Container(
      margin: EdgeInsets.all(isMobile ? 4.0 : 10.0),
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 8.0 : 10.0,
        horizontal: isMobile ? 12.0 : 20.0,
      ),
      decoration: BoxDecoration(
        color: AppTheme.darkBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Player Section
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Player',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 14.0 : 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                // Show runs or balls depending on game phase
                SizedBox(
                  height: 20,
                  child: Row(
                    children: List.generate(
                      totalBalls,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 1.0 : 2.0),
                        child: gameProvider.gamePhase == GamePhase.userBatting
                            ? _buildRunIndicator(index, gameProvider, isMobile)
                            : _buildBallIndicator(
                                index, gameProvider, isMobile),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Center Section (To Win)
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  'To win: ${gameProvider.getTargetScore()}',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: isMobile ? 14.0 : 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Right Player Section
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Bot',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 14.0 : 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                // Show runs or balls depending on game phase
                SizedBox(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: List.generate(
                      totalBalls,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 1.0 : 2.0),
                        child: gameProvider.gamePhase == GamePhase.botBatting
                            ? _buildRunIndicator(index, gameProvider, isMobile)
                            : _buildBallIndicator(
                                index, gameProvider, isMobile),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build ball indicator
  Widget _buildBallIndicator(
      int index, GameProvider gameProvider, bool isMobile) {
    if (index < gameProvider.ballsPlayed) {
      return Image.asset(
       Assets.ball,
        width: isMobile ? 16.0 : 20.0,
        height: isMobile ? 16.0 : 20.0,
      );
    } else {
      return Container(
        width: isMobile ? 16.0 : 20.0,
        height: isMobile ? 16.0 : 20.0,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
      );
    }
  }

  // Helper method to build run indicator
  Widget _buildRunIndicator(
      int index, GameProvider gameProvider, bool isMobile) {
    if (index < gameProvider.ballsPlayed) {
      return Container(
        width: isMobile ? 16.0 : 20.0,
        height: isMobile ? 16.0 : 20.0,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            gameProvider.getRunForBall(index).toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 10.0 : 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      return Image.asset(
         Assets.ball,
        width: isMobile ? 16.0 : 20.0,
        height: isMobile ? 16.0 : 20.0,
        color: Colors.grey,
      );
    }
  }
}
