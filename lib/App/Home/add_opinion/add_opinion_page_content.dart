import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddOpinionPageContent extends StatefulWidget {
  const AddOpinionPageContent({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  final Function onSave;

  @override
  State<AddOpinionPageContent> createState() => _AddOpinionPageContentState();
}

class _AddOpinionPageContentState extends State<AddOpinionPageContent> {
  var restaurantName = '';
  var burgerName = '';
  var rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(25.0),
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
          Slider(
            onChanged: (newValue) {
              setState(() {
                rating = newValue;
              });
              print(rating.toString());
            },
            value: rating,
            min: 1.0,
            max: 6.0,
            divisions: 10,
            label: rating.toString(),
          ),
          Text(
            rating.toString(),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: restaurantName.isEmpty || burgerName.isEmpty
                  ? null
                  : () {
                      FirebaseFirestore.instance.collection('restaurants').add({
                        'name': restaurantName,
                        'burger': burgerName,
                        'rating': rating,
                      });
                      widget.onSave();
                    },
              child: const Text('Dodaj'))
        ],
      ),
    ));
  }
}
