import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.DCPlus.Semantics
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Framework
import SSA.Core.Framework.Macro
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.EDSL2
import SSA.Core.Tactic.SimpSet


namespace MLIR2DCPlus
section Dialect

inductive Ty
| tokenstream : Ty
| tokenstream2 : Ty
| valuestream (w : Nat) : Ty -- A stream of BitVec w
| valuestream2 (w : Nat) : Ty -- A stream of BitVec w
| valuetokenstream (w : Nat) : Ty -- A product of streams of BitVec wvariadicvaluevokenvstream
| variadicvaluetokenstream (w : Nat) : Ty -- variadicvaluevokenvstream
deriving Inhabited, DecidableEq, Repr, Lean.ToExpr

instance : ToString Ty where
  toString t := repr t |>.pretty

inductive Op
| fst
| snd
| pair (w : Nat)
| fstVal (w : Nat)
| fstValPure (w : Nat)
| sndVal (w : Nat)
| sndValPure (w : Nat)
| fstVal' (w : Nat)
| sndVal' (w : Nat)
| tokVal' (w : Nat)
| fork
| forkVal
| join
| merge
| mux
| cMerge
| branch
| source
| sink
| supp
| not
deriving Inhabited, DecidableEq, Repr, Lean.ToExpr

abbrev DCPlus : Dialect where
  Op := Op
  Ty := Ty

def_signature for DCPlus where
  | .fst => (Ty.tokenstream2) → (Ty.tokenstream)
  | .fstVal t => (Ty.valuetokenstream t) → Ty.valuestream t
  | .fstVal' t => (Ty.variadicvaluetokenstream t) → Ty.valuestream t
  | .fstValPure t => (Ty.valuestream2 t) → Ty.valuestream t
  | .snd => (Ty.tokenstream2) → (Ty.tokenstream)
  | .sndValPure t => (Ty.valuestream2 t) → Ty.valuestream t
  | .pair w => (Ty.valuestream w, Ty.valuestream w) → Ty.valuestream2 w
  | .sndVal t => (Ty.valuetokenstream t) → Ty.tokenstream
  | .sndVal' t => (Ty.variadicvaluetokenstream t) → Ty.valuestream t
  | .tokVal' t => (Ty.variadicvaluetokenstream t) → Ty.tokenstream
  | .merge => (Ty.tokenstream, Ty.tokenstream) → Ty.valuestream 1
  | .branch => (Ty.valuestream 1, Ty.tokenstream) → Ty.tokenstream2
  | .fork => (Ty.tokenstream) → Ty.tokenstream2
  | .forkVal => (Ty.valuestream 1) → Ty.valuestream2 1
  | .join => (Ty.tokenstream, Ty.tokenstream) → Ty.tokenstream
  | .mux => (Ty.tokenstream, Ty.tokenstream, Ty.valuestream 1) → Ty.tokenstream
  | .sink => (Ty.tokenstream) → Ty.tokenstream
  | .source => () → Ty.tokenstream
  | .cMerge => (Ty.tokenstream, Ty.tokenstream) → Ty.valuetokenstream 1
  | .supp => (Ty.valuestream 1, Ty.tokenstream) → Ty.tokenstream
  | .not => (Ty.valuestream 1) → Ty.valuestream 1

instance instDCTyDenote : TyDenote Ty where
toType := fun
| Ty.tokenstream => CIRCTStream.DCPlusOp.TokenStream
| Ty.tokenstream2 => CIRCTStream.DCPlusOp.TokenStream × CIRCTStream.DCPlusOp.TokenStream
| Ty.valuestream w => CIRCTStream.DCPlusOp.ValueStream (BitVec w)
| Ty.valuestream2 w => CIRCTStream.DCPlusOp.ValueStream (BitVec w) × CIRCTStream.DCPlusOp.ValueStream (BitVec w)
| Ty.valuetokenstream w => CIRCTStream.DCPlusOp.ValueStream (BitVec w) × CIRCTStream.DCPlusOp.TokenStream
| Ty.variadicvaluetokenstream w => CIRCTStream.DCPlusOp.VariadicValueStream w × CIRCTStream.DCPlusOp.TokenStream


def_denote for DCPlus where
  | .fst => fun s => [s.fst]ₕ
  | .fstVal _ => fun s => [s.fst]ₕ
  | .fstValPure _ => fun s => [s.fst]ₕ
  | .fstVal' _ => fun s => [s.fst.mapOpt (·[0]?)]ₕ
  | .snd => fun s => [s.snd]ₕ
  | .sndValPure _ => fun s => [s.snd]ₕ
  | .pair _ => fun s₁ s₂ => [(s₁, s₂)]ₕ
  | .sndVal _ => fun s => [s.snd]ₕ
  | .sndVal' _ => fun s => [s.fst.mapOpt (·[0]?)]ₕ
  | .tokVal' _ => fun s => [s.snd]ₕ
  | .merge => fun s₁ s₂ => [CIRCTStream.DCPlusOp.merge s₁ s₂]ₕ
  | .branch => fun s₁ s₂ => [CIRCTStream.DCPlusOp.branch s₁ s₂]ₕ
  | .fork => fun s => [CIRCTStream.DCPlusOp.fork s]ₕ
  | .forkVal => fun s => [CIRCTStream.DCPlusOp.forkVal s]ₕ
  | .join => fun s₁ s₂ => [CIRCTStream.DCPlusOp.join s₁ s₂]ₕ
  | .mux => fun s₁ s₂ c => [CIRCTStream.DCPlusOp.mux s₁ s₂ c]ₕ
  | .sink => fun s => [CIRCTStream.DCPlusOp.sink s]ₕ
  | .source => [CIRCTStream.DCPlusOp.source]ₕ
  | .cMerge => fun s₁ s₂ => [CIRCTStream.DCPlusOp.cMerge s₁ s₂]ₕ
  | .supp => fun s₁ s₂ => [CIRCTStream.DCPlusOp.supp s₁ s₂]ₕ
  | .not => fun s₁ => [CIRCTStream.DCPlusOp.not s₁]ₕ


def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM DCPlus DCPlus.Ty
  | MLIR.AST.MLIRType.undefined s => do
    match s.splitOn "_" with
    | ["TokenStream"] => return .tokenstream
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
    | ["VariadicValueTokenStream", w] =>
    match w.toNat? with
      | some w' => return .variadicvaluetokenstream w'
      | _ => throw .unsupportedType
    | _ => throw .unsupportedType
  | _ => throw .unsupportedType

instance instTransformTy : MLIR.AST.TransformTy DCPlus 0 where
  mkTy := mkTy


section Compat
open LeanMLIR.SingleReturnCompat (Expr)

def source : Expr (DCPlus) Γ .pure (.tokenstream) :=
  Expr.mk
    (op := .source)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .nil)
    (regArgs := .nil)

def sink {Γ : Ctxt _} (a : Γ.Var (MLIR2DCPlus.Ty.tokenstream)) : Expr (DCPlus) Γ .pure (.tokenstream) :=
  Expr.mk
    (op := .sink)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)


def supp {Γ : Ctxt _} (a : Γ.Var (MLIR2DCPlus.Ty.tokenstream)) (c : Γ.Var (MLIR2DCPlus.Ty.valuestream 1)) : Expr (DCPlus) Γ .pure (.tokenstream) :=
  Expr.mk
    (op := .supp)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons c <| .cons a <| .nil)
    (regArgs := .nil)


def branch {Γ : Ctxt _} (c : Γ.Var (MLIR2DCPlus.Ty.valuestream 1)) (a : Γ.Var (MLIR2DCPlus.Ty.tokenstream)) : Expr (DCPlus) Γ .pure (.tokenstream2) :=
  Expr.mk
    (op := .branch)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons c <| .cons a <| .nil)
    (regArgs := .nil)

def fork {Γ : Ctxt _}  (a : Γ.Var (MLIR2DCPlus.Ty.tokenstream)) : Expr (DCPlus) Γ .pure (.tokenstream2) :=
  Expr.mk
    (op := .fork)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def forkVal {Γ : Ctxt _}  (a : Γ.Var (MLIR2DCPlus.Ty.valuestream 1)) : Expr (DCPlus) Γ .pure (.valuestream2 1) :=
  Expr.mk
    (op := .forkVal)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def join {Γ : Ctxt _}  (a b : Γ.Var (MLIR2DCPlus.Ty.tokenstream)) : Expr (DCPlus) Γ .pure (.tokenstream) :=
  Expr.mk
    (op := .join)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def merge {Γ : Ctxt _}  (a b : Γ.Var (MLIR2DCPlus.Ty.tokenstream)) : Expr (DCPlus) Γ .pure (.valuestream 1) :=
  Expr.mk
    (op := .merge)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def mux {Γ : Ctxt _}  (a b : Γ.Var (MLIR2DCPlus.Ty.tokenstream)) (c : Γ.Var (MLIR2DCPlus.Ty.valuestream 1)) : Expr (DCPlus) Γ .pure (.tokenstream) :=
  Expr.mk
    (op := .mux)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .cons c <| .nil)
    (regArgs := .nil)

def cMerge {Γ : Ctxt _} (a b : Γ.Var (MLIR2DCPlus.Ty.tokenstream)) : Expr (DCPlus) Γ .pure (.valuetokenstream 1) :=
  Expr.mk
    (op := .cMerge)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def fst (a : Γ.Var (MLIR2DCPlus.Ty.tokenstream2)) : Expr (DCPlus) Γ .pure (.tokenstream) :=
    Expr.mk
    (op := .fst)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def snd {Γ} (a : Γ.Var (MLIR2DCPlus.Ty.tokenstream2)) : Expr (DCPlus) Γ .pure (.tokenstream) :=
    Expr.mk
    (op := .snd)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def fstValPure (a : Γ.Var (MLIR2DCPlus.Ty.valuestream2 r)) : Expr (DCPlus) Γ .pure (.valuestream r) :=
    Expr.mk
    (op := .fstValPure r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def sndValPure (a : Γ.Var (MLIR2DCPlus.Ty.valuestream2 r)) : Expr (DCPlus) Γ .pure (.valuestream r) :=
    Expr.mk
    (op := .sndValPure r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def not (a : Γ.Var (MLIR2DCPlus.Ty.valuestream 1)) : Expr (DCPlus) Γ .pure (.valuestream 1) :=
    Expr.mk
    (op := .not)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

end Compat

def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM (DCPlusOp) (Σ eff ty, Expr (DCPlus) Γ eff ty) := do
  match opStx.name with
  | op@"DCPlus.source" =>
    if opStx.args.length > 0 then
      throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
    else
      return ⟨_, [.tokenstream], source⟩
  | op@"DCPlus.fork" | op@"DCPlus.forkVal" | op@"DCPlus.sink" | op@"DCPlus.fst" | op@"DCPlus.snd" | op@"DCPlus.fstValPure" | op@"DCPlus.sndValPure" |  op@"DCPlus.not" =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, op with
      | .tokenstream2, "DCPlus.fst" => return ⟨_, [.tokenstream], fst v₁⟩
      | .valuestream2 r, "DCPlus.fstValPure" => return ⟨_, [.valuestream r], fstValPure v₁⟩
      | .valuestream2 r, "DCPlus.sndValPure" => return ⟨_, [.valuestream r], sndValPure v₁⟩
      | .tokenstream2, "DCPlus.snd"  => return ⟨_, [.tokenstream], snd v₁⟩
      | .tokenstream, "DCPlus.sink" => return ⟨_, [.tokenstream], sink v₁⟩
      | .tokenstream, "DCPlus.fork"  => return ⟨_, [.tokenstream2], fork v₁⟩
      | .valuestream 1, "DCPlus.forkVal"  => return ⟨_, [.valuestream2 1], forkVal v₁⟩
      | .valuestream 1, "DCPlus.not"  => return ⟨_, [.valuestream 1], not v₁⟩
      | _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"DCPlus.join" | op@"DCPlus.merge" | op@"DCPlus.branch" | op@"DCPlus.supp" | op@"DCPlus.cMerge" =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂, op with
      | .tokenstream, .tokenstream, "DCPlus.join"  => return ⟨_, [.tokenstream], join v₁ v₂⟩
      | .tokenstream, .tokenstream, "DCPlus.merge" => return ⟨_, [.valuestream 1], merge v₁ v₂⟩
      | .valuestream 1, .tokenstream, "DCPlus.branch"  => return ⟨_, [.tokenstream2], branch v₁ v₂⟩
      | .valuestream 1, .tokenstream, "DCPlus.supp"  => return ⟨_, [.tokenstream], supp v₂ v₁⟩
      | .tokenstream, .tokenstream, "DCPlus.cMerge" => return ⟨_, [.valuetokenstream 1], cMerge v₁ v₂⟩
      | _, _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"DCPlus.mux"   =>
    match opStx.args with
    | v₁Stx::v₂Stx::v₃Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      let ⟨ty₃, v₃⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₃Stx
      match ty₁, ty₂, ty₃, op with
      | .tokenstream, .tokenstream, .valuestream 1, "DCPlus.mux" => return ⟨_, [.tokenstream], mux v₁ v₂ v₃⟩
      | _, _, _, _=> throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected three operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"

instance : MLIR.AST.TransformExpr DCPlus 0 where
  mkExpr := mkExpr

def mkReturn (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) : MLIR.AST.ReaderM (DCPlusOp)
    (Σ eff ty, Com DCPlus Γ eff ty) :=
  if opStx.name == "return"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    return ⟨.pure, [ty], Com.ret v⟩
  | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})"
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

instance : MLIR.AST.TransformReturn (DCPlus) 0 where
  mkReturn := mkReturn

instance : DialectToExpr DCPlus where
  toExprM := .const ``Id [0]
  toExprDialect := .const ``DCPlus []

open Qq MLIR AST Lean Elab Term Meta in
elab "[DCPlus_com| " reg:mlir_region "]" : term => do SSA.elabIntoCom' reg DCPlus
