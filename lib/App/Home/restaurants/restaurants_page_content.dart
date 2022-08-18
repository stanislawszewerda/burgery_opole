import 'package:burgery_opole/App/Home/restaurants/cubit/restaurants_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantPageContent extends StatelessWidget {
  const RestaurantPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantsCubit(),
      child: BlocBuilder<RestaurantsCubit, RestaurantsState>(
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                'Something went wrong ${state.errorMessage}',
              ),
            );
          }
          if (state.isLoading == true) {
            return const Center(
                child: Text('Proszę czekać trwa ładowanie danych'));
          }

          final documents = state.documents;

          return ListView(children: [
            for (final document in documents) ...[
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(document['name']),
                        Text(document['burger']),
                      ],
                    ),
                    Text(document['rating'].toString()),
                  ],
                ),
              )
            ],
          ]);

          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('restaurants')
                  .orderBy('rating', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: Text('Proszę czekać trwa ładowanie danych'));
                }

                final documents = snapshot.data!.docs;

                return ListView(children: [
                  for (final document in documents) ...[
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(document['name']),
                              Text(document['burger']),
                            ],
                          ),
                          Text(document['rating'].toString()),
                        ],
                      ),
                    )
                  ],
                ]);
              });
        },
      ),
    );
  }
}
