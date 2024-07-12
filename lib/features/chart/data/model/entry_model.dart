// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class EntryModel {
  String? idNo;
  DateTime? date;
  String? challanNo;
  String? supplierBillNo;
  String? latNo;
  double? quantity;
  String? stichingName;
  String? stichingBillNo;
  String? washingName;
  String? washingBillNo;
  String? note;
  String? location;
  String? userEmail;
  List<DetailsModel>? itemDetails;
  String? sId;

  EntryModel({
    this.idNo,
    this.date,
    this.challanNo,
    this.supplierBillNo,
    this.latNo,
    this.quantity,
    this.stichingName,
    this.stichingBillNo,
    this.washingName,
    this.washingBillNo,
    this.itemDetails,
    this.location,
    this.note,
    this.userEmail,
    this.sId,
  });

  EntryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    idNo = json['idNo'] ?? '';
    userEmail = json['userEmail'] ?? '';
    date = json['date'] != null ? DateTime.tryParse(json['date']) : null;
    challanNo = json['challanNo'] ?? '';
    supplierBillNo = json['supplierBillNo'] ?? '';
    latNo = json['latNo'] ?? '';
    location = json['location'] ?? '';
    quantity = json['quantity']?.toDouble() ?? 0;
    stichingName = json['stichingName'] ?? '';
    stichingBillNo = json['stichingBillNo'] ?? '';
    washingName = json['washingName'] ?? '';
    washingBillNo = json['washingBillNo'] ?? '';
    note = json['note'] ?? '';
    if (json['itemDetails'] != null) {
      itemDetails = (json['itemDetails'] as List)
          .map((v) => DetailsModel.fromJson(v))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sId != null) {
      data['_id'] = sId;
    }
    data['userEmail'] = userEmail;
    data['idNo'] = idNo;
    data['date'] = date?.toIso8601String();
    data['challanNo'] = challanNo;
    data['supplierBillNo'] = supplierBillNo;
    data['latNo'] = latNo;
    data['location'] = location;
    data['quantity'] = quantity;
    data['stichingName'] = stichingName;
    data['stichingBillNo'] = stichingBillNo;
    data['washingName'] = washingName;
    data['washingBillNo'] = washingBillNo;
    data['note'] = note;
    if (itemDetails != null) {
      data['itemDetails'] = itemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DetailsModel {
  String? sId;
  String? model;
  String? bundleNo;
  String? color;
  String? size;
  double? quantity;
  double? damageQuantity;
  String? stitchingOrWashing;
  double? finalQuantity;
  String? saleBillNo;
  String? remark;
  String? status;
  String? lastEditedBy;

  DetailsModel(
      {this.sId,
      this.model,
      this.bundleNo,
      this.color,
      this.size,
      this.quantity,
      this.damageQuantity,
      this.stitchingOrWashing,
      this.finalQuantity,
      this.saleBillNo,
      this.remark,
      this.status,
      this.lastEditedBy});

  DetailsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    model = json['model'] ?? '';
    bundleNo = json['bundleNo'] ?? '';
    color = json['color'] ?? '';
    size = json['size'] ?? '';
    quantity = json['quantity']?.toDouble() ?? 0;
    damageQuantity = json['damageQuantity']?.toDouble() ?? 0;
    stitchingOrWashing = json['stitchingOrWashing'] ?? '';
    finalQuantity = json['finalQuantity']?.toDouble() ?? 0;
    saleBillNo = json['saleBillNo'] ?? '';
    remark = json['remark'] ?? '';
    status = json['status'] ?? '';
    lastEditedBy = json['lastEditedBy'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId ?? uuid.v4();
    data['model'] = model;
    data['bundleNo'] = bundleNo;
    data['color'] = color;
    data['size'] = size;
    data['quantity'] = quantity;
    data['damageQuantity'] = damageQuantity;
    data['stitchingOrWashing'] = stitchingOrWashing;
    data['finalQuantity'] = finalQuantity;
    data['saleBillNo'] = saleBillNo;
    data['remark'] = remark;
    data['status'] = status;
    data['lastEditedBy'] = lastEditedBy;
    return data;
  }

  DetailsModel copyWith(
      {String? sId,
      String? model,
      String? bundleNo,
      String? color,
      String? size,
      double? quantity,
      double? damageQuantity,
      String? stitchingOrWashing,
      double? finalQuantity,
      String? saleBillNo,
      String? remark,
      String? status,
      String? lastEditedBy}) {
    return DetailsModel(
      sId: sId ?? this.sId,
      model: model ?? this.model,
      bundleNo: bundleNo ?? this.bundleNo,
      color: color ?? this.color,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
      damageQuantity: damageQuantity ?? this.damageQuantity,
      stitchingOrWashing: stitchingOrWashing ?? this.stitchingOrWashing,
      finalQuantity: finalQuantity ?? this.finalQuantity,
      saleBillNo: saleBillNo ?? this.saleBillNo,
      remark: remark ?? this.remark,
      status: status ?? this.status,
      lastEditedBy: lastEditedBy ?? this.lastEditedBy,
    );
  }
}
