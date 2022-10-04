import 'package:flutter/material.dart';

abstract class ILocalStorageDriver {
  Future delete({String key});
  Future getData({String key});
  Future put({String key, dynamic value});

  Future getList({@required String key});
  Future putList({@required String key, List list});
}
