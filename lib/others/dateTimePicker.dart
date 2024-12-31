import 'package:flutter/material.dart';

 class CustomDateTimePicker {

   Future<DateTime?> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    return pickedDate;
  }

   Future<TimeOfDay?> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    // if (pickedTime != null )
     return pickedTime;
    
  }

  
  
}

CustomDateTimePicker customDateTimePicker= CustomDateTimePicker();