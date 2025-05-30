import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paainet/utils/themeData/const.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  final List<Map<String, dynamic>> featureCards = [
    {
      "title": "Time-Aware Intelligence",
      "description":
          """In the real world, most of our tasks and goals are bound by the arrow of time — they unfold over days, weeks, and months. But today’s LLMs (Large Language Models) don’t live in that timeline. They just give you an output and move on.
Let’s say you tell an LLM: “I have an exam in 30 days and I haven’t prepared. Help me ace it.” You’ll get a study plan, some resources, and that’s it — the rest is on you.
But that’s where Paainet is different. Paainet doesn’t just hand you a plan. It lives through your journey. It grows with your progress. It checks in with you daily, feeds you personalized notes, curated resources, motivation, questions — and pushes you forward, even when you don’t ask. It doesn’t just respond. It evolves with you.
This is the magic of Paainet — a system that doesn’t just help you plan success, it walks with you until you achieve it.""",
      "color": AppColors.button,
      "icon": Icons.timer,
    },
    {
      "title": "Type Less, Get More",
      "description":
          """I believe everyone deserves amazing outcomes from AI — not just the tech-savvy. Right now, "Great Prompts = Great Output." But here’s the catch: writing a great prompt requires communication skills, writing ability, and a lot of structured thinking.
Not everyone has that, and honestly, not everyone wants to learn prompt engineering. People like my mom, my grandfather, even kids — they don’t want to master prompt hacks. They just want great results. Period.
And most of the time, people don’t even know what they need until they see it. That’s where AI should step in. That’s where Paainet steps in.
Paainet is built around a simple belief: one command should be enough. From there, it figures out the rest — no back-and-forth, no fancy prompts. We’ve curated a massive database of real, high-quality prompts tested across the internet and stored them as embeddings in a powerful vector database. This allows Paainet’s internal engine to fetch the right intent, instantly, and deliver results that feel tailor-made — without users ever typing another word.
That’s not just smart AI. That’s thoughtful AI — for everyone.""",
      "color": AppColors.success,
      "icon": Icons.keyboard_alt_outlined,
    },
    {
      "title": "Future of AI Interaction",
      "description":
          """We made a promise — Paainet will change the way people interact with AI.
Right now, the experience is clunky. You need to be time-aware, write long, detailed prompts, and think way too much. Honestly, that’s not how AI should feel. That’s not how magic should feel.
We want the experience to be effortless — less thinking, less typing, more doing. Just smooth, powerful results.
Our long-term vision for Paainet is bold: to make AI a truly general platform for everyone. A space where anyone — from a student to a grandparent — can interact with AI in the most natural, seamless way. A platform where you don’t just use AI, but collaborate with it. Share ideas. Build with others. Connect through intelligent AI avatars that grow with you.
This isn’t just the future of AI. It’s the future of human potential — and Paainet is building that bridge.""",
      "color": AppColors.buttonHover,
      "icon": Icons.auto_awesome,
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.background,
              AppColors.background.withOpacity(0.9),
              AppColors.background.withOpacity(0.8),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _opacityAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    const SizedBox(height: 60),
                    FadeTransition(
                      opacity: _opacityAnimation,
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              style: GoogleFonts.lato(
                                fontSize: 70,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                              ),
                              children: const [
                                TextSpan(
                                    text: "P",
                                    style: TextStyle(color: AppColors.text)),
                                TextSpan(
                                    text: "a",
                                    style: TextStyle(color: AppColors.text)),
                                TextSpan(
                                    text: "a",
                                    style: TextStyle(color: Colors.blue)),
                                TextSpan(
                                    text: "i",
                                    style: TextStyle(color: Colors.red)),
                                TextSpan(
                                    text: "Net",
                                    style: TextStyle(color: AppColors.text)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              style: GoogleFonts.sora(
                                fontSize: 20,
                                wordSpacing: 5,
                              ),
                              children: const [
                                TextSpan(
                                    text: "Own",
                                    style: TextStyle(color: Colors.blue)),
                                TextSpan(text: " "),
                                TextSpan(
                                    text: "freedom",
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Changing how humans interact with AI",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sora(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 50),
                    ...featureCards
                        .map((card) => _buildFeatureCard(card))
                        .toList(),
                    const SizedBox(height: 40),
                    _buildMissionSection(),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeatureCard(Map<String, dynamic> card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: card["color"].withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: card["color"].withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              card["icon"],
              size: 40,
              color: card["color"],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card["title"],
                      style: GoogleFonts.lato(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      card["description"],
                      style: GoogleFonts.sora(
                        fontSize: 16,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionSection() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.button.withOpacity(0.15),
            AppColors.secondaryButtonBg.withOpacity(0.15),
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            "Our Mission",
            style: GoogleFonts.lato(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            """Paainet’s mission is simple — to make AI easy and accessible for everyone.
Not just for developers, hackers, or early adopters — but for everyday people. For our moms, our grandparents, our little siblings.

We want them to feel empowered.
To own their freedom — the freedom to create, the freedom to grow, the freedom to dream bigger.

Freedom to ace life.
Freedom to think — with AI by their side, not behind a wall of complex prompts or tech barriers.

That’s the world Paainet is building — and everyone deserves a place in it.

""",
            textAlign: TextAlign.center,
            style: GoogleFonts.sora(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 30),
          OutlinedButton(
            onPressed: () {
              context.goNamed('login');
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Experience Freedom",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.button,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
