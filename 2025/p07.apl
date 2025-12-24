#!/usr/local/bin/dyalogscript DEFAULT_PP=15

ex  ← ⊃⎕NGET './input/07e.txt' 1
inp ← ⊃⎕NGET './input/07p.txt' 1

⍝ Part 1
⎕← {r⊣{∪⍵(+,-){⍵⊣r+←+⌿⍵}⍵∊⍺}/⌽⍵⊣r←0}⍸¨'.'≠ inp

⍝ Part 2
⎕← +⌿⊃((~⍤⊣×⊢)+×⍥(1∘⌽)+×⍥(¯1∘⌽))/⌽0,⍨¨0,¨'.'≠inp

