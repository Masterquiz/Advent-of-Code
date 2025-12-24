#!/usr/local/bin/dyalogscript DEFAULT_PP=15

ex  ← ⎕CSV './input/02e.txt' ⍬4
inp ← ⎕CSV './input/02p.txt' ⍬4

fmt ← {'-'(⍎¨≠⊆⊢)¨⍵}

⍝ Part 1:
⍝ - Find all invalid IDS (Numbers of type XX, e.g. 2727, from 1 to 9999999999)
⍝ - Count how many invalid IDS are within the intervals.
ids ← ∊(1+10*⍳5) × (9×+\0,10*1-⍨⍳4) + ⍳¨9×10*1-⍨⍳5
⎕← ⊃+⌿∊{ids/⍨1=ids⍸⍨0 1+⍵}¨fmt inp

⍝ Part 2: Same as above.
⍝ - Add invalid IDS remaining (multiple ripetition)
ids   ,← ,111 11111 1111111 111111111 ∘.× ⍳9 ⍝ 1-digit repeated
ids   ,← ,10101 1010101 101010101 ∘.× 9+⍳90  ⍝ 2-digit repeated
ids ∪⍤,← 1001001 × 99+⍳900                   ⍝ 3-digit repeated

⎕← ⊃+⌿∊{ids/⍨1=ids⍸⍨0 1+⍵}¨fmt inp

