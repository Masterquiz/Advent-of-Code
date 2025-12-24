#!/usr/local/bin/dyalogscript DEFAULT_PP=15

ex  ← ⊃⎕NGET './input/07e.txt' 1
inp ← ⊃⎕NGET './input/07p.txt' 1

format ← {↓⍉↑{{(⍎⊃⍵)(⍎2⊃⍵)}':'(≠⊆⊢)⍵}¨⍵}

⍝ Part 1
⍝ Possible operators: +, ×.
⎕← {(R E)←⍵ ⋄ +⌿R/R∊∘{⊃(×,+)/⌽⍵}¨2⊃⍵}format ex

⍝ Part 2 (Not too fast)
⍝ Possible operators; `+`, `×`, concatanation: `{⍎⍺,⍥⍕⍵}`.
⎕← {(R E)←⍵ ⋄ +/R/⍨R{T←⍺ ⋄ T∊⊃{{⍵/⍨T≥⍵}⍺(+,×,(⍎,⍨⍥⍕)¨)⍵}/⌽⍵}¨E}format inp

