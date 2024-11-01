# 🎮Flutter Games

`flutter_game` is a Flutter application that utilizes APIs from the [Shadify](https://github.com/cheatsnake/shadify) project to provide a rich gaming experience. This app leverages the backend APIs to interact with various game modules and offer gameplay functionalities.

## Project Overview

This project is designed to offer seamless access to different game functionalities through a user-friendly interface. The APIs provided by the Shadify project are crucial for the app's operation, enabling features such as game logic, scoring, and data management.

## Available Games

The following games are available within the app and their API documentation:

- [Sudoku](./backend/docs/modules/sudoku.md)
- [Takuzu](./backend/docs/modules/takuzu.md)
- [Set](./backend/docs/modules/set.md)
- [Math](./backend/docs/modules/math.md)
- [Schulte](./backend/docs/modules/schulte.md)
- [Minesweeper](./backend/docs/modules/minesweeper.md)
- [Wordsearch](./backend/docs/modules/wordsearch.md)
- [Anagram](./backend/docs/modules/anagram.md)
- [Countries](./backend/docs/modules/countries.md)
- [Camp](./backend/docs/modules/camp.md)
- [Kuromasu](./backend/docs/modules/kuromasu.md)
- [Memory](./backend/docs/modules/memory.md)

## Backend Setup

For detailed instructions on setting up the backend using the Shadify project, please refer to the [`backend/readme.md`](./backend/README.md) file located in the backend directory of this repository. This document provides comprehensive steps for configuring the backend, which is built using Go, to work with the Flutter app.

## Features

- User-friendly interface for various games
- Integration with Shadify APIs for game functionalities
- Efficient data management and gameplay experience
- State management using BLoC pattern
- Networking implemented with Dio for API calls

## Installation

To get started with the `flutter_game` project, follow these steps:

### 1. Clone the repository:

```bash
git clone https://github.com/bijithpn/Flutter-Games.git
```

### 2. Navigate to the project directory:

```bash
cd flutter_game
```

### 3. Install the necessary dependencies:

```bash
flutter pub get
```

### 4. Set up the backend server for the APIs. For documentation, refer to the [`backend/readme.md`](./backend/README.md) file.

## Acknowledgments

Special thanks to the contributors and maintainers of the [Shadify](https://github.com/cheatsnake/shadify) project for providing the APIs that power this application. Their efforts have been instrumental in enabling the functionalities within the Flutter game.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! If you would like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature/YourFeatureName
   ```
3. Make your changes and commit them:
   ```bash
   git commit -m "Add your message here"
   ```
4. Push to the branch:
   ```bash
   git push origin feature/YourFeatureName
   ```
5. Open a pull request.

For further details and updates, feel free to check the documentation in the `backend` folder and explore the game's capabilities!
