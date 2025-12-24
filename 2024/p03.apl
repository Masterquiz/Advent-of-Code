#!/usr/local/bin/dyalogscript

⍝ Input: string.
⍝ *** Part 1 ***
⍝ Add up the product of the numbers that matches the pattern `mul(X,Y)`.
⍝ *** Part 2 ***
⍝ The string now contains `do()` and `don't()`. The above pattern after `don't()` should be ignored, until `do()` is found.
⍝ Note that the above patter shoudn't be ignored until the first `don't()`.

ex  ← ⊃⎕NGET './input/03e.txt' 1
inp ← ⊃⎕NGET './input/03p.txt' 1

⍝ Part 1
f ← {+/(×/∘⍎3∘↓)¨'mul\(\d+,\d+\)'⎕S{⍵.Match}⊢⍵}
⎕← f inp

⍝ Part 1 without regex
f2 ← {+/{{((','=⍵⊃⍨b⍳0)∧1=+/~b)××/⍎¨⍵⊆⍨b←⍵∊⎕D}⊃⍵⊆⍨~∨\⍵∊')'}∘(4∘↓)¨⍵⊂⍨'mul('⍷⍵}∘∊

⍝ Part 2
g ← ⊢⊂⍨1,⍷
⎕← f ∊'don''t()'∘(⊃g)¨'do()' g ∊inp

