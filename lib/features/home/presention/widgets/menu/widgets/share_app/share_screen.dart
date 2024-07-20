import 'package:share_plus/share_plus.dart';

void SharePressed(){
  Share.share('https://play.google.com/store/apps/details?id=com.instructivetech.testapp', subject: 'Look what I made!');
}
