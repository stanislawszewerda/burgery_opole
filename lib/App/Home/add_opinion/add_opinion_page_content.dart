import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddOpinionPageContent extends StatefulWidget {
  const AddOpinionPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<AddOpinionPageContent> createState() => _AddOpinionPageContentState();
}

class _AddOpinionPageContentState extends State<AddOpinionPageContent> {
  var restaurantName = '';
  var burgerName = '';

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          decoration:
              const InputDecoration(hintText: 'Podaj nazwę restauracji'),
          onChanged: (newValue) {
            setState(() {
              restaurantName = newValue;
            });
          },
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          decoration: const InputDecoration(hintText: 'Podaj nazwę burgera'),
          onChanged: (newValue) {
            setState(() {
              burgerName = newValue;
            });
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance.collection('restaurants').add({
                'name': restaurantName,
                'burger': burgerName,
                'rating': 3.0
              });
            },
            child: const Text('Dodaj'))
      ],
    ));
  }
}
