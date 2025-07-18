import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;

import '../../component/config/app_const.dart';
import '../../component/config/app_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppStyle.pressedGreen,
            centerTitle: true,
            elevation: 0,
            title: Text(
              "List User",
              style: AppStyle.bold(size: 20, textColor: Colors.white),
            )),
        backgroundColor: AppStyle.whiteColor,
        body: Column(children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onTapOutside: (PointerDownEvent event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onChanged: (value) {
                // controller.updateKeyword();
              },
              style: AppStyle.regular(
                size: 20,
              ),
              decoration: InputDecoration(
                hintText: "Search Surah",
                hintStyle: AppStyle.regular(
                  size: 20,
                  textColor: AppStyle.searchHintColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: AppStyle.searchBorderColor,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: AppStyle.searchBorderColor,
                    width: 1.5,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppStyle.pressedGreen,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: RefreshIndicator(
            onRefresh: () {
              return Future.value();
            },
            child: Skeletonizer(
              enabled: false,
              child: ListView.separated(
                  itemCount: 10 + 1,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  separatorBuilder: (ctx, index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  itemBuilder: (ctx, index) {
                    if (index == 10) {
                      return const SizedBox(height: 200);
                    }
                    return _cardSurah(
                        isLoading: true,
                        email: 'firmanmulyawan491@gmail.com',
                        firstName: 'Firman',
                        lastName: 'Mulyawan',
                        urlImage: 'https://reqres.in/img/faces/1-image.jpg',
                        onTap: () {});
                  }),
            ),
          ))
        ]));
  }

  Widget _cardSurah({
    void Function()? onTap,
    String email = '',
    String firstName = '',
    String lastName = '',
    String urlImage = '',
    bool isLoading = false,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: svg_provider.Svg(
                  AppConst.assetTopicBackground,
                ),
                fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Opacity(
                  // opacity: enabled ? 1.0 : 0.4,
                  opacity: 1.0,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          urlImage,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                  color: AppStyle.homeArabicBlue,
                                  strokeWidth: 2),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error,
                                color: Colors.red, size: 30);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // arab and progress bar
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        firstName,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        lastName,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
