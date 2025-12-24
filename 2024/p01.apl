#!/usr/local/bin/dyalogscript

⍝ Input: Two integer vectors.
⍝ *** Part 1 ***
⍝ - Pair up the numbers from the two vectors in increasing order.
⍝ - Add up all the distances (difference without sign).
⍝ *** Part 2 ***
⍝ Add up each number in the first vector after multiplying it by the number of times that number appears in the second vector.

ex  ← ⊃⎕NGET './input/01e.txt' 2
inp ← ⊃⎕NGET './input/01p.txt' 2

format ← ↓∘⍉⍎⍤1

⍝ Part 1
⎕← +⌿|⊃-⌿{⍵[⍋⍵]}¨format inp

⍝ Part 2
⎕← {⍺+.×+/⍺∘.=⍵}/format inp

