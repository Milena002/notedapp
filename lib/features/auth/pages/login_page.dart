import 'package:country_picker/country_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:notedapp/common/utils/constants.dart';
import 'package:notedapp/common/widgets/appstyle.dart';
import 'package:notedapp/common/widgets/custom_outline_btn.dart';

import 'package:notedapp/common/widgets/custom_textfield.dart';
import 'package:notedapp/common/widgets/height_spacer.dart';

import 'package:notedapp/common/widgets/reusable_text.dart';

import 'package:notedapp/common/widgets/show_alert_dialog.dart';
import 'package:notedapp/features/auth/controllers/auth_controller.dart';
import 'package:notedapp/features/auth/controllers/code_provider.dart';
import 'package:notedapp/features/auth/pages/otp_page.dart'; // Import the updated CustomTextField widget
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}
class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phone = TextEditingController();
 
  Country country = Country(
      phoneCode: "44",
      countryCode: "UK",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "UK",
      example: "UK",
      displayName: "United Kingdom",
      displayNameNoCountryCode: "UK",
      e164Key: ""
    );
 
 sendCodeToUser(){
  if(phone.text.isEmpty){
    return showAlertDialog(
      context: context, message: "Please Enter Your Phone Number");
  }else if(phone.text.length < 8){
     return showAlertDialog(
      context: context, message: "Your Number is too short");
  }else{
    print('+${country.phoneCode}${phone.text}');
    ref.read(authControllerProvider).sendSms(
    context: context, 
    phone: '+${country.phoneCode}${phone.text}');
  }
 }
 
 
  @override
  Widget build(BuildContext context) {
    

   
    
    // Function to handle button press
    void handleSendCode() {
      // Your logic to send the code
      print("Send Code button pressed!");
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Center(
                child: Image.asset(
                  "assets/images/login-icon.png",
                  width: 200,
                  height: 200,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 35),
                child: Text(
                  "Please Enter Your Phone Number: ",
                  style: appstyle(17, AppConst.kCharcoal, FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: CustomTextField(
                  controller: phone,
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(14),
                    child: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                         context: context, 
                          countryListTheme: CountryListThemeData(
                            backgroundColor: AppConst.kWhite,
                            bottomSheetHeight: AppConst.kHeight*0.6,
                            borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppConst.kRadius),
                            topRight: Radius.circular(AppConst.kRadius),
                          )
                        ),
                        onSelect: (code){
                          setState(() {
                            country = code;
                          });
                        });
                      },
                      child: ReusableText(
                        text: "${country.flagEmoji} + ${country.phoneCode}", 
                        style: appstyle(18, AppConst.kBlack, FontWeight.bold)),
                    ),
                  ),
                  keyboard: TextInputType.number,
                  hintText: "Enter Phone Number",
                  hintStyle: appstyle(16, AppConst.kCharcoal, FontWeight.w600),
                 // onButtonPressed: handleSendCode,
                ),
              ),
              const HeightSpacer(height: 20),
              Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomOutlineBtn(
                onTap: (){
                  sendCodeToUser();
                },
                
              width: AppConst.kWidth*0.85, 
              height: AppConst.kHeight*0.07, 
              color: AppConst.kCharcoal, 
              color2: AppConst.kTeaGreen,
              text: "Send Code"),

            )  
            ] 
          ),
        ),
      ),
    );
  }
}