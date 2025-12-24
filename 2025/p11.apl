#!/usr/local/bin/dyalogscript DEFAULT_PP=15

ex_1 ← ⊃⎕NGET './input/11e_1.txt' 1
ex_2 ← ⊃⎕NGET './input/11e_2.txt' 1
inp  ← ⊃⎕NGET './input/11p.txt' 1

fmt ← {{(¯1↓⊃⍵)(1↓⍵)}' '(≠⊆⊢)⍵}¨

⍝ Part 1
⎕← {
    s ← 'you' ⋄ e ← 'out'
    (k v) ← ↓⍉↑⍵

    ≢{⊃,/{e≡⍵: ⊂⍵ ⋄ v⊃⍨k⍳⊂⍵}¨⍵}⍣≡⊢ ⊂s
    ⍝ Can use from part 2: `'out' f 'you'`
    ⍝ {{(⊂⍵),∘⊂¨⊃⌽map⊃⍨(⊃¨map)⍳¯1↑⍵}¨⍵}⍣1⊢ ⊂⊂s

    ⍝ {⊃,/{e≡⊃⌽⍵: ⊂⍵ ⋄ (⊂⍵),∘⊂¨⊃⌽map⊃⍨(⊃¨map)⍳¯1↑⍵}¨⍵}⍣≡⊢ ⊂⊂s
}∘fmt inp

⍝ Part 2
⎕← {
    s ← ⊂'svr' ⋄ e ← ⊂'out' ⋄ i ← 'fft' 'dac'
    (k v) ← ↓⍉↑⍵

    map ← 0,⍨v∘.∊⍨⊂¨∪k,e
    f ← {⍺⍵⌷(+.×⍨)⍣≡⊢1@(⊂⍵ ⍵)⊢map}⍥(k⍳⊂)

    ⍝ NOTE: Could be probably be written better.
    (e,s,⍨⌽i)+⍥{×/f/¨2,⍥⊂/⍵}e,i,s

    ⍝ WS FULL (Progressivly compact more the output, but the number of paths are always too big:
    ⍝   - s → 'fft' → 'dac' → e: ×/ 3651 6402587 21788
    ⍝   - s → 'dac' → 'fft' → e: ×/ 1404600129099 0 1742098280392
    ⍝ A: {⊃,/{0=≡⍵: ⍵ ⋄ e≡⊃⌽⍵: ∧⌿i∊⍵ ⋄ (⊂⍵),∘⊂¨⊃⌽map⊃⍨(⊃¨map)⍳¯1↑⍵}¨⍵}⍣1⊢ ⊂⊂s
    ⍝ B: {⊃,/{(c t)←⍵ ⋄ e≡t: ⊂⍵ ⋄ {⍵{⍵⍺}¨c+2⊥i∘.≡⍵}v⊃⍨k⍳⊂t}¨⍵}
    ⍝ C: compact ← {(c t)←↓⍉↑⍵ ⋄ (∪t[o]){⍵⍺}¨⊃¨,/¨(1,2≢/t[o])⊂c[o←⍋t]}∘,
    ⍝    f ← {⊃,/{(c t)←⍵ ⋄ e≡t: ⊂⍵ ⋄ {⍵{⍵⍺}¨↓c∘.+⍨2⊥i∘.≡⍵}v⊃⍨k⍳⊂t}¨⍵}
    ⍝    +⌿3=∊⊃¨compact∘f⍣0⊢,⊂(,0) s
}∘fmt inp

