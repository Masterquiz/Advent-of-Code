#!/usr/local/bin/dyalogscript

⍝ Missing part 2

'disp' 'cmpx' ⎕CY 'dfns'

ex  ← ⎕CSV './input/09e.txt' ⍬4
inp ← ⎕CSV './input/09p.txt' ⍬4

⍝ Part 1
⎕← ⌈⌿,∘.(×⌿1+|⍤-)⍨↓inp

⍝ Part 2
fmt ← {⍺←⍵ ⋄ '.X#'⌷⍨⊂1+⍺-⍨2×⍵} ⍝ NOTE: Temporary function

⍝  0123456789ABCD
⍝ 0..............
⍝ 1.......#...#..
⍝ 2..............
⍝ 3..#....#......
⍝ 4..............
⍝ 5..#......#....
⍝ 6..............
⍝ 7.........#.#..
⍝ 8..............

⍝ ⎕← disp {
⍝     edges ← 2,/⊂¨(⊢,1∘↑)⍵ ⍝ Edges
⍝     ⍝ `∨/,v1 v2∘.≡⍵`: If edge is same or has a vertex in common, it's ok (not crossing the rectangle).
⍝     is_valid ← {
⍝         v1←⍺
⍝         v2←⍵
⍝
⍝         v1≡v2: 0 ⍝ Same vertex, degenerate vertex (Maybe this can be removed)
⍝
⍝         ⎕← disp {
⍝             ∨/,v1 v2∘.≡⍵: (1)(v1 v2,⍵)
⍝             ('-')(v1 v2,⍵)
⍝         }¨edges
⍝
⍝         1
⍝     }
⍝     ∘.(is_valid×(×⌿1+|⍤-))⍨⍵
⍝ }∘↓ex

⍝ Doesn't wrong, even with ex (exclude a pair of vertices if there's a `#` at the centre of the rectangle)
⍝ ⎕← ⌈⌿,∘.{⍺ {∨⌿∧/(⍺<⍤1⊢inp)∧(⍵>⍤1⊢inp)} ⍵: 0 ⋄ ⍺ (×⌿1+|⍤-) ⍵}⍨↓inp

⍝ Aggiunta una rientranza
ex1←(¯3↓ex)⍪⊃⍪/(7 5)(7 7)(5 7)(5 5)(¯3↑ex)

⍝ Spirale
ex2 ← ↑⌽¨(1 1)(1 11)(11 11)(11 2)(5 2)(5 7)(7 7)(7 4)(9 4)(9 9)(3 9)(3 1)

⍝ ⍝ All these below, raises WS FULL
⍝ ⍝ Place 1s
⍝ s ← {1@(↓1+⍵-⍤1⊢⌊⌿⍵)⊢0⍴⍨(1+⌈⌿-⌊⌿)⍵}∘⌽
⍝
⍝ ⍝ These two don't work
⍝ f ← {{⍵∨{×⍵∧⍵≠⍤¯1⊢⌈/⍵}+\⍵}⍉{⍵∨2|+\⍵}⍵}
⍝ g ← (⍉f∧⍉∘f∘⍉)∘{1@(↓1+⍵-⍤1⊢⌊⌿⍵)⊢0⍴⍨(1+⌈⌿-⌊⌿)⍵}∘⌽
⍝ ⎕← g inp ⍝ Correct
⍝ ⎕← g inp ⍝ Wrong
⍝
⍝ ⍝ This should find the borders, but it doesn't consider the vertices order.
⍝ f ← {(⍉{⍵∨2|+\⍵}⍉⍵)∨{⍵∨2|+\⍵}⍵}∘s
⍝ ⎕← f ex1 ⍝ Correct
⍝ ⍝ For wrong, see chat.
⍝
⍝ Correctly find borders.
s ← {1@(⊃,/2{(⊂⍺⌊⍵)+,1-⍨⍳1+|⍺-⍵}/↓1+⍵-⍤1⊢⌊⌿⍵)⊢0⍴⍨(1+⌈⌿-⌊⌿)⍵}∘⌽∘(⊢⍴⍨1 0+⍴)
⎕← disp ⍴{
    ⎕← disp ⍵
    m←0⍪⍨0⍪0,⍨0,⍵
    div←2
    tmp←⍵↑⍨(⍴⍵)+div-div|⍴⍵
    v←,⊃∘.,/↓(1-⍨⍳div)∘.×⍨d←div÷⍨⍴tmp
    ⍝ ⎕← disp div div⍴d∘↑¨v↓¨⊂tmp
    ~¯1 ¯1↓1 1↓⊃⍪/,/div div⍴(1 1 0 0)(0 1 1 0)(1 0 0 1)(0 0 1 1){
        (L T R B)←⍺
        m←0,⍣L⊢0⍪⍣T⊢0,⍨⍣R⊢0⍪⍨⍣B⊢⍵
        w←1,⍣L⊢1⍪⍣T⊢1,⍨⍣R⊢1⍪⍨⍣B⊢0⍨¨⍵
        {¯1 ¯1↓1 1↓(~1,1,⍨1⍪1⍪⍨m)∧⊃∨/,¯1 0 1∘.⊖¯1 0 1⌽¨⊂0,0,⍨0⍪0⍪⍨⍵}⍣≡⊢w
    }¨d∘↑¨v↓¨⊂tmp
    ⍝ ¯1 ¯1↓1 1↓{(~m)∧⊃∨/,¯1 0 1∘.⊖¯1 0 1⌽¨⊂⍵}⍣≡⊢1,1,⍨1⍪1⍪⍨0⍨¨⍵
}s inp

⍝ ..#X#..
⍝ ..XXX..
⍝ ..XXX..
⍝ ..XXX..
⍝ ..XXX..
⍝ #X#XX..
⍝ XXXXX..
⍝ XXXX#X#
⍝ XXXXXXX
⍝ #XXXXX#


⎕←'MAXWS is ',(↑2⎕nq '.' 'GetEnvironment' 'MAXWS')
⎕←'⎕WA is ',tsize ⎕WA

