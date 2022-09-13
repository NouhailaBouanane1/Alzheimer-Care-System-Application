import 'package:flutter/material.dart';
import 'package:graduation_project/screen1Patient.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
    child: IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Alzheimer Care System',
          body: 'Caring for our seniors is the greatest responsibility',
          image: buildImage('images/OnBoarding/onBoarding.jpg'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: 'Alzheimer disease',
          body: 'We Remember Their Love When They Can No Longer Remember',
          image: buildImage('images/OnBoarding/onboarding3.jpg'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: 'Train your Memory',
          body: 'Start your journey',
          image: buildImage('images/OnBoarding/onboarding4.jpg'),
          decoration: getPageDecoration(),
        ),

      ],
      done: Text('Skip',
          style: TextStyle(
              fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
      )),
      onDone: () => goToHome(context),
      showSkipButton: true,
      skip: Text('Skip',  style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: Colors.white,
      )),
      onSkip: () => goToHome(context),
      next: Icon(Icons.arrow_forward,color: Colors.white,),
      dotsDecorator: getDotDecoration(),
      onChange: (index) => print('Page $index selected'),
      globalBackgroundColor: Theme.of(context).primaryColor,
      nextFlex: 0,
      // isProgressTap: false,
      // isProgress: false,
      // showNextButton: false,
      // freeze: true,
      // animationDuration: 1000,
    ),
  );

  void goToHome(context) => Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => screen1Patient()),
  );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
    color: Color(0xFFBDBDBD),
    //activeColor: Colors.orange,
    size: Size(10, 10),
    activeSize: Size(22, 10),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );

  PageDecoration getPageDecoration() => PageDecoration(
    titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    bodyTextStyle: TextStyle(fontSize: 20),
    imagePadding: EdgeInsets.all(24),
    pageColor: Colors.white,
  );
}