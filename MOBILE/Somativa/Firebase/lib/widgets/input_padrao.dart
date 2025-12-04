import 'package:flutter/material.dart';

Widget inputPadrao({
  required TextEditingController controller,
  required String label,
  bool obscure = false,
}) {
  return TextField(
    controller: controller,
    obscureText: obscure,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.85),
      labelText: label,
      labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),
    style: const TextStyle(fontSize: 16),
  );
}
