import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:haash_moving_chart/cores/theme/color_pellets.dart';
import 'package:haash_moving_chart/cores/utils/show_snackbar.dart';
import 'package:haash_moving_chart/cores/widgets/buttons.dart';
import 'package:haash_moving_chart/cores/widgets/spacer.dart';
import 'package:haash_moving_chart/cores/widgets/text_fields.dart';
import 'package:haash_moving_chart/features/chart/presentation/provider/entry_provider.dart';
import 'package:haash_moving_chart/features/chart/presentation/screens/view_entry_items.dart';
import 'package:haash_moving_chart/features/chart/presentation/widgets/add_transaction_item_alert_dialog.dart';
import 'package:provider/provider.dart';

class AddNewEntry extends StatelessWidget {
  AddNewEntry({super.key});

  get locations => null;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    final provider = context.read<EntryProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'New Entry',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Consumer<EntryProvider>(builder: (context, _, child) {
              return DropdownButton(
                  underline: const SizedBox(),
                  style: const TextStyle(fontSize: 12),
                  value: provider.selectedLocation,
                  items: provider.locations.map((e) {
                    return DropdownMenuItem<dynamic>(
                      value: e,
                      child: Text(
                        e.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                  onChanged: (e) => provider.locationChanged(e!));
            }),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: provider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Consumer<EntryProvider>(
                            builder: (context, prov, child) {
                          return DefaultTextFormField(
                            isValidate: true,
                            textInputType: TextInputType.number,
                            textController: provider.idNoController,
                            label: 'ID No',
                          );
                        })),
                    const SpacerWidget(
                      width: 10,
                    ),
                    Expanded(
                        flex: 2,
                        child: Consumer<EntryProvider>(
                            builder: (context, prov, child) {
                          return DefaultTextFormField(
                            readOnly: true,
                            isValidate: true,
                            onTap: () => provider.selectDateFunction(context),
                            textController: provider.dateController,
                            label: 'Date',
                          );
                        })),
                    const SpacerWidget(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: DefaultTextFormField(
                        isValidate: true,
                        textController: provider.challanController,
                        label: 'Challan No',
                      ),
                    ),
                  ],
                ),
                const SpacerWidget(
                  height: 20,
                ),
                const Text('Fabric Details'),
                const SpacerWidget(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: DefaultTextFormField(
                        isValidate: true,
                        textController: provider.supplierBillController,
                        label: 'Supplier bill No',
                      ),
                    ),
                    const SpacerWidget(
                      width: 20,
                    ),
                    Expanded(
                      flex: 2,
                      child: DefaultTextFormField(
                        isValidate: true,
                        textController: provider.latNoController,
                        label: 'LAT No',
                      ),
                    ),
                    const SpacerWidget(
                      width: 20,
                    ),
                    Expanded(
                      flex: 2,
                      child: DefaultTextFormField(
                        isValidate: true,
                        textInputType: TextInputType.number,
                        textController: provider.quantityController,
                        label: 'Quantity',
                      ),
                    ),
                  ],
                ),
                const SpacerWidget(
                  height: 10,
                ),
                const Text('Work Details'),
                const SpacerWidget(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          DefaultTextFormField(
                            isValidate: true,
                            textController: provider.stichingController,
                            label: 'Stiching Name',
                          ),
                          const SpacerWidget(
                            height: 10,
                          ),
                          DefaultTextFormField(
                            isValidate: true,
                            textController: provider.washingController,
                            label: 'Washing Name',
                          ),
                        ],
                      ),
                    ),
                    const SpacerWidget(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          DefaultTextFormField(
                            isValidate: true,
                            textController: provider.stichBillController,
                            label: 'Bill No',
                          ),
                          const SpacerWidget(
                            height: 10,
                          ),
                          DefaultTextFormField(
                            isValidate: true,
                            textController: provider.washBillController,
                            label: 'Bill No',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SpacerWidget(
                  height: 10,
                ),
                const Text('CUTTING DETAILS'),
                const SpacerWidget(
                  height: 5,
                ),
                Consumer<EntryProvider>(builder: (context, prov, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: CustomTextButton(
                            onPressed: () => showAddItemDialog(
                                  context,
                                  provider,
                                )),
                      ),
                      if (provider.items.isNotEmpty)
                        const SpacerWidget(
                          width: 20,
                        ),
                      if (provider.items.isNotEmpty)
                        InkWell(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ViewEntryItems(provider: provider)))
                          },
                          child: Stack(children: [
                            const Icon(
                              Icons.edit_document,
                              size: 40,
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.red,
                                ),
                                width: 17,
                                height: 17,
                                child: Center(
                                  child: Consumer<EntryProvider>(
                                    builder: (context, prov, child) {
                                      return Text(
                                        provider.items.length.toString(),
                                        style: const TextStyle(
                                            color: AppPallete.whiteColor,
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        )
                    ],
                  );
                }),
                const SpacerWidget(
                  height: 20,
                ),
                DefaultTextFormField(
                  maxLine: 2,
                  textController: provider.noteController,
                  label: 'Note',
                ),
                const SpacerWidget(
                  height: 20,
                ),
                PrimaryButton(
                    label: 'Save',
                    onPressed: () async {
                      if (provider.formKey.currentState!.validate()) {
                        if (provider.items.isEmpty) {
                          showSnackBar(context, 'Add atleast on item');
                          return;
                        }

                        await provider.addEntry(firebaseUser?.email);
                        if (provider.isSuccess && context.mounted) {
                          showSnackBar(context, 'Entry added');
                          provider.clearFields();
                          Navigator.pop(context);
                        }
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
