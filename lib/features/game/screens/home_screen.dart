import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants/assets.dart';
import '../providers/game_provider.dart';
import '../models/enums.dart';
import '../widgets/game_header.dart';
import '../widgets/score_board.dart';
import '../widgets/game_message.dart';
import '../widgets/timer_indicator.dart';
import '../widgets/hand_gesture_button.dart';
import '../widgets/hand_gesture_display.dart';
import '../widgets/game_result_overlay.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              Assets.background,
              fit: BoxFit.cover,
            ),
          ),
          Consumer<GameProvider>(
            builder: (context, gameProvider, child) {
              return SafeArea(
                child: Column(
                  children: [
                    // Game header with balls indicator
                    GameHeader(gameProvider: gameProvider),

                    const SizedBox(height: 10),

                    // Score Board
                    const ScoreBoard(),

                    // Timer
                    if (gameProvider.gamePhase == GamePhase.userBatting ||
                        gameProvider.gamePhase == GamePhase.botBatting)
                      const TimerIndicator(),

                    // Game Message
                    const GameMessage(),

                    // Hand Gesture Display (new)
                    if (gameProvider.gamePhase == GamePhase.userBatting ||
                        gameProvider.gamePhase == GamePhase.botBatting)
                      HandGestureDisplay(gameProvider: gameProvider),

                    // Game Area
                    Expanded(
                      child: Center(
                        child: _buildGameArea(context, gameProvider),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Result Overlay
          Consumer<GameProvider>(
            builder: (context, gameProvider, _) => GameResultOverlay(
              gameProvider: gameProvider,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameArea(BuildContext context, GameProvider gameProvider) {
    switch (gameProvider.gamePhase) {
      case GamePhase.notStarted:
        return _buildStartGameButton(context);

      case GamePhase.userBatting:
        return _buildGameControls(
            context, Assets.batting, 'You are batting! Choose a number');

      case GamePhase.botBatting:
        return _buildGameControls(
            context, Assets.ball, 'You are bowling! Choose a number');

      case GamePhase.gameOver:
        return _buildGameOverScreen(context, gameProvider);
    }
  }

  Widget _buildStartGameButton(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image.asset(
        //   Assets.gameDefend,
        //   width: 200,
        //   height: 200,
        // ),
        // const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            Provider.of<GameProvider>(context, listen: false).startNewGame();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          ),
          child: const Text(
            'Start Game',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGameControls(
      BuildContext context, String imagePath, String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 10),
        Text(
          message,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        _buildNumberButtons(),
      ],
    );
  }

  Widget _buildNumberButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // First row (1, 2, 3)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: HandGestureButton(
                number: index + 1,
              ),
            ),
          ),
        ),
        // Second row (4, 5, 6)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: HandGestureButton(
                number: index + 4,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGameOverScreen(BuildContext context, GameProvider gameProvider) {
    final bool userWon = gameProvider.winner == Player.user;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          userWon ? Assets.youWon : Assets.out,
          width: 200,
          height: 200,
        ),
        const SizedBox(height: 10),
        Text(
          gameProvider.resultMessage,
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Provider.of<GameProvider>(context, listen: false).startNewGame();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: const Text(
            'Play Again',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
