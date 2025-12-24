#!/usr/local/bin/dyalogscript

ex  ← ⊃⎕NGET './input/05e.txt' 1
inp ← ⊃⎕NGET './input/05p.txt' 1

format ← {{('|'(⍎¨≠⊆⊢)¨⊃⍵)(⍎¨2⊃⍵)}⍵⊆⍨×≢¨⍵}

{
  (A B)←⍵

  mask ← {~∨/A∊⊃,/(1-⍨⍳≢⍵)↑¨↓∘.,⍨⍵}¨B

  ⍝ Part 1
  ⎕← +/{⍵⊃⍨⌈2÷⍨≢⍵}¨mask/B

  ⍝ Part 2 (Not too fast)
  ⎕← +/{⍵⊃⍨⌈2÷⍨≢⍵}¨mask~⍛/{{∧/b←A(×⊢≤/⍤⍳∩)¨⊂⍵: ⍵ ⋄ ⌽@(⍵⍳⊃A/⍨~b)⊢⍵}⍣≡⊢⍵}¨B
}∘format inp

