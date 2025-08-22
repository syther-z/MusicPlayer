import 'package:cook_the_best/home_page.dart';
import 'package:cook_the_best/player_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Approuter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => HomePage(),),
      // GoRoute(path: '/player/:id', builder:  (context, state) => PlayerPage(idx: int.parse(state.pathParameters['id']!)),),
      GoRoute(
  path: '/player/:id',
  pageBuilder: (context, state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: PlayerPage(idx: int.parse(state.pathParameters['id']!)),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1), // Start from bottom
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  },
)

    ],
    // redirect: (context, state) => '/player',
  );

}