// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:paainet/features/Presentation/widgets/your_space_widget/add_card.dart';
// import 'package:paainet/features/Presentation/widgets/your_space_widget/task_tile.dart';
// import 'package:paainet/features/Presentation/widgets/your_space_widget/agent_card.dart';

// class YourSpaceTab extends StatelessWidget {
//   const YourSpaceTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SectionTitle("Your agents"),
//             Wrap(
//               spacing: 12,
//               runSpacing: 12,
//               children: [
//                 AgentCard(name: "Calendar Buddy", task: "Plan your week"),
//                 AgentCard(name: "Idea Genie", task: "Brainstorm startup ideas"),
//                 AgentCard(name: "Mood Mate", task: "Give pep talks"),
//                 AddAgentCard(),
//               ],
//             ),
//             SizedBox(height: 30),
//             SectionTitle("Tasks"),
//             TaskTile(task: "Organize calendar for next week"),
//             TaskTile(task: "Finish UI draft with DesignBot"),
//             TaskTile(task: "Get AI to summarize today's research"),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SectionTitle extends StatelessWidget {
//   final String title;
//   const SectionTitle(this.title, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: GoogleFonts.sora(fontSize: 18, fontWeight: FontWeight.bold),
//     );
//   }
// }
