import SSA.Core.Framework.Dialect
import SSA.Core.Framework
import SSA.Core.MLIRSyntax.AST

open MLIR.AST
/-
This class defines how a we can serialize dialect components back to an MLIR.AST.
-/



class DialectSerialize (d : Dialect) where
  opName : d.Op → String
  opAttributes : d.Op → MLIR.AST.AttrDict 0
  tyString : d.Ty → String

#check Expr

/-
structure Op where
  (name: String)
  (res: List <| TypedSSAVal φ)
  (args: List <| TypedSSAVal φ)
  (regions: List Region)
  (attrs: AttrDict φ)

inductive Expr : (Γ : Ctxt d.Ty) → (eff : EffectKind) → (ty : d.Ty) → Type where
  | mk {Γ} {ty} (op : d.Op)
    (ty_eq : ty = DialectSignature.outTy op)
    (eff_le : DialectSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) <| DialectSignature.sig op)
    /- For now, assume that regions are impure.
       We keep it this way to minimize the total amount of disruption in our definitions.
       We shall change this once the rest of the file goes through. -/
    (regArgs : HVector (fun t : Ctxt d.Ty × d.Ty => Com t.1 .impure t.2)
      (DialectSignature.regSig op)) : Expr Γ eff ty

/-- An ssa value (variable name) with a type -/
abbrev TypedSSAVal := SSAVal × MLIRType φ

inductive SSAVal : Type where
  | name : String -> SSAVal
deriving DecidableEq, Repr


-/
-- unsure about the number here, I don't know if it should be zero or φ
-- need a waqy to map dialect types to MLIR.AST types
-- and need a stringgenerating function across a single com and expr
def Expr.toAST {d : Dialect} [DialectSignature d] [DialectSerialize d]
  {Γ : Ctxt d.Ty} {eff : EffectKind} {ty : d.Ty}
  (e : Expr d Γ eff ty) : MLIR.AST.Op 0 :=
  match e with
  | Expr.mk op ty_eq eff_le args regArgs =>
    let name : String := DialectSerialize.opName op
    let attrs : AttrDict 0:= DialectSerialize.opAttributes op
    let res : List (TypedSSAVal 0) := [] --should map to variable name and MLIRType 0
    let operands : List (TypedSSAVal 0) := []  --should map to variable name and MLIRType 0
    {
      name := name, -- done via Op
      res := res, -- return value to do
      args := operands, --arguemnts to do
      regions := [], -- done
      attrs := attrs -- done
    }




/-
inductive Expr : (Γ : Ctxt d.Ty) → (eff : EffectKind) → (ty : d.Ty) → Type where
  | mk {Γ} {ty} (op : d.Op)
    (ty_eq : ty = DialectSignature.outTy op)
    (eff_le : DialectSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) <| DialectSignature.sig op)



-/



--def Com.toAST : Com ... -> AST... :=
