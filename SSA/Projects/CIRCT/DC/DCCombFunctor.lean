import Mathlib.Logic.Function.Iterate
import Mathlib.Tactic.Linarith
import SSA.Core.Framework
import SSA.Core.Tactic
import SSA.Core.ErasedContext
import SSA.Core.Util
import SSA.Projects.CIRCT.Comb.Comb
import SSA.Projects.CIRCT.DC.DC
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim

open Ctxt(Var)

namespace DCCombOp

/- First thing we need it to pop a value from the stream of int -/

def popReady (s : CIRCTStream.Stream (BitVec w)) (n : Nat) : BitVec w :=
  if 0 < n then
    match s.head with
    | some e => e
    | _ => popReady s.tail (n - 1)
  else
    0#w

section Dialect

inductive Ty2
  | bv (w : Nat) : Ty2
deriving Inhabited, DecidableEq, Repr, Lean.ToExpr

inductive Ty
| tokenstream : Ty
| tokenstream2 : Ty
| valuestream (Ty2 : Ty2) : Ty -- A stream of values of type `Ty2`.
| valuestream2 (Ty2 : Ty2) : Ty -- A stream of values of type `Ty2`.
| valuetokenstream (Ty2 : Ty2) : Ty -- A product of streams of values of type `Ty2`.
deriving Inhabited, DecidableEq, Repr, Lean.ToExpr

inductive Op
| popReady (w : Nat)
deriving Inhabited, DecidableEq, Repr, Lean.ToExpr
