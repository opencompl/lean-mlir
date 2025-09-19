import SSA.Core
import SSA.Projects.ISL.Semantics

import Lean

/-!
# ISL Dialect

This sets up a very basic prototype of an ISL-like dialect, with:
* side-effectfull register read/writes, and
* basic bitvec arithmetic (without poison semantics)

-/
namespace LeanMLIR.ISL
open Lean (ToExpr)

/-!
## Types & Operations
-/

inductive ISLTy
  | regIndex
  | bits (w : Nat)
  deriving DecidableEq, ToExpr, Repr

inductive ISLOp
  | regConst (r : RegIndex)
  | regRead
  | regWrite
  | bitsConst {w : Nat} (x : BitVec w)
  | bitsAdd (w : Nat)
  deriving DecidableEq, ToExpr, Repr

/-!
## ISL Dialect

Note that we don't model UB or Poison in this dialect, so the only side-effects
are reading/writing the register state.
-/

set_option linter.dupNamespace false in
def ISL : Dialect where
  Ty := ISLTy
  Op := ISLOp
  m := StateM RegFile

/-!
## Operation Signatures
-/

open ISLOp in
open RegFile (registerWidth) in
def_signature for ISL
  | regConst _ => () -> .regIndex
  | regRead => (.regIndex) -[.impure]-> (.bits registerWidth)
  | regWrite => (.regIndex, .bits registerWidth) -[.impure]-> []
  | @bitsConst w _ => () -> [.bits w]
  | bitsAdd w => (.bits w, .bits w) -> [.bits w]

/-!
## Semantics
-/

/-! ### Type Semantics -/
instance : TyDenote ISL.Ty where
  toType := fun
    | .regIndex => RegIndex
    | .bits w => BitVec w

/-! ### Operation Semantics -/
def_denote for ISL
  | .regConst r   => [r]ₕ
  | .regRead      => fun r regFile => ([regFile.read r]ₕ, regFile)
  | .regWrite     => fun r v regFile => ([]ₕ, regFile.write r v)
  | .bitsConst x  => [x]ₕ
  | .bitsAdd _    => fun (x y : BitVec _) => [x + y]ₕ
