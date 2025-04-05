import SSA.Core.MLIRSyntax.EDSL2
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim

/-!
  This file defines CIRCT's Comb dialect's semantics: https://circt.llvm.org/docs/Dialects/Comb/
  We currently only support 2-state logic.
-/

open Lean (ToExpr)

namespace Comb

inductive IcmpPredicate where
  | eq
  | ne
  | slt
  | sle
  | sgt
  | sge
  | ult
  | ule
  | ugt
  | uge
deriving Inhabited, DecidableEq, Repr

instance : ToString IcmpPredicate where
  toString
  | .eq  => "eq"
  | .ne  => "ne"
  | .slt => "ugt"
  | .sle => "sle"
  | .sgt => "sgt"
  | .sge => "sge"
  | .ult => "ult"
  | .ule => "ule"
  | .ugt => "ugt"
  | .uge => "uge"


/-- Variadic `add` operation with a list of bitvectors with width `w` as input -/
def add {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.add (0#w) l

/-- Variadic `and` operation with a list of bitvectors with width `w` as input -/
def and {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.and (0#w) l

/-- Concatenate a list of bitvecs `xs`, where the length of bitvec `xs[i]` is given by
  element `ls[i]` in a list of nat `ls` -/
def concat {ls : List Nat} (xs : HVector BitVec ls) : BitVec (List.sum ls) :=
  match (xs) with
  | (.nil) => 0#0
  | (.cons x xs) =>
     let xsSum := concat xs
     x ++ xsSum

/-- Signed division -/
def divs (x y : BitVec w) : BitVec w :=
  BitVec.sdiv x y

/-- Unsigned division -/
def divu (x y : BitVec w) : BitVec w :=
  BitVec.udiv x y

/-- Extract the `lb` lower bits from BitVec `x` -/
def extract (x : BitVec w) (lb : Nat) : BitVec (w - lb) :=
  BitVec.truncate (w - lb) (BitVec.ushiftRight x lb)

/-- Boolean comparison between two input BitVecs -/
def icmp {w : Nat} (c : IcmpPredicate) (x y : BitVec w) : Bool :=
  match c with
    | .eq  => (x == y)
    | .ne => (x != y)
    | .sgt => (y.slt x)
    | .sge => (y.sle x)
    | .slt => (x.slt y)
    | .sle => (x.sle y)
    | .ugt => (x > y)
    | .uge => (x ≥ y)
    | .ult => (x < y)
    | .ule => (x ≤ y)

/-- Signed modulo -/
def mods (x y : BitVec w) : BitVec w :=
  BitVec.smod x y

/-- Unsigned modulo -/
def modu (x y : BitVec w) : BitVec w :=
  BitVec.umod x y

/-- Variadic `mul` operation with a list of bitvectors with width `w` as input -/
def mul {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.mul (1#w) l

/- Generic `mux` operation for any type α -/
def mux (x y : α) (cond : Bool) : α :=
  bif cond then x else y

/-- Variadic `or` operation with a list of bitvectors with width `w` as input -/
def or {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.or (BitVec.zero w) l

/-- Returns boolean parity value of BitVec `x` -/
def parity (x : BitVec w) : Bool :=
  (BitVec.umod x 2#w) == 1

/-- Replicate input BitVec `x` `n` times -/
def replicate (x : BitVec w) (n : Nat) : BitVec (w * n) :=
  BitVec.replicate n x

/-- Shift left -/
def shl (x y : BitVec w) : BitVec w :=
  x <<< y

/-- Signed shift right -/
def shrs (x y : BitVec w) : BitVec w :=
  BitVec.sshiftRight' x y

/-- Unsigned shift right -/
def shru (x y : BitVec w) : BitVec w :=
  BitVec.ushiftRight x y.toNat

/-- Subtraction -/
def sub (x y : BitVec w) : BitVec w :=
  x - y

/-- Variadic `xor` operation with a list of bitvectors with width `w` as input -/
def xor {w : Nat} (l : List (BitVec w)) : BitVec w :=
  List.foldr BitVec.xor (BitVec.zero w) l

end Comb

namespace MLIR2Comb

section Dialect

inductive Op
| add (w : Nat) (arity : Nat)
| and (w : Nat) (arity : Nat)
| concat (w : List Nat) -- len(w) = #args, wi is the width of the i-th arg
| divs (w : Nat)
| divu (w : Nat)
| extract (w : Nat) (n : Nat) -- I tried to avoid the two args but could not think of a better solution
| icmp (p : String) (w : Nat)
| mods (w : Nat)
| modu (w : Nat)
| mul (w : Nat) (arity : Nat)
| mux (w : Nat)
| or (w : Nat) (arity : Nat)
| parity (w : Nat)
| replicate (w : Nat) (n : Nat)
| shl (w : Nat)
| shrs (w : Nat)
| shru (w : Nat)
| sub (w : Nat)
| xor (w : Nat) (arity : Nat)
deriving Inhabited, DecidableEq, Repr, ToExpr

inductive Ty
| bv (w : Nat) : Ty -- A bitvector of width `Ty2`.
| bool : Ty
| nat : Ty
| hList (l : List Nat) : Ty -- dependent type bitvec
| icmpPred (s : String) : Ty -- dependent type bitvec
deriving Inhabited, DecidableEq, Repr, ToExpr

open TyDenote (toType) in
instance instCombTyDenote : TyDenote Ty where
toType := fun
| Ty.bv w => BitVec w
| Ty.nat  => Nat
| Ty.bool => Bool
| Ty.hList l => HVector BitVec l -- het list of bitvec whose lengths are contained in l
| Ty.icmpPred _=> Comb.IcmpPredicate

abbrev Comb : Dialect where
  Op := Op
  Ty := Ty

open TyDenote (toType)

-- arg type CONF
@[simp, reducible]
def Op.sig : Op  → List Ty
  | .add w n => List.replicate (n + 1) (Ty.bv w)
  | .and w n => List.replicate (n + 1) (Ty.bv w)
  | .concat l => [Ty.hList l]
  | .divs w => [Ty.bv w, Ty.bv w]
  | .divu w => [Ty.bv w, Ty.bv w]
  | .extract w _ => [Ty.bv w]
  | .icmp p w => [Ty.icmpPred p, Ty.bv w, Ty.bv w]
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
  | .concat l => Ty.bv l.sum
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

@[simp]
instance : DialectDenote (Comb) where
    denote
    -- the idea is to parse arg as a List w (where arg is currently a list of mlir types)
    | .add _ _, arg, _ => Comb.add (HVector.toList (f:=toType) arg)
    | .and _ _, arg, _ => Comb.and (HVector.toList (f:=toType) arg)
    | .concat _, arg, _ => Comb.concat (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .divs _, arg, _ => Comb.divs (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .divu _, arg, _ => Comb.divu (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .extract _ n, arg, _ => Comb.extract (arg.getN 0 (by simp [DialectSignature.sig, signature])) n
    | .icmp _ _, arg, _ => Comb.icmp (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .mods _, arg, _ => Comb.mods (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .modu _, arg, _ => Comb.modu (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .mul _ _, arg, _ => Comb.mul (HVector.toList (f:=toType) arg)
    | .mux _, arg, _ => Comb.mux (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature])) (arg.getN 2 (by simp [DialectSignature.sig, signature]))
    | .or _ _, arg, _ => Comb.or (HVector.toList (f:=toType) arg)
    | .parity _, arg, _ => Comb.parity (arg.getN 0 (by simp [DialectSignature.sig, signature]))
    | .replicate _ n, arg, _ => Comb.replicate (arg.getN 0 (by simp [DialectSignature.sig, signature])) n
    | .shl _, arg, _ => Comb.shl (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .shrs _, arg, _ => Comb.shrs (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .shru _, arg, _ => Comb.shru (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .sub _, arg, _ => Comb.sub (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
    | .xor _ _, arg, _ => Comb.xor (HVector.toList (f:=toType) arg)

end Dialect

def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM Comb Comb.Ty
  | MLIR.AST.MLIRType.undefined s => do
    match s.splitOn "_" with
    | ["Bool"] =>
      return .bool
    | ["Nat"] =>
      return .nat
    | ["BitVec", r] =>
      return .bv (r.toNat!)
    | ["IcmpPred", r] =>
      return .icmpPred r
    | ["hList", r] =>
      return .icmpPred r
    | _ => throw .unsupportedType
  | _ => throw .unsupportedType

instance instTransformTy : MLIR.AST.TransformTy Comb 0 where
  mkTy := mkTy

def add {Γ : Ctxt _} (arity: Nat) (a : HVector (Γ.Var) (List.replicate (arity + 1) (.bv w))) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .add w arity)
    (ty_eq := by rfl)
    (eff_le := by constructor)
    (args := a)
    (regArgs := .nil)

def and {Γ : Ctxt _} (arity: Nat) (a : HVector (Γ.Var) (List.replicate (arity + 1) (.bv w))) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .and w arity)
    (ty_eq := by rfl)
    (eff_le := by constructor)
    (args := a)
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

def extract {Γ : Ctxt _} (a : Γ.Var (.bv w)) (n : Nat) : Expr (Comb) Γ .pure (.bv (w - n)) :=
  Expr.mk
    (op := .extract w n)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .nil)
    (regArgs := .nil)

def icmp {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) (k : Γ.Var (.icmpPred op)) : Expr (Comb) Γ .pure (.bool) :=
  Expr.mk
    (op := .icmp op w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons k <| .cons a <| .cons b <| .nil)
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

def mul {Γ : Ctxt _} (arity: Nat) (a : HVector (Γ.Var) (List.replicate (arity + 1) (.bv w)))  : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .mul w arity)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := a)
    (regArgs := .nil)

def mux {Γ : Ctxt _} (a : Γ.Var (.bv w)) (b : Γ.Var (.bv w)) (cond : Γ.Var (.bool)) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .mux w)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons a <| .cons b <| .cons cond <| .nil)
    (regArgs := .nil)

def or {Γ : Ctxt _} (arity: Nat) (a : HVector (Γ.Var) (List.replicate (arity + 1) (.bv w))) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .or w arity)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := a)
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

def xor {Γ : Ctxt _} (arity: Nat) (a : HVector (Γ.Var) (List.replicate (arity + 1) (.bv w))) : Expr (Comb) Γ .pure (.bv w) :=
  Expr.mk
    (op := .xor w arity)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := a)
    (regArgs := .nil)

def List.toHVector {Γ : Ctxt _} : (l : List ((ty : Comb.Ty) × Γ.Var ty)) → HVector (Γ.Var) (l.map (·.1))
| [] => .nil
| ⟨_, var⟩::rest => .cons var (toHVector rest)

def toHVector {Γ : Ctxt _} ty : (l : List ((ty : Comb.Ty) × Γ.Var ty)) → (h : l.all (·.1 = ty)) → HVector (Γ.Var) (List.replicate l.length ty)
| [], h => .nil
| ⟨ty', var⟩::rest, h =>
  have hty : ty' = ty := sorry
  have hrest : rest.all (·.1 = ty) := sorry
  .cons (hty ▸ var) (toHVector _ rest hrest)

def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
    MLIR.AST.ReaderM (Comb) (Σ eff ty, Expr (Comb) Γ eff ty) := do
  match opStx.name with
  | op@"Comb.parity" | op@"Comb.concat" =>
    match opStx.args with
    | v₁Stx::[] =>
      let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, op with
      | .bv w, "Comb.parity" => return ⟨_, .bool, parity v₁⟩
      | .hList l, "Comb.concat" => return ⟨_, .bv l.sum, concat v₁⟩
      | _, _ => throw <| .generic s!"type mismatch"
    | _ => throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
  | op@"Comb.add" | op@"Comb.and" | op@"Comb.mul" | op@"Comb.or" | op@"Comb.xor" =>
      let args ← opStx.args.mapM (MLIR.AST.TypedSSAVal.mkVal Γ)
      if hl: args.length = 0 then
        sorry -- throwError "BAD"
      else
        let ⟨.bv w, _⟩ := args[0]
        -- TODO: this should be provably in range
          | by
              simp at hl
              sorry

            sorry -- throwError "Unexpected type"
        if hall : args.all (·.1 = .bv w) then
          let argsᵥ := toHVector (.bv w) _ hall
          have heq : args.length - 1 + 1 = args.length := by omega
          match op with
          | "Comb.add" => return ⟨_, .bv w, add (args.length - 1) (heq ▸ argsᵥ)⟩
          | "Comb.and" => return ⟨_, .bv w, and (args.length - 1) (heq ▸ argsᵥ)⟩
          | "Comb.mul" => return ⟨_, .bv w, mul (args.length - 1) (heq ▸ argsᵥ)⟩
          | "Comb.or" => return ⟨_, .bv w, or (args.length - 1) (heq ▸ argsᵥ)⟩
          | "Comb.xor" => return ⟨_, .bv w, xor (args.length - 1) (heq ▸ argsᵥ)⟩
          | _ => throw <| .generic s!"type mismatch"
        else
          throw <| .generic s!"unexpected operation" -- throwError "Unexpect type"
  | op@"Comb.divs" | op@"Comb.divu" | op@"Comb.mods" | op@"Comb.modu" | op@"Comb.replicate" | op@"Comb.shl" | op@"Comb.shrs" | op@"Comb.shru" | op@"Comb.sub"  =>
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
      -- | .bv w, .nat, "Comb.extract" =>
      --   return ⟨_, .bv (w - v₂), extract v₁ v₂⟩
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
      | .bv w₁, .bv w₂, .icmpPred s, "Comb.icmp" =>
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
    if "Comb.replicate" = opStx.name
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
  SSA.elabIntoCom' reg Comb

end MLIR2Comb
