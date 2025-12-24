#!/usr/local/bin/dyalogscript

⍝ Missing part 2

'disp' 'displays' ⎕CY 'dfns'

⍝ *** Part 2 ***
⍝ E.g. First element of ex:
⍝ (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
⍝       B        T
⍝ ┌           ┐ ┌ ┐
⍝ │0 0 0 0 1 1│ │3│
⍝ │0 1 0 0 0 1│ │5│
⍝ │0 0 1 1 1 0│,│4│
⍝ │1 1 0 1 0 0│ │7│
⍝ └           ┘ └ ┘

ex  ← ⊃⎕NGET './input/10e.txt' 1
inp ← ⊃⎕NGET './input/10p.txt' 1

fmt ← {{('#'=⊃⍵)(⍎¨¯1↓1↓⍵)(⍎⊃⌽⍵)}¯1↓¨1↓¨' '(≠⊆⊢)⍵}

⍝ Part 1
⎕← +⌿{
    (T B _) ← ⍵
    B←{1@⍵⊢0⍴⍨≢T}¨1+B
    1{⍵∊⍨⊂T: ⍺ ⋄ (⍺+1)∇∪,B∘.≠⍵}B
}∘fmt¨ inp

⍝ Part 2
⍝ ⍝ Too slow, sometimes WS FULL
⍝ g ← {
⍝     ⍝ State:
⍝     ⍝ c — Current counter values.
⍝     ⍝ k — Index of current button.
⍝     ⍝ p — Total number of presses so far.
⍝
⍝     (B T ub M) ← ⍺⍺
⍝     (c k p) ← ⍵
⍝
⍝     d ← T-c ⍝ Residual difference
⍝
⍝     ⍝ If #presses exceeds the best option, ignore.
⍝     p ≥ best: ⍬
⍝
⍝     ⍝ If the target is reached, save best.
⍝     c ≡ T: best ⊢← p
⍝
⍝     ⍝ If I pressed all the buttons without reaching target, ignore.
⍝     k = 1+2⊃⍴B: ⍬
⍝
⍝     ⍝ Won't reach the target, even if I press the remaining buttons the maximum possible times.
⍝     ∨/d>+/M↓⍨⍤1⊢k-1: ⍬
⍝
⍝     ⍝ Calculate a lower bound of #presses.
⍝     ⍝ The remaining #presses are at least equals the largest residual difference,
⍝     ⍝   so I can ignore the ones that exceeds best.
⍝     best ≤ p+⌈/d : ⍬
⍝
⍝     ⍝ Simulate all possible presses.
⍝     ∇∘{(c+⍵×B[;k]) (k+1) (p+⍵)}¨0,⍳ub[k]⌊⌊/B[;k]/d
⍝ }
⍝
⍝ ∇ best←f (B T)
⍝     ⍝ B: Each column is a boolean vector rappresenting which counters does it increment.
⍝     ⍝    cols: buttons.
⍝     ⍝    rows: counters incremented.
⍝     ⍝ T: Target
⍝     best ← ⌊/⍬ ⍝ Starts at infinity
⍝
⍝     ⍝ Sort the columns in descending order by number of 1s.
⍝     B ← B[;⍒+⌿B]
⍝
⍝     ⍝ Precalculate some variables
⍝     ub ← (⍉B)⌊/⍤/⍤1⊢T ⍝ Upper Bound: Maximum number of presses allowed per button.
⍝     M  ← B×⍤1⊢ub
⍝
⍝     ⍝ Call the main recursive function.
⍝     (B T ub M g) ((0⍨¨T) 1 0)
⍝ ∇
⍝
⍝ ⎕← +⌿{
⍝     (_ B T) ← ⍵
⍝     B←⍉↑{1@⍵⊢0⍨¨T}¨1+B
⍝
⍝     f B T
⍝ }∘fmt¨ inp

⍝ ⍝ WS FULL
⍝ ⎕← disp +/{
⍝     (_ B T) ← ⍵
⍝     B←{1@⍵⊢0⍴⍨≢T}¨1+B
⍝
⍝     1{⍵∊⍨⊂T: ⍺ ⋄ (⍺+1)∇∪{⍵⌿⍨∨/¨(⊂T)≥⍵},B∘.+⍵}B
⍝ }∘fmt¨ inp

⍝ ∇ DFS (k r S x B n)
⍝     ⍝ ⎕← disp (k r S x B n)(bestSum)
⍝     ⍝ prune by objective
⍝     :If ~S ≥ bestSum
⍝         ⍝ all variables assigned
⍝         :If ~k > n
⍝             col ← k⊃⍤1⊢B
⍝
⍝             :For v :In ⍳1+(0⌈⌊/r/⍨1=col) ⍝ max value for x[k]
⍝                 r2 ← r - v×col
⍝                 :If ∨/r2<0
⍝                     :Continue
⍝                 :EndIf
⍝
⍝                 Brem ← B[;k~⍨⍳n]
⍝                 lb ← ⌈/⌈r2÷+/Brem ⍝ LowerBound
⍝
⍝                 :If bestSum≤S+v+lb
⍝                     :Continue
⍝                 :EndIf
⍝
⍝                 DFS (k+1) r2 (S+v) (x,v) B n
⍝             :EndFor
⍝         :ElseIf ∧/r=0
⍝             bestSum ← S
⍝             bestX ← x
⍝         :EndIf
⍝     :EndIf
⍝ ∇
⍝
⍝ SolveBxEqT ← {
⍝     B ← ⍺
⍝     t ← ⍵
⍝
⍝     ⍝ Remove zero columns
⍝     B ← B/⍨∨⌿B
⍝
⍝     ⍝ Column ordering (descending column sum)
⍝     perm ← ⍒+⌿B
⍝     B ← B[;perm]
⍝
⍝     n ← 2⊃⍴B
⍝     bestSum ← ⌊/⍬
⍝     bestX ← ⍬
⍝
⍝     DFS (1 t 0 ⍬ B n)
⍝
⍝     ⎕← disp bestSum
⍝
⍝     ⍝ restore original order
⍝     bestX[⍋perm]
⍝ }
⍝
⍝ ⎕← disp ⍪{
⍝     (_ B T) ← ⍵
⍝     B←↑{1@⍵⊢0⍴⍨≢T}¨1+B
⍝
⍝     (⍉B)+.×1 5 0 1 3 0
⍝
⍝     (⍉B) SolveBxEqT T
⍝
⍝     ⍝ ⊢r←⍬
⍝     ⍝ 1{13=⍺: r ⋄ ⍵∊⍨⊂T: ⍺ ⋄ (⍺+1)∇{⍵⊣r,←≢⍵}∪{⍵⌿⍨∨/¨(⊂T)≥⍵},B∘.+⍵}B
⍝ }∘fmt¨ ⊂⊃ex

⍝ ⍝ Isn't useful, since it doesn't produce an inverse in N
⍝ ∇ GINV ← GEN A;N;M;I;LOC2;M1;NORM;V;B
⍝     ⍝ GINV:  Generalized inverse.
⍝     ⍝ LOC:   Indices of the linearly independent columns of A.
⍝     ⍝ GSMAT: Set of orthonormal vectors that span the range of A.
⍝     CNST ← 1e¯3
⍝
⍝     ⍝ FIND FIRST NONZERO COLUMN, IF NONE GO TO LBL2 TO RETURN TRANSPOSE.
⍝     (N M) ← ⍴A
⍝
⍝     ⍝ CNST IS THE ACCURACY OF DATA
⍝     I ← ((⌈⌿|A)>SIZE←(2*¯100)⌈(CNST×⌈/,|A))⍳1
⍝     LOC2 ← ,⍳I-1
⍝     →(I>M)/LBL2
⍝
⍝     ⍝ INSERT NORMALIZED COLUMN INTO GSMAT AS FIRST DIRECTION TO BE
⍝     ⍝ SPANNED IN THE GRAM-SCEMIDT PROCEDUREs
⍝     M1 ← 1
⍝     NORM ← (+/A[;I]*2)*0.5
⍝     GSMAT ← (N,1)⍴(A[;I]×÷NORM)
⍝     LOC ← ,I
⍝
⍝     ⍝ PICK NEW COLUMN FROM A
⍝     LBL7: I ← I + 1
⍝     →(I>M)/LBL4
⍝
⍝     V ← A[;I]
⍝
⍝     ⍝ CHECK IF INDICATED COLUMN IS A LINEAR COMBINATION OF PREVIOUS
⍝     ⍝ COLUMNS BY SUBTRACTING PORTIONS ALREADY SPANNED BY THE EXISTING
⍝     ⍝ DIRECTIONS IN GSMAT. IF ANY NONZERO PORTION REMAINS THIS IS TO BE
⍝     ⍝ TAKEN AS THE NEW DIRECTION
⍝     V ← V-GSMAT+.×V+.×GSMAT
⍝     NORM ← (+/V*2)*0.5
⍝     → (NORM>SIZE)/LBL3
⍝
⍝     ⍝ COLUMN NOT INDEPENDENT. ADD INDEX TO LOC2
⍝     LOC2 ← LOC2,I
⍝     →LBL7
⍝
⍝     ⍝ INSERT NORMALIZED VECTOR INDICATING NEW DIRECTION SPANNED INTO
⍝     ⍝ GSMAT. M1 IS COUNTER FOR COLUMNS IN GSMAT (DIRECTIONS SPANNED)
⍝     ⍝ AND WILL EINALLY INDICATE THE RANK OF TEE MATRIX A.
⍝     LBL3: M1 ← M1 + 1
⍝     GSMAT ← GSMAT,((N,1)⍴(V×÷NORM))
⍝     LOC ← LOC,I
⍝     →LBL7
⍝
⍝     ⍝ FIND TEE GENERALIZED INVERSE. LOC AND LOC2 INDICATE THE LOCATION
⍝     ⍝ (INDICES) OF THE LINEARLY INDEPENDENT AND DEPENDENT COLUMNS
⍝     ⍝ RESPECTIVELY. TREY ARE USED INSTEAD OF A PERMUTATION MATRIX.
⍝     LBL4: →(M1=M)/LBL1
⍝     B ← ⍉⌹⍉((M1,M1)⍴1,M1⍴0),(A[;LOC2])⌹A[;LOC]
⍝     GINV ← B+.×⌹A[;LOC]
⍝     GINV ← GINV[⍋(LOC,LOC2);]
⍝     →0
⍝
⍝     LBL2: GINV ← (M,N)⍴0
⍝     →0
⍝
⍝     LBL1: GINV ← ⌹A
⍝ ∇

