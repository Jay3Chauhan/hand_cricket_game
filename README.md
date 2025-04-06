# Hand Cricket Game

A fun and interactive hand cricket game built with Flutter, where you can play against an AI bot. This mobile-responsive game brings the classic playground game to your device with modern UI and smooth animations.

## Features

- 🏏 Interactive batting and bowling gameplay
- 🤖 Play against an AI bot
- ⏱️ Time-based turns (10 seconds per move)
- 📊 Real-time score tracking
- 🎯 Target score calculation
- 📱 Responsive design for both mobile and desktop
- 🎮 Intuitive hand gesture controls
- 🎨 Beautiful UI with animations
- 🏆 End-game results and statistics

## How to Play

1. **Start the Game**: Press the "Start Game" button to begin
2. **Batting Phase**:
   - Choose a number between 1-6 by tapping/clicking the hand gesture buttons
   - If your number matches the bot's number, you're out!
   - Score runs based on your chosen number if it doesn't match
   - Play continues until you're out or complete 6 balls

3. **Bowling Phase**:
   - Choose a number to bowl against the bot
   - If the bot's number matches yours, they're out!
   - Bot scores runs based on their number if it doesn't match
   - Game ends when bot is out or surpasses your score

4. **Winning**:
   - Score more runs than the bot to win
   - Get the bot out before they chase your target
   - Watch for the timer - you have 10 seconds per move!

## Technical Details

### Built With
- Flutter SDK
- Provider for state management
- Custom animations and transitions
- Responsive design utilities

### Project Structure
```
lib/
├── core/
│   ├── utils/
│      ├── constants/
│      ├── theme/
│      └── responsive_util.dart
│   
├── features/
│   └── game/
│       ├── models/
│       ├── providers/
│       ├── screens/
│       └── widgets/
└── main.dart
```

## Getting Started

1. **Prerequisites**:
   - Flutter SDK (3.29.0)
   - Dart SDK  3.7.0 (stable)
   - Android Studio / VS Code with Flutter extensions

2. **Installation**:
   ```bash
   # Clone the repository
   git clone [repository-url]

   # Navigate to project directory
   cd hand_game

   # Install dependencies
   flutter pub get

   # Run the app
   flutter run
   ```
## Release APK
https://drive.google.com/file/d/15MmcFmqzQPBwSGZTTPrRbE-zEG0JeCoM/view?usp=sharing
