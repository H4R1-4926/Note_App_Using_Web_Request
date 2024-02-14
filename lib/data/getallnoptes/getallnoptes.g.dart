// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getallnoptes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Getallnotes _$GetallnotesFromJson(Map<String, dynamic> json) => Getallnotes(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => Notemodel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GetallnotesToJson(Getallnotes instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
