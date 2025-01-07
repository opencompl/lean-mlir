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
    with x and z values acting as wild cards.
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

/- according to the docs the input of mux
  can be any type. I'll stick to bitvecs for now. -/
def mux (x y : BitVec w) (cond : Bool) : BitVec w :=
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

def xor (x y : BitVec w) : BitVec w :=
  x ^^^ y

end Comb

namespace MLIR2Comb

section Dialect

/-
  One thing i've tried in these defs
  is to give w (and potentially additional params, such as `n` in replicate and extract)
  as additional type-like arguments. I believe this is not correct, however, I could not think of
  any alternative solutions.
-/

inductive Op
| add (w : Nat)
| and (w : Nat)
| concat (w : Nat)
| divs (w : Nat)
| divu (w : Nat)
| extract (w : Nat)
| icmp (w : Nat)
| mods (w : Nat)
| modu (w : Nat)
| mul (w : Nat)
| mux (w : Nat)
| or (w : Nat)
| parity (w : Nat)
| replicate (w : Nat)
| shl (w : Nat)
| shrs (w : Nat)
| shru (w : Nat)
| sub (w : Nat)
| xor (w : Nat)
deriving Inhabited, DecidableEq, Repr

inductive Ty
| bv (w : Nat) : Ty -- A bitvector of width `Ty2`.
| nat : Ty
| bool : Ty
deriving Inhabited, DecidableEq, Repr

open TyDenote (toType) in
instance instCombTyDenote : TyDenote Ty where
toType := fun
| Ty.bv n => BitVec n
| Ty.nat => Nat
| Ty.bool => Bool

abbrev Comb : Dialect where
  Op := Op
  Ty := Ty

open TyDenote (toType)

-- arg type CONF
@[simp, reducible]
def Op.sig : Op  → List Ty
  | .add w => [Ty.bv w, Ty.bv w]
  | .and w => [Ty.bv w, Ty.bv w]
  | .concat w => [Ty.bv w, Ty.bv w]
  | .divs w => [Ty.bv w, Ty.bv w]
  | .divu w => [Ty.bv w, Ty.bv w]
  | .extract w => [Ty.bv w, Ty.nat]
  | .icmp w => [Ty.bv w, Ty.bv w, Ty.nat]
  | .mods w => [Ty.bv w, Ty.bv w]
  | .modu w => [Ty.bv w, Ty.bv w]
  | .mul w => [Ty.bv w, Ty.bv w]
  | .mux w => [Ty.bv w, Ty.bv w, Ty.bool]
  | .or w => [Ty.bv w, Ty.bv w]
  | .parity w => [Ty.bv w]
  | .replicate w => [Ty.bv w, Ty.nat]
  | .shl w => [Ty.bv w, Ty.bv w]
  | .shrs w => [Ty.bv w, Ty.bv w]
  | .shru w => [Ty.bv w, Ty.bv w]
  | .sub w => [Ty.bv w, Ty.bv w]
  | .xor w => [Ty.bv w, Ty.bv w]

-- return type CONF
@[simp, reducible]
def Op.outTy : Op  → Ty
  | .add w => Ty.bv w
  | .and w => Ty.bv w
  | .concat w => Ty.bv (w + w)
  | .divs w => Ty.bv w
  | .divu w => Ty.bv w
  | .extract w => sorry -- Ty.bv (w - n)
  | .icmp _ => Ty.bool
  | .mods w => Ty.bv w
  | .modu w => Ty.bv w
  | .mul w => Ty.bv w
  | .mux w => Ty.bv w
  | .or w =>  Ty.bv w
  | .parity _ => Ty.bool
  | .replicate w => sorry -- Ty.bv (w * n)
  | .shl w =>  Ty.bv w
  | .shrs w =>  Ty.bv w
  | .shru w =>  Ty.bv w
  | .sub w =>  Ty.bv w
  | .xor w => Ty.bv w

@[simp, reducible]
def Op.signature : Op → Signature (Ty) :=
  fun o => {sig := Op.sig o, outTy := Op.outTy o, regSig := []}

instance : DialectSignature Comb := ⟨Op.signature⟩

@[simp]
instance : DialectDenote (Comb) where
    denote
    | .add w, arg, _ => Comb.add (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .and w, arg, _ => Comb.and (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .concat w, arg, _ => sorry --Comb.concat (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .divs w, arg, _ => Comb.divs (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .divu w, arg, _ => Comb.divu (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .extract w, arg, _ => sorry -- Comb.extract (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .icmp w, arg, _ => sorry -- Comb.icmp (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .mods w, arg, _ => Comb.mods (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .modu w, arg, _ => Comb.modu (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .mul w, arg, _ => Comb.mul (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .mux w, arg, _ => sorry -- Comb.mux (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .or w, arg, _ => Comb.or (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .parity w, arg, _ => sorry -- Comb.parity (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .replicate w, arg, _ => sorry -- Comb.replicate (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .shl w, arg, _ => Comb.shl (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .shrs w, arg, _ => Comb.shrs (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .shru w, arg, _ => Comb.shru (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .sub w, arg, _ => Comb.sub (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .xor w, arg, _ => Comb.xor (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))

end Dialect


def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM Comb Comb.Ty
  | MLIR.AST.MLIRType.undefined s => do
    match s.splitOn "_" with
    | ["bool"] =>
      return .bool
    | ["nat"] =>
      return .nat
    | ["bv", r] =>
      return .bv (r.toNat!) -- this seems a bit sketchy
    | _ => throw .unsupportedType
  | _ => throw .unsupportedType

instance instTransformTy : MLIR.AST.TransformTy Comb 0 where
  mkTy := mkTy



def add {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def and {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def concat {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def divs {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def divu {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

/-
  problem: handling nat/bool arguments
-/
def extract {Γ : Ctxt _} (a : Γ.Var (.bv w)) (n : Γ.Var (.nat)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := sorry)--.cons a <| sorry n <| .nil)
    (regArgs := .nil)

def icmp {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) (n : Γ.Var (.nat)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := sorry)
    (regArgs := .nil)

def mods {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def modu {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def mul {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def mux {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) (cond : Γ.Var (.bool)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := sorry)
    (regArgs := .nil)

def or {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def parity {Γ : Ctxt _} (a : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := sorry)
    (regArgs := .nil)

def replicate {Γ : Ctxt _} (a : Γ.Var (.bv w)) (n : Γ.Var (.nat)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := sorry)
    (regArgs := .nil)


def shl {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def shrs {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def shru {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def sub {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def xor {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM (Comb) (Σ eff ty, Expr (Comb) Γ eff ty) := do
  match opStx.name with
  | op@"Comb.source" =>
    if opStx.args.length > 0 then
      throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
    else
      return ⟨_, .tokenstream, source⟩
  | op@"Comb.sink" | op@"Comb.unpack" | op@"Comb.fork" | op@"Comb.branch" | op@"Comb.fst" | op@"Comb.snd" | op@"Comb.fstVal" | op@"Comb.sndVal" =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, op with
      | .tokenstream2, "Comb.fst" => return ⟨_, .tokenstream, fst v₁⟩
      | .tokenstream2, "Comb.snd"  => return ⟨_, .tokenstream, snd v₁⟩
      | .valuetokenstream r, "Comb.fstVal" => return ⟨_, .valuestream r, fstVal v₁⟩
      | .valuetokenstream r, "Comb.sndVal"  => return ⟨_, .tokenstream, sndVal v₁⟩
      | .tokenstream, "Comb.sink" => return ⟨_, .tokenstream, sink v₁⟩
      | .valuestream r, "Comb.unpack"  => return ⟨_, .valuetokenstream r, unpack v₁⟩
      | .tokenstream, "Comb.fork"  => return ⟨_, .tokenstream2, fork v₁⟩
      | .valuestream .bool, "Comb.branch"  => return ⟨_, .tokenstream2, branch v₁⟩
      | _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"Comb.merge" | op@"Comb.join" | op@"Comb.pack" | op@"Comb.pair"  =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂, op with
      | .tokenstream, .tokenstream, "Comb.merge" => return ⟨_, .valuestream .bool, merge v₁ v₂⟩
      | .valuestream r, .valuestream r', "Comb.pair" =>
        if h: r = r' then return ⟨_, .valuestream2 r, pair v₁ (by subst r ; exact v₂)⟩
        else throw <| .generic s!"type mismatch"
      | .tokenstream, .tokenstream, "Comb.join"  => return ⟨_, .tokenstream, join v₁ v₂⟩
      | .valuestream r, .tokenstream, "Comb.pack"  => return ⟨_, .valuestream r, pack v₁ v₂⟩
      | _, _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"Comb.select" =>
    match opStx.args with
    | v₁Stx::v₂Stx::v₃Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      let ⟨ty₃, v₃⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₃Stx
      match ty₁, ty₂, ty₃, op with
      | .tokenstream, .tokenstream, .valuestream .bool, "Comb.select" => return ⟨_, .tokenstream, select v₁ v₂ v₃⟩
      | _, _, _, _=> throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected three operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"

instance : MLIR.AST.TransformExpr (Comb) 0 where
  mkExpr := mkExpr

def mkReturn (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) : MLIR.AST.ReaderM (Comb)
    (Σ eff ty, Com Comb Γ eff ty) :=
  if opStx.name == "return"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    return ⟨.pure, ty, Com.ret v⟩
  | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})"
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

instance : MLIR.AST.TransformReturn (Comb) 0 where
  mkReturn := mkReturn

open Qq MLIR AST Lean Elab Term Meta in
elab "[Comb_com| " reg:mlir_region "]" : term => do
  SSA.elabIntoCom reg q(Comb)

end MLIR2Comb

  | .divs
  | .divu
  | .extract
  | .icmp
  | .mods
  | .modu
  | .mul
  | .mux
  | .or
  | .parity
  | .replicate
  | .shl
  | .shrs
  | .shru
  | .sub
  | .xor
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

instance : DialectSignature Comb := ⟨Op.signature⟩

@[simp]
instance : DialectDenote (Comb) where
    denote
    | .fst, arg, _ => (arg.getN 0 (by simp [DialectSignature.sig, signature])).fst
    | .snd, arg, _ => (arg.getN 0 (by simp [DialectSignature.sig, signature])).snd
    | .fstVal _, arg, _ => (arg.getN 0 (by simp [DialectSignature.sig, signature])).fst
    | .sndVal _, arg, _ => (arg.getN 0 (by simp [DialectSignature.sig, signature]) ).snd
    | .pair _, arg, _ => (arg.getN 0 (by simp [DialectSignature.sig, signature]), arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .unpack _, arg, _ => CIRCTStream.Comb.unpack (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .pack _, arg, _  => CIRCTStream.Comb.pack (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .branch, arg, _  => CIRCTStream.Comb.branch (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .fork, arg, _  => CIRCTStream.Comb.fork (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .join, arg, _  => CIRCTStream.Comb.join (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .merge, arg, _  => CIRCTStream.Comb.merge (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .select, arg, _  => CIRCTStream.Comb.select (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature])) (arg.getN 2 (by simp [DialectSignature.sig, signature]))
    | .sink, arg, _  => CIRCTStream.Comb.sink (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .source, _, _  => CIRCTStream.Comb.source

end Dialect



def mkTy2 : String → MLIR.AST.ExceptM (Comb) Ty2
  | "Int" => return (.int)
  | "Bool" => return (.bool)
  | _ => throw .unsupportedType

def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM Comb Comb.Ty
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

instance instTransformTy : MLIR.AST.TransformTy Comb 0 where
  mkTy := mkTy

def source : Expr (Comb) Γ .pure (.tokenstream) :=
  Expr.mk
    (op := .source)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .nil)
    (regArgs := .nil)

def sink {Γ : Ctxt _} (a : Γ.Var (.tokenstream)) : Expr (Comb) Γ .pure (.tokenstream) :=
  Expr.mk
    (op := .sink)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def unpack {r} {Γ : Ctxt _} (a : Γ.Var (.valuestream r)) : Expr (Comb) Γ .pure (.valuetokenstream r) :=
  Expr.mk
    (op := .unpack r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def pack {r} {Γ : Ctxt _} (a : Γ.Var (.valuestream r)) (b : Γ.Var (.tokenstream)) : Expr (Comb) Γ .pure (.valuestream r) :=
  Expr.mk
    (op := .pack r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def branch {Γ : Ctxt _} (a : Γ.Var (.valuestream .bool)) : Expr (Comb) Γ .pure (.tokenstream2) :=
  Expr.mk
    (op := .branch)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def fork (a : Γ.Var (.tokenstream)) : Expr (Comb) Γ .pure (.tokenstream2) :=
  Expr.mk
    (op := .fork)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def join {Γ : Ctxt _} (a b : Γ.Var (.tokenstream)) : Expr (Comb) Γ .pure (.tokenstream) :=
  Expr.mk
    (op := .join)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def merge {Γ : Ctxt _} (a b : Γ.Var (.tokenstream)) : Expr (Comb) Γ .pure (.valuestream .bool) :=
  Expr.mk
    (op := .merge)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def select {Γ : Ctxt _} (a b : Γ.Var (.tokenstream)) (c : Γ.Var (.valuestream .bool)) : Expr (Comb) Γ .pure (.tokenstream) :=
  Expr.mk
    (op := .select)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .cons c <| .nil)
    (regArgs := .nil)

def fst {Γ : Ctxt _} (a : Γ.Var (.tokenstream2)) : Expr (Comb) Γ .pure (.tokenstream)  :=
  Expr.mk
    (op := .fst)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def fstVal {r} {Γ : Ctxt _} (a : Γ.Var (.valuetokenstream r))  : Expr (Comb) Γ .pure (.valuestream r)  :=
  Expr.mk
    (op := .fstVal r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def sndVal {r} {Γ : Ctxt _} (a : Γ.Var (.valuetokenstream r))  : Expr (Comb) Γ .pure (.tokenstream)  :=
  Expr.mk
    (op := .sndVal r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def snd {Γ : Ctxt _} (a : Γ.Var (.tokenstream2)) : Expr (Comb) Γ .pure (.tokenstream)  :=
  Expr.mk
    (op := .snd)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def pair {r} {Γ : Ctxt _} (a b: Γ.Var (.valuestream r)) : Expr (Comb) Γ .pure (.valuestream2 r)  :=
  Expr.mk
    (op := .pair r)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM (Comb) (Σ eff ty, Expr (Comb) Γ eff ty) := do
  match opStx.name with
  | op@"Comb.source" =>
    if opStx.args.length > 0 then
      throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
    else
      return ⟨_, .tokenstream, source⟩
  | op@"Comb.sink" | op@"Comb.unpack" | op@"Comb.fork" | op@"Comb.branch" | op@"Comb.fst" | op@"Comb.snd" | op@"Comb.fstVal" | op@"Comb.sndVal" =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, op with
      | .tokenstream2, "Comb.fst" => return ⟨_, .tokenstream, fst v₁⟩
      | .tokenstream2, "Comb.snd"  => return ⟨_, .tokenstream, snd v₁⟩
      | .valuetokenstream r, "Comb.fstVal" => return ⟨_, .valuestream r, fstVal v₁⟩
      | .valuetokenstream r, "Comb.sndVal"  => return ⟨_, .tokenstream, sndVal v₁⟩
      | .tokenstream, "Comb.sink" => return ⟨_, .tokenstream, sink v₁⟩
      | .valuestream r, "Comb.unpack"  => return ⟨_, .valuetokenstream r, unpack v₁⟩
      | .tokenstream, "Comb.fork"  => return ⟨_, .tokenstream2, fork v₁⟩
      | .valuestream .bool, "Comb.branch"  => return ⟨_, .tokenstream2, branch v₁⟩
      | _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"Comb.merge" | op@"Comb.join" | op@"Comb.pack" | op@"Comb.pair"  =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂, op with
      | .tokenstream, .tokenstream, "Comb.merge" => return ⟨_, .valuestream .bool, merge v₁ v₂⟩
      | .valuestream r, .valuestream r', "Comb.pair" =>
        if h: r = r' then return ⟨_, .valuestream2 r, pair v₁ (by subst r ; exact v₂)⟩
        else throw <| .generic s!"type mismatch"
      | .tokenstream, .tokenstream, "Comb.join"  => return ⟨_, .tokenstream, join v₁ v₂⟩
      | .valuestream r, .tokenstream, "Comb.pack"  => return ⟨_, .valuestream r, pack v₁ v₂⟩
      | _, _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"Comb.select" =>
    match opStx.args with
    | v₁Stx::v₂Stx::v₃Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      let ⟨ty₃, v₃⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₃Stx
      match ty₁, ty₂, ty₃, op with
      | .tokenstream, .tokenstream, .valuestream .bool, "Comb.select" => return ⟨_, .tokenstream, select v₁ v₂ v₃⟩
      | _, _, _, _=> throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected three operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"

instance : MLIR.AST.TransformExpr (Comb) 0 where
  mkExpr := mkExpr

def mkReturn (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) : MLIR.AST.ReaderM (Comb)
    (Σ eff ty, Com Comb Γ eff ty) :=
  if opStx.name == "return"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    return ⟨.pure, ty, Com.ret v⟩
  | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})"
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

instance : MLIR.AST.TransformReturn (Comb) 0 where
  mkReturn := mkReturn

open Qq MLIR AST Lean Elab Term Meta in
elab "[Comb_com| " reg:mlir_region "]" : term => do
  SSA.elabIntoCom reg q(Comb)

end MLIR2Comb
