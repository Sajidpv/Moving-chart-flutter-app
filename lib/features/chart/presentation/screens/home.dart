import 'package:flutter/material.dart';
import 'package:haash_moving_chart/cores/theme/provider/theme_provider.dart';
import 'package:haash_moving_chart/cores/utils/show_snackbar.dart';
import 'package:haash_moving_chart/cores/widgets/shimmer_effect.dart';
import 'package:haash_moving_chart/cores/widgets/spacer.dart';
import 'package:haash_moving_chart/features/chart/data/model/entry_model.dart';
import 'package:haash_moving_chart/features/chart/presentation/provider/entry_provider.dart';
import 'package:haash_moving_chart/features/chart/presentation/screens/add_entry.dart';
import 'package:haash_moving_chart/features/chart/presentation/screens/view_entry.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moving Chart'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Consumer<ThemeProvider>(builder: (context, provider, child) {
              return GestureDetector(
                onTap: () => provider.toggleTheme(),
                child: Icon(
                  provider.isDarkMode ? Icons.wb_sunny : Icons.nights_stay,
                  size: 25,
                  color: provider.isDarkMode ? Colors.yellow : Colors.blueGrey,
                ),
              );
            }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNewEntry()));
        },
        icon: const Icon(Icons.add),
        label: const Text('New Entry'),
      ),
      body: Consumer<EntryProvider>(builder: (context, provider, child) {
        return FutureBuilder(
            future: provider.allEntries,
            builder: (context, AsyncSnapshot<List<EntryModel>> snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return RefreshIndicator(
                  onRefresh: () {
                    provider.getEntries();
                    return Future.delayed(const Duration(seconds: 2));
                  },
                  child: ListView.separated(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color.fromARGB(255, 255, 255, 255)),
                          child: GestureDetector(
                            onTap: () {
                              provider.items = item.itemDetails!;

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ViewAnEntry(entry: item)));
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey.shade300,
                                child: Text(
                                  item.idNo!,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              title: Text(item.challanNo!,
                                  style: const TextStyle(fontSize: 12)),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      item.quantity.toString(),
                                      style: const TextStyle(fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  provider.deleteEntry(item.sId!);
                                  if (provider.isSuccess) {
                                    showSnackBar(context,
                                        '${item.challanNo} is deleted successfully');
                                  }
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SpacerWidget(
                        height: 7,
                      );
                    },
                  ),
                );
              } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No Entries found!'),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const ShimmerListTile();
              }
            });
      }),
    );
  }
}
