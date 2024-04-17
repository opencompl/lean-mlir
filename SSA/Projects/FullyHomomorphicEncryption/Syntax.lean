/-
Syntax definitions for FHE, providing a custom [fhe_com|...] with syntax sugar.

Authors: Andrés Goens<andres@goens.org>, Siddharth Bhat<siddu.druid@gmail.com>
-/
import SSA.Core.MLIRSyntax.EDSL
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


section CstComputable

def ROfZComputable_impl (z : ℤ) : R q n :=
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
  R.fromPoly p

/-#
Explanation of what's going on:
- We want to have a `cstComputable : Z -> R`, which achieves three properties:
1. It is computable, since the meta code needs it to be computable for `[fhe_icom|..]` to elaborate.
2. It is equal to the noncomputable definition `(coe z : R q n)`
3. It does not unfold when using `simp_peephole`, so we can rewrite using the equation
     `ROfZComputable_def` after calling `simp_peephole`.

We achieve this by the following means:

1. computable => implemented_by.
2. equal to the noncomputable defn => make this the lean definition.
3. does not unfold => irreducible, allow using the definition with the lemma `ROfZComputable_def`.
-/


@[irreducible, implemented_by ROfZComputable_impl]
def ROfZComputable_stuck_term (q n : Nat) (z : ℤ) :=
  (↑ z : R q n)

@[simp]
lemma ROfZComputable_def (q n :Nat) (z : ℤ) : ROfZComputable_stuck_term  q n z = (↑ z : R q n) := by
  unfold ROfZComputable_stuck_term
  rfl

def cstComputable {Γ : Ctxt _} (z : Int) : Expr (Op q n) Γ .polynomialLike :=
  Expr.mk
    (op := Op.const (ROfZComputable_stuck_term q n z))
    (ty_eq := rfl)
    (args := .nil)
    (regArgs := .nil)
end CstComputable

def mkExpr (Γ : Ctxt (Ty q n)) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM (Op q n) (Σ ty, Expr (Op q n) Γ ty) := do
  match opStx.name with
  | "poly.const" =>
    match opStx.attrs.find_int "value" with
    | .some (v, _ty) =>
      return ⟨.polynomialLike, cstComputable v⟩
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

end MkFuns -- we don't want q and i here anymore

open Qq MLIR AST Lean Elab Term Meta in
elab "[fhe_com" qi:term "," ni:term "," hq:term " | " reg:mlir_region "]" : term => do
  let q : Q(Nat) ← elabTermEnsuringTypeQ qi q(Nat)
  let n : Q(Nat) ← elabTermEnsuringTypeQ ni q(Nat)
  let _factval ← elabTermEnsuringTypeQ hq q(Fact ($q > 1))

  SSA.elabIntoCom reg q(Op $q $n)
