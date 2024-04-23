/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.ErasedContext


/-- A MLIR `Dialect` is comprised of a type of `Op`erations, and a type of `Ty`pes -/
structure Dialect where
  (Op : Type)
  (Ty : Type)

/-!
There's a slight hickup with the bundling approach: the `TyDenote` class currently *only* takes
`Ty` as an argument.

We could change this, so that `TyDenote` becomes
```lean
class TyDenote (d : Dialect) where
  toType : d.Ty → Type
```
but this has knock-on effects that would require us to change `Ctxt` to also take a dialect.
I expect this to be fine in practice, but it feels unclean.



However, if we don't make this change, we have the unfortunate situation that,
assuming `d = ⟨Op, Ty⟩`, `TyDenote Ty` is a distinct instance from `TyDenote d.Ty`.
Thus, if a user defined their dialect with `TyDenote Ty`, but not `TyDenote` then they would get a
`failed to synthesize instance of TyDenote (MyDialect.Ty)` error.

-/
