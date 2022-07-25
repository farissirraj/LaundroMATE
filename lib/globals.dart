import 'package:shared_preferences/shared_preferences.dart';

void savePrefs() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('start', start);
  await prefs.setString('end', end);
  await prefs.setString('appointment', appointment!);
  await prefs.setInt('diff', difference);
}

void saveProfile() async {
  final prefs = await SharedPreferences.getInstance();
  name = prefs.getString('Name')!;
  telegram = prefs.getString('Telegram')!;
}

void fetchPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  appointment = prefs.getString('appointment')!;
}

void removePrefs(context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('start');
  await prefs.remove('end');
  await prefs.remove('appointment');
  await prefs.remove('diff');
}

void removeProfile(context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('name');
  await prefs.remove('end');
}

void changeName() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('Name');
  await prefs.setString('Name', name);
}

void changeTele() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('Telegram');
  await prefs.setString('Telegram', telegram);
}

//User Profile
String name = '';
String telegram = '';

//Time Conversions and Management
String start = '';
String end = '';
String temp = '';
DateTime select = DateTime.now();
DateTime startTime = DateTime.now();
DateTime endTime = DateTime.now();
String? appointment = '00';

//Status Page Path and Flag Variables
int status = 0;
String wmPath = 'assets/wm_green.png';
String dPath = 'assets/dryer_green.png';

//Notification Time Management
final difference = startTime.difference(endTime).inSeconds;
