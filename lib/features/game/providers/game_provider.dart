import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/enums.dart';

class GameProvider extends ChangeNotifier {
  // Game state variables
  int userScore = 0;
  int botScore = 0;
  int userChoice = 0;
  int botChoice = 0;
  int ballsPlayed = 0;
  bool isUserOut = false;
  bool isBotOut = false;
  GamePhase gamePhase = GamePhase.notStarted;
  String resultMessage = '';
  Player? winner;

  // Timer related variables
  int timeLeft = 10;
  Timer? _timer;
  bool get isTimerActive => _timer != null && _timer!.isActive;

  // Random number generator for bot
  final Random _random = Random();

  // New property to track runs per ball
  List<int> runsPerBall = [];

  // Start a new game
  void startNewGame() {
    userScore = 0;
    botScore = 0;
    userChoice = 0;
    botChoice = 0;
    ballsPlayed = 0;
    isUserOut = false;
    isBotOut = false;
    gamePhase = GamePhase.userBatting;
    resultMessage = 'You are batting now!';
    winner = null;
    runsPerBall = [];

    startTimer();
    notifyListeners();
  }

  // Start timer for user's turn
  void startTimer() {
    timeLeft = 10;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        timeLeft--;
        notifyListeners();
      } else {
        timeOut();
      }
    });
  }

  // Handle time out
  void timeOut() {
    _timer?.cancel();
    if (gamePhase == GamePhase.userBatting) {
      isUserOut = true;
      resultMessage = 'Time out! You are out!';
      switchToBotBatting();
    } else if (gamePhase == GamePhase.botBatting) {
      endGame();
    }
  }

  // User makes a choice (1-6)
  void makeUserChoice(int choice) {
    if (choice < 1 || choice > 6) return;

    userChoice = choice;

    if (gamePhase == GamePhase.userBatting) {
      playUserBattingTurn();
    } else if (gamePhase == GamePhase.botBatting) {
      playBotBattingTurn();
    }
  }

  // Play a turn when user is batting
  void playUserBattingTurn() {
    // Generate bot's bowling choice
    botChoice = _random.nextInt(6) + 1;
    ballsPlayed++;

    // Check if user is out
    if (userChoice == botChoice) {
      isUserOut = true;
      resultMessage = 'You are out! Bot chose $botChoice.';
      switchToBotBatting();
    } else {
      // Add run to the list
      runsPerBall.add(userChoice);
      // Add runs to user's score
      userScore += userChoice;
      resultMessage = 'You scored $userChoice runs! Bot chose $botChoice.';

      // Check if maximum balls reached
      if (ballsPlayed >= 6) {
        switchToBotBatting();
      } else {
        startTimer();
      }
    }

    notifyListeners();
  }

  // Switch to bot's batting turn
  void switchToBotBatting() {
    _timer?.cancel();
    ballsPlayed = 0;
    gamePhase = GamePhase.botBatting;
    resultMessage = 'Bot is batting now!';
    runsPerBall = [];
    notifyListeners();

    // Give a short delay before bot starts batting
    Future.delayed(const Duration(seconds: 2), () {
      startTimer();
      notifyListeners();
    });
  }

  // Play a turn when bot is batting
  void playBotBattingTurn() {
    // Generate bot's batting choice
    botChoice = _random.nextInt(6) + 1;
    ballsPlayed++;

    // Check if bot is out
    if (userChoice == botChoice) {
      isBotOut = true;
      resultMessage = 'Bot is out! Bot chose $botChoice.';
      endGame();
    } else {
      // Add bot's run to the list
      runsPerBall.add(botChoice);
      // Add runs to bot's score
      botScore += botChoice;
      resultMessage = 'Bot scored $botChoice runs! You chose $userChoice.';

      // Check if bot has won
      if (botScore > userScore) {
        endGame();
      } else if (ballsPlayed >= 6) {
        endGame();
      } else {
        startTimer();
      }
    }

    notifyListeners();
  }

  // Get run for a specific ball
  int getRunForBall(int ballIndex) {
    if (ballIndex < runsPerBall.length) {
      return runsPerBall[ballIndex];
    }
    return 0;
  }

  // Calculate target score
  int getTargetScore() {
    if (gamePhase == GamePhase.botBatting) {
      return userScore + 1;
    }
    return 0;
  }

  // End the game and determine the winner
  void endGame() {
    _timer?.cancel();
    gamePhase = GamePhase.gameOver;

    if (botScore > userScore) {
      winner = Player.bot;
      resultMessage = 'Game Over! Bot wins by ${botScore - userScore} runs!';
    } else if (userScore > botScore) {
      winner = Player.user;
      resultMessage = 'Game Over! You win by ${userScore - botScore} runs!';
    } else {
      resultMessage = 'Game Over! It\'s a tie!';
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
