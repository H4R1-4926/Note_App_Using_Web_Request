// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, avoid_print, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:note_app/data/getallnoptes/getallnoptes.dart';
import 'package:note_app/data/notemodel/notemodel.dart';
import 'package:note_app/data/url.dart';

abstract class ApiCalls {
  Future<Notemodel?> createnote(Notemodel value);
  Future<List<Notemodel>> getallnote();
  Future<Notemodel?> updatenote(Notemodel value);
  Future<void> deletenote(String id);
}

class NoteDb extends ApiCalls {
  //== singleton

  NoteDb._internal();

  static NoteDb instance = NoteDb._internal();

  NoteDb factory() {
    return instance;
  }

  //==end singleton

  final dio = Dio();
  final url = Url();

  ValueNotifier<List<Notemodel>> notelistnoti = ValueNotifier([]);

  NoteDb() {
    dio.options = BaseOptions(
      baseUrl: url.baseUrl,
      responseType: ResponseType.plain,
    );
  }

  @override
  Future<Notemodel?> createnote(Notemodel value) async {
    try {
      final _result = await dio.post(
        url.createnote,
        data: value.toJson(),
      );
      final _resultjson = jsonDecode(_result.data);
      final _note = Notemodel.fromJson(
        _resultjson as Map<String, dynamic>,
      );
      notelistnoti.value.insert(0, _note);
      notelistnoti.notifyListeners();
      return _note;
    } on DioException catch (e) {
      print(e);
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deletenote(String id) async {
    final _result =
        await dio.delete(url.baseUrl + url.deletenote.replaceFirst('{id}', id));
    if (_result.data == null) {
      return;
    } else {
      final _index = notelistnoti.value.indexWhere((note) => note.id == id);
      if (_index == -1) {
        return;
      }
      notelistnoti.value.removeAt(_index);
      notelistnoti.notifyListeners();
    }
  }

  @override
  Future<List<Notemodel>> getallnote() async {
    final _result = await dio.get(url.baseUrl + url.getallnote,
        options: Options(responseType: ResponseType.plain));
    if (_result.data != null) {
      final _resultasjson = jsonDecode(_result.data);
      final getnote = Getallnotes.fromJson(_resultasjson);
      notelistnoti.value.clear();
      notelistnoti.value.addAll(getnote.data.reversed);
      notelistnoti.notifyListeners();
      return getnote.data;
    } else {
      notelistnoti.value.clear();
      return [];
    }
  }

  @override
  Future<Notemodel?> updatenote(Notemodel value) async {
    final _result =
        await dio.put(url.baseUrl + url.updatenote, data: value.toJson());
    if (_result.data == null) {
      return null;
    } else {
      //find index

      final index =
          notelistnoti.value.indexWhere((note) => note.id == value.id);
      if (index == -1) {
        return null;
      }

      //remove from index
      notelistnoti.value.removeAt(index);

      // add  note in the index

      notelistnoti.value.insert(index, value);
      notelistnoti.notifyListeners();
      return value;
    }
  }

  Notemodel? getnotebtId(String id) {
    try {
      return notelistnoti.value.firstWhere((note) => note.id == id);
    } catch (_) {
      return null;
    }
  }
}
