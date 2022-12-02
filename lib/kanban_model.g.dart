// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanban_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KanbanBoardModel _$KanbanBoardModelFromJson(Map<String, dynamic> json) =>
    KanbanBoardModel(
      (json['columns'] as List<dynamic>?)
          ?.map((e) => KanbanColumnModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$KanbanBoardModelToJson(KanbanBoardModel instance) =>
    <String, dynamic>{
      'columns': instance.columns,
    };

KanbanColumnModel _$KanbanColumnModelFromJson(Map<String, dynamic> json) =>
    KanbanColumnModel(
      json['title'] as String,
    );

Map<String, dynamic> _$KanbanColumnModelToJson(KanbanColumnModel instance) =>
    <String, dynamic>{
      'title': instance.title,
    };

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
