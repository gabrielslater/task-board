// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanban_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KanbanBoardModel _$KanbanBoardModelFromJson(Map<String, dynamic> json) =>
    KanbanBoardModel();

Map<String, dynamic> _$KanbanBoardModelToJson(KanbanBoardModel instance) =>
    <String, dynamic>{};

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
