/-
Carry state is currently `α → Bool` where `α` is an arbitrary Type. We do not need to
use vectors/arrays because we are only working with subsets of `α → Bool` and not explicit elements.
Later maybe we use `β × (α → Bool)` and `β → Circuit α` will be a subset of this. Maybe `β` will be 
`Fin n`.   
-/