import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:haash_moving_chart/cores/theme/provider/theme_provider.dart';
import 'package:haash_moving_chart/cores/utils/show_snackbar.dart';
import 'package:haash_moving_chart/cores/widgets/app_clossing_function.dart';
import 'package:haash_moving_chart/cores/widgets/shimmer_effect.dart';
import 'package:haash_moving_chart/cores/widgets/spacer.dart';
import 'package:haash_moving_chart/features/chart/data/model/entry_model.dart';
import 'package:haash_moving_chart/features/chart/presentation/provider/entry_provider.dart';
import 'package:haash_moving_chart/features/chart/presentation/screens/add_entry.dart';
import 'package:haash_moving_chart/features/chart/presentation/screens/view_entry.dart';
import 'package:haash_moving_chart/features/chart/presentation/widgets/drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static route() => MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Moving Chart'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Consumer<EntryProvider>(builder: (context, provider, __) {
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
                  onChanged: (e) => provider.locationChanged(e));
            }),
          ),
        ],
      ),
      drawer: HomeDrawer(
        user: user,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNewEntry()));
        },
        icon: const Icon(Icons.add),
        label: const Text('New Entry'),
      ),
      body: WillPopScopWidget(
        child: Consumer<EntryProvider>(builder: (context, provider, child) {
          return FutureBuilder(
              future: provider.allEntries,
              builder: (context, AsyncSnapshot<List<EntryModel>> snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final filteredIitems = snapshot.data!
                      .where((element) =>
                          element.location == provider.selectedLocation)
                      .toList();
                  return RefreshIndicator(
                    onRefresh: () {
                      provider.getEntries();
                      return Future.delayed(const Duration(seconds: 2));
                    },
                    child: ListView.separated(
                      itemCount: filteredIitems.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = filteredIitems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
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
                                backgroundColor:
                                    const Color.fromARGB(202, 221, 221, 221),
                                child: Text(
                                  item.idNo!,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                              title: Text(item.challanNo!,
                                  style: const TextStyle(fontSize: 16)),
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
      ),
    );
  }
}
