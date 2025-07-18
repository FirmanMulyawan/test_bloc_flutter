import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../component/bloc/user_by_id_bloc.dart';
import '../../component/bloc/user_by_id_event.dart';
import '../../component/bloc/user_by_id_state.dart';
import '../../component/config/app_const.dart';
import '../../component/config/app_style.dart';
import '../../component/model/user_id_response.dart';

class DetailScreen extends StatefulWidget {
  final String? userId;
  const DetailScreen({super.key, this.userId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    context.read<UserByIdBloc>().add(LoadUserByIdEvent(widget.userId ?? ''));
    super.initState();
  }

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
          child: BlocBuilder<UserByIdBloc, UserByIdState>(
              builder: (context, state) {
            if (state is UserByIdLoadingState) {
              return Skeletonizer(
                  enabled: true,
                  child: _isCard(
                      email: "firman@gmail.com",
                      firstName: "firman",
                      lastName: "Mulyawan",
                      imageUrl: "https://reqres.in/img/faces/1-image.jpg"));
            }

            if (state is UserErrorState) {
              return const Center(child: Text("Error"));
            }

            if (state is UserByIdSuccessState) {
              Data userById = state.user.data;

              return _isCard(
                  email: userById.email,
                  firstName: userById.firstName,
                  lastName: userById.lastName,
                  imageUrl: userById.avatar);
            }

            return Container();
          }),
        ),
      ),
    );
  }

  Widget _isCard(
      {required String imageUrl,
      required String email,
      required String firstName,
      required String lastName}) {
    return Column(
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
              imageUrl,
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
                return const Icon(Icons.error, color: Colors.red, size: 30);
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
                text: email,
                style: AppStyle.regular(size: 18, textColor: AppStyle.green),
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
                text: firstName,
                style: AppStyle.regular(size: 18, textColor: AppStyle.green),
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
                text: lastName,
                style: AppStyle.regular(size: 18, textColor: AppStyle.green),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
