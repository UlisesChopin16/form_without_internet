import 'package:flutter/material.dart';

class IconsManager {
  static const IconData pendingAssigment = Icons.assignment_late_outlined;
  static const IconData inProgressAssigment = Icons.pending_actions_rounded;
  static const IconData completedAssigment = Icons.assignment_turned_in_outlined;
  static const IconData totalAssigments = Icons.assignment_outlined;
  static const IconData realizeAssigment = Icons.assignment_rounded;
  static const IconData resumeAssigment = Icons.assignment_turned_in;
  static const IconData circleCheck = Icons.check_circle_outline;

  static const List<IconData> iconsStatusAssigment = [
    pendingAssigment,
    inProgressAssigment,
    completedAssigment,
    totalAssigments,
  ];
}
