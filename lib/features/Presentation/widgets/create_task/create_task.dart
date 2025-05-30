import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paainet/utils/themeData/const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class CreateTask extends StatefulWidget {
  final VoidCallback? onTaskCreated;
  const CreateTask({super.key, this.onTaskCreated});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final TextEditingController _taskController = TextEditingController();
  final Uuid _uuid = const Uuid();
  bool _isLoading = false;
  bool _isCheckingLimit = true;
  int _currentTaskCount = 0;
  final int _maxTasks = 3;

  @override
  void initState() {
    super.initState();
    _checkTaskCount();
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  Future<void> _checkTaskCount() async {
    setState(() {
      _isCheckingLimit = true;
    });

    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;

      if (user != null) {
        final response =
            await supabase.from('tasks').select('id').eq('lid', user.id);

        setState(() {
          _currentTaskCount = response.length;
          _isCheckingLimit = false;
        });
      }
    } catch (e) {
      print('Error checking task count: $e');
      setState(() {
        _isCheckingLimit = false;
      });
    }
  }

  int get _remainingTasks => _maxTasks - _currentTaskCount;
  bool get _hasReachedLimit => _currentTaskCount >= _maxTasks;

  String get _limitMessage {
    if (_hasReachedLimit) {
      return "You have reached the task limit!";
    } else if (_remainingTasks == 1) {
      return "1 task remaining";
    } else {
      return "$_remainingTasks tasks remaining";
    }
  }

  Future<void> _handleDone() async {
    // Check limit before proceeding
    if (_hasReachedLimit) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ You have exceeded the task limit!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final task = _taskController.text.trim();

    if (task.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task')),
      );
      return;
    }

    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Double-check the limit right before inserting
      final currentResponse =
          await supabase.from('tasks').select('id').eq('lid', user.id);

      if (currentResponse.length >= _maxTasks) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ Task limit reached! Cannot create more tasks.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Generate a unique UUID for this task
      final taskId = _uuid.v4();

      // Debug: Print the generated UUID
      print('Generated Task ID: $taskId');

      await supabase.from('tasks').insert({
        'id': taskId,
        'user_task': task,
        'lid': user.id,
        'time': 'No time set yet',
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('✅ Task created successfully (REFRESH THE PAGE PLEASE)')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Full error details: $e');

      // Check if it's specifically a duplicate key error
      if (e.toString().contains('duplicate key')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('❌ Duplicate key error - check your table setup')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Failed to create task: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.button),
        title: Text(
          "Create Task",
          style: GoogleFonts.lato(
            fontSize: 24,
            color: AppColors.text,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _taskController,
              style: GoogleFonts.lato(color: AppColors.text),
              maxLines: 7,
              minLines: 7,
              enabled: !_hasReachedLimit,
              decoration: InputDecoration(
                hintText: _hasReachedLimit
                    ? "Task limit reached - cannot create more tasks"
                    : "Give any task....",
                hintStyle: TextStyle(
                  color: _hasReachedLimit ? Colors.red : Colors.grey,
                ),
                filled: true,
                fillColor: _hasReachedLimit
                    ? const Color(0xFFF5F5F5)
                    : const Color(0xFFF9F9F9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Task limit status
            if (_isCheckingLimit)
              const Center(child: CircularProgressIndicator())
            else
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: _hasReachedLimit
                      ? Colors.red.shade50
                      : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _hasReachedLimit
                        ? Colors.red.shade200
                        : Colors.blue.shade200,
                  ),
                ),
                child: Text(
                  _limitMessage,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: _hasReachedLimit
                        ? Colors.red.shade700
                        : Colors.blue.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: (_isLoading || _hasReachedLimit || _isCheckingLimit)
                    ? null
                    : _handleDone,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _hasReachedLimit
                      ? Colors.grey.shade400
                      : AppColors.button,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 3,
                        ),
                      )
                    : Text(
                        _hasReachedLimit ? "Limit Reached" : "Create",
                        style: GoogleFonts.sora(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          color: _hasReachedLimit ? Colors.white : null,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
