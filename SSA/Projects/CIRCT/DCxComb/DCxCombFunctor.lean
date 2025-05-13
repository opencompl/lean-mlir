import Mathlib.Logic.Function.Iterate
import Mathlib.Tactic.Linarith
import SSA.Core.Framework
import SSA.Core.Tactic
import SSA.Core.ErasedContext
import SSA.Core.Util
import SSA.Projects.CIRCT.DC.DC
import SSA.Projects.CIRCT.Comb.Comb
import SSA.Projects.CIRCT.Stream.Stream

open Ctxt(Var)

namespace DCxCombFunctor
namespace CIRCTStream

open TyDenote

/-- Describes that the dialect Op' has a type whose denotation is 'DenotedTy -/
class HasTy (d : Dialect) (DenotedTy : Type) [TyDenote d.Ty] [DialectSignature d] where
    ty : d.Ty
    denote_eq : toType ty = DenotedTy := by rfl

-- DCxComb contains operations of two types: comb and dc
inductive DC.Op (Op' Ty' : Type) (m') [TyDenote Ty'] [DialectSignature ⟨Op', Ty', m'⟩]
    [DialectDenote ⟨Op', Ty', m'⟩] : Type _
  | comb (o : MLIR2Comb.Op)
  | dc (o : MLIR2DC.Op)
  deriving DecidableEq, Repr

def DC (d : Dialect) [TyDenote d.Ty] [DialectSignature d] [DialectDenote d] : Dialect where
  Op := DC.Op d.Op d.Ty d.m
  Ty := d.Ty
  m := d.m

-- explain how to denote comb and dc
-- pb; pack and unpack are meaningless, we're lifting every comb op into a stream op whihc is sub-optimal
-- it basically defeats the purpose of having pack and unpack
-- we can encode handshake semantics implicitly or explicitly
-- if we use streams this is implicit and we don't need pack/unpack

/-- compose DC on top of Comb-/
abbrev DCComb := DC MLIR2Comb.Comb

-- the only ops where dc and comb meet are pack and unpack, so we only need to re-define
-- the semantics for that

def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM DCComb DCComb.Ty
  | MLIR.AST.MLIRType.int _ w => do
    match w with
    | .concrete w' => return .bv w'
    | .mvar _ => throw <| .generic s!"Bitvec size can't be an mvar"
  | MLIR.AST.MLIRType.undefined s => do
    match s.splitOn "_" with
    | ["TokenStream"] =>
      return .tokenstream
    | ["TokenStream2"] =>
      return .tokenstream2
    | ["ValueStream", w] =>
      match w.toNat? with
      | some w' => return .valuestream w'
      | _ => throw .unsupportedType
    | ["ValueStream2", w] =>
      match w.toNat? with
      | some w' => return .valuestream2 w'
      | _ => throw .unsupportedType
    | ["ValueTokenStream", w] =>
    match w.toNat? with
      | some w' => return .valuetokenstream w'
      | _ => throw .unsupportedType
    | _ => throw .unsupportedType
  | _ => throw .unsupportedType
