import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homescreen.dart';
import 'globals.dart' as globals;

final _onboardingNameController = TextEditingController();
final _onboardingTelegramController = TextEditingController();

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  final List<PageViewModel> pages = [
    // Welcome Page
    PageViewModel(
        title: '',
        //body: 'Description',
        bodyWidget: Column(children: const [
          SizedBox(height: 20),
          Text(
            'Welcome to',
            style: TextStyle(
                fontSize: 40,
                fontFamily: 'Kollektif',
                color: Color.fromRGBO(0, 74, 173, 2)),
          ),
          SizedBox(height: 5),
          Text(
            'LaundroMATE',
            style: TextStyle(
                fontSize: 40,
                fontFamily: 'Kollektif',
                color: Color.fromRGBO(0, 74, 173, 2)),
          ),
        ]),
        image: Center(
          child: Image.asset('assets/icon_onboarding.png'),
          heightFactor: 0.5,
        )),

    //Booking Instructions
    PageViewModel(
        title: '',
        bodyWidget: Column(children: const [
          SizedBox(height: 20),
          Text(
            'TO BOOK:',
            style: TextStyle(
                fontSize: 40,
                fontFamily: 'Kollektif',
                color: Color.fromRGBO(0, 74, 173, 2)),
          ),
          SizedBox(height: 5),
          Image(image: AssetImage('assets/calendarBooking.png')),
          SizedBox(height: 5),
          Text(
            'Select your preferred slot and click the + button.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, fontFamily: 'Kollektif', color: Colors.black),
          )
        ]),
        image: null),

    //Button Instruction
    PageViewModel(
        title: '',
        bodyWidget: Column(children: const [
          SizedBox(height: 20),
          Image(image: AssetImage('assets/sideButtons.png'), height: 400),
          SizedBox(height: 5),
          Text(
            'To delete your appointment, click on the 🗑️ button',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, fontFamily: 'Kollektif', color: Colors.black),
          ),
          SizedBox(height: 5),
          Text(
            'To refresh your calendar, click on the 🔄 button. Please do so if the calendar does not refresh immediately.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, fontFamily: 'Kollektif', color: Colors.black),
          )
        ]),
        image: null),

    //Enter details
    PageViewModel(
        title: '',
        bodyWidget: Column(children: [
          const SizedBox(height: 25),
          const Text(
            'One Last Step!',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 40,
                fontFamily: 'Kollektif',
                color: Color.fromRGBO(0, 74, 173, 2)),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: _onboardingNameController,
            decoration:
                const InputDecoration(hintText: 'Name', labelText: 'Name'),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: _onboardingTelegramController,
            decoration: const InputDecoration(
                hintText: 'Telegram Handle', labelText: 'Telegram Handle'),
          ),
        ]),
        image: null)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        showNextButton: true,
        next: const Icon(Icons.arrow_forward,
            size: 30, color: Color.fromRGBO(0, 74, 173, 2)),
        showBackButton: true,
        back: const Icon(Icons.arrow_back,
            size: 30, color: Color.fromRGBO(0, 74, 173, 2)),

        onDone: () {
          if (_onboardingNameController.text == '' ||
              _onboardingTelegramController.text == '') {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: const Text('Alert!'),
                    content: const Text('Invalid Name/Telegram Handle'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Okay'),
                      ),
                    ],
                  );
                });
          } else {
            onDone(context);
          }
        },
      ),
    );
  }

  void onDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('Onboarding', false);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
    globals.name = _onboardingNameController.text;
    globals.telegram = _onboardingTelegramController.text;
    await prefs.setString('Name', _onboardingNameController.text);
    await prefs.setString('Telegram', _onboardingTelegramController.text);
  }
}
