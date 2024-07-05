import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:haash_moving_chart/cores/theme/color_pellets.dart';
import 'package:haash_moving_chart/cores/widgets/spacer.dart';
import 'package:haash_moving_chart/features/chart/presentation/provider/entry_provider.dart';
import 'package:provider/provider.dart';

class ViewEntryItems extends StatelessWidget {
  const ViewEntryItems({super.key, required this.provider});
  final EntryProvider provider;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moving Items'),
      ),
      body: Consumer<EntryProvider>(builder: (context, provider, child) {
        return provider.items.isEmpty
            ? const Center(child: Text('No items added'))
            : ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListTile(
                      title: Text(
                        '${provider.items[index].model!} - ${provider.items[index].bundleNo!}',
                      ),
                      subtitle: Text(
                        '${provider.items[index].color!} - ${provider.items[index].size!}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              'Qty: ${provider.items[index].quantity!.toString()}'),
                          const SpacerWidget(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () => provider.deleteItems(index),
                            child: const Icon(
                              Icons.delete_forever_rounded,
                              color: AppPallete.errorColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SpacerWidget(
                    height: 5,
                  );
                },
                itemCount: provider.items.length,
              );
      }),
    );
  }
}
