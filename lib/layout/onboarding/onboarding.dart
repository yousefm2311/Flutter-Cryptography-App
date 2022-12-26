// ignore_for_file: unnecessary_string_interpolations, camel_case_types

import 'package:cryptography_app/layout/home.dart';
import 'package:cryptography_app/shared/component.dart';
import 'package:cryptography_app/shared/network/remote/cache.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class pageViewModel {
  String image;
  String text;
  String text2;
  pageViewModel({
    required this.image,
    required this.text,
    required this.text2,
  });
}

class OnBoarding_Screen extends StatefulWidget {
  const OnBoarding_Screen({super.key});

  @override
  State<OnBoarding_Screen> createState() => _OnBording_ScreenState();
}

class _OnBording_ScreenState extends State<OnBoarding_Screen> {
  void submit() {
    Cache_Helper.saveDate(key: 'Onboarding', value: true).then((value) {
      if (value) {
        defalutNavigatorReplacement(context, const Home_Screen());
      }
    });
  }

  List<pageViewModel> pageViewList = [
    pageViewModel(
        image: 'assets/5.json',
        text: 'Encrypt and Decrypt ',
        text2:
            'The use of the most famous algorithm in encryption and decryption'),
    pageViewModel(
        image: 'assets/8.json',
        text: 'Speed Processing',
        text2: 'Encrypt and Decrypt any text using key'),
    pageViewModel(
        image: 'assets/7.json',
        text: 'Cryptography',
        text2:
            'We use encryption in everything in our lives to protect our data'),
    pageViewModel(
        image: 'assets/22.json',
        text: 'Easy to use',
        text2: 'Everyone can use this software to encrypt and decrypt data'),
  ];
  bool isLast = false;
  var countPageview = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (() {
                submit();
              }),
              child: const Text('SKIP'))
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 25.0,
          ),
          SmoothPageIndicator(
            controller: countPageview,
            count: pageViewList.length,
            effect: const ExpandingDotsEffect(
              activeDotColor: Colors.deepOrange,
              dotHeight: 10,
              dotWidth: 10,
              dotColor: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Expanded(
            child: PageView.builder(
              controller: countPageview,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (value) {
                if (value == pageViewList.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              itemBuilder: (context, index) =>
                  buildPageView(pageViewList[index]),
              itemCount: pageViewList.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.0),
                color: Colors.deepOrange,
              ),
              child: MaterialButton(
                onPressed: (() {
                  if (isLast) {
                    submit();
                  } else {
                    countPageview.nextPage(
                        duration: const Duration(milliseconds: 1200),
                        curve: Curves.linearToEaseOut);
                  }
                }),
                child: isLast
                    ? const Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget buildPageView(pageViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Lottie.asset(
              '${model.image}',
              width: 350,
              height: 350,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            model.text,
            style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            model.text2,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
