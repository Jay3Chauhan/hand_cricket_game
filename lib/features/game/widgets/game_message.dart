import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants/assets.dart';
import '../providers/game_provider.dart';
import '../models/enums.dart';
import '../../../core/utils/responsive_util.dart';

class GameMessage extends StatelessWidget {
  const GameMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        if (gameProvider.gamePhase == GamePhase.notStarted) {
          return const SizedBox.shrink();
        }

        String? imageAsset = _getMessageImage(gameProvider.resultMessage);
        final bool isMobile = ResponsiveUtil.isMobileScreen(context);

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 12 : 16,
            horizontal: isMobile ? 16 : 24,
          ),
          margin: EdgeInsets.only(
            top: isMobile ? 4 : 8,
            bottom: isMobile ? 8 : 16,
          ),
          child: Column(
            children: [
              // if (imageAsset != null)
              //   Image.asset(
              //     imageAsset,
              //     width: isMobile ? 50 : 60,
              //     height: isMobile ? 50 : 60,
              //   ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  gameProvider.resultMessage,
                  key: ValueKey(gameProvider.resultMessage),
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Determine which image to show based on the message content
  String? _getMessageImage(String message) {
    if (message.contains('out')) {
      return Assets.out;
    } else if (message.contains('scored 1')) {
      return Assets.one;
    } else if (message.contains('scored 2')) {
      return Assets.two;
    } else if (message.contains('scored 3')) {
      return Assets.three;
    } else if (message.contains('scored 4')) {
      return Assets.four;
    } else if (message.contains('scored 5')) {
      return Assets.five;
    } else if (message.contains('scored 6')) {
      return Assets.sixer;
    }
    return null;
  }
}
