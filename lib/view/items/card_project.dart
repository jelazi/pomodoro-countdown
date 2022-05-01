import 'package:flutter/material.dart';

import '../../models/project.dart';

class CardProject extends StatefulWidget {
  Project project;
  CardProject(this.project);

  @override
  State<CardProject> createState() => _CardProjectState();
}

class _CardProjectState extends State<CardProject> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(widget.project.nameProject),
    );
  }
}
