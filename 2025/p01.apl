#!/usr/local/bin/dyalogscript

ex  ← ⊃⎕NGET './input/01e.txt' 1
inp ← ⊃⎕NGET './input/01p.txt' 1

fmt ← {(⍎1↓⍵)×¯1*'L'∊⍵}

⍝ Part 1
⎕← +/0=100|+\50,fmt¨inp

⍝ Part 2
⍝ Bruteforce: write down each number pointed by the dial and count the 0s.
⎕← {+/0=100|∊(¯1↓+\50,⍵)+(××⍳∘|)¨⍵}fmt¨inp

