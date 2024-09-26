import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim


namespace CIRCTStream
namespace DC

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

def branch (x : TokenStream) (c : ValueStream Bool): TokenStream × TokenStream  :=
  Stream.corec₂ (β := TokenStream × Stream Bool) (x, c) fun ⟨x, c⟩ =>
    Id.run <| do
      match c 0, x 0 with
        | none, _ => (none, none, (x, c.tail))
        | _, none => (none, none, (x.tail, c))
        | some c₀, some _ =>
          if c₀ then
            (some (), none, (x.tail, c.tail))
          else
            (none, some (), (x.tail, c.tail))

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

def select (x y : TokenStream) (c : Stream Bool): TokenStream :=
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

end DC
end CIRCTStream

section Dialect

inductive Ty2
  | int : Ty2
  | bool : Ty2
deriving Inhabited, DecidableEq, Repr

inductive Op
| merge
| branch
| fork
| join
| select
| sink
| source
| pack (t : Ty2)
| unpack (t : Ty2)
deriving Inhabited, DecidableEq, Repr

inductive Ty
| tokenstream : Ty
| tokenstream2 : Ty
| valuestream (ty2 : Ty2) : Ty -- A stream of values of type `ty2`.
| valuetokenstream (ty2 : Ty2) : Ty -- A product of streams of values of type `ty2`.
deriving Inhabited, DecidableEq, Repr

instance : TyDenote Ty2 where
toType := fun
| Ty2.int => Int
| Ty2.bool => Bool

open TyDenote (toType) in
instance instDCTyDenote : TyDenote Ty where
toType := fun
| Ty.tokenstream => CIRCTStream.DC.TokenStream
| Ty.tokenstream2 => CIRCTStream.DC.TokenStream × CIRCTStream.DC.TokenStream
| Ty.valuestream ty2 => CIRCTStream.DC.ValueStream (toType ty2)
| Ty.valuetokenstream ty2 => CIRCTStream.DC.ValueStream (toType ty2) × CIRCTStream.DC.TokenStream

set_option linter.dupNamespace false in
abbrev DC : Dialect where
  Op := Op
  Ty := Ty

open TyDenote (toType)

-- arg type CONF
@[simp, reducible]
def Op.sig : Op  → List Ty
  | .merge => [Ty.tokenstream, Ty.tokenstream]
  | .branch => [Ty.tokenstream, Ty.valuestream Ty2.bool]
  | .fork => [Ty.tokenstream]
  | .join => [Ty.tokenstream, Ty.tokenstream]
  | .select => [Ty.tokenstream, Ty.tokenstream, Ty.valuestream Ty2.bool]
  | .sink => [Ty.tokenstream]
  | .source => []
  | .pack t => [Ty.valuestream t, Ty.tokenstream]
  | .unpack t => [Ty.valuestream t]

-- return type CONF
@[simp, reducible]
def Op.outTy : Op → Ty
  | .merge => Ty.valuestream Ty2.bool
  | .branch => Ty.tokenstream2
  | .fork => Ty.tokenstream2
  | .join => Ty.tokenstream
  | .select => Ty.tokenstream
  | .sink => Ty.tokenstream
  | .source => Ty.tokenstream
  | .pack t => Ty.valuestream t
  | .unpack t => Ty.valuetokenstream t

@[simp, reducible]
def Op.signature : Op → Signature (Ty) :=
  fun o => {sig := Op.sig o, outTy := Op.outTy o, regSig := []}

instance : DialectSignature DC := ⟨Op.signature⟩

@[simp]
instance : DialectDenote (DC) where
    denote
    | .unpack _, arg, _ => CIRCTStream.DC.unpack (arg.getN 0)
    | .pack _, arg, _  => CIRCTStream.DC.pack (arg.getN 0) (arg.getN 1)
    | .branch, arg, _  => CIRCTStream.DC.branch (arg.getN 0) (arg.getN 1)
    | .fork, arg, _  => CIRCTStream.DC.fork (arg.getN 0)
    | .join, arg, _  => CIRCTStream.DC.join (arg.getN 0) (arg.getN 1)
    | .merge, arg, _  => CIRCTStream.DC.merge (arg.getN 0) (arg.getN 1)
    | .select, arg, _  => CIRCTStream.DC.select (arg.getN 0) (arg.getN 1) (arg.getN 2)
    | .sink, arg, _  => CIRCTStream.DC.sink (arg.getN 0)
    | .source, _, _  => CIRCTStream.DC.source

end Dialect

namespace MLIR2DC

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
    (args := sorry)
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

def branch {Γ : Ctxt _} (a : Γ.Var (.tokenstream)) (b : Γ.Var (.valuestream .bool)) : Expr (DC) Γ .pure (.tokenstream2) :=
  Expr.mk
    (op := .branch)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
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

def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM (DC) (Σ eff ty, Expr (DC) Γ eff ty) := do
  match opStx.name with
  | op@"DC.source" =>
    if opStx.args.length > 0 then
      throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
    else
      return ⟨_, .tokenstream, source⟩
  | op@"DC.sink" | op@"DC.unpack" | op@"DC.fork" =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, op with
      | .tokenstream, "DC.sink" => return ⟨_, .tokenstream, sink v₁⟩
      | .valuestream r, "DC.unpack"  => return ⟨_, .valuetokenstream r, unpack v₁⟩
      | .tokenstream, "DC.fork"  => return ⟨_, .tokenstream2, fork v₁⟩
      | _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"DC.merge" | op@"DC.join" | op@"DC.pack" | op@"DC.branch" =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂, op with
      | .tokenstream, .tokenstream, "DC.merge" => return ⟨_, .valuestream .bool, merge v₁ v₂⟩
      | .tokenstream, .tokenstream, "DC.join"  => return ⟨_, .tokenstream, join v₁ v₂⟩
      | .valuestream r, .tokenstream, "DC.pack"  => return ⟨_, .valuestream r, pack v₁ v₂⟩
      | .tokenstream, .valuestream .bool, "DC.branch"  => return ⟨_, .tokenstream2, branch v₁ v₂⟩
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

open Qq MLIR AST Lean Elab Term Meta in
elab "[DC_com| " reg:mlir_region "]" : term => do
  SSA.elabIntoCom reg q(DC)

end MLIR2DC
