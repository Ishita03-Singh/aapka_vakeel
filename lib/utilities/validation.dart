import 'package:flutter/material.dart';

class ValidationService{

      String? validateName(String? value) {
      if (value == null || value.isEmpty) {
        return 'Name is required';
      }
      // Regular expression to allow only alphabets and spaces
      final nameRegex = RegExp(r'^[a-zA-Z ]+$');
      if (!nameRegex.hasMatch(value)) {
        return 'Enter a valid name (only alphabets and spaces allowed)';
      }
      if (value.length < 2) {
        return 'Name must be at least 2 characters long';
      }
      return null; // No error
    }

      String? validateEmail(String? value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }
        // Regular expression for email validation
        final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
        if (!emailRegex.hasMatch(value)) {
          return 'Enter a valid email address';
        }
        return null; // No error
      }

      String? validateAddress(String? value) {
        if (value == null || value.isEmpty) {
          return 'Address is required';
        }
        if (value.length < 5) {
          return 'Address must be at least 5 characters long';
        }
        if (!RegExp(r'^[a-zA-Z0-9\s,.-]+$').hasMatch(value)) {
          return 'Address contains invalid characters';
        }
        return null; // No error
      }
      String? validatePincode(String? value) {
        if (value == null || value.isEmpty) {
          return 'Pincode is required';
        }
        // Regular expression to match a 6-digit pincode
        if (!RegExp(r'^\d{6}$').hasMatch(value)) {
          return 'Enter a valid 6-digit pincode';
        }
        return null; // No error
      }

      validate(String value,TextInputType inputType){
        if(inputType==TextInputType.name){
          return validateName(value);
        }
        if(inputType==TextInputType.emailAddress){
          return validateEmail(value);
        }
        if(inputType==TextInputType.streetAddress)
        {
          return validateAddress(value);
        }
        if(inputType==TextInputType.streetAddress)
        {
          return validateAddress(value);
        }
        //return when type is pincode
        if(inputType==TextInputType.number)
        {
          return validatePincode(value);
        }
        else{
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
        }
      }

}
ValidationService validationService= ValidationService();