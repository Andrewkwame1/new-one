import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/auth/auth_screen.dart';
import 'package:myapp/student/face_recognition_screen.dart';
import 'package:myapp/student/student_home_screen.dart';
import 'package:myapp/teacher/add_class_screen.dart';
import 'package:myapp/teacher/class_attendance_screen.dart';
import 'package:myapp/teacher/teacher_home_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: FaceRecognitionAttendanceApp(),
    ),
  );
}

class FaceRecognitionAttendanceApp extends StatelessWidget {
  const FaceRecognitionAttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    const MaterialColor primarySeedColor = Colors.blue;

    final TextTheme appTextTheme = TextTheme(
      displayLarge:
          GoogleFonts.oswald(fontSize: 57, fontWeight: FontWeight.bold),
      titleLarge: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w500),
      bodyMedium: GoogleFonts.openSans(fontSize: 14),
      labelLarge: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
    );

    final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeedColor,
        brightness: Brightness.light,
      ),
      textTheme: appTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: primarySeedColor,
        foregroundColor: Colors.white,
        titleTextStyle:
            GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primarySeedColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle:
              GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );

    final ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeedColor,
        brightness: Brightness.dark,
      ),
      textTheme: appTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        titleTextStyle:
            GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: primarySeedColor.shade200,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle:
              GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );

    final GoRouter router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const AuthScreen();
          },
        ),
        GoRoute(
          path: '/teacher',
          builder: (BuildContext context, GoRouterState state) {
            return const TeacherHomeScreen();
          },
        ),
        GoRoute(
          path: '/teacher/add_class',
          builder: (BuildContext context, GoRouterState state) {
            return const AddClassScreen();
          },
        ),
        GoRoute(
          path: '/teacher/class/:classId/attendance',
          builder: (BuildContext context, GoRouterState state) {
            final classId = state.pathParameters['classId']!;
            return ClassAttendanceScreen(classId: classId);
          },
        ),
        GoRoute(
          path: '/student',
          builder: (BuildContext context, GoRouterState state) {
            return const StudentHomeScreen();
          },
        ),
        GoRoute(
          path: '/student/face_recognition',
          builder: (BuildContext context, GoRouterState state) {
            final extra = state.extra as Map<String, dynamic>;
            return FaceRecognitionScreen(
              classId: extra['classId'],
              studentId: extra['studentId'],
              cameraDescription: extra['cameraDescription'],
            );
          },
        ),
      ],    );

    return MaterialApp.router(
      routerConfig: router,
      title: 'Face Recognition Attendance',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}
