import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Utilities/button_style.dart';
import '../Utilities/colors.dart';
// import 'custom_outlined_icons_icons.dart';
import 'custom_text.dart';

class CustomButton {
  // addServerButton(Function onpress) => ElevatedButton(
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: AppColor.tertiaryColor,
  //       foregroundColor: AppColor.tertiaryColor,
  //       elevation: 5,
  //       padding: const EdgeInsets.all(10),
  //       shadowColor: AppColor.secondaryColor,
  //       shape: const CircleBorder(),
  //       side: BorderSide(color: AppColor.tertiaryColor, width: 2),
  //       fixedSize: const Size(52, 52),
  //     ),
  //     onPressed: () => onpress(),
  //     child: Icon(Icons.add, color: AppColor.tertiaryTextColor));

  overlayButton(IconData icon, String text, Function onPress) => Padding(
      padding: kIsWeb
          ? const EdgeInsets.fromLTRB(0, 10, 0, 0)
          : const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: TextButton(
          onPressed: () => onPress(),
          style: MyButtonStyle.overlay_buttons_left,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style:
                    TextStyle(color: AppColor.secondaryTextColor, fontSize: 16),
              ),
              Icon(
                icon,
                color: AppColor.iconColor,
                size: 20,
              ),
            ],
          )));

  iconButton(BuildContext context, String msg, IconData icon, Function() fun) =>
      Tooltip(
          message: msg,
          child: IconButton(
              // color: AppColor.bgColor,
              onPressed: fun,
              //splashColor: AppColor.secondaryColor.withOpacity(0.5),
              // CustomNavigator.pushRTL(context, const Settings()),
              // const Settings()),
              style: TextButton.styleFrom(
                  // backgroundColor: AppColor.bgColor,
                  fixedSize: const Size(10, 10),
                  elevation: 0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.zero),
              icon: Icon(icon, color: Colors.black)));

  // cancel Button -> LoaderOverlay - Lottie Animation
  cancelButton(String text, Function onPressed) => TextButton(
      style: TextButton.styleFrom(
          padding: const EdgeInsets.all(10.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          foregroundColor: AppColor.tertiaryColor,
          backgroundColor: AppColor.secondaryColor,
          // minimumSize: const Size(100, 30),
          elevation: 0,
          shadowColor: AppColor.secondaryColor),
      onPressed: () => onPressed(),
      child: CustomText.cancelBtnText(text));

  taskButton(String text, Function() onPressed) => TextButton(
      style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          foregroundColor: AppColor.tertiaryColor,
          backgroundColor: Colors.black,
          // minimumSize: const Size(100, 30),
          elevation: 0,
          shadowColor: AppColor.secondaryColor),
      onPressed: onPressed,
      child: CustomText.taskBtnText(text));

  gridButton(BuildContext context, int index, String msg, IconData icon,
          Function fun) =>
      Tooltip(
          message: msg,
          child: IconButton(

              // color: AppColor.bgColor,
              //  onPressed: () => onPressed(index),
              onPressed: () => fun(index),
              // CustomNavigator.pushRTL(context, const Settings()),
              // const Settings()),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              style: IconButton.styleFrom(
                  // backgroundColor: Colors.amber,
                  // fixedSize: const Size(20, 20),
                  elevation: 0,
                  // minimumSize: const Size(50, 10),
                  padding: EdgeInsets.zero),
              icon: Icon(
                icon,
                color: AppColor.iconColor,
                size: 20,
              )));

  closeButton(BuildContext context, int index, String msg, IconData icon,
          Function fun) =>
      Tooltip(
          message: msg,
          child: IconButton(

              // color: AppColor.bgColor,
              //  onPressed: () => onPressed(index),
              onPressed: () => fun(index),
              // CustomNavigator.pushRTL(context, const Settings()),
              // const Settings()),

              constraints: const BoxConstraints(),
              style: IconButton.styleFrom(
                  // backgroundColor: Colors.amber,
                  // fixedSize: const Size(20, 20),
                  elevation: 0,
                  // minimumSize: const Size(50, 10),
                  padding: EdgeInsets.zero),
              icon: Icon(
                icon,
                color: Colors.red,
                size: 20,
              )));

  scBarButton(BuildContext context, String msg, IconData icon, Function() fun) {
    return Column(
      children: [
        IconButton(
            // color: AppColor.bgColor,
            onPressed: fun,
            // CustomNavigator.pushRTL(context, const Settings()),
            // const Settings()),
            style: TextButton.styleFrom(
                backgroundColor: AppColor.bgColor,
                fixedSize: const Size(20, 20),
                elevation: 0,
                minimumSize: const Size(20, 20),
                padding: EdgeInsets.zero),
            icon: Icon(icon, color: AppColor.iconColor)),
        Text(
          msg,
          style: TextStyle(
              color: AppColor.iconColor,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  customTextButton(Widget child, Function() fun,
      {Color color = Colors.transparent}) {
    return TextButton(
      onPressed: fun,
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
      child: child,
    );
  }
}

CustomButton customButton = CustomButton();
