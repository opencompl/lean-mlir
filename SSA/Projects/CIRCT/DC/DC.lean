import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Framework
import SSA.Core.Framework.Macro
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.EDSL2

namespace CIRCTStream
namespace DCOp

def ValueStream := Stream

def TokenStream := Stream Unit

def unpack (x : ValueStream α) : ValueStream α × TokenStream :=
  Stream.corec₂ (β := Stream α) (x)
    fun x => Id.run <| do
      match x 0 with
      | some _ => return (x 0, some (), x.tail)
      | none => return (none, none, x.tail)

def pack (x : ValueStream α) (y : TokenStream) : ValueStream α :=
  Stream.corec (β := ValueStream α × TokenStream) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some x₀, some _ => (x₀, (x.tail, y.tail))
    | some _, none => (none, (x, y.tail)) -- wait to sync with the token stream
    | none, some _ => (none, (x.tail, y)) -- wait to sync with the value stream
    | none, none => (none, (x.tail, y.tail))

def branch (x : ValueStream Bool): TokenStream × TokenStream  :=
  Stream.corec₂ (β := ValueStream Bool) x fun x =>
    Id.run <| do
      match x 0 with
        | none => (none, none, (x.tail))
        | some x₀ =>
          if x₀ then
            (some (), none, (x.tail))
          else
            (none, some (), (x.tail))

def fork (x : TokenStream) : TokenStream × TokenStream  :=
  Stream.corec₂ (β := TokenStream) x
    fun x => Id.run <| do
      (x 0, x 0, x.tail)

def join (x y : TokenStream) : TokenStream  :=
  Stream.corec (β := TokenStream × TokenStream) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some _, some _ => (some (), (x.tail, y.tail))
    | some _, none => (none, (x, y.tail))
    | none, some _ => (none, (x.tail, y))
    | none, none => (none, (x.tail, y.tail))

def merge (x y : TokenStream) : ValueStream Bool :=
  Stream.corec (β := TokenStream × TokenStream) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some _, some _ => (some true, (x.tail, y))
    | some _, none => (some true, (x.tail, y.tail))
    | none, some _ => (some false, (x.tail, y.tail))
    | none, none => (none, (x.tail, y.tail))

def select (x y : TokenStream) (c : ValueStream Bool): TokenStream :=
  Stream.corec (β := TokenStream × TokenStream × Stream Bool) (x, y, c) fun ⟨x, y, c⟩ =>
    match x 0, y 0, c 0 with
    | some _, some _, some c₀ =>
      if c₀ then
        (some (), (x.tail, y, c.tail))
      else
        (some (), (x.tail, y.tail, c.tail))
    | some _, none, some c₀ =>
      if c₀ then
        (some (), (x.tail, y.tail, c.tail))
      else
        (none, (x, y.tail, c))
    | none, some _, some c₀ =>
      if c₀ then
        (none, (x.tail, y, c))
      else
        (some (), (x.tail, y.tail, c))
    | _, _, none => (none, (x, y, c.tail))
    | none, none, some _ => (none, (x.tail, y.tail, c))

def sink (x : TokenStream) : TokenStream :=
  Stream.corec (β := TokenStream) x fun x => (none, x.tail)

def source : TokenStream :=
  Stream.corec () fun () => (some (), ())

end DCOp

namespace MLIR2DC

section Dialect

inductive Ty2
  | int : Ty2
  | bool : Ty2
deriving Inhabited, DecidableEq, Repr, Lean.ToExpr

inductive Ty
| tokenstream : Ty
| tokenstream2 : Ty
| valuestream (Ty2 : Ty2) : Ty -- A stream of values of type `Ty2`.
| valuestream2 (Ty2 : Ty2) : Ty -- A stream of values of type `Ty2`.
| valuetokenstream (Ty2 : Ty2) : Ty -- A product of streams of values of type `Ty2`.
deriving Inhabited, DecidableEq, Repr, Lean.ToExpr

inductive Op
| fst
| snd
| pair (t : Ty2)
| fstVal (t : Ty2)
| sndVal (t : Ty2)
| merge
| branch
| fork
| join
| select
| sink
| source
| pack (t : Ty2)
| unpack (t : Ty2)
deriving Inhabited, DecidableEq, Repr, Lean.ToExpr

abbrev DC : Dialect where
  Op := Op
  Ty := Ty

def_signature for DC where
  | .fst => (Ty.tokenstream2) → (Ty.tokenstream)
  | .fstVal t => (Ty.valuetokenstream t) → Ty.valuestream t
  | .snd => (Ty.tokenstream2) → (Ty.tokenstream)
  | .sndVal t => (Ty.valuetokenstream t) → Ty.tokenstream
  | .pair t => (Ty.valuestream t, Ty.valuestream t) → Ty.valuestream2 t
  | .merge => (Ty.tokenstream, Ty.tokenstream) → Ty.valuestream Ty2.bool
  | .branch => (Ty.valuestream Ty2.bool) → Ty.tokenstream2
  | .fork => (Ty.tokenstream) → Ty.tokenstream2
  | .join => (Ty.tokenstream, Ty.tokenstream) → Ty.tokenstream
  | .select => (Ty.tokenstream, Ty.tokenstream, Ty.valuestream Ty2.bool) → Ty.tokenstream
  | .sink => (Ty.tokenstream) → Ty.tokenstream
  | .source => () → Ty.tokenstream
  | .pack t => (Ty.valuestream t, Ty.tokenstream) → Ty.valuestream t
  | .unpack t => (Ty.valuestream t) → Ty.valuetokenstream t

instance : TyDenote Ty2 where
toType := fun
| Ty2.int => Int
| Ty2.bool => Bool

instance instDCTyDenote : TyDenote Ty where
toType := fun
| Ty.tokenstream => CIRCTStream.DCOp.TokenStream
| Ty.tokenstream2 => CIRCTStream.DCOp.TokenStream × CIRCTStream.DCOp.TokenStream
| Ty.valuestream Ty2 => CIRCTStream.DCOp.ValueStream (TyDenote.toType Ty2)
| Ty.valuestream2 Ty2 => CIRCTStream.DCOp.ValueStream (TyDenote.toType Ty2) × CIRCTStream.DCOp.ValueStream (TyDenote.toType Ty2)
| Ty.valuetokenstream Ty2 => CIRCTStream.DCOp.ValueStream (TyDenote.toType Ty2) × CIRCTStream.DCOp.TokenStream


def_denote for DC where
  | .fst => fun xs => xs.fst
  | .fstVal _ => fun xs => xs.fst
  | .snd => fun xs => xs.snd
  | .sndVal _ => fun xs => xs.snd
  | .pair _ => fun xs => sorry
  | .merge => fun xs => DCOp.merge xs
  | .branch => fun xs => DCOp.branch xs
  | .fork => fun xs => DCOp.fork xs
  | .join => fun xs => DCOp.join xs
  | .select => fun xs => DCOp.select xs
  | .sink => fun xs => DCOp.sink xs
  | .source => fun xs => DCOp.source xs
  | .pack _ => fun xs => DCOp.pack xs
  | .unpack _ => fun xs => DCOp.unpack xs

end Dialect

def mkTy2 : String → MLIR.AST.ExceptM (DC) Ty2
  | "Int" => return (.int)
  | "Bool" => return (.bool)
  | _ => throw .unsupportedType

def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM DC DC.Ty
  | MLIR.AST.MLIRType.undefined s => do
    match s.splitOn "_" with
    | ["TokenStream"] =>
      return .tokenstream
    | ["TokenStream2"] =>
      return .tokenstream2
    | ["ValueStream", r] =>
      return .valuestream (← mkTy2 r)
    | ["ValueStream2", r] =>
      return .valuestream2 (← mkTy2 r)
    | ["ValueTokenStream", r] =>
      return .valuetokenstream (← mkTy2 r)
    | _ => throw .unsupportedType
  | _ => throw .unsupportedType

instance instTransformTy : MLIR.AST.TransformTy DC 0 where
  mkTy := mkTy

def source : Expr (DC) Γ .pure (.tokenstream) :=
  Expr.mk
    (op := .source)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .nil)
    (regArgs := .nil)

def sink {Γ : Ctxt _} (a : Γ.Var (.tokenstream)) : Expr (DC) Γ .pure (.tokenstream) :=
  Expr.mk
    (op := .sink)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def unpack {r} {Γ : Ctxt _} (a : Γ.Var (.valuestream r)) : Expr (DC) Γ .pure (.valuetokenstream r) :=
  Expr.mk
    (op := .unpack r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def pack {r} {Γ : Ctxt _} (a : Γ.Var (.valuestream r)) (b : Γ.Var (.tokenstream)) : Expr (DC) Γ .pure (.valuestream r) :=
  Expr.mk
    (op := .pack r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def branch {Γ : Ctxt _} (a : Γ.Var (.valuestream .bool)) : Expr (DC) Γ .pure (.tokenstream2) :=
  Expr.mk
    (op := .branch)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def fork (a : Γ.Var (.tokenstream)) : Expr (DC) Γ .pure (.tokenstream2) :=
  Expr.mk
    (op := .fork)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def join {Γ : Ctxt _} (a b : Γ.Var (.tokenstream)) : Expr (DC) Γ .pure (.tokenstream) :=
  Expr.mk
    (op := .join)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def merge {Γ : Ctxt _} (a b : Γ.Var (.tokenstream)) : Expr (DC) Γ .pure (.valuestream .bool) :=
  Expr.mk
    (op := .merge)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def select {Γ : Ctxt _} (a b : Γ.Var (.tokenstream)) (c : Γ.Var (.valuestream .bool)) : Expr (DC) Γ .pure (.tokenstream) :=
  Expr.mk
    (op := .select)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .cons c <| .nil)
    (regArgs := .nil)

def fst {Γ : Ctxt _} (a : Γ.Var (.tokenstream2)) : Expr (DC) Γ .pure (.tokenstream)  :=
  Expr.mk
    (op := .fst)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def fstVal {r} {Γ : Ctxt _} (a : Γ.Var (.valuetokenstream r))  : Expr (DC) Γ .pure (.valuestream r)  :=
  Expr.mk
    (op := .fstVal r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def sndVal {r} {Γ : Ctxt _} (a : Γ.Var (.valuetokenstream r))  : Expr (DC) Γ .pure (.tokenstream)  :=
  Expr.mk
    (op := .sndVal r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def snd {Γ : Ctxt _} (a : Γ.Var (.tokenstream2)) : Expr (DC) Γ .pure (.tokenstream)  :=
  Expr.mk
    (op := .snd)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def pair {r} {Γ : Ctxt _} (a b: Γ.Var (.valuestream r)) : Expr (DC) Γ .pure (.valuestream2 r)  :=
  Expr.mk
    (op := .pair r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM (DC) (Σ eff ty, Expr (DC) Γ eff ty) := do
  match opStx.name with
  | op@"DC.source" =>
    if opStx.args.length > 0 then
      throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
    else
      return ⟨_, .tokenstream, source⟩
  | op@"DC.sink" | op@"DC.unpack" | op@"DC.fork" | op@"DC.branch" | op@"DC.fst" | op@"DC.snd" | op@"DC.fstVal" | op@"DC.sndVal" =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, op with
      | .tokenstream2, "DC.fst" => return ⟨_, .tokenstream, fst v₁⟩
      | .tokenstream2, "DC.snd"  => return ⟨_, .tokenstream, snd v₁⟩
      | .valuetokenstream r, "DC.fstVal" => return ⟨_, .valuestream r, fstVal v₁⟩
      | .valuetokenstream r, "DC.sndVal"  => return ⟨_, .tokenstream, sndVal v₁⟩
      | .tokenstream, "DC.sink" => return ⟨_, .tokenstream, sink v₁⟩
      | .valuestream r, "DC.unpack"  => return ⟨_, .valuetokenstream r, unpack v₁⟩
      | .tokenstream, "DC.fork"  => return ⟨_, .tokenstream2, fork v₁⟩
      | .valuestream .bool, "DC.branch"  => return ⟨_, .tokenstream2, branch v₁⟩
      | _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"DC.merge" | op@"DC.join" | op@"DC.pack" | op@"DC.pair"  =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂, op with
      | .tokenstream, .tokenstream, "DC.merge" => return ⟨_, .valuestream .bool, merge v₁ v₂⟩
      | .valuestream r, .valuestream r', "DC.pair" =>
        if h: r = r' then return ⟨_, .valuestream2 r, pair v₁ (by subst r ; exact v₂)⟩
        else throw <| .generic s!"type mismatch"
      | .tokenstream, .tokenstream, "DC.join"  => return ⟨_, .tokenstream, join v₁ v₂⟩
      | .valuestream r, .tokenstream, "DC.pack"  => return ⟨_, .valuestream r, pack v₁ v₂⟩
      | _, _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"DC.select" =>
    match opStx.args with
    | v₁Stx::v₂Stx::v₃Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      let ⟨ty₃, v₃⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₃Stx
      match ty₁, ty₂, ty₃, op with
      | .tokenstream, .tokenstream, .valuestream .bool, "DC.select" => return ⟨_, .tokenstream, select v₁ v₂ v₃⟩
      | _, _, _, _=> throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected three operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"

instance : MLIR.AST.TransformExpr (DC) 0 where
  mkExpr := mkExpr

def mkReturn (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) : MLIR.AST.ReaderM (DC)
    (Σ eff ty, Com DC Γ eff ty) :=
  if opStx.name == "return"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    return ⟨.pure, ty, Com.ret v⟩
  | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})"
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

instance : MLIR.AST.TransformReturn (DC) 0 where
  mkReturn := mkReturn

instance : DialectToExpr DC where
  toExprM := .const ``Id [0]
  toExprDialect := .const ``DC []

open Qq MLIR AST Lean Elab Term Meta in
elab "[DC_com| " reg:mlir_region "]" : term => do SSA.elabIntoCom' reg DC

end MLIR2DC
