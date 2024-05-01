/-
Released under Apache 2.0 license as described in the file LICENSE.
-/


/-- A MLIR `Dialect` is comprised of a type of `Op`erations, and a type of `Ty`pes.

Note that you usually want to define your dialect as an `abbrev`, so that typeclass inference is
able to unfold the dialect structure, and return instances defined on the constituent types,
e.g., when asked for `TyDenote myDialect.Ty`.
An exception to this is dialect wrappers, e.g., `Scf`, these *have* to be `def`s, so that we can
define an instance for `DialectDenote (Scf FooDialect)` and it will be keyed correctly for typeclass
synthesis (see https://leanprover.zulipchat.com/#narrow/stream/270676-lean4/topic/Typeclass.20synthesis.20fails.20with.20an.20.60abbrev.60.20involved/near/435178544) -/
structure Dialect where
  (Op : Type)
  (Ty : Type)
  (m : Type → Type := Id)
