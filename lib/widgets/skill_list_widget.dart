import 'package:flutter/material.dart';

class SkillListWidget extends StatelessWidget {
  const SkillListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: ListView(
        children: [
          Text('Skills:', style: Theme.of(context).textTheme.titleLarge),
          const Column(
            children: [
              ListTile(
                leading: Icon(Icons.check),
                title: Text('Knowledge of the Flutter framework'),
              ),
              ListTile(
                leading: Icon(Icons.check),
                title: Text('Ability to design and build user interfaces'),
              ),
              ListTile(
                leading: Icon(Icons.check),
                title: Text('Ability to write efficient and maintainable code'),
              ),
              ListTile(
                leading: Icon(Icons.check),
                title: Text('Ability to work with state management'),
              ),
              ListTile(
                leading: Icon(Icons.check),
                title: Text('Ability to work with asynchronous programming'),
              ),
              ListTile(
                leading: Icon(Icons.check),
                title: Text('Ability to test and debug Flutter applications'),
              ),
              ListTile(
                leading: Icon(Icons.check),
                title: Text(
                    'Ability to work with continuous integration and continuous delivery (CI/CD)'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
