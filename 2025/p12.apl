#!/usr/local/bin/dyalogscript

'disp' ⎕CY 'dfns'

ex  ← ⊃⎕NGET './input/12e.txt' 1
inp ← ⊃⎕NGET './input/12p.txt' 1

format ← {{('#'=1↑⍤↓¨¯1↓⍵)('x:'∘(⍎¨~⍤∊⍨⊆⊢)¨⊃⌽⍵)}⍵⊆⍨×≢¨⍵}

⍝ Part 1
⎕← +⌿{
    (G B)←⍵
    v←+/⍣2↑G
    {(W H T)←⍵ ⋄ (W×H)≥T+.×v}¨B
}format inp

