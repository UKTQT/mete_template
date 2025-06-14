import 'package:com_nectrom_metetemplate/core/base/base_scaffold.dart';
import 'package:com_nectrom_metetemplate/core/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        title: TextWidget(
          title: "Example Screen",
        ),
      ),
      body: Column(
        children: [
          TextWidget(
            title: "Example Screen",
          ),
        ],
      ),
    );
  }
}
