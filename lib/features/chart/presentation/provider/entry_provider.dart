import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:haash_moving_chart/cores/services/firebase_methods.dart';
import 'package:haash_moving_chart/cores/utils/select_date.dart';
import 'package:haash_moving_chart/cores/widgets/text_fields.dart';
import 'package:haash_moving_chart/features/chart/data/model/entry_model.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class EntryProvider with ChangeNotifier {
  EntryProvider() {
    _initialization();
  }
  bool isLoading = false, isSuccess = false, isAssigned = false;
  String message = '';
  DateTime selectedDate = DateTime.now();
  final List<String> locations = ['Kerala', 'Mumbai'];
  String selectedLocation = 'Kerala';
  final dateController = TextEditingController();

  final idNoController = TextEditingController();
  final challanController = TextEditingController();
  final supplierBillController = TextEditingController();
  final latNoController = TextEditingController();
  final quantityController = TextEditingController();
  final stichingController = TextEditingController();
  final stichBillController = TextEditingController();
  final washingController = TextEditingController();
  final washBillController = TextEditingController();
  final modelController = TextEditingController();
  final bundleIdController = TextEditingController();
  final colorController = TextEditingController();
  final sizeController = TextEditingController();
  final itemQuantityController = TextEditingController();
  final damageQuantityController = TextEditingController();
  final stichingOrWashingController = TextEditingController();
  final finalQuantityController = TextEditingController();
  final salesBillNoController = TextEditingController();
  final remarkController = TextEditingController();
  final noteController = TextEditingController();
  List<DetailsModel> items = [];
  Future<List<EntryModel>>? allEntries;
  final formKey = GlobalKey<FormState>();
  final itemsFormKey = GlobalKey<FormState>();
  final FirebaseAuthMethods _firebaseAuthMethods =
      FirebaseAuthMethods(FirebaseAuth.instance);
  void _initialization() {
    dateController.text = formatDate(selectedDate);
    getEntries();
  }

  Future<void> selectDateFunction(BuildContext context) async {
    final DateTime? pickedDate = await selectDate(context);

    if (pickedDate != null) {
      dateController.text = formatDate(pickedDate);
      selectedDate = pickedDate;
    }
    notifyListeners();
  }

  Future<void> getEntries() async {
    isLoading = true;
    notifyListeners();
    allEntries = _firebaseAuthMethods.getEntries();
    isLoading = false;
    notifyListeners();
  }

  Future<void> editEntryItems(String docId, String entryId) async {
    isLoading = true;
    notifyListeners();
    final updatedModel = DetailsModel(
      sId: entryId,
      model: modelController.text.trim(),
      bundleNo: bundleIdController.text.trim(),
      color: colorController.text.trim(),
      size: sizeController.text.trim(),
      quantity: parseDouble(itemQuantityController.text.trim()),
      damageQuantity: parseDouble(damageQuantityController.text.trim()),
      stitchingOrWashing: stichingOrWashingController.text.trim(),
      finalQuantity: parseDouble(finalQuantityController.text.trim()),
      saleBillNo: salesBillNoController.text.trim(),
      remark: remarkController.text.trim(),
    );
    final index = items.indexWhere((element) => element.sId == entryId);
    if (index != -1) {
      items[index] = updatedModel;
    } else {
      message = 'Error: Entry ID not found in the list';
      isLoading = false;
      notifyListeners();
      return;
    }

    try {
      final result =
          await _firebaseAuthMethods.editEntryInDb(docId, entryId, items);
      isSuccess = result;
      message = isSuccess ? 'Item Updated' : 'Failed to update';
      notifyListeners();
    } catch (e) {
      message = 'Error updating entry: $e';
      isSuccess = false;
    }

    isLoading = false;
    notifyListeners();
  }

  void locationChanged(String value) {
    selectedLocation = value;
    notifyListeners();
  }

  Future<void> deleteEntry(String id) async {
    isLoading = true;
    notifyListeners();
    try {
      final result = await _firebaseAuthMethods.deleteEntry(id);
      if (result) {
        getEntries();
      }
      isSuccess = result;
    } catch (e) {
      message = 'Error deleting entry: $e';
      isSuccess = false;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteItemFromEntry(String documentId, String itemId) async {
    isLoading = true;
    notifyListeners();

    try {
      final result =
          await _firebaseAuthMethods.deleteItemFromEntry(documentId, itemId);
      if (result) {
        getEntries();
      }
      isSuccess = result;
    } catch (e) {
      message = 'Error deleting item from entry: $e';
      isSuccess = false;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> addEntry(String? userEmail) async {
    isLoading = true;
    notifyListeners();
    final model = EntryModel(
      sId: uuid.v4(),
      idNo: idNoController.text.trim(),
      date: selectedDate,
      challanNo: challanController.text.trim(),
      supplierBillNo: supplierBillController.text.trim(),
      latNo: latNoController.text.trim(),
      quantity: parseDouble(quantityController.text.trim()),
      stichingName: stichingController.text.trim(),
      stichingBillNo: stichBillController.text.trim(),
      washingName: washingController.text.trim(),
      washingBillNo: washBillController.text.trim(),
      note: noteController.text.trim(),
      userEmail: userEmail,
      location: selectedLocation,
      itemDetails: items,
    );
    try {
      final result = await _firebaseAuthMethods.addNewEntryToDb(model);
      if (result) {
        await getEntries();
        items.clear();
      }
      isSuccess = result;
    } catch (e) {
      message = 'Error adding new entry: $e';
      isSuccess = false;
    }

    isLoading = false;
    notifyListeners();
  }

  void addItems() {
    isLoading = true;
    notifyListeners();
    try {
      items.add(DetailsModel(
          model: modelController.text.trim(),
          bundleNo: bundleIdController.text.trim(),
          color: colorController.text.trim(),
          size: sizeController.text.trim(),
          quantity: parseDouble(itemQuantityController.text.trim()),
          damageQuantity: parseDouble(damageQuantityController.text.trim()),
          stitchingOrWashing: stichingOrWashingController.text.trim(),
          finalQuantity: parseDouble(finalQuantityController.text.trim()),
          saleBillNo: salesBillNoController.text.trim(),
          remark: remarkController.text.trim()));
      isSuccess = true;
    } catch (e) {
      message = 'Error adding new item: $e';
      isSuccess = false;
    }

    isLoading = false;
    notifyListeners();
  }

  void deleteItems(index) {
    try {
      items.removeAt(index);
    } catch (e) {
      message = 'Error adding new item: $e';
    }

    notifyListeners();
  }

  void calculateTotalQuantity() {
    final damages = parseDouble(damageQuantityController.text);
    final quantity = parseDouble(itemQuantityController.text);
    finalQuantityController.text = (quantity - damages).toString();
    notifyListeners();
  }

  void clearFields() {
    challanController.clear();
    supplierBillController.clear();
    latNoController.clear();
    idNoController.clear();
    quantityController.clear();
    stichingController.clear();
    stichBillController.clear();
    washingController.clear();
    washBillController.clear();

    noteController.clear();
    modelController.clear();
    bundleIdController.clear();
    colorController.clear();
    sizeController.clear();
    itemQuantityController.clear();
    damageQuantityController.clear();
    stichingOrWashingController.clear();
    finalQuantityController.clear();
    salesBillNoController.clear();
    remarkController.clear();
    selectedDate = DateTime.now();
    dateController.text = formatDate(selectedDate);
    isSuccess = false;
    isLoading = false;
    isAssigned = false;
    items = [];
  }

  void clearAlertFields() {
    modelController.clear();
    bundleIdController.clear();
    colorController.clear();
    sizeController.clear();
    itemQuantityController.clear();
    damageQuantityController.clear();
    stichingOrWashingController.clear();
    finalQuantityController.clear();
    salesBillNoController.clear();
    remarkController.clear();
    isSuccess = false;
    isLoading = false;
    isAssigned = false;
  }

  @override
  void dispose() {
    challanController.dispose();
    supplierBillController.dispose();
    latNoController.dispose();
    idNoController.dispose();
    quantityController.dispose();
    stichingController.dispose();
    stichBillController.dispose();
    washingController.dispose();
    washBillController.dispose();
    super.dispose();
  }
}
