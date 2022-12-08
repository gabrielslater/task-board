// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_board_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardModel _$BoardModelFromJson(Map<String, dynamic> json) => BoardModel(
      (json['columns'] as List<dynamic>?)
          ?.map((e) => ColumnModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BoardModelToJson(BoardModel instance) =>
    <String, dynamic>{
      'columns': instance.columns,
    };

ColumnModel _$ColumnModelFromJson(Map<String, dynamic> json) => ColumnModel(
      json['title'] as String,
    )..cards = (json['cards'] as List<dynamic>)
        .map((e) => CardModel.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$ColumnModelToJson(ColumnModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'cards': instance.cards,
    };

CardModel _$CardModelFromJson(Map<String, dynamic> json) => CardModel(
      json['title'] as String,
      json['body'] as String,
    );

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
    };
