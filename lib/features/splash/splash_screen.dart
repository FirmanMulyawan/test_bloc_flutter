import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/config/app_const.dart';
import '../../component/config/app_route.dart';
import '../../component/config/app_style.dart';
import '../../component/widget/background_image.dart';
import 'splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().startProgress();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, double>(
      listenWhen: (prev, curr) => curr == 1.0,
      listener: (context, state) async {
        await Future.delayed(const Duration(milliseconds: 600));
        if (!context.mounted) return;
        context.goNamed(AppRoute.login);
      },
      child: BackgroundImage(
        image: AssetImage(
          AppConst.bgSplash,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Spacer(),
                    const SizedBox(
                      height: 37,
                    ),
                    BlocBuilder<SplashCubit, double>(
                      builder: (context, progress) {
                        return Container(
                          width: 215,
                          decoration: BoxDecoration(
                            color: AppStyle.whiteColor,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 215 * progress,
                                height: 22,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppStyle.progressBarTopBlue,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppStyle.progressBarBottomBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 236,
                      child: Image.asset(AppConst.kidsIcon),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
