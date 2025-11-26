
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade200, Colors.grey.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Face Recognition Attendance',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 50),
              _buildLoginButton(
                context,
                'Login as Teacher',
                () => context.go('/teacher_home'),
                Icons.person_outline,
              ),
              const SizedBox(height: 20),
              _buildLoginButton(
                context,
                'Login as Student',
                () => context.go('/student_home'),
                Icons.school_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(
    BuildContext context,
    String text,
    VoidCallback onPressed,
    IconData icon,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 24),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.teal.shade800,
        backgroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 15,
        ),
      ),
    );
  }
}
