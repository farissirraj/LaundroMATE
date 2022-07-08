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
String appointment = '';

//Status Page Path and Flag Variables
int status = 0;
String wmPath = 'assets/wm_green.png';
String dPath = 'assets/dryer_green.png';

//Notification Time Management
final difference = startTime.difference(endTime).inSeconds;
