---
marp: true
author: Ahmed Shuaib
size: 16:9
theme: default
---

# Platformata
## Game Design with Automata Theory
**Ahmed Shuaib**

---

# Introduction
- There are many ways of incorporating automata in game design that have been considered.
- Many design decisions take place during the development of a game.
- Decisions can vary based on the genre of the game.
- Automata can help with these streamline the process.

---

# Literature Review

[1] In a paper from 2022 A procedural-level generation has been demonstrated using cellular automata.

- A genetic algorithm is used to evolve the cellular automata rules applied to generate game levels.
- A Procedural content generator designed using this method is meant to be used during the game development process rather than at runtime.
---

[2] In a paper from 2016 students designed an infinite runner game using mealy machines.

- The game consisted of several states such as: running, jumping, and flying.
- Games designed using automata are less prone to bugs and the development process is simplified.

---

[3] Conway's Game of Life

- Developed by John Conway.
- A "zero-player" game utilizing cellular automata.
- Essentially a square grid containing cells that evolve based on three rules: birth, death, and survival.

---

# Game Design

### Input Alphabet
$$ \sum_{Move} = \{ U, D, L, R \} $$
$$ \sum_{Action} = \{P, J, O \} $$
$$ \sum_{Game} = \{T_{n}, TA_{n}, A_{n}, B_{n}, NB_{n}, D_{n}, ND_{n} \} $$

---
