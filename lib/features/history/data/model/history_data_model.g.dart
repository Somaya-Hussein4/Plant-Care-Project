// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryDataModel _$HistoryDataModelFromJson(Map<String, dynamic> json) =>
    HistoryDataModel(
      scans: (json['scans'] as List<dynamic>)
          .map((e) => HistoryScanModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HistoryDataModelToJson(HistoryDataModel instance) =>
    <String, dynamic>{
      'scans': instance.scans,
    };
