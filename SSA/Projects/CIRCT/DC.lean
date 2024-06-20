import SSA.Core.Framework
import SSA.Core.MLIRSyntax.EDSL
open MLIR AST Ctxt


def Val := Option (Bool)
abbrev Brook := Nat → Val

def Brook.corec (fuel : Nat) {β} (s0 : β) (f : β → (Val × Val × β)) : Brook × Brook :=
  match fuel with
  | 0 => (fun _ => .none, fun i => .none)
  | fuel'+ 1 =>
    let x :=
      fun (i : Nat) =>
        match i with
        | 0 => (f s0).fst
        | i+1 => (Brook.corec fuel' (f s0).snd.snd f).fst i
    let y :=
      fun (i : Nat) =>
        match i with
        | 0 => (f s0).snd.fst
        | i+1 => (Brook.corec fuel' (f s0).snd.snd f).snd i
    (x, y)

def Brook.dropFirst (x : Brook) : Brook :=
  fun ix => x (ix + 1)

def Branch (x y c : Brook) : Brook × Brook :=
  Brook.corec (β := Brook × Brook × Brook) 100 (x, y, c)
    fun ⟨x, y, c⟩ => Id.run <| do
      let x := x
      let y := y

      let c₀ := c 0
      let c := c.dropFirst

      match c₀ with
        | none => (none, none, (x, y, c))
        | some c₀ =>
          if c₀ then
            let a := x 0
            let x := x.dropFirst
            (a, none, (x, y, c))
          else do
            let b := y 0
            let y := y.dropFirst
            (none, b, (x, y, c))


inductive Op
| branch
deriving Inhabited, DecidableEq, Repr

inductive Ty
| brook : Ty
| brook2 : Ty
deriving Inhabited, DecidableEq, Repr

instance : TyDenote Ty where
toType := fun
| .brook => Brook
| .brook2 => Brook × Brook


/-- `FHE` is the dialect for fully homomorphic encryption -/
abbrev DC : Dialect where
  Op := Op
  Ty := Ty

open TyDenote (toType)


@[simp, reducible]
def Op.sig : Op  → List Ty
| .branch => [Ty.brook, Ty.brook, Ty.brook]
@[simp, reducible]
def Op.outTy : Op → Ty
| .branch => Ty.brook2

@[simp, reducible]
def Op.signature : Op → Signature (Ty) :=
  fun o => {sig := Op.sig o, outTy := Op.outTy o, regSig := []}

instance : DialectSignature DC := ⟨Op.signature⟩

@[simp]
noncomputable instance : DialectDenote (DC) where
    denote
    | .branch, arg, _ => Branch (arg.getN 0) (arg.getN 1) (arg.getN 2)


/-- Syntax -/

def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM (DC) (DC).Ty
  | MLIR.AST.MLIRType.undefined "brook" => do
    return .brook
  | MLIR.AST.MLIRType.undefined "brook2" => do
    return .brook2
  | _ => throw .unsupportedType

instance instTransformTy : MLIR.AST.TransformTy (DC) 0 where
  mkTy := mkTy

def branch {Γ : Ctxt _} (a b c : Var Γ .brook) : Expr (DC) Γ .pure .brook2  :=
  Expr.mk
    (op := .branch)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .cons c .nil)
    (regArgs := .nil)

def mkExpr (Γ : Ctxt (DC).Ty) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM (DC) (Σ eff ty, Expr (DC) Γ eff ty) := do
  match opStx.name with
  | "dc.branch" =>
    match opStx.args with
    | v₁Stx::v₂Stx::v₃Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      let ⟨ty₃, v₃⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₃Stx
      match ty₁, ty₂, ty₃ with
      | .brook, .brook, .brook => return ⟨_, .brook2, branch v₁ v₂ v₃⟩
      | _, _, _  => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"

instance : MLIR.AST.TransformExpr (DC) 0 where
  mkExpr := mkExpr

def mkReturn (Γ : Ctxt (DC).Ty) (opStx : MLIR.AST.Op 0) : MLIR.AST.ReaderM (DC)
    (Σ eff ty, Com (DC) Γ eff ty) :=
  if opStx.name == "return"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    return ⟨.pure, ty, Com.ret v⟩
  | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})"
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

instance : MLIR.AST.TransformReturn (DC) 0 where
  mkReturn := mkReturn

open Qq MLIR AST Lean Elab Term Meta in
elab "[dc_com" " | " reg:mlir_region "]" : term => do

  SSA.elabIntoCom reg q(DC)

def BranchEg1 := [dc_com| {
  ^entry(%0: !brook, %1: !brook, %2: !brook):
    %out = "dc.branch" (%0, %1, %2) : (!brook, !brook, !brook) -> (!brook2)
    "return" (%out) : (!brook2) -> ()
  }]

#eval BranchEg1
#reduce BranchEg1
