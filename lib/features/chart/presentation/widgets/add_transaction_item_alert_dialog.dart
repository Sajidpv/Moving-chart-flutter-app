import 'package:flutter/material.dart';
import 'package:haash_moving_chart/cores/theme/provider/theme_provider.dart';
import 'package:haash_moving_chart/cores/utils/show_snackbar.dart';
import 'package:haash_moving_chart/cores/widgets/container_layout.dart';
import 'package:provider/provider.dart';
import 'package:haash_moving_chart/cores/widgets/buttons.dart';
import 'package:haash_moving_chart/cores/widgets/spacer.dart';
import 'package:haash_moving_chart/cores/widgets/text_fields.dart';
import 'package:haash_moving_chart/features/chart/data/model/entry_model.dart';
import 'package:haash_moving_chart/features/chart/presentation/provider/entry_provider.dart';

void showAddItemDialog(BuildContext context, EntryProvider provider,
    {DetailsModel? detailsItem, String? id}) {
  provider.clearAlertFields();
  showDialog(
    context: context,
    builder: (context) => AddItemToEntry(
      detailsItem: detailsItem,
      id: id,
      provider: provider,
    ),
  );
}

class AddItemToEntry extends StatelessWidget {
  const AddItemToEntry({
    super.key,
    required this.provider,
    this.detailsItem,
    this.id,
  });
  final EntryProvider provider;
  final String? id;
  final DetailsModel? detailsItem;

  @override
  Widget build(BuildContext context) {
    if (detailsItem != null && provider.isAssigned == false) {
      provider.modelController.text = detailsItem!.model!;
      provider.bundleIdController.text = detailsItem!.bundleNo!;
      provider.colorController.text = detailsItem!.color!;
      provider.sizeController.text = detailsItem!.size!;
      provider.itemQuantityController.text = detailsItem!.quantity!.toString();
      provider.damageQuantityController.text =
          detailsItem!.damageQuantity!.toString();
      provider.stichingOrWashingController.text =
          detailsItem!.stitchingOrWashing!;
      provider.finalQuantityController.text =
          detailsItem!.finalQuantity!.toString();
      provider.salesBillNoController.text = detailsItem!.saleBillNo!;
      provider.remarkController.text = detailsItem!.remark!;
      provider.isAssigned = true;
    }
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Form(
          key: provider.itemsFormKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add Item',
                      style: TextStyle(fontSize: 24),
                    ),
                    InkWell(
                        onTap: () => Navigator.pop(context),
                        child: buildContainer(
                          isBorder: true,
                          elevation: 0,
                          radius: 30,
                          Icon(
                            Icons.close,
                            color: context.read<ThemeProvider>().isDarkMode
                                ? Theme.of(context).secondaryHeaderColor
                                : Theme.of(context).primaryColor,
                          ),
                        ))
                  ],
                ),
                const SpacerWidget(
                  height: 10,
                ),
                DefaultTextFormField(
                  isValidate: true,
                  textController: provider.modelController,
                  label: 'Model',
                ),
                const SpacerWidget(
                  height: 10,
                ),
                DefaultTextFormField(
                  isValidate: true,
                  textController: provider.bundleIdController,
                  label: 'BundleId',
                ),
                const SpacerWidget(
                  height: 10,
                ),
                DefaultTextFormField(
                  isValidate: true,
                  textController: provider.colorController,
                  label: 'Color',
                ),
                const SpacerWidget(
                  height: 10,
                ),
                DefaultTextFormField(
                  isValidate: true,
                  textController: provider.sizeController,
                  label: 'Size',
                ),
                const SpacerWidget(
                  height: 10,
                ),
                DefaultTextFormField(
                  isValidate: true,
                  textInputType: TextInputType.number,
                  textController: provider.itemQuantityController,
                  onChanged: (value) => provider.calculateTotalQuantity(),
                  label: 'Quantity',
                ),
                const SpacerWidget(
                  height: 10,
                ),
                DefaultTextFormField(
                  isValidate: true,
                  textInputType: TextInputType.number,
                  textController: provider.damageQuantityController,
                  onChanged: (value) => provider.calculateTotalQuantity(),
                  label: 'Damage',
                ),
                const SpacerWidget(
                  height: 10,
                ),
                DefaultTextFormField(
                  isValidate: true,
                  textController: provider.stichingOrWashingController,
                  label: 'Stiching/Washing',
                ),
                const SpacerWidget(
                  width: 10,
                ),
                Consumer<EntryProvider>(builder: (context, provider, child) {
                  return DefaultTextFormField(
                    isValidate: true,
                    textInputType: TextInputType.number,
                    textController: provider.finalQuantityController,
                    label: 'Final Quantity',
                  );
                }),
                const SpacerWidget(
                  width: 10,
                ),
                DefaultTextFormField(
                  isValidate: true,
                  textController: provider.salesBillNoController,
                  label: 'Sales Bill No',
                ),
                const SpacerWidget(
                  height: 10,
                ),
                DefaultTextFormField(
                  maxLine: 2,
                  textController: provider.remarkController,
                  label: 'Remarks',
                ),
                const SpacerWidget(
                  height: 10,
                ),
                Consumer<EntryProvider>(builder: (context, _, __) {
                  return provider.isLoading
                      ? const CircularProgressIndicator()
                      : PrimaryButton(
                          label: 'Add',
                          onPressed: () async {
                            if (provider.itemsFormKey.currentState!
                                .validate()) {
                              detailsItem != null
                                  ? await provider.editEntryItems(
                                      id!, detailsItem!.sId!)
                                  : provider.addItems();
                              if (provider.isSuccess == true) {
                                if (detailsItem != null && context.mounted) {
                                  showSnackBar(context, provider.message);
                                }
                                provider.clearAlertFields();
                                if (context.mounted) Navigator.pop(context);
                              }
                            }
                          });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
