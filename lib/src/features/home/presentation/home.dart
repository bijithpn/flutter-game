import 'package:flutter/material.dart';
import 'package:flutter_games/src/core/utils/constants/app_constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Map<String, String>> homeTileData = [
    {"title": "Sudoku", "image": AppImages.sudoku},
    {"title": "Takuzu", "image": AppImages.takuzu},
    {"title": "Set", "image": AppImages.set},
    {"title": "Math", "image": AppImages.mathExpressions},
    {"title": "Schulte", "image": AppImages.schulte},
    {"title": "Minesweeper", "image": AppImages.minesweeper},
    {"title": "Wordsearch", "image": AppImages.wordsearch},
    {"title": "Anagram", "image": AppImages.anagram},
    {"title": "Countries", "image": AppImages.guessCountry},
    {"title": "Camp", "image": AppImages.camp},
    {"title": "Kuromasu", "image": AppImages.kuromasu},
    {"title": "Memory", "image": AppImages.memory},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Home",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.builder(
        itemCount: homeTileData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 25,
            mainAxisSpacing: 25,
            childAspectRatio: 1.1,
            crossAxisCount: 2),
        itemBuilder: (_, i) {
          Map<String, String> homeData = homeTileData[i];
          return GridTile(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade400,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    fit: BoxFit.cover,
                    homeData['image']!,
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(height: 10),
                  Text(homeData['title']!),
                  SizedBox(height: 5),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
