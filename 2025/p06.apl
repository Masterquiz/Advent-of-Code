#!/usr/local/bin/dyalogscript DEFAULT_PP=15

ex  ← ⊃⎕NGET './input/06e.txt' 1
inp ← ⊃⎕NGET './input/06p.txt' 1

⍝ ⍺⍺: Function to format the matrix of numbers.
fmt ← {mul←'*'=' '~⍨⊃⌽⍵ ⋄ map←⍺⍺ ¯1↓⍵ ⋄ +⌿(⊃,/map/⍨~mul),(×/¨mul/map)}

⍝ Part 1
⎕← {↓⍉↑⍎¨⍵} fmt inp

⍝ Part 2
⎕← {⍎¨¨{⍵⊆⍨×' '≢⍤~⍨¨⍵}↓⍉↑⍵} fmt inp

