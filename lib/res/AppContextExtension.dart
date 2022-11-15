
import 'package:flutter/cupertino.dart';
import 'package:flutter_movie_app_mvvm/res/Resources.dart';

extension AppContext on BuildContext {
  Resources get resources => Resources.of(this);
}