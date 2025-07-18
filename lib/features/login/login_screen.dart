import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran_app/component/config/app_route.dart';

import '../../component/config/app_const.dart';
import '../../component/config/app_style.dart';
import '../../component/widget/background_image.dart';
import '../../component/widget/popup_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        image: AssetImage(AppConst.bgImage),
        child: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          const SizedBox(
            height: 100,
          ),
          Container(
            margin: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: AppStyle.whiteColor,
            ),
            child: Column(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  height: 62,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: AppStyle.textFieldColor,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 62,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            color: Colors.transparent,
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'login',
                              style: AppStyle.bold(
                                textColor: AppStyle.whiteColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: _loginScreen(),
                ),
              ],
            ),
          ),
        ]))));
  }

  Widget _loginScreen() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'email',
              style: AppStyle.regular(
                size: 12,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              onTapOutside: (PointerDownEvent event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onChanged: (string) {},
              decoration: const InputDecoration(
                hintText: 'enterEmail',
                prefix: SizedBox(
                  width: 12,
                ),
              ),
              validator: (value) {
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'password',
              style: AppStyle.regular(
                size: 12,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              onTapOutside: (PointerDownEvent event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onChanged: (string) {},
              decoration: InputDecoration(
                hintText: 'enterPassword',
                prefix: const SizedBox(
                  width: 12,
                ),
                suffixIcon: IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    // controller.isSecure
                    //     ? AppConst.eyeIcon
                    //     : AppConst.eyeClosedIcon,
                    AppConst.eyeClosedIcon,
                    colorFilter: ColorFilter.mode(
                      AppStyle.buttonDisabledColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              validator: (value) {
                return null;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            PopupButton(
              size: 50,
              color: AppStyle.mainOrange,
              shadowColor: AppStyle.hoverOrange,
              onPressed: () {
                context.goNamed(AppRoute.home);
              },
              child: Center(
                child: Text(
                  'login',
                  textAlign: TextAlign.center,
                  style: AppStyle.bold(
                    size: 15,
                    textColor: AppStyle.whiteColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
