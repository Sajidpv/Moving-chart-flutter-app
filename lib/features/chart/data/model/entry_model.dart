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
    this.note,
    this.sId,
  });

  EntryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    idNo = json['idNo'] ?? '';
    date = json['date'] != null ? DateTime.tryParse(json['date']) : null;
    challanNo = json['challanNo'] ?? '';
    supplierBillNo = json['supplierBillNo'] ?? '';
    latNo = json['latNo'] ?? '';
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
    data['idNo'] = idNo;
    data['date'] = date?.toIso8601String();
    data['challanNo'] = challanNo;
    data['supplierBillNo'] = supplierBillNo;
    data['latNo'] = latNo;
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

  DetailsModel({
    this.sId,
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
  });

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
    return data;
  }
}
