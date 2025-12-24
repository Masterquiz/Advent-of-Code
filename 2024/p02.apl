#!/usr/local/bin/dyalogscript

⍝ *** Part 1 ***
⍝ Count how many lines are safe. A line is safe if:
⍝ - (i) The numbers are all in/decreasing order;
⍝ - Two adjacent numbers differ by (ii) at least one and (iii) at most three.

⍝ *** Part 2 ***
⍝ A line is safe if, without at most a number, it follows the previous pattern.

ex  ← ⊃⎕NGET './input/02e.txt' 1
inp ← ⊃⎕NGET './input/02p.txt' 1

format ← ⍎¨

safe ← ((1≡⍥,|∘∪∘×)∧(∧/3≥|))2-/⊢
⍝        ↑           ↑ Check (iii)
⍝        | Check both (i) and (ii)

⍝ Part 1: Count the number of safe rows.
⎕← +⌿safe¨format inp

⍝ Part 2
⍝ Check if it's safe, by searching for the previous pattern in all the sequences obtained removing each number
⎕← +/{∨/⍵ safe⍤/⍨⍤1 ∘.≠⍨⍳≢⍵}¨format inp

