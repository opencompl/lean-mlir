/-
Released under Apache 2.0 license as described in the file LICENSE.
This file reflects the semantics of bitstreams, terms, predicates, and FSMs
into lean bitvectors.

We profile slow problems in this file.

```
$ lake build bv-circuit-profile; samply record .lake/build/bin/bv-circuit-profile
```

Authors: Siddharth Bhat
-/
import SSA.Experimental.Bits.Fast.Reflect


def slowPrec : Predicate := Predicate.eq
    (Term.add
      (Term.sub (Term.neg (Term.not (Term.xor (Term.var 0) (Term.var 1)))) (Term.shiftL (Term.var 1) 1))
      (Term.not (Term.var 0)))
    (Term.sub
      (Term.neg (Term.not (Term.or (Term.var 0) (Term.not (Term.var 1)))))
      (Term.add (Term.and (Term.var 0) (Term.var 1)) (Term.shiftL (Term.and (Term.var 0) (Term.var 1)) 1)))



def main : IO Unit := do
  IO.println (repr slowPrec)
  return ()
