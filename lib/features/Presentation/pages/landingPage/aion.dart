import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:paainet/utils/themeData/const.dart';

class Aion extends StatefulWidget {
  const Aion({super.key});

  @override
  State<Aion> createState() => _AionState();
}

class _AionState extends State<Aion> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeroSection(),
                  const SizedBox(height: 40),
                  _buildArchitectureSection(),
                  const SizedBox(height: 60),
                  _buildAGIPathSection(),
                  const SizedBox(height: 60),
                  _buildTechnicalInnovationSection(),
                  const SizedBox(height: 80),
                  _buildCTASection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'AION-1',
                  textStyle: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                    letterSpacing: 1.2,
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 1,
            ),
            const SizedBox(height: 20),
            Text(
              'The Cognitive Architecture for AGI',
              style: TextStyle(
                fontSize: 24,
                color: AppColors.text.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArchitectureSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AION-1 Core Architecture',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _buildArchitectureCard(
              icon: Icons.sync,
              title: 'Recursive Validation',
              description:
                  'Self-correcting AI through multi-layered verification',
            ),
            _buildArchitectureCard(
              icon: Icons.account_tree,
              title: 'Economic Attention',
              description: 'Resource-aware cognitive allocation system',
            ),
            _buildArchitectureCard(
              icon: Icons.memory,
              title: 'Stateful Cognition',
              description: 'Persistent memory and contextual awareness',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildArchitectureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 40, color: AppColors.button),
          const SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              color: AppColors.text.withOpacity(0.8),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAGIPathSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Path to Artificial General Intelligence',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 30),
        _buildTimelineEntry(
          title: 'Recursive Validation',
          description: 'Multi-layered self-correction mechanism',
          isFirst: true,
        ),
        _buildTimelineEntry(
          title: 'Economic Consciousness',
          description: 'Resource-aware decision making',
        ),
        _buildTimelineEntry(
          title: 'Cognitive Scaffolding',
          description: 'Externalized reasoning layers',
        ),
        _buildTimelineEntry(
          title: 'Meta-Learning Core',
          description: 'Continuous architecture improvement',
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildTimelineEntry({
    required String title,
    required String description,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.button,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 60,
                  color: AppColors.button.withOpacity(0.3),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    color: AppColors.text.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicalInnovationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Why AION Matters',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 30),
        _buildInnovationPoint(
          '62% Error Reduction',
          'Through recursive validation loops',
        ),
        _buildInnovationPoint(
          '40-75% Cost Savings',
          'Economic resource allocation system',
        ),
        _buildInnovationPoint(
          'Continuous Improvement',
          'Self-optimizing architecture',
        ),
      ],
    );
  }

  Widget _buildInnovationPoint(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.success),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: AppColors.text.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection() {
    return Center(
      child: Column(
        children: [
          Text(
            'Join the Cognitive Revolution',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 30),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 18,
              ),
              decoration: BoxDecoration(
                color: AppColors.button,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.button.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Text(
                'Get Early Access',
                style: TextStyle(
                  color: AppColors.buttonText,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
