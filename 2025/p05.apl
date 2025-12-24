#!/usr/local/bin/dyalogscript DEFAULT_PP=15

ex  ← ⊃⎕NGET './input/05e.txt' 1
inp ← ⊃⎕NGET './input/05p.txt' 1

fmt ← {{('-'(⍎¨≠⊆⊢)¨⊃⍵)(⍎¨2⊃⍵)}⍵⊆⍨×≢¨⍵}

⍝ Part 1
⎕← {+⌿∨⌿1=⍵∘.⍸⍨⍺+⊂0 1}/fmt inp

⍝ Part 2
⍝ Merge overlapping sets keeping disjunctive ones.
⎕← +⌿1+-⍨/¨⊃{
    ⍝ A right overlap with (A B) can occur only with the first element (since the order).
    ⍝   (C D) → ((A⌊C) D)
    1=(0 1+⊃⍵)⍸2⊃⍺: (⊂(⍺⌊⍥⊃⊃),2⊃⊃)@1⊢⍵
    ⍵,⍨⊂⍺                     ⍝ Concatenate (A B)
}∘,∘⊆/{⍵[⍋⌽¨⍵]}⊃fmt inp

⍝ ⍝ Alternative: Smarter way to find disjunctive sets.
⍝ ⎕← {+⌿(⊃∘⌽-⊃)¨(¯1⌽0=+\(1 ¯1⍴⍨≢⍵)[⍋⍵])⊂⍵[⍋⍵]}∊(⊂0 1)+⊃fmt inp

