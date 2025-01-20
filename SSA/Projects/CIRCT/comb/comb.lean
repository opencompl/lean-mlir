import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim


namespace Comb

/- most inputs for the following ops should be variadic. binary for now. -/
def add (x y : BitVec w) : BitVec w :=
  x + y

def and (x y : BitVec w) : BitVec w :=
  x &&& y

def concat (x : BitVec w₁) (y : BitVec w₂) : BitVec (w₁ + w₂) :=
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

def parity (x : BitVec w) : Bool :=
  (BitVec.umod x 2#w) == 1

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
| add (w : Nat) (n : Nat) -- n is the number of arguments
| and (w : Nat) (n : Nat)
| concat (w : List Nat) -- len(w) = #args, wi is the width of the i-th arg
| divs (w : Nat)
| divu (w : Nat)
| extract (w : Nat) (n : Nat) -- I tried to avoid the two args but could not think of a better solution
| icmp (w : Nat) (n : Nat)
| mods (w : Nat)
| modu (w : Nat)
| mul (w : Nat) (n : Nat)
| mux (w : Nat)
| or (w : Nat) (n : Nat)
| parity (w : Nat)
| replicate (w : Nat) (n : Nat)
| shl (w : Nat)
| shrs (w : Nat)
| shru (w : Nat)
| sub (w : Nat)
| xor (w : Nat) (n : Nat)
deriving Inhabited, DecidableEq, Repr

inductive Ty
| bv (w : Nat) : Ty -- A bitvector of width `Ty2`.
| nat (n : Nat): Ty -- A very unfair trick
| bool : Ty
deriving Inhabited, DecidableEq, Repr

open TyDenote (toType) in
instance instCombTyDenote : TyDenote Ty where
toType := fun
| Ty.bv w => BitVec w
| Ty.nat _ => Nat
| Ty.bool => Bool

abbrev Comb : Dialect where
  Op := Op
  Ty := Ty

open TyDenote (toType)

-- arg type CONF
@[simp, reducible]
def Op.sig : Op  → List Ty
  | .add w n => List.replicate (n + 1) (Ty.bv w)
  | .and w n => List.replicate (n + 1) (Ty.bv w)
  | .concat w  => w.map (fun w => Ty.bv w)
  | .divs w => [Ty.bv w, Ty.bv w]
  | .divu w => [Ty.bv w, Ty.bv w]
  | .extract w n => [Ty.bv w, Ty.nat n]
  | .icmp w n => [Ty.bv w, Ty.bv w, Ty.nat n]
  | .mods w => [Ty.bv w, Ty.bv w]
  | .modu w => [Ty.bv w, Ty.bv w]
  | .mul w n => List.replicate (n + 1) (Ty.bv w)
  | .mux w => [Ty.bv w, Ty.bv w, Ty.bool]
  | .or w n => List.replicate (n + 1) (Ty.bv w)
  | .parity w => [Ty.bv w]
  | .replicate w _ => [Ty.bv w]
  | .shl w => [Ty.bv w, Ty.bv w]
  | .shrs w => [Ty.bv w, Ty.bv w]
  | .shru w => [Ty.bv w, Ty.bv w]
  | .sub w => [Ty.bv w, Ty.bv w]
  | .xor w n => List.replicate (n + 1) (Ty.bv w)

-- return type CONF
@[simp, reducible]
def Op.outTy : Op  → Ty
  | .add w _ => Ty.bv w
  | .and w _ => Ty.bv w
  | .concat w => Ty.bv w.sum
  | .divs w => Ty.bv w
  | .divu w => Ty.bv w
  | .extract w n => Ty.bv (w - n)
  | .icmp _ _ => Ty.bool
  | .mods w => Ty.bv w
  | .modu w => Ty.bv w
  | .mul w _ => Ty.bv w
  | .mux w => Ty.bv w
  | .or w _ =>  Ty.bv w
  | .parity _ => Ty.bool
  | .replicate w n =>  Ty.bv (w * n)
  | .shl w =>  Ty.bv w
  | .shrs w =>  Ty.bv w
  | .shru w =>  Ty.bv w
  | .sub w =>  Ty.bv w
  | .xor w _ => Ty.bv w

@[simp, reducible]
def Op.signature : Op → Signature (Ty) :=
  fun o => {sig := Op.sig o, outTy := Op.outTy o, regSig := []}

instance : DialectSignature Comb := ⟨Op.signature⟩

def HVector.toList : HVector f (List.replicate n a) → List (f a) :=
  sorry

def Comb.variadicAdd (l : List (BitVec w)) : List (BitVec w) → BitVec w :=
  List.foldr BitVec.add _ _
  sorry

@[simp]
instance : DialectDenote (Comb) where
    denote
    | .add _ _, (arg : HVector toType (List.replicate ..)), _ => Comb.variadicAdd (HVector.toList (f:=toType) arg)
    | .and _ _, arg, _ => Comb.and (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .concat _, arg, _ => Comb.concat (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .divs _, arg, _ => Comb.divs (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .divu _, arg, _ => Comb.divu (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .extract w n, arg, _ => Comb.extract (arg.getN 0 (by simp [DialectSignature.sig, signature])) n
    | .icmp _ _, arg, _ => Comb.icmp (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature])) (arg.getN 2 (by simp [DialectSignature.sig, signature]))
    | .mods _, arg, _ => Comb.mods (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .modu _, arg, _ => Comb.modu (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .mul _ _, arg, _ => Comb.mul (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .mux _, arg, _ => Comb.mux (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature])) (arg.getN 2 (by simp [DialectSignature.sig, signature]))
    | .or _ _, arg, _ => Comb.or (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .parity _, arg, _ => Comb.parity (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .replicate _ n, arg, _ => Comb.replicate (arg.getN 0 (by simp [DialectSignature.sig, signature])) n
    | .shl _, arg, _ => Comb.shl (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .shrs _, arg, _ => Comb.shrs (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .shru _, arg, _ => Comb.shru (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .sub _, arg, _ => Comb.sub (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .xor _ _, arg, _ => Comb.xor (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))

end Dialect


def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM Comb Comb.Ty
  | MLIR.AST.MLIRType.undefined s => do
    match s.splitOn "_" with
    | ["bool"] =>
      return .bool
    | ["nat", r] =>
      return .nat r.toNat!
    | ["bv", r] =>
      return .bv (r.toNat!) -- this seems a bit sketchy
    | _ => throw .unsupportedType
  | _ => throw .unsupportedType

instance instTransformTy : MLIR.AST.TransformTy Comb 0 where
  mkTy := mkTy

def add {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .add w)
    (ty_eq := by rfl)
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

def concat {Γ : Ctxt _} (a : Γ.Var (.bv w₁)) (b : Γ.Var (.bv w₂)) : Expr (Comb) Γ .pure (.bv (w₁ + w₂)) :=
  Expr.mk
    (op := .concat w₁ w₂)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def divs {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .divs w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def divu {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .divu w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

/-
  problem: handling nat/bool arguments
-/
def extract {Γ : Ctxt _} (a : Γ.Var (.bv w)) (k : Γ.Var (.nat n)) : Expr (Comb) Γ .pure (.bv (w - n)) :=
  Expr.mk
    (op := .extract w n)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons k <| .nil)
    (regArgs := .nil)

def icmp {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) (k : Γ.Var (.nat n)) : Expr (Comb) Γ .pure (.bool) :=
  Expr.mk
    (op := .icmp w n)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .cons k <| .nil)
    (regArgs := .nil)

def mods {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .mods w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def modu {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .modu w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def mul {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .mul w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def mux {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) (cond : Γ.Var (.bool)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .mux w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .cons cond <| .nil)
    (regArgs := .nil)

def or {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .or w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def parity {Γ : Ctxt _} (a : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bool) :=
  Expr.mk
    (op := .parity w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def replicate {Γ : Ctxt _} (a : Γ.Var (.bv w)) (k : Γ.Var (.nat n)) : Expr (Comb) Γ .pure (.bv (w * n)) :=
  Expr.mk
    (op := .replicate w n)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons k <| .nil)
    (regArgs := .nil)


def shl {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .shl w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def shrs {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .shrs w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def shru {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .shru w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def sub {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .sub w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def xor {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .xor w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .nil)
    (regArgs := .nil)

def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM (Comb) (Σ eff ty, Expr (Comb) Γ eff ty) := do
  match opStx.name with
  | op@"Comb.parity"  =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, op with
      | .bv w, "Comb.parity" => return ⟨_, .bool, parity v₁⟩
      | _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"Comb.add" | op@"Comb.and" | op@"Comb.concat" | op@"Comb.divs" | op@"Comb.divu" | op@"Comb.extract" | op@"Comb.mods" | op@"Comb.modu" | op@"Comb.mul" | op@"Comb.or" | op@"Comb.replicate" | op@"Comb.shl" | op@"Comb.shrs" | op@"Comb.shru" | op@"Comb.sub" | op@"Comb.xor"   =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂, op with
      /- more checks need to be added here to ensure the consistency of operations and bitvec sizes -/
      | .bv w₁, .bv w₂, "Comb.add" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, add v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w₁, .bv w₂, "Comb.and" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, add v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w₁, .bv w₂, "Comb.concat" => return ⟨_, .bv (w₁ + w₂), concat v₁ v₂⟩
      | .bv w₁, .bv w₂, "Comb.divs" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, divs v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w₁, .bv w₂, "Comb.divu" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, divu v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w, .nat n, "Comb.extract" =>
        return ⟨_, .bv (w - n), extract v₁ v₂⟩
      | .bv w, .nat n, "Comb.replicate" =>
        return ⟨_, .bv (w * n), replicate v₁ v₂⟩
      | .bv w₁, .bv w₂, "Comb.mods" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, mods v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w₁, .bv w₂, "Comb.modu" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, modu v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w₁, .bv w₂, "Comb.mul" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, mul v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w₁, .bv w₂, "Comb.or" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, or v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      /- TODO: conditions on shifts can be relaxed. reason about how. -/
      | .bv w₁, .bv w₂, "Comb.shl" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, shl v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w₁, .bv w₂, "Comb.shrs" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, shrs v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w₁, .bv w₂, "Comb.shru" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, shru v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w₁, .bv w₂, "Comb.sub" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, sub v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w₁, .bv w₂, "Comb.xor" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, xor v₁ v₂⟩
        else
          throw <| .generic s!"type mismatch"
      | _, _, _=> throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"Comb.icmp" | op@"Comb.mux" =>
    match opStx.args with
    | v₁Stx::v₂Stx::v₃Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      let ⟨ty₃, v₃⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₃Stx
      match ty₁, ty₂, ty₃, op with
      | .bv w₁, .bv w₂, .nat n, "Comb.icmp" =>
        if h : w₁ = w₂ then
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bool, icmp v₁ v₂ v₃⟩
        else
          throw <| .generic s!"type mismatch"
      | .bv w₁, .bv w₂, .bool, "Comb.mux" =>
        if h : w₁ = w₂ then
          /- mux should work even if w₁ ≠ w₂ but i need to think about how to implement that in an elegant way -/
          let v₂ := v₂.cast (by rw [h])
          return ⟨_, .bv w₁, mux v₁ v₂ v₃⟩
        else
          throw <| .generic s!"type mismatch"
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
