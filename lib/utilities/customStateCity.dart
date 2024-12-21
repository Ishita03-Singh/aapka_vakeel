import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

class cutsomStateCity{

  static   statecityInput(Function countryChangeCallback,Function stateChangeCallback,Function cityChangeCallback,){
        return   CSCPicker(
                  // disableCountry:true,
                  defaultCountry:CscCountry.India,
                  currentCountry: CscCountry.India.toString(),
                  showCities: true,
                  showStates: true,
                   dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      border:
                      Border.all(color: Colors.grey.shade300, width: 1)),

                  ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                  disabledDropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey.shade300,
                      border:
                      Border.all(color: Colors.grey.shade300, width: 1)),
                  stateSearchPlaceholder: "State",
                  citySearchPlaceholder: "City",
                  stateDropdownLabel: "State",
                  cityDropdownLabel: "City",
                
                  selectedItemStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  dropdownHeadingStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),

                  dropdownItemStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),

                  ///Dialog box radius [OPTIONAL PARAMETER]
                  dropdownDialogRadius: 10.0,

                  onCountryChanged: (value) {
                    countryChangeCallback();
                    // setState(() {
                    //   ///store value in state variable
                    //   StateController.text = value??'';
                    // });
                  },
                  ///Search bar radius [OPTIONAL PARAMETER]
                  searchBarRadius: 10.0,
                  onStateChanged: (value) {
                    stateChangeCallback();
                    // setState(() {
                    //   ///store value in state variable
                    //   StateController.text = value??'';
                    // });
                  },

                  ///triggers once city selected in dropdown
                  onCityChanged: (value) {
                    cityChangeCallback();
                    // setState(() {
                    //   ///store value in city variable
                    //   CityController.text = value??'';
                    // });
                  },
                );


  }
}
