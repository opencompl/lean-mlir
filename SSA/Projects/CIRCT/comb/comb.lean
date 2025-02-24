import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim


namespace Comb

/-- Variadic `add` operation on a list of `BitVec w` -/
def add {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.add (0#w) l

/-- Variadic `and` operation on a list of `BitVec w` -/
def and {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.and (0#w) l

/-- Concatenate a list of bitvecs `xs`, where the length of bitvec xs[i] is given by
  element ls[i] in a list of nat `ls`-/
def concat {ls : List Nat} : HVector BitVec ls → BitVec (List.sum ls)
  | .nil => 0#0
  | .cons x xs =>
     let xsSum := concat xs
     x ++ xsSum

/-- Signed division between two `BitVec w` -/
def divs (x y : BitVec w) : BitVec w :=
  BitVec.sdiv x y

/-- Unsigned division between two `BitVec w` -/
def divu (x y : BitVec w) : BitVec w :=
  BitVec.udiv x y

/-- Extract the most significant bits from a `BitVec w` up to `lb` -/
def extract (x : BitVec w) (lb : Nat) : BitVec (w - lb) :=
  BitVec.truncate (w - lb) (BitVec.ushiftRight x lb)


/-- Compare two integer values -/
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

/-- Signed modulo between two `BitVec w` -/
def mods (x y : BitVec w) : BitVec w :=
  BitVec.smod x y

/-- Unsigned modulo between two `BitVec w` -/
def modu (x y : BitVec w) : BitVec w :=
  BitVec.umod x y

/-- Variadic `mul` operation on a list of `BitVec w` -/
def mul {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.mul (1#w) l

/-- Return one or the other operand depending on a selector bit -/
def mux (x y : α) (cond : Bool) : α :=
  bif cond then x else y

/-- Variadic `or` operation on a list of `BitVec w` -/
def or {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.or (BitVec.zero w) l

/-- Return the boolean parity value of `BitVec w` -/
def parity (x : BitVec w) : Bool :=
  (BitVec.umod x 2#w) == 1

/-- Replicate `BitVec w` `n` times -/
def replicate (x : BitVec w) (n : Nat) : BitVec (w * n) :=
  BitVec.replicate n x

/-- Shift left between two `BitVec w` -/
def shl (x y : BitVec w) : BitVec w :=
  x <<< y

/-- Signed shift right between two `BitVec w` -/
def shrs (x y : BitVec w) : BitVec w :=
  BitVec.sshiftRight' x y

/-- Unigned shift right between two `BitVec w` -/
def shru (x y : BitVec w) : BitVec w :=
  BitVec.ushiftRight x y.toNat

/-- Subtraction two `BitVec w` -/
def sub (x y : BitVec w) : BitVec w :=
  x - y

/-- Variadic `xor` operation on a list of `BitVec w` -/
def xor {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.xor (BitVec.zero w) l

end Comb

namespace MLIR2Comb

section Dialect

inductive Op
| add (n : Nat) -- n is the number of arguments
| and (n : Nat)
| concat (w : List Nat) -- len(w) = #args, wi is the width of the i-th arg
| divs (w : Nat)
| divu (w : Nat)
| extract (w : Nat) (n : Nat) -- I tried to avoid the two args but could not think of a better solution
| icmp (w : Nat) (n : Nat)
| mods (w : Nat)
| modu (w : Nat)
| mul (w : Nat)
| mux (w : Nat)
| or (n : Nat)
| parity (w : Nat)
| replicate (w : Nat) (n : Nat)
| shl (w : Nat)
| shrs (w : Nat)
| shru (w : Nat)
| sub (w : Nat)
| xor (n : Nat)
deriving Inhabited, DecidableEq, Repr

inductive Ty
| bv (w : Nat) : Ty -- A bitvector of width `Ty2`.
| nat (n : Nat): Ty
| bool : Ty
| list (w : Nat) : Ty -- list of bitvecs with the same length
| hList (l : List Nat) : Ty -- dependent type bitvec
deriving Inhabited, DecidableEq, Repr

open TyDenote (toType) in
instance instCombTyDenote : TyDenote Ty where
toType := fun
| Ty.bv w => BitVec w
| Ty.nat _ => Nat
| Ty.bool => Bool
| Ty.list w => List (BitVec w)
| Ty.hList l => HVector BitVec l

abbrev Comb : Dialect where
  Op := Op
  Ty := Ty

open TyDenote (toType)

-- arg type CONF
@[simp, reducible]
def Op.sig : Op  → List Ty
  | .add w => [Ty.list w]
  | .and w => [Ty.list w]
  | .concat l => [Ty.hList l]
  | .divs w => [Ty.bv w, Ty.bv w]
  | .divu w => [Ty.bv w, Ty.bv w]
  | .extract w n => [Ty.bv w, Ty.nat n]
  | .icmp w n => [Ty.bv w, Ty.bv w, Ty.nat n]
  | .mods w => [Ty.bv w, Ty.bv w]
  | .modu w => [Ty.bv w, Ty.bv w]
  | .mul w => [Ty.list w]
  | .mux w => [Ty.bv w, Ty.bv w, Ty.bool]
  | .or w => [Ty.list w]
  | .parity w => [Ty.bv w]
  | .replicate w _ => [Ty.bv w]
  | .shl w => [Ty.bv w, Ty.bv w]
  | .shrs w => [Ty.bv w, Ty.bv w]
  | .shru w => [Ty.bv w, Ty.bv w]
  | .sub w => [Ty.bv w, Ty.bv w]
  | .xor w => [Ty.list w]

-- return type CONF
@[simp, reducible]
def Op.outTy : Op  → Ty
  | .add w => Ty.bv w
  | .and w => Ty.bv w
  | .concat l => Ty.bv l.sum
  | .divs w => Ty.bv w
  | .divu w => Ty.bv w
  | .extract w n => Ty.bv (w - n)
  | .icmp _ _ => Ty.bool
  | .mods w => Ty.bv w
  | .modu w => Ty.bv w
  | .mul w => Ty.bv w
  | .mux w => Ty.bv w
  | .or w =>  Ty.bv w
  | .parity _ => Ty.bool
  | .replicate w n =>  Ty.bv (w * n)
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
    | .add _, arg, _ => Comb.add (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .and _, arg, _ => Comb.and (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .concat _, arg, _ => Comb.concat (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .divs _, arg, _ => Comb.divs (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .divu _, arg, _ => Comb.divu (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .extract w n, arg, _ => Comb.extract (arg.getN 0 (by simp [DialectSignature.sig, signature])) n
    | .icmp _ _, arg, _ => Comb.icmp (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature])) (arg.getN 2 (by simp [DialectSignature.sig, signature]))
    | .mods _, arg, _ => Comb.mods (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .modu _, arg, _ => Comb.modu (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .mul _, arg, _ => Comb.mul (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .mux _, arg, _ => Comb.mux (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature])) (arg.getN 2 (by simp [DialectSignature.sig, signature]))
    | .or _, arg, _ => Comb.or (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .parity _, arg, _ => Comb.parity (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .replicate _ n, arg, _ => Comb.replicate (arg.getN 0 (by simp [DialectSignature.sig, signature])) n
    | .shl _, arg, _ => Comb.shl (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .shrs _, arg, _ => Comb.shrs (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .shru _, arg, _ => Comb.shru (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .sub _, arg, _ => Comb.sub (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .xor _, arg, _ => Comb.xor (arg.getN 0 (by simp [DialectSignature.sig, signature]))

end Dialect

def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM Comb Comb.Ty
  | MLIR.AST.MLIRType.undefined s => do
    match s.splitOn "_" with
    | ["bool"] =>
      return .bool
    | ["nat", r] =>
      return .nat r.toNat!
    | ["bv", r] =>
      return .bv (r.toNat!)
    | ["list", r] =>
      return .list (r.toNat!)
    | _ => throw .unsupportedType
  | _ => throw .unsupportedType

instance instTransformTy : MLIR.AST.TransformTy Comb 0 where
  mkTy := mkTy

def add {Γ : Ctxt _} (l : Γ.Var (.list w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .add w)
    (ty_eq := by rfl)
    (eff_le := by constructor)
    (args := .cons l <| .nil)
    (regArgs := .nil)

def and {Γ : Ctxt _} (l : Γ.Var (.list w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons l <| .nil)
    (regArgs := .nil)

def concat {l : List Nat} {Γ : Ctxt _} (ls : Γ.Var (.hList l)): Expr (Comb) Γ .pure (.bv (l.sum)) :=
  Expr.mk
    (op := .concat l)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons ls <| .nil)
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

def mul {Γ : Ctxt _} (l : Γ.Var (.list w))  : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .mul w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons l <| .nil)
    (regArgs := .nil)

def mux {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) (cond : Γ.Var (.bool)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .mux w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .cons cond <| .nil)
    (regArgs := .nil)

def or {Γ : Ctxt _} (l : Γ.Var (.list w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .or w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons l <| .nil)
    (regArgs := .nil)

def parity {Γ : Ctxt _} (a : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bool) :=
  Expr.mk
    (op := .parity w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def replicate {Γ : Ctxt _} (a : Γ.Var (.bv w)) : Expr (Comb) Γ .pure (.bv (w * n)) :=
  Expr.mk
    (op := .replicate w n)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
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

def xor {Γ : Ctxt _} (l : Γ.Var (.list w)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .xor w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons l <| .nil)
    (regArgs := .nil)

def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM (Comb) (Σ eff ty, Expr (Comb) Γ eff ty) := do
  match opStx.name with
  | op@"Comb.parity" | op@"Comb.add" | op@"Comb.and" | op@"Comb.mul" | op@"Comb.or"  | op@"Comb.xor" | op@"Comb.concat" =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, op with
      | .bv w, "Comb.parity" => return ⟨_, .bool, parity v₁⟩
      | .list w, "Comb.add" => return ⟨_, .bv w, add v₁⟩
      | .list w, "Comb.and" => return ⟨_, .bv w, and v₁⟩
      | .list w, "Comb.mul" => return ⟨_, .bv w, mul v₁⟩
      | .list w, "Comb.or" => return ⟨_, .bv w, or v₁⟩
      | .list w, "Comb.xor" => return ⟨_, .bv w, xor v₁⟩
      | .hList l, "Comb.concat" => return ⟨_, .bv l.sum, concat v₁⟩
      | _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"Comb.divs" | op@"Comb.divu" | op@"Comb.extract" | op@"Comb.mods" | op@"Comb.modu" | op@"Comb.replicate" | op@"Comb.shl" | op@"Comb.shrs" | op@"Comb.shru" | op@"Comb.sub"  =>
    match opStx.args with
    | v₁Stx::v₂Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂, op with
      /- more checks need to be added here to ensure the consistency of operations and bitvec sizes -/
      -- | .bv w₁, .bv w₂, "Comb.concat" =>
      --   return ⟨_, .bv (w₁ + w₂), concat v₁ v₂⟩
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
  | _ =>
    if "Comb.replicate".isPrefixOf opStx.name
    then {
      match (opStx.name).splitOn "_" with
      | [_, n] =>
        match opStx.args with
        | v₁Stx::[] =>
          let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
          match ty₁ with
          | .bv w₁ =>
            let n' := n.toNat!
            return ⟨_, .bv (w₁ * n'), replicate v₁ (n := n')⟩
          | _ => throw <| .generic s!"type mismatch"
        | _ => throw <| .generic s!"type mismatch"
      | _ => throw <| .generic s!"type mismatch"
    }
    else
      throw <| .unsupportedOp s!"unsupported operation {repr opStx}"

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
