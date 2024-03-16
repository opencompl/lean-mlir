import SSA.Projects.InstCombine.LLVM.Transform
import SSA.Projects.MLIRSyntax.AST
import SSA.Projects.MLIRSyntax.EDSL
import SSA.Projects.FullyHomomorphicEncryption.Basic

open MLIR AST Ctxt
open Polynomial -- for R[X] notation

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

private def R.ofZComputable (z : ℤ) : R q n :=
  let zq : ZMod q := z
  let p : (ZMod q)[X] := {
      toFinsupp := Finsupp.mk
        (support := List.toFinset (if zq = 0 then  [] else [0]))
        (toFun := fun i => if i = 0 then z else 0)
        (mem_support_toFun := by
          intros a
          constructor
          · intros ha
            simp at ha
            split at ha
            case mp.inl hz =>
              simp at ha
            case mp.inr hz =>
              simp at ha
              subst ha
              simp [hz]
          · intros hb
            simp at hb
            obtain ⟨ha, hz⟩ := hb
            subst ha
            simp [hz]
        )
      : (ZMod q)[X]
  }
  fromPoly p



def cstComputable {Γ : Ctxt _} (z : Int) : Expr (Op q n) Γ .polynomialLike :=
  Expr.mk
    (op := .const (R.ofZComputable z))
    (ty_eq := rfl)
    (args := .nil)
    (regArgs := .nil)

-- A lot of this boilerplate should be automatable
@[implemented_by cstComputable]
def cstUncomputable {Γ : Ctxt _} (r : Int) : Expr (Op q n) Γ .polynomialLike  :=
  Expr.mk
    (op := .const r)
    (ty_eq := rfl)
    (args := .nil)
    (regArgs := .nil)

theorem cst_computable_eq_cst_uncomputable [Fact (q > 1)] {Γ : Ctxt (Ty q n)}  (r : Int) :
    cstComputable r = cstUncomputable (Γ := Γ) r := by
  simp [cstComputable, cstUncomputable]
  sorry


-- Will for now not support poly constants, just integers
def mkExpr (Γ : Ctxt (Ty q n)) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM (Op q n) (Σ ty, Expr (Op q n) Γ ty) := do
  match opStx.name with
  | "poly.const" =>
    match opStx.attrs.find_int "value" with
    | .some (v, _ty) =>
      return ⟨.polynomialLike, cstUncomputable v⟩
    | .none => throw <| .generic s!"expected 'const' to have int attr 'value', found: {repr opStx}"
  | "arith.const" =>
    match opStx.attrs.find_int "value" with
    | .some (v, vty) => match vty with
        | .int _ _ => match opStx.res with
          | [(_,MLIR.AST.MLIRType.int MLIR.AST.Signedness.Signless _)] => return ⟨.integer, cstInt v⟩
          | [(_,MLIR.AST.MLIRType.index)] => return ⟨.index, cstIdx v.toNat⟩
          | _ => throw <| .generic s!"unsupported result type {repr opStx.res} for arith.const"
        | _ => throw <| .generic s!"unsupported constant type {repr vty} for arith.const"
    | .none => throw <| .generic s!"expected 'const' to have int attr 'value', found: {repr opStx}"
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

open Qq MLIR AST Lean Elab Term Meta in
elab "[fhe_com| " reg:mlir_region "]" : term => do
  let ast_stx ← `([mlir_region| $reg])
  let ast ← elabTermEnsuringTypeQ ast_stx q(Region 0)
  let mvalues ← `(⟨[], by rfl⟩)
  -- let mvalues : Q(Vector Nat 0) ← elabTermEnsuringType mvalues q(Vector Nat 0)
  -- Defining hardcoded numbers for q and n for now...
  let com := q(mlir2fhe (q := 2) (n := 3) $ast)
  synthesizeSyntheticMVarsNoPostponing
  let com : Q(MLIR.AST.ExceptM (Op 2 3) (Σ (Γ' : Ctxt (Ty 2 3)) (ty : Ty 2 3), Com (Op 2 3) Γ' ty)) ←
    withTheReader Core.Context (fun ctx => { ctx with options := ctx.options.setBool `smartUnfolding false }) do
      withTransparency (mode := TransparencyMode.all) <|
        return ←reduce com
  let comExpr : Expr := com
  trace[Meta] com
  trace[Meta] comExpr
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
