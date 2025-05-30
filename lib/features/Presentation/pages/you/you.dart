import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paainet/features/Presentation/pages/you/Tabs/youtab/you_tab.dart';
import 'package:paainet/features/Presentation/widgets/create_task/create_task.dart';
import 'package:paainet/utils/themeData/const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class You extends StatefulWidget {
  const You({super.key});

  @override
  State<You> createState() => _YouState();
}

class _YouState extends State<You> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  List<Widget> _pages = [];
  bool _isLoading = true;
  String? _error;
  RealtimeChannel? _subscription;

  @override
  void initState() {
    super.initState();
    _fetchTasks();
    _setupRealtimeSubscription();
  }

  Future<void> _fetchTasks() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      // Get current user
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        setState(() {
          _error = 'User not authenticated';
          _isLoading = false;
        });
        return;
      }

      // Fetch tasks from Supabase
      final response = await Supabase.instance.client
          .from('tasks')
          .select('user_task, time')
          .eq('lid', user.id)
          .order('created_at', ascending: false);

      // Convert response to widgets
      List<Widget> pages = [];
      for (var task in response) {
        pages.add(YouTabContent(
          task: task['user_task'] ?? '',
          time: task['time'] ?? '',
        ));
      }

      setState(() {
        _pages = pages;
        _isLoading = false;
        _currentPage = 0; // Reset to first page
      });

      // Reset page controller if there are pages
      if (_pages.isNotEmpty && _pageController.hasClients) {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } catch (e) {
      setState(() {
        _error = 'Error fetching tasks: $e';
        _isLoading = false;
      });
    }
  }

  void _setupRealtimeSubscription() {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    _subscription = Supabase.instance.client
        .channel('tasks_channel')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'tasks',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'lid',
            value: user.id,
          ),
          callback: (payload) {
            // Refresh tasks when any change occurs
            _fetchTasks();
          },
        )
        .subscribe();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.animateToPage(
        ++_currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        --_currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Method to refresh tasks after creating a new one
  void _onTaskCreated() {
    // The real-time subscription will handle the refresh automatically
    // But we can still call _fetchTasks() for immediate feedback
    _fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: AppColors.background,
              insetPadding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: 380,
                  height: 500,
                  child: CreateTask(
                    onTaskCreated:
                        _onTaskCreated, // Pass callback to refresh tasks
                  ),
                ),
              ),
            ),
          );
        },
        backgroundColor: AppColors.button,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.background,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tasks",
                  style: GoogleFonts.lato(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.button,
                  ),
                ),
                const SizedBox(width: 8),
                if (_isLoading)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
          ),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              _error!,
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchTasks,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
              ),
              child: const Text(
                'Retry',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    if (_pages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.task_alt,
              color: Colors.grey,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              "No tasks yet",
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Click on '+' to create your first task",
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          itemCount: _pages.length,
          onPageChanged: (index) {
            setState(() => _currentPage = index);
          },
          itemBuilder: (context, index) => _pages[index],
        ),
        // Page indicators
        if (_pages.length > 1)
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? AppColors.button
                        : Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        // Left arrow
        if (_currentPage > 0)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: AppColors.button.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: _previousPage,
                color: AppColors.button,
              ),
            ),
          ),
        // Right arrow
        if (_currentPage < _pages.length - 1)
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: AppColors.button.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: _nextPage,
                color: AppColors.button,
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _subscription?.unsubscribe();
    super.dispose();
  }
}
