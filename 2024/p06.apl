#!/usr/local/bin/dyalogscript

ex  ← ⊃⎕NGET './input/06e.txt' 2
inp ← ⊃⎕NGET './input/06p.txt' 2

{
  dim ← ⍴⍵
  dirs ← ⊂¨(¯1 0)(0 1)(1 0)(0 ¯1)

  start_pos ← 1↑⍸'^'⍷⍵

  ⍝ NOTE: Consider as obstacles also the border to simplify the code below.
  ⍝   (It's not a special case not having a real obstacles).
  obstacles ← 1-⍨⍸1,1,⍨1⍪1⍪⍨'#'=⍵

  dir ← 0 ⍝ Used to loop through directions — 1: N, 2: E, 3: S, 4: W

  ⍝ Part 1
  ⎕← ≢ visited ← ∪{
    dir ⊢← 1⌈5|1+dir

    ⍝ The distance by the next obstacle is the nearest one, among the ones in
    ⍝  the same direction.
    d←⌈/⊃⌊/|{⍵/⍨(dir⊃dirs)≡¨×⍵}obstacles-¯1↑⍵

    ⍵,(¯1↑⍵)+(dir⊃dirs)×⍳d-1
  }⍣{dim(∨/=,1∊⊢)⊃⌽⍺}⊢start_pos ⍝ end when touch the border.

  ⍝ Part 2 (Quite slow, ≈98s)
  ⍝ Try to place an obstacle in each visited cell, and see if a cycle is detected.
  ⎕← +⌿{
    dir ← 0
    t_obstacles ← obstacles,⊂⍵

    ⍝ A cycle is detected when I remake a step in the same direction
    ~dim(∨/=,1∊⊢)2↑⊃⌽{
      dir ⊢← 1⌈5|1+dir
      d←⌈/⊃⌊/|{⍵/⍨(dir⊃dirs)≡¨×⍵}t_obstacles-⊂2↑⊃⌽⍵
      ⍵,dir,⍨¨(⊂2↑⊃⌽⍵)+(dir⊃dirs)×⍳d-1
    }⍣{((⍺=⍥(≢∘∪)⍵)∧(⍺≠⍥≢⍵))∨dim(∨/=,1∊⊢)2↑⊃⌽⍺}⊢(dir,⍨¨start_pos)
  }¨visited
} inp


