import 'package:flutter/material.dart';

class HorizontalStepper extends StatefulWidget {
  const HorizontalStepper(
      {super.key, required this.steps, required this.formKey});

  final Map<String, Widget> steps;
  final List<GlobalKey<FormState>?> formKey;

  @override
  State<HorizontalStepper> createState() => _HorizontalStepperState();
}

class _HorizontalStepperState extends State<HorizontalStepper> {
  int currentStep = 0;

  StepState _getStepState(int index) {
    if (currentStep > index) {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }

  void _onStepContinue() {
    if (currentStep != widget.steps.length - 1) {
      if (widget.formKey[currentStep]!.currentState!.validate() == false) {
        setState(() => currentStep += 1);
      }
    } else {
      Navigator.popAndPushNamed(context, "/studentprofile");
    }
  }

  void _onStepCancel() {
    setState(() => currentStep -= 1);
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.horizontal,
      steps: List<Step>.generate(
        widget.steps.length,
        (int index) {
          return Step(
            isActive: currentStep >= index,
            label: Text(
              widget.steps.keys.elementAt(index),
              style: const TextStyle(fontSize: 12),
            ),
            state: _getStepState(index),
            title: const Text(''),
            content: widget.steps.values.elementAt(index),
          );
        },
      ),
      controlsBuilder: (context, details) => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          children: <Widget>[
            if (currentStep != 0 && currentStep != widget.steps.length - 1)
              Expanded(
                child: OutlinedButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Back'),
                ),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: details.onStepContinue,
                child: Text(currentStep != widget.steps.length - 1
                    ? 'Next'
                    : 'Back home'),
              ),
            ),
          ],
        ),
      ),
      currentStep: currentStep,
      onStepContinue: _onStepContinue,
      onStepCancel: _onStepCancel,
    );
  }
}
