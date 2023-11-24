import 'package:flutter/material.dart';

class CustTextFormSign extends StatelessWidget {
  CustTextFormSign({required this.valid,required this.hint,required this.myController, super.key});
  late String hint;
  final String? Function(String?) valid;
  late TextEditingController myController;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(bottom: 25),
      child: TextFormField(
        controller: myController,
        validator: valid ,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(25),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
