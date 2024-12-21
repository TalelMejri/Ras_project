import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? prefixIcon;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText; // Initialize with provided obscureText value
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText ? _isObscured : false,
      style: const TextStyle(
        color: Colors.white, // Set the input text color to white
      ),
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: const Color(0xFF606060), // Icon color
                size: 20, // Adjust the size of the icon if needed
              )
            : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFF606060),
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 56, 56, 56)),
          borderRadius: BorderRadius.circular(10), // Rounded border for the field
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 142, 142, 142)),
          borderRadius: BorderRadius.circular(10), // Rounded border for the field
        ),
        fillColor: const Color(0xFF262626),
        filled: true,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Color(0xFF606060),
        ),
      ),
    );
  }
}
