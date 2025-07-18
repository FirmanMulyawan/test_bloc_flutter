import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../component/config/app_const.dart';
import '../../component/config/app_style.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppStyle.pressedGreen,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset(
              AppConst.assetBackButton,
              width: 24,
              height: 24,
            ),
            onPressed: () {
              context.pop();
            },
          ),
          title: Text(
            "Detail User",
            style: AppStyle.bold(size: 20, textColor: Colors.white),
          )),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 300,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppStyle.borderGreen,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    "https://reqres.in/img/faces/1-image.jpg",
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                            color: AppStyle.homeArabicBlue, strokeWidth: 2),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error,
                          color: Colors.red, size: 30);
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Email: ",
                      style: AppStyle.bold(size: 18, textColor: Colors.black),
                    ),
                    TextSpan(
                      text: "User@gmail.com",
                      style:
                          AppStyle.regular(size: 18, textColor: AppStyle.green),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "First Name: ",
                      style: AppStyle.bold(size: 18, textColor: Colors.black),
                    ),
                    TextSpan(
                      text: "John",
                      style:
                          AppStyle.regular(size: 18, textColor: AppStyle.green),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Last Name: ",
                      style: AppStyle.bold(size: 18, textColor: Colors.black),
                    ),
                    TextSpan(
                      text: "do",
                      style:
                          AppStyle.regular(size: 18, textColor: AppStyle.green),
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
