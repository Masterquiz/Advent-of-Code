#!/usr/local/bin/dyalogscript

ex  ← ⊃⎕NGET './input/04e.txt' 2
inp ← ⊃⎕NGET './input/04p.txt' 2

⍝ Part 1
⍝ Format: Boolean matrix of the cells with a roll.
⍝ Count number of rolls adjacent to each cell (NOTE: It'll count also the actual roll)
⍝ Find the boolean matrix of cells with a roll and with less than 4 adjacent rolls.
⎕← {+⌿,⍵∧5>3+⌿3+/0,0,⍨0⍪0⍪⍨⍵}'@'=inp

⍝ Part 2
⍝ The main function returns a matrix of the rolls that have not been removed (the cells that contains a roll, but have 4 or more adjacent rolls).
⍝ Iterate the function until there is no change.
⍝ Find the number of removed rolls, by subtracting the final number of rolls with the initial one.
⍝ NOTE: To improve performance, do not use stencil in the inner function.
⎕← {⍵-⍥(+⌿,){⍵>5>3+⌿3+/0,0,⍨0⍪0⍪⍨⍵}⍣≡⊢⍵}'@'=inp

