import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../../../core/utils/responsive_util.dart';

class TimerIndicator extends StatelessWidget {
  const TimerIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        final progress = gameProvider.timeLeft / 10;
        final isLowTime = gameProvider.timeLeft <= 3;
        final bool isMobile = ResponsiveUtil.isMobileScreen(context);

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 32,
            vertical: isMobile ? 6 : 8,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.timer,
                    color: isLowTime ? Colors.red : Colors.white,
                    size: isMobile ? 18 : 20,
                  ),
                  SizedBox(width: isMobile ? 6 : 8),
                  Text(
                    '${gameProvider.timeLeft} seconds left',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      color: isLowTime ? Colors.red : Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 6 : 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: isMobile ? 6 : 8,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isLowTime ? Colors.red : Colors.orange,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
