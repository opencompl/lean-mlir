/-
Syntax definitions for FHE, providing a custom [fhe_com|...] with syntax sugar.

Authors: Andrés Goens<andres@goens.org>
-/
import SSA.Core.MLIRSyntax.Transform
import SSA.Core.MLIRSyntax.AST
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Projects.FullyHomomorphicEncryption.Basic

open MLIR AST Ctxt
open Polynomial -- for R[X] notation

section MkFuns
variable {q : Nat} {n : Nat} [Fact (q > 1)]

def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM (Op q n) (Ty q n)
  | MLIR.AST.MLIRType.undefined "R" => do
    return .polynomialLike
  | MLIR.AST.MLIRType.int MLIR.AST.Signedness.Signless _ => do
    return .integer
  | MLIR.AST.MLIRType.index  => do
    return .index
  | _ => throw .unsupportedType

instance instTransformTy : MLIR.AST.TransformTy (Op q n) (Ty q n) 0 where
  mkTy := mkTy

def cstInt {Γ : Ctxt _} (z :Int) : Expr (Op q n) Γ .integer  :=
  Expr.mk
    (op := .const_int z)
    (ty_eq := rfl)
    (args := .nil)
    (regArgs := .nil)

def cstIdx {Γ : Ctxt _} (i : Nat) : Expr (Op q n) Γ .index :=
  Expr.mk
    (op := .const_idx i)
    (ty_eq := rfl)
    (args := .nil)
    (regArgs := .nil)

def add {Γ : Ctxt (Ty q n)} (e₁ e₂ : Var Γ .polynomialLike) : Expr (Op q n) Γ .polynomialLike :=
  Expr.mk
    (op := .add)
    (ty_eq := rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := .nil)

def mul {Γ : Ctxt (Ty q n)} (e₁ e₂ : Var Γ .polynomialLike) : Expr (Op q n) Γ .polynomialLike :=
  Expr.mk
    (op := .mul)
    (ty_eq := rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := .nil)

def mon {Γ : Ctxt (Ty q n)} (a : Var Γ .integer) (i : Var Γ .index) : Expr (Op q n) Γ .polynomialLike :=
  Expr.mk
    (op := .monomial)
    (ty_eq := rfl)
    (args := .cons a <| .cons i .nil)
    (regArgs := .nil)

def mkExpr (Γ : Ctxt (Ty q n)) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM (Op q n) (Σ ty, Expr (Op q n) Γ ty) := do
  match opStx.name with
  | "poly.monomial" =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂ with
        | .integer, .index => return ⟨.polynomialLike, mon v₁ v₂⟩
        | _, _ => throw <| .generic s!"expected operands to be of types `integer` and `index` for `monomial`. Got: {repr ty₁}, {repr ty₂}"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | "poly.add" =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂ with
        | .polynomialLike, .polynomialLike => return ⟨.polynomialLike, add v₁ v₂⟩
        | _, _ => throw <| .generic s!"expected both operands to be of type 'polynomialLike'"
    | _ => throw <| .generic s!"expected two operands for `add`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"

instance : MLIR.AST.TransformExpr (Op q n) (Ty q n) 0 where
  mkExpr := mkExpr

def mkReturn (Γ : Ctxt (Ty q n)) (opStx : MLIR.AST.Op 0) : MLIR.AST.ReaderM (Op q n) (Σ ty, Com (Op q n) Γ ty) :=
  if opStx.name == "return"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    return ⟨ty, Com.ret v⟩
  | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})"
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

instance : MLIR.AST.TransformReturn (Op q n) (Ty q n) 0 where
  mkReturn := mkReturn

def mlir2fhe (reg : MLIR.AST.Region 0) :
    MLIR.AST.ExceptM (Op q n) (Σ (Γ : Ctxt (Ty q n)) (ty : (Ty q n)), Com (Op q n) Γ ty) := MLIR.AST.mkCom reg

end MkFuns -- we don't want q and i here anymore

open Qq MLIR AST Lean Elab Term Meta in
elab "[fhe_com" qi:term "," ni:term "," hq:term " | " reg:mlir_region "]" : term => do
  let ast_stx ← `([mlir_region| $reg])
  let ast ← elabTermEnsuringTypeQ ast_stx q(Region 0)
  let qval : Q(Nat) ← elabTermEnsuringTypeQ qi q(Nat)
  let nval : Q(Nat) ← elabTermEnsuringTypeQ ni q(Nat)
  -- We need this for building `R  later
  -- I would like to synthesize this at elaboration time, not sure how
  let _factval ← elabTermEnsuringTypeQ hq q(Fact ($qval > 1))
  let com := q(mlir2fhe (q := $qval) (n := $nval) $ast)
  synthesizeSyntheticMVarsNoPostponing
  let com : Q(MLIR.AST.ExceptM (Op 2 3) (Σ (Γ' : Ctxt (Ty 2 3)) (ty : Ty 2 3), Com (Op 2 3) Γ' ty)) ←
    withTheReader Core.Context (fun ctx => { ctx with options := ctx.options.setBool `smartUnfolding false }) do
      withTransparency (mode := TransparencyMode.default) <|
        return ←reduce com
  let comExpr : Expr := com
  match comExpr.app3? ``Except.ok with
  | .some (_εexpr, _αexpr, aexpr) =>
      match aexpr.app4? ``Sigma.mk with
      | .some (_αexpr, _βexpr, _fstexpr, sndexpr) =>
        match sndexpr.app4? ``Sigma.mk with
        | .some (_αexpr, _βexpr, _fstexpr, sndexpr) =>
            return sndexpr
        | .none => throwError "Found `Except.ok (Sigma.mk _ WRONG)`, Expected (Except.ok (Sigma.mk _ (Sigma.mk _ _))"
      | .none => throwError "Found `Except.ok WRONG`, Expected (Except.ok (Sigma.mk _ _))"
  | .none => throwError "Expected `Except.ok`, found {comExpr}"
