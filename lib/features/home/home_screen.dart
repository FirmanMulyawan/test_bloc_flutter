import 'package:flutter/material.dart';

import '../../component/config/app_const.dart';
import '../../component/widget/background_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      image: AssetImage(AppConst.bgImage),
    );
  }
}
