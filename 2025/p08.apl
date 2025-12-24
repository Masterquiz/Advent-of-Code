#!/usr/local/bin/dyalogscript

ex  ← 10,⍥⊂↓⎕CSV './input/08e.txt' ⍬4
inp ← 1000,⍥⊂↓⎕CSV './input/08p.txt' ⍬4

{
    n ← ≢map ← ⍵
    lim ← ⍺

    ⍝ Find the two junction boxes indices from the sorting position.
    conv ← {(⌈⍵÷n)(n@(0∘=)⊢n|⍵)}

    ⍝ Merge the left junction box to the circuits at the right.
    merge ← {(⍺⌿⍨~b),⍥⊆(∪⍵,∊⍺⌿⍨b←∨⌿⍵∘.∊⍺)}∘conv

    ⍝ Sort junction boxes pairs by the nearest ones.
    ⍝ Remove (X, X) pairs.
    ⍝ In the sorted vector (X, Y) and (Y, X) pairs are all consecutive; I need to keep only one of them.
    nearest ← {⍵⌿⍨1 0⍴⍨≢⍵}n↓⍋,∘.{+⌿×⍨⍺-⍵}⍨⍵

    1{
        ⍝ Part 1
        lim=⍺-1: (⍺+1)∇(⍵ merge ⍺⊃nearest)⊣⎕← ×⌿1⌈3↑{⍵[⍒⍵]}≢¨⍵

        ⍝ Part 2
        (2=≢⍵)∧(n=≢∪∊⍵): ⎕← ×/⊃¨map⌷⍨⊂conv (⍺-1)⊃nearest

        (⍺+1)∇(⍵ merge ⍺⊃nearest)
    }⍬
}/inp

