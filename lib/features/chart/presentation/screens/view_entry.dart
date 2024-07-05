import 'package:flutter/material.dart';
import 'package:haash_moving_chart/cores/utils/select_date.dart';
import 'package:haash_moving_chart/cores/widgets/spacer.dart';
import 'package:haash_moving_chart/features/chart/data/model/entry_model.dart';
import 'package:haash_moving_chart/features/chart/presentation/provider/entry_provider.dart';
import 'package:haash_moving_chart/features/chart/presentation/widgets/add_transaction_item_alert_dialog.dart';
import 'package:provider/provider.dart';

class ViewAnEntry extends StatelessWidget {
  const ViewAnEntry({super.key, required this.entry});
  final EntryModel entry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entry.challanNo!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ID No: ${entry.idNo}'),
                            Text('Challan No: ${entry.challanNo}'),
                            Text('Lat No: ${entry.latNo}'),
                            Text('Stitching Name: ${entry.stichingName}'),
                            Text('Washing Name: ${entry.washingName}'),
                            Text('User: ${entry.userEmail}'),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date: ${formatDate(entry.date!)}'),
                            Text('Supplier Bill No: ${entry.supplierBillNo}'),
                            Text('Quantity: ${entry.quantity}'),
                            Text('Stitching Bill No: ${entry.stichingBillNo}'),
                            Text('Washing Bill No: ${entry.washingBillNo}'),
                            Text('Location: ${entry.location}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SpacerWidget(height: 20),
                  Text('Notes: ${entry.note}')
                ],
              ),
            ),
            const SpacerWidget(height: 20),
            const Text('Cutting Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Consumer<EntryProvider>(builder: (context, provider, child) {
              provider.items = entry.itemDetails!;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Model')),
                    DataColumn(label: Text('Bundle No')),
                    DataColumn(label: Text('Color')),
                    DataColumn(label: Text('Size')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Damage Quantity')),
                    DataColumn(label: Text('Stitching/Washing')),
                    DataColumn(label: Text('Final Quantity')),
                    DataColumn(label: Text('Sale Bill No')),
                    DataColumn(label: Text('Remark')),
                    DataColumn(label: Text('')),
                    // DataColumn(label: Text('')),
                  ],
                  rows: entry.itemDetails?.map((item) {
                        return DataRow(cells: [
                          DataCell(Text(item.model ?? '')),
                          DataCell(Text(item.bundleNo ?? '')),
                          DataCell(Text(item.color ?? '')),
                          DataCell(Text(item.size ?? '')),
                          DataCell(Text(item.quantity?.toString() ?? '')),
                          DataCell(Text(item.damageQuantity?.toString() ?? '')),
                          DataCell(Text(item.stitchingOrWashing ?? '')),
                          DataCell(Text(item.finalQuantity?.toString() ?? '')),
                          DataCell(Text(item.saleBillNo ?? '')),
                          DataCell(Text(item.remark ?? '')),
                          DataCell(InkWell(
                              onTap: () {
                                showAddItemDialog(context, provider,
                                    id: entry.sId, detailsItem: item);
                              },
                              child: const Icon(Icons.edit_note_rounded))),
                          // DataCell(InkWell(
                          //     onTap: () async {
                          //       await provider.deleteItemFromEntry(
                          //           entry.sId!, item.sId!);
                          //       if (provider.isSuccess && context.mounted) {
                          //         showSnackBar(context, 'Item deleted');
                          //       }
                          //     },
                          //     child: const Icon(
                          //       Icons.delete_forever_rounded,
                          //       color: AppPallete.errorColor,
                          //     ))),
                        ]);
                      }).toList() ??
                      [],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
