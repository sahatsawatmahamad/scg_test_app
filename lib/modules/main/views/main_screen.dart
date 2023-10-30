import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scg_test_app/modules/home/views/home_screen.dart';
import 'package:scg_test_app/modules/search/bloc/search_bloc.dart';
import 'package:scg_test_app/modules/search/views/search_screen.dart';
import 'package:scg_test_app/utils/screen_wrapper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        appBar: AppBar(
          title: const Text('News'),
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(
                      onChange: (keyword) => Modular.get<SearchBloc>().add(
                        GetSearchNews(keyword: keyword),
                      ),
                    ),
                  ),
                );
              },
              child: const Icon(Icons.search),
            ),
            const SizedBox(
              width: 16,
            )
          ],
        ),
        child: const HomeScreen());
  }
}
