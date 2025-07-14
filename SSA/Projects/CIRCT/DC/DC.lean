import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Framework
import SSA.Core.Framework.Macro
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.EDSL2
import SSA.Core.Tactic.SimpSet

namespace CIRCTStream
namespace DCOp

def ValueStream := Stream

def TokenStream := Stream Unit

def VariadicValueStream (w : Nat) := CIRCTStream.Stream (List (BitVec w))

def unpack (x : ValueStream (BitVec w)) : ValueStream (BitVec w) × TokenStream :=
  Stream.corec₂ (β := Stream (BitVec w)) (x)
    fun x => Id.run <| do
      match x 0 with
      | some _ => return (x 0, some (), x.tail)
      | none => return (none, none, x.tail)

-- ifeally we spit out a tuple of bitvec, but it's less usable
-- the output of this is synced
def unpack2 (x : ValueStream (BitVec w)) (y : ValueStream (BitVec w)) : VariadicValueStream w × TokenStream :=
  Stream.corec₂ (β := CIRCTStream.Stream (BitVec w) × CIRCTStream.Stream (BitVec w)) (x, y)
    fun (x, y) => Id.run <| do
      match x 0, y 0 with
      | some x', some y' => return (some [x', y'], some .unit, (x.tail, y.tail))
      | some _, none => return (none, none, (x, y.tail))
      | none, some _ => return (none, none, (x.tail, y)) -- the mid return is the one that returns some if we have a sync
      | none, none => return (none, none, (x.tail, y.tail))

def pack (x : ValueStream α) (y : TokenStream) : ValueStream α :=
  Stream.corec (β := ValueStream α × TokenStream) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some x₀, some _ => (x₀, (x.tail, y.tail))
    | some _, none => (none, (x, y.tail)) -- wait to sync with the token stream
    | none, some _ => (none, (x.tail, y)) -- wait to sync with the value stream
    | none, none => (none, (x.tail, y.tail))

def pack2 (x : VariadicValueStream α × TokenStream) : (ValueStream (BitVec α)) × (ValueStream (BitVec α))  :=
  Stream.corec₂ (β := VariadicValueStream α × TokenStream) (x) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some x', some _ => (x'[0]?, x'[1]?, (x.tail, y.tail))
    | some _, none => (none, none, (x, y.tail))
    | none, some _ => (none, none, (x.tail, y)) -- wait to sync with the value stream
    | none, none => (none, none, (x.tail, y.tail)) -- wait to sync with the value stream

def branch (x : ValueStream (BitVec 1)): TokenStream × TokenStream  :=
  Stream.corec₂ (β := ValueStream (BitVec 1)) x fun x =>
    Id.run <| do
      match x 0 with
        | none => (none, none, (x.tail))
        | some x₀ =>
          if x₀.msb then
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

def merge (x y : TokenStream) : ValueStream (BitVec 1) :=
  Stream.corec (β := TokenStream × TokenStream) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some _, some _ => (some 1, (x.tail, y))
    | some _, none => (some 1, (x.tail, y.tail))
    | none, some _ => (some 0, (x.tail, y.tail))
    | none, none => (none, (x.tail, y.tail))

def select (x y : TokenStream) (c : ValueStream (BitVec 1)): TokenStream :=
  Stream.corec (β := TokenStream × TokenStream × Stream (BitVec 1)) (x, y, c) fun ⟨x, y, c⟩ =>
    match x 0, y 0, c 0 with
    | some _, some _, some c₀ =>
      if c₀.msb then -- it's just one bit
        (some (), (x.tail, y, c.tail))
      else
        (some (), (x.tail, y.tail, c.tail))
    | some _, none, some c₀ =>
      if c₀.msb then
        (some (), (x.tail, y.tail, c.tail))
      else
        (none, (x, y.tail, c))
    | none, some _, some c₀ =>
      if c₀.msb then
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

end CIRCTStream

namespace MLIR2DC

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
| sndVal (w : Nat)
| fstVal' (w : Nat)
| sndVal' (w : Nat)
| tokVal' (w : Nat)
| merge
| branch
| fork
| join
| select
| sink
| source
| pack (w : Nat)
| pack2 (w : Nat)
| unpack (w : Nat)
| unpack2 (w : Nat)
deriving Inhabited, DecidableEq, Repr, Lean.ToExpr

abbrev DC : Dialect where
  Op := Op
  Ty := Ty

def_signature for DC where
  | .fst => (Ty.tokenstream2) → (Ty.tokenstream)
  | .fstVal t => (Ty.valuetokenstream t) → Ty.valuestream t
  | .fstVal' t => (Ty.variadicvaluetokenstream t) → Ty.valuestream t
  | .snd => (Ty.tokenstream2) → (Ty.tokenstream)
  | .pair w => (Ty.valuestream w, Ty.valuestream w) → Ty.valuestream2 w
  | .sndVal t => (Ty.valuetokenstream t) → Ty.tokenstream
  | .sndVal' t => (Ty.variadicvaluetokenstream t) → Ty.valuestream t
  | .tokVal' t => (Ty.variadicvaluetokenstream t) → Ty.tokenstream
  | .merge => (Ty.tokenstream, Ty.tokenstream) → Ty.valuestream 1
  | .branch => (Ty.valuestream 1) → Ty.tokenstream2
  | .fork => (Ty.tokenstream) → Ty.tokenstream2
  | .join => (Ty.tokenstream, Ty.tokenstream) → Ty.tokenstream
  | .select => (Ty.tokenstream, Ty.tokenstream, Ty.valuestream 1) → Ty.tokenstream
  | .sink => (Ty.tokenstream) → Ty.tokenstream
  | .source => () → Ty.tokenstream
  | .pack t => (Ty.valuestream t, Ty.tokenstream) → Ty.valuestream t
  | .pack2 t => (Ty.variadicvaluetokenstream t) → Ty.valuestream2 t
  | .unpack t => (Ty.valuestream t) → Ty.valuetokenstream t
  | .unpack2 t => (Ty.valuestream t, Ty.valuestream t) → Ty.variadicvaluetokenstream t

instance instDCTyDenote : TyDenote Ty where
toType := fun
| Ty.tokenstream => CIRCTStream.DCOp.TokenStream
| Ty.tokenstream2 => CIRCTStream.DCOp.TokenStream × CIRCTStream.DCOp.TokenStream
| Ty.valuestream w => CIRCTStream.DCOp.ValueStream (BitVec w)
| Ty.valuestream2 w => CIRCTStream.DCOp.ValueStream (BitVec w) × CIRCTStream.DCOp.ValueStream (BitVec w)
| Ty.valuetokenstream w => CIRCTStream.DCOp.ValueStream (BitVec w) × CIRCTStream.DCOp.TokenStream
| Ty.variadicvaluetokenstream w => CIRCTStream.DCOp.VariadicValueStream w × CIRCTStream.DCOp.TokenStream


def_denote for DC where
  | .fst => fun s => s.fst
  | .fstVal _ => fun s => s.fst
  | .fstVal' _ => fun s => s.fst.mapOpt (·[0]?)
  | .snd => fun s => s.snd
  | .pair _ => fun s₁ s₂ => (s₁, s₂)
  | .sndVal _ => fun s => s.snd
  | .sndVal' _ => fun s => s.fst.mapOpt (·[0]?)
  | .tokVal' _ => fun s => s.snd
  | .merge => fun s₁ s₂ => CIRCTStream.DCOp.merge s₁ s₂
  | .branch => fun s => CIRCTStream.DCOp.branch s
  | .fork => fun s => CIRCTStream.DCOp.fork s
  | .join => fun s₁ s₂ => CIRCTStream.DCOp.join s₁ s₂
  | .select => fun s₁ s₂ c => CIRCTStream.DCOp.select s₁ s₂ c
  | .sink => fun s => CIRCTStream.DCOp.sink s
  | .source => fun s => CIRCTStream.DCOp.source s
  | .pack _ => fun s₁ s₂ => CIRCTStream.DCOp.pack s₁ s₂
  | .pack2 _ => fun s₁ => CIRCTStream.DCOp.pack2 s₁
  | .unpack _ => fun s => CIRCTStream.DCOp.unpack s
  | .unpack2 _ => fun s => CIRCTStream.DCOp.unpack2 s

end Dialect

def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM DC DC.Ty
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
    | ["VariadicValueTokenStream", w] =>
    match w.toNat? with
      | some w' => return .variadicvaluetokenstream w'
      | _ => throw .unsupportedType
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

def unpack2 {r} {Γ : Ctxt _} (a : Γ.Var (.valuestream r)) (b : Γ.Var (.valuestream r)) : Expr (DC) Γ .pure (.variadicvaluetokenstream r) :=
  Expr.mk
    (op := .unpack2 r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def pack {r} {Γ : Ctxt _} (a : Γ.Var (.valuestream r)) (b : Γ.Var (.tokenstream)) : Expr (DC) Γ .pure (.valuestream r) :=
  Expr.mk
    (op := .pack r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def pack2 {r} {Γ : Ctxt _} (a : Γ.Var (.variadicvaluetokenstream r)) : Expr (DC) Γ .pure (.valuestream2 r) :=
  Expr.mk
    (op := .pack2 r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a  <| .nil)
    (regArgs := .nil)

def branch {Γ : Ctxt _} (a : Γ.Var (.valuestream 1)) : Expr (DC) Γ .pure (.tokenstream2) :=
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

def merge {Γ : Ctxt _} (a b : Γ.Var (.tokenstream)) : Expr (DC) Γ .pure (.valuestream 1) :=
  Expr.mk
    (op := .merge)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def select {Γ : Ctxt _} (a b : Γ.Var (.tokenstream)) (c : Γ.Var (.valuestream 1)) : Expr (DC) Γ .pure (.tokenstream) :=
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

def pair {r} {Γ : Ctxt _} (a b: Γ.Var (.valuestream r)) : Expr (DC) Γ .pure (.valuestream2 r)  :=
  Expr.mk
    (op := .pair r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def snd {Γ : Ctxt _} (a : Γ.Var (.tokenstream2)) : Expr (DC) Γ .pure (.tokenstream)  :=
  Expr.mk
    (op := .snd)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
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
      | .valuetokenstream _, "DC.sndVal"  => return ⟨_, .tokenstream, sndVal v₁⟩
      | .tokenstream, "DC.sink" => return ⟨_, .tokenstream, sink v₁⟩
      | .valuestream r, "DC.unpack"  => return ⟨_, .valuetokenstream r, unpack v₁⟩
      | .tokenstream, "DC.fork"  => return ⟨_, .tokenstream2, fork v₁⟩
      | .valuestream 1, "DC.branch"  => return ⟨_, .tokenstream2, branch v₁⟩
      | _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"DC.merge" | op@"DC.join" | op@"DC.pack" | op@"DC.pair" =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂, op with
      | .tokenstream, .tokenstream, "DC.merge" => return ⟨_, .valuestream 1, merge v₁ v₂⟩
      | .tokenstream, .tokenstream, "DC.join"  => return ⟨_, .tokenstream, join v₁ v₂⟩
      | .valuestream r, .tokenstream, "DC.pack"  => return ⟨_, .valuestream r, pack v₁ v₂⟩
      | .valuestream r₁, .valuestream r₂, "DC.pair"  =>
        if h : r₁ = r₂ then
          let v₂' : Γ.Var (Ty.valuestream r₁) := Eq.mp (by rw [h]) v₂
          return ⟨_, .valuestream2 r₁, pair v₁ v₂'⟩
        else throw <| .generic s!"type mismatch, expected same width for pair, got {r₁} and {r₂}"
      | _, _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"DC.select" =>
    match opStx.args with
    | v₁Stx::v₂Stx::v₃Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      let ⟨ty₃, v₃⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₃Stx
      match ty₁, ty₂, ty₃, op with
      | .tokenstream, .tokenstream, .valuestream 1, "DC.select" => return ⟨_, .tokenstream, select v₁ v₂ v₃⟩
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
