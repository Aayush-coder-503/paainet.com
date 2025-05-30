import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paainet/features/Presentation/widgets/you_widgets/feed_card.dart';
import 'package:paainet/utils/themeData/const.dart';

class YouTabContent extends StatelessWidget {
  final String task;
  final String? time;

  const YouTabContent({
    super.key,
    required this.task,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 400,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 127, 112, 67),
                    Color.fromARGB(255, 21, 130, 41)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 22, 106, 40).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        task,
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                  if (time != null)
                    Positioned(
                      top: -12,
                      right: -12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                          color: AppColors.button.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.timelapse,
                                size: 16, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(
                              "For $time",
                              style: GoogleFonts.sora(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Updates",
              style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "30 May 2025",
            style: GoogleFonts.lato(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.text.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 10),
          const Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FeedCard(
                  title: "Physics",
                  subtitle:
                      """Newton’s first law states that if a body is at rest or moving at a constant speed in a straight line, it will remain at rest or keep moving in a straight line at constant speed unless it is acted upon by a force. In fact, in classical Newtonian mechanics, there is no important distinction between rest and uniform motion in a straight line; they may be regarded as the same state of motion seen by different observers, one moving at the same velocity as the particle and the other moving at constant velocity with respect to the particle. This postulate is known as the law of inertia.

The law of inertia was first formulated by Galileo Galilei for horizontal motion on Earth and was later generalized by René Descartes. Although the principle of inertia is the starting point and the fundamental assumption of classical mechanics, it is less than intuitively obvious to the untrained eye. In Aristotelian mechanics and in ordinary experience, objects that are not being pushed tend to come to rest. The law of inertia was deduced by Galileo from his experiments with balls rolling down inclined planes.

For Galileo, the principle of inertia was fundamental to his central scientific task: he had to explain how is it possible that if Earth is really spinning on its axis and orbiting the Sun, we do not sense that motion. The principle of inertia helps to provide the answer: since we are in motion together with Earth and our natural tendency is to retain that motion, Earth appears to us to be at rest. Thus, the principle of inertia, far from being a statement of the obvious, was once a central issue of scientific contention. By the time Newton had sorted out all the details, it was possible to accurately account for the small deviations from this picture caused by the fact that the motion of Earth’s surface is not uniform motion in a straight line (the effects of rotational motion are discussed below). In the Newtonian formulation, the common observation that bodies that are not pushed tend to come to rest is attributed to the fact that they have unbalanced forces acting on them, such as friction and air resistance.
""",
                  content: """
Newton’s first law states that if a body is at rest or moving at a constant speed in a straight line, it will remain at rest or keep moving in a straight line at constant speed unless it is acted upon by a force. In fact, in classical Newtonian mechanics, there is no important distinction between rest and uniform motion in a straight line; they may be regarded as the same state of motion seen by different observers, one moving at the same velocity as the particle and the other moving at constant velocity with respect to the particle. This postulate is known as the law of inertia.

The law of inertia was first formulated by Galileo Galilei for horizontal motion on Earth and was later generalized by René Descartes. Although the principle of inertia is the starting point and the fundamental assumption of classical mechanics, it is less than intuitively obvious to the untrained eye. In Aristotelian mechanics and in ordinary experience, objects that are not being pushed tend to come to rest. The law of inertia was deduced by Galileo from his experiments with balls rolling down inclined planes.

For Galileo, the principle of inertia was fundamental to his central scientific task: he had to explain how is it possible that if Earth is really spinning on its axis and orbiting the Sun, we do not sense that motion. The principle of inertia helps to provide the answer: since we are in motion together with Earth and our natural tendency is to retain that motion, Earth appears to us to be at rest. Thus, the principle of inertia, far from being a statement of the obvious, was once a central issue of scientific contention. By the time Newton had sorted out all the details, it was possible to accurately account for the small deviations from this picture caused by the fact that the motion of Earth’s surface is not uniform motion in a straight line (the effects of rotational motion are discussed below). In the Newtonian formulation, the common observation that bodies that are not pushed tend to come to rest is attributed to the fact that they have unbalanced forces acting on them, such as friction and air resistance.


Newton’s second law: F = ma
Learn how immovable objects and unstoppable forces are the same
Learn how immovable objects and unstoppable forces are the sameA lesson proving immovable objects and unstoppable forces are one and the same.
See all videos for this article
Newton’s second law is a quantitative description of the changes that a force can produce on the motion of a body. It states that the time rate of change of the momentum of a body is equal in both magnitude and direction to the force imposed on it. The momentum of a body is equal to the product of its mass and its velocity. Momentum, like velocity, is a vector quantity, having both magnitude and direction. A force applied to a body can change the magnitude of the momentum or its direction or both. Newton’s second law is one of the most important in all of physics. For a body whose mass m is constant, it can be written in the form F = ma, where F (force) and a (acceleration) are both vector quantities. If a body has a net force acting on it, it is accelerated in accordance with the equation. Conversely, if a body is not accelerated, there is no net force acting on it.

Newton’s third law: the law of action and reaction
Newton's third law of motion explained
Newton's third law of motion explainedFor every action there is an equal but opposite reaction.
See all videos for this article
Newton’s third law states that when two bodies interact, they apply forces to one another that are equal in magnitude and opposite in direction. The third law is also known as the law of action and reaction. This law is important in analyzing problems of static equilibrium, where all forces are balanced, but it also applies to bodies in uniform or accelerated motion. The forces it describes are real ones, not mere bookkeeping devices. For example, a book resting on a table applies a downward force equal to its weight on the table. According to the third law, the table applies an equal and opposite force to the book. This force occurs because the weight of the book causes the table to deform slightly so that it pushes back on the book like a coiled spring.

If a body has a net force acting on it, it undergoes accelerated motion in accordance with the second law. If there is no net force acting on a body, either because there are no forces at all or because all forces are precisely balanced by contrary forces, the body does not accelerate and may be said to be in equilibrium. Conversely, a body that is observed not to be accelerated may be deduced to have no net force acting on it.

Influence of Newton’s laws
Newton’s laws first appeared in his masterpiece, Philosophiae Naturalis Principia Mathematica (1687), commonly known as the Principia. In 1543 Nicolaus Copernicus suggested that the Sun, rather than Earth, might be at the centre of the universe. In the intervening years Galileo, Johannes Kepler, and Descartes laid the foundations of a new science that would both replace the Aristotelian worldview, inherited from the ancient Greeks, and explain the workings of a heliocentric universe. In the Principia Newton created that new science. He developed his three laws in order to explain why the orbits of the planets are ellipses rather than circles, at which he succeeded, but it turned out that he explained much more. The series of events from Copernicus to Newton is known collectively as the Scientific Revolution.

In the 20th century Newton’s laws were replaced by quantum mechanics and relativity as the most fundamental laws of physics. Nevertheless, Newton’s laws continue to give an accurate account of nature, except for very small bodies such as electrons or for bodies moving close to the speed of light. Quantum mechanics and relativity reduce to Newton’s laws for larger bodies or for bodies moving more slowly.

The Editors of Encyclopaedia Britannica
This article was most recently revised and updated by Encyclopaedia Britannica.


inertia
Table of Contents
Introduction
References & Edit History
Related Topics
Quizzes
Italian-born physicist Dr. Enrico Fermi draws a diagram at a blackboard with mathematical equations. circa 1950.
Physics and Natural Law
Discover
Los Angeles Police Department wanted flyer on Elizabeth Short, aka the "Black Dahlia," who was brutally murdered in January 1947. The FBI supported the Los Angeles Police Department in the case, including by identifying Short through her fingerprints that
America’s 5 Most Notorious Cold Cases (Including One You May Have Thought Was Already Solved)
Baseball laying in the grass. Homepage blog 2010, arts and entertainment, history and society, sports and games athletics
10 Greatest Baseball Players of All Time
Estimated battle casualties, Normandy invasion, World War II. WWII, D-Day
Estimated Battle Casualties During the Normandy Invasion and Campaign to Liberate Paris (June–August 1944)
The Colosseum, Rome, Italy.  Giant amphitheatre built in Rome under the Flavian emperors. (ancient architecture; architectural ruins)
New Seven Wonders of the World
Cuban Bee Hummingbird (Mellisuga helenae) single adult male, Zapata peninsula, Cuba, Caribbean.Bee hummingbirds are the smallest birds in the world.
Queen Mab’s Stable: 7 of the Smallest Animals
Figure 13: A Maxim machine gun, belt-fed and water-cooled, operated by German infantrymen, World War I.
7 Deadliest Weapons in History
Grasshopper on white background. (bug; insect)
Would You Eat Bugs?
Science
Physics
Matter & Energy
inertia
physics
Written and fact-checked by 
Article History
Related Topics: moment of inertia motion Mach’s principle equivalence principle rotational inertia
inertia, property of a body by virtue of which it opposes any agency that attempts to put it in motion or, if it is moving, to change the magnitude or direction of its velocity. Inertia is a passive property and does not enable a body to do anything except oppose such active agents as forces and torques. A moving body keeps moving not because of its inertia but only because of the absence of a force to slow it down, change its course, or speed it up.

There are two numerical measures of the inertia of a body: its mass, which governs its resistance to the action of a force, and its moment of inertia about a specified axis, which measures its resistance to the action of a torque about the same axis. See Newton’s laws of motion.
""")
            ],
          )
        ],
      ),
    );
  }
}
