#!/usr/local/bin/dyalogscript

)load dfns

ex  ← ⊃⎕NGET './input/25e.txt' 1
inp ← ⊃⎕NGET './input/25p.txt' 1

format ← {{⍵{(⍵/⍨1=⊃¨⊃¨⍺)(⍵/⍨0=⊃¨⊃¨⍺)}(1-⍨+/↑⍵)}⍵⊆⍨≢¨⍵}∘('#'∘=)

⍝ Part 1
⎕← {(L K)←⍵ ⋄ +⌿,L∘.{∧/5≥⍺+⍵}K} format inp

