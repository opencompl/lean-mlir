import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim


namespace Comb

/- most inputs for the following ops should be variadic. binary for now. -/
def add (x y : BitVec w) : BitVec w :=
  x + y

def and (x y : BitVec w) : BitVec w :=
  x &&& y

def concat (x y : BitVec w) : BitVec (w + w) :=
  x ++ y

def divs (x y : BitVec w) : BitVec w :=
  BitVec.sdiv x y

def divu (x y : BitVec w) : BitVec w :=
  BitVec.udiv x y

def extract (x : BitVec w) (lb : Nat) : BitVec (w - lb) :=
  BitVec.truncate (w - lb) (BitVec.ushiftRight x lb)

def icmp (x y : BitVec w) (op : Nat) : Bool :=
  match op with
  | 0 => x == y
  | 1 => x != y
  | 2 => BitVec.slt x y
  | 3 => BitVec.sle x y
  | 4 => x.toInt > y.toInt
  | 5 => x.toInt ≥  y.toInt
  | 6 => BitVec.ult x y
  | 7 => BitVec.ule x y
  | 8 => x.toNat > y.toNat
  | 9 => x.toNat > y.toNat
  /- ceq/cne = SV case in/equality ("===")
    tests 4-state logical in/equality (0, 1, x, z)
    TODO: model the concept.
  -/
  | 10 => x == y
  | 11 => x == y
  /- weq/wne = SV wild card inequality ("==?")
    also based on 4-state logical in/equality,
    with x and z values acting as wildcards.
    TODO: model the concept.
  -/
  | 12 => x == y
  | 13 => x == y
  | _ => false

def mods (x y : BitVec w) : BitVec w :=
  BitVec.smod x y

def modu (x y : BitVec w) : BitVec w :=
  BitVec.umod x y

def mul (x y : BitVec w) : BitVec w :=
  x * y

def mux (x y : α) (cond : Bool) : α :=
  match cond with
  | true => x
  | false => y

def or (x y : BitVec w) : BitVec w :=
  x ||| y

def parity (x : BitVec w) : BitVec 1 :=
  BitVec.truncate 1 (BitVec.umod x 2#w)

def replicate (x : BitVec w) (n : Nat) : BitVec (w * n) :=
  BitVec.replicate n x

def shl (x y : BitVec w) : BitVec w :=
  x <<< y

def shrs (x y : BitVec w) : BitVec w :=
  BitVec.sshiftRight' x y

def shru (x y : BitVec w) : BitVec w :=
  BitVec.ushiftRight x y.toNat

def sub (x y : BitVec w) : BitVec w :=
  x - y

/-
  Return true/false based on a lookup table.
  This operation assumes a fully elaborated table – 2^n entries.
  Inputs are sorted MSB -> LSB from left to right and the offset into lookupTable is computed from them.
  The table is sorted from 0 -> (2^n - 1) from left to right.
  No difference from array_get into an array of constants except for xprop behavior.
  If one of the inputs is unknown, but said input doesn’t make a difference in the output (based on the lookup table)
  the result should not be ‘x’ – it should be the well-known result.
  Input size should also be variadic, but I am considering two inputs only for the time being.
-/
-- def truthTable (lookupTable : List Bool) (x y : BitVec 1) : BitVec 1 :=
/-
  I need to meditate a bit more on how to define this.
-/

def mux (x y : BitVec w) : BitVec w :=
def mux (x y : BitVec w) : BitVec w :=

end Comb

namespace MLIR2DC

section Dialect

inductive Ty2
  | int : Ty2
  | bool : Ty2
deriving Inhabited, DecidableEq, Repr

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
deriving Inhabited, DecidableEq, Repr

inductive Ty
| tokenstream : Ty
| tokenstream2 : Ty
| valuestream (Ty2 : Ty2) : Ty -- A stream of values of type `Ty2`.
| valuestream2 (Ty2 : Ty2) : Ty -- A stream of values of type `Ty2`.
| valuetokenstream (Ty2 : Ty2) : Ty -- A product of streams of values of type `Ty2`.
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
| Ty.valuestream Ty2 => CIRCTStream.DC.ValueStream (toType Ty2)
| Ty.valuestream2 Ty2 => CIRCTStream.DC.ValueStream (toType Ty2) × CIRCTStream.DC.ValueStream (toType Ty2)
| Ty.valuetokenstream Ty2 => CIRCTStream.DC.ValueStream (toType Ty2) × CIRCTStream.DC.TokenStream

abbrev DC : Dialect where
  Op := Op
  Ty := Ty

open TyDenote (toType)

-- arg type CONF
@[simp, reducible]
def Op.sig : Op  → List Ty
  | .fst => [Ty.tokenstream2]
  | .fstVal t => [Ty.valuetokenstream t]
  | .snd => [Ty.tokenstream2]
  | .sndVal t => [Ty.valuetokenstream t]
  | .pair t => [Ty.valuestream t, Ty.valuestream t]
  | .merge => [Ty.tokenstream, Ty.tokenstream]
  | .branch => [Ty.valuestream Ty2.bool]
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
  | .fst => Ty.tokenstream
  | .fstVal t => Ty.valuestream t
  | .sndVal _ => Ty.tokenstream
  | .snd => Ty.tokenstream
  | .pair t => Ty.valuestream2 t
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
    | .fst, arg, _ => (arg.getN 0 (by simp [DialectSignature.sig, signature])).fst
    | .snd, arg, _ => (arg.getN 0 (by simp [DialectSignature.sig, signature])).snd
    | .fstVal _, arg, _ => (arg.getN 0 (by simp [DialectSignature.sig, signature])).fst
    | .sndVal _, arg, _ => (arg.getN 0 (by simp [DialectSignature.sig, signature]) ).snd
    | .pair _, arg, _ => (arg.getN 0 (by simp [DialectSignature.sig, signature]), arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .unpack _, arg, _ => CIRCTStream.DC.unpack (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .pack _, arg, _  => CIRCTStream.DC.pack (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .branch, arg, _  => CIRCTStream.DC.branch (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .fork, arg, _  => CIRCTStream.DC.fork (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .join, arg, _  => CIRCTStream.DC.join (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .merge, arg, _  => CIRCTStream.DC.merge (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .select, arg, _  => CIRCTStream.DC.select (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature])) (arg.getN 2 (by simp [DialectSignature.sig, signature]))
    | .sink, arg, _  => CIRCTStream.DC.sink (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .source, _, _  => CIRCTStream.DC.source

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

open Qq MLIR AST Lean Elab Term Meta in
elab "[DC_com| " reg:mlir_region "]" : term => do
  SSA.elabIntoCom reg q(DC)

end MLIR2DC
