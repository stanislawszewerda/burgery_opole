import 'package:burgery_opole/App/Home/restaurants/cubit/restaurants_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantPageContent extends StatelessWidget {
  const RestaurantPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantsCubit()..start(),
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
            return const Center(child: CircularProgressIndicator());
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
        },
      ),
    );
  }
}
