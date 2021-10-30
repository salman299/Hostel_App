import 'package:flutter/material.dart';
import 'package:hostel_app/screens/hostel_form/components/drop_down.dart';
import 'package:hostel_app/screens/hostel_form/components/page1.dart';
import 'package:hostel_app/screens/hostel_form/components/page2.dart';
import 'package:hostel_app/screens/hostel_form/components/text_field.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _activeStepIndex = 0;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController whatsapp = TextEditingController();
  TextEditingController facebookUrl = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController hostelType = TextEditingController();

  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController latitute = TextEditingController(text: '27');
  TextEditingController longitute = TextEditingController(text: '49');


  List<Step> stepList() => [
        Step(
            state:
                _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 0,
            title: const Text('Hostel Desc'),
            content: Page1(
                name: name,
                phone: phone,
                email: email,
                whatsapp: whatsapp,
                facebookUrl: facebookUrl,
                gender: gender,
                hostelType: hostelType)),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text('Address'),
          content: Page2(
            county: country,
            city: city,
            longitute: longitute,
            latitute: latitute,
          ),
        ),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Confirm'),
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Name: ${name.text}'),
                Text('Email: ${email.text}'),
                Text('Latitute: ${latitute.text}'),
                Text('Longitute: ${longitute.text}'),

                const Text('Password: *****'),
              ],
            )))
      ];

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.horizontal,
      currentStep: _activeStepIndex,
      steps: stepList(),
      // physics: _activeStepIndex == 1 ? NeverScrollableScrollPhysics(): ClampingScrollPhysics(),
      onStepContinue: () {
        if (_activeStepIndex < (stepList().length - 1)) {
          setState(() {
            _activeStepIndex += 1;
          });
        } else {
          print('Submited');
        }
      },
      onStepCancel: () {
        if (_activeStepIndex == 0) {
          return;
        }

        setState(() {
          _activeStepIndex -= 1;
        });
      },
      onStepTapped: (int index) {
        setState(() {
          _activeStepIndex = index;
        });
      },
      controlsBuilder: (context, {onStepContinue, onStepCancel}) {
        final isLastStep = _activeStepIndex == stepList().length - 1;
        return Container(
          margin: EdgeInsets.only(top: 10),
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onStepContinue,
                  child:
                      (isLastStep) ? const Text('Submit') : const Text('Next'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              if (_activeStepIndex > 0)
                Expanded(
                  child: ElevatedButton(
                    onPressed: onStepCancel,
                    child: const Text('Back'),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
