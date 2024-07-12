import 'package:flutter/material.dart';
import 'package:haash_moving_chart/cores/theme/color_pellets.dart';
import 'package:haash_moving_chart/cores/utils/select_date.dart';
import 'package:haash_moving_chart/cores/utils/show_snackbar.dart';
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
            const Text('Item Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Consumer<EntryProvider>(builder: (context, provider, child) {
              provider.items = entry.itemDetails!;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Edit')),
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
                    DataColumn(label: Text('Last updated by')),
                    DataColumn(label: Text('Status')),
                  ],
                  rows: entry.itemDetails?.map((item) {
                        provider.selectedStatus = item.status;
                        return DataRow(cells: [
                          DataCell(InkWell(
                              onTap: () {
                                showAddItemDialog(context, provider,
                                    id: entry.sId, detailsItem: item);
                              },
                              child: const Icon(Icons.edit))),
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
                          DataCell(Text(item.lastEditedBy ?? '')),
                          DataCell(
                            DropdownButton<String>(
                              value: provider.selectedStatus,
                              items: const [
                                DropdownMenuItem(
                                  value: 'Pending',
                                  child: Text(
                                    'Pending',
                                    style:
                                        TextStyle(color: AppPallete.errorColor),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Finished',
                                  child: Text(
                                    'Finished',
                                    style: TextStyle(
                                        color: AppPallete.enabledGreen),
                                  ),
                                ),
                              ],
                              onChanged: (String? newValue) async {
                                if (newValue != null) {
                                  await provider.updateStatus(
                                      entry.sId!, item.sId!, newValue);
                                  if (provider.isSuccess == true) {
                                    if (context.mounted) {
                                      showSnackBar(context, provider.message);
                                    }
                                  } else {
                                    if (context.mounted) {
                                      showSnackBar(context,
                                          '${provider.message}, Please refresh the app and try again.');
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    }
                                  }
                                }
                              },
                            ),
                          ),
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
