#!/usr/local/bin/dyalogscript

ex  ← ⊃⎕NGET './input/04e.txt' 1
inp ← ⊃⎕NGET './input/04p.txt' 1

⍝ Part 1
⎕← {
  v ← 0,⍳1-⍨≢⍵
  m ← ⌽∘.≤⍨v

  rows  ← ⍵
  cols  ← ↓⍉↑⍵
  diag  ← ⊃,/,/(~m)m∘.{⍺/¨⍥↓⍉v⌽⍵}(↑⍵)(⌽⍉↑⍵)

  +/∊'XMAS' 'SAMX' ∘.⍷ rows,cols,diag
} inp

⍝ Part 2
⎕← +/∊'MSAMS' 'SSAMM' 'SMASM' 'MMASS' ∘.≡ (9⍴1 0)∘/¨ ⊃,/↓3,⌿3,/↑inp

