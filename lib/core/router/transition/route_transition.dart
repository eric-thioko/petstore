import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteTransition {
  RouteTransition._();
  
  static fade({required Widget child, required LocalKey key}) =>
      CustomTransitionPage(
        key: key,
        child: child,
        transitionDuration: Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: child,
          );
        },
      );
  
  static slideIn({required Widget child, required LocalKey key, Offset begin = const Offset(1.0, 0.0),
  int? duration,
  }) =>
      CustomTransitionPage(
        key: key,
        child: child,
        transitionDuration: Duration(milliseconds: duration ?? 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: begin,
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child,
          );
        },
      );
  
  static scale({required Widget child, required LocalKey key}) =>
      CustomTransitionPage(
        key: key,
        child: child,
        transitionDuration: Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: child,
          );
        },
      );
  
  static rotate({required Widget child, required LocalKey key}) =>
      CustomTransitionPage(
        key: key,
        child: child,
        transitionDuration: Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return RotationTransition(
            turns: Tween<double>(begin: 0.5, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: child,
          );
        },
      );
  
  static slideFade({required Widget child, required LocalKey key, Offset begin = const Offset(1.0, 0.0)}) =>
      CustomTransitionPage(
        key: key,
        child: child,
        transitionDuration: Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(begin: begin, end: Offset.zero).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: child,
            ),
          );
        },
      );
}
