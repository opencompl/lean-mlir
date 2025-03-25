import SSA.Core.Framework
import SSA.Core.Framework.Macro

/-!
## Variadic Example Dialect

This file showcases how the `def_signature` and `def_denote` elaborators can
still be used when certain operations of the dialect have a variadic number
of arguments.

NOTE: a variadic number of *regions* is not supported.
-/

namespace VariadicExample

inductive Ty
| int
deriving DecidableEq, Repr

inductive Op : Type
| add (n : Nat) : Op
| const : (val : ℤ) → Op
deriving DecidableEq, Repr

def VariadicDialect : Dialect where
  Op := Op
  Ty := Ty

def_signature for VariadicDialect where
  | .const _  => () -> .int
  | .add n    => ${List.replicate n .int} → .int

instance : TyDenote (Dialect.Ty VariadicDialect) where
  toType := fun | .int => BitVec 32

def_denote for VariadicDialect where
  | .const z => BitVec.ofInt _ z
  | .add n   => sorry
