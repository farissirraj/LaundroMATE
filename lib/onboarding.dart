import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'homescreen.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  final List<PageViewModel> pages = [
    PageViewModel(
        title: '',
        //body: 'Description',
        bodyWidget: Column(children: const [
          SizedBox(height: 20),
          Text(
            'Welcome to',
            style: TextStyle(
                fontSize: 50,
                fontFamily: 'Kollektif',
                color: Color.fromRGBO(0, 74, 173, 2)),
          ),
          SizedBox(height: 5),
          Text(
            'LaundroMATE',
            style: TextStyle(
                fontSize: 50,
                fontFamily: 'Kollektif',
                color: Color.fromRGBO(0, 74, 173, 2)),
          )
        ]),
        image: Center(
          child: Image.asset('assets/icon_onboarding.png'),
          heightFactor: 0.5,
        )),
    PageViewModel(
        title: 'Second Page',
        body: 'Description',
        footer: ElevatedButton(
          onPressed: () {},
          child: const Text("Let's Go"),
        ),
        image: Center(
          child: Image.asset('assets/dryer_green.png'),
        ))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'LaundroMATE',
      //     style: TextStyle(color: Color.fromRGBO(0, 74, 173, 2)),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      // ),
      body: IntroductionScreen(
        pages: pages,
        globalBackgroundColor: Colors.white,
        // globalBackgroundColor: Colors.white,
        dotsDecorator: const DotsDecorator(
          size: Size(10, 10),
          color: Color.fromARGB(253, 0, 0, 0),
          activeSize: Size.square(20),
          activeColor: Color.fromRGBO(0, 74, 173, 2),
        ),
        showDoneButton: true,
        done: const Text('Done',
            style:
                TextStyle(fontSize: 20, color: Color.fromRGBO(0, 74, 173, 2))),
        //showSkipButton: true,
        // skip: const Text('Skip',
        //     style: TextStyle(fontSize: 20, color: Colors.white)),
        showNextButton: true,
        next: const Icon(Icons.arrow_forward,
            size: 30, color: Color.fromRGBO(0, 74, 173, 2)),
        showBackButton: true,
        back: const Icon(Icons.arrow_back,
            size: 30, color: Color.fromRGBO(0, 74, 173, 2)),

        onDone: () => onDone(context),
      ),
    );
  }

  void onDone(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
