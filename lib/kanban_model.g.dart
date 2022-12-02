// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanban_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KanbanCardModel _$KanbanCardModelFromJson(Map<String, dynamic> json) =>
    KanbanCardModel(
      json['title'] as String,
      json['body'] as String,
    );

Map<String, dynamic> _$KanbanCardModelToJson(KanbanCardModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
    };
