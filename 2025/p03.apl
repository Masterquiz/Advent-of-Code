#!/usr/local/bin/dyalogscript DEFAULT_PP=15

ex  ← ⍎¨⊃⎕NGET './input/03e.txt' 2
inp ← ⍎¨⊃⎕NGET './input/03p.txt' 2

⍝ Part 1
⎕← +⌿(10∘⊥)∘{(a b)←2↑⍒⍵ ⋄ (a<b)∨(a=≢⍵): ⍵[a(⌊,⌈)b] ⋄ ⍵[a,a+⊃⍒a↓⍵]}⍤1⊢inp

⍝ Part 2
⍝ Recursively find the best digits, from the most significant one.
n ← 12
⎕← +⌿{10⊥r⊣{i↓⍵⊣r,←⍵⊃⍨i←⊃⍒⍵↑⍨1+n-⍨r+⍥≢⍵}⍣n⊢⍵⊣r←⍬}⍤1⊢inp

