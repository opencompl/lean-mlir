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

open CIRCTStream

open TyDenote

/-- Describes that the dialect Op' has a type whose denotation is 'DenotedTy -/
-- class HasTy (d : Dialect) (DenotedTy : Type) [TyDenote d.Ty] [DialectSignature d] where
--     ty : d.Ty
--     denote_eq : toType ty = DenotedTy := by rfl


-- abbrev HasBool (d : Dialect) [TyDenote d.Ty] [DialectSignature d] : Type := HasTy d Bool
-- abbrev HasInt (d : Dialect) [TyDenote d.Ty] [DialectSignature d] : Type := HasTy d Int
-- abbrev HasNat (d : Dialect) [TyDenote d.Ty] [DialectSignature d] : Type := HasTy d Nat

-- DCxComb contains operations of two types: comb and dc
inductive Op : Type _
  | comb (o : MLIR2Comb.Comb.Op)
  | dc (o : MLIR2DC.DC.Op)
  deriving DecidableEq, Repr

abbrev DCxComb : Dialect where
  Op := Op
  Ty := MLIR2DC.DC.Ty

def liftTy : MLIR2Comb.Ty → Option MLIR2DC.Ty
| .bv w => .some <| .valuestream w
| .typeSum w₁ w₂ => 
  if w₁ = w₂ then 
    -- TODO(yann): We should probably allow value streams with different bit widths in the products.
    .some <| .valuestream2 w₁
  else 
    .none
| .bool => .some <| .valuestream 1
| _ => .none

-- TODO(yann): Currently we use a small hack to use a default void type for types that have no equivalent going from
-- Comb to DC.  This default value should be a stream to make denotation easier.
def liftSig (sig : Signature MLIR2Comb.Ty) : Signature MLIR2DC.Ty :=
  Signature.mk (sig.sig.map ((Option.getD . (.valuestream 0)) ∘ liftTy)) [] (liftTy sig.outTy |>.getD (.valuestream 0))

instance : DialectSignature DCxComb where
  signature := fun op => 
    match op with
    | .comb o => liftSig (signature o)
    -- TODO(yann): Need to specify the signature instance directly because it is otherwise trying to get the instance of
    -- DCxComb.
    | .dc o => MLIR2DC.instDialectSignatureDC.signature o

def hv_cast1 (op) (h : HVector toType (instDialectSignatureDCxComb.sig (Op.comb op))) : Stream (HVector toType (DialectSignature.sig op)) := by
  cases op <;> dsimp [DialectSignature.sig, signature, liftSig, liftTy] at h
  all_goals sorry

def_denote for DCxComb where
| .comb op => sorry
| .dc op => MLIR2DC.instDialectDenoteDC.denote op

instance : DialectDenote DCxComb where
  denote := fun op => 
    match op with
    | .comb op => sorry
    | .dc op => MLIR2DC.instDialectDenoteDC.denote op

-- instance : MLIR.AST.TransformExpr DCxComb 0 where

-- instance : MLIR.AST.TransformReturn (DCxComb) 0 where

-- instance : DialectToExpr DCxComb where
--   toExprM := .const ``Id [0]
--   toExprDialect := .const ``DCxComb []

-- open Qq MLIR AST Lean Elab Term Meta in
-- elab "[DCxComb_com| " reg:mlir_region "]" : term => do SSA.elabIntoCom' reg DCxComb

-- explain how to denote comb and dc
-- pb; pack and unpack are meaningless, we're lifting every comb op into a stream op whihc is sub-optimal
-- it basically defeats the purpose of having pack and unpack
-- we can encode handshake semantics implicitly or explicitly
-- if we use streams this is implicit and we don't need pack/unpack

/- compose DC on top of Comb-/

-- abbrev DCComb := DC MLIR2Comb.Comb

-- the only ops where dc and comb meet are pack and unpack, so we only need to re-define
-- the semantics for that

-- def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM DCComb DCComb.Ty
--   | MLIR.AST.MLIRType.int _ w => do
--     match w with
--     | .concrete w' => return .bv w'
--     | .mvar _ => throw <| .generic s!"Bitvec size can't be an mvar"
--   | MLIR.AST.MLIRType.undefined s => do
--     match s.splitOn "_" with
--     | ["TokenStream"] =>
--       return .tokenstream
--     | ["TokenStream2"] =>
--       return .tokenstream2
--     | ["ValueStream", w] =>
--       match w.toNat? with
--       | some w' => return .valuestream w'
--       | _ => throw .unsupportedType
--     | ["ValueStream2", w] =>
--       match w.toNat? with
--       | some w' => return .valuestream2 w'
--       | _ => throw .unsupportedType
--     | ["ValueTokenStream", w] =>
--     match w.toNat? with
--       | some w' => return .valuetokenstream w'
--       | _ => throw .unsupportedType
--     | _ => throw .unsupportedType
--   | _ => throw .unsupportedType

-- abbrev DCComb := DC MLIR2Comb.Comb

-- abbrev DCComb := DC MLIR2Comb.Comb

end DCxCombFunctor
