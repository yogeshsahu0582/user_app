import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<HomeProvider>(context, listen: false).loadWorkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6FE7DD),

        title: const Text("PA Nearby Workers"),
      ),

      body: homeProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: homeProvider.workers.length,

              itemBuilder: (context, index) {
                final worker = homeProvider.workers[index];

                return Card(
                  margin: const EdgeInsets.all(10),

                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF6FE7DD),

                      child: Text(worker.name[0]),
                    ),

                    title: Text(worker.name),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(worker.skillType),

                        Text("⭐ ${worker.rating}"),
                      ],
                    ),

                    trailing: ElevatedButton(
                      onPressed: () async {
                        bool success = await homeProvider.bookWorker(
                          userId: 1,
                          serviceType: worker.skillType,
                        );

                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Booking Created")),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Booking Failed")),
                          );
                        }
                      },

                      child: const Text("Book"),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
