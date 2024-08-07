/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
--import SSA.Core.WellTypedFramework
import SSA.Core.Framework
import SSA.Core.Util
import SSA.Core.Util.ConcreteOrMVar
import SSA.Projects.InstCombine.ForStd
import SSA.Projects.InstCombine.LLVM.Semantics

/-!
  # InstCombine Dialect

  This file defines a dialect of basic arithmetic and bitwise operations on bitvectors.

  The dialect supports types of arbitrary-width bitvectors.
  Thus, some definitions wil be parameterized by `φ`, the number of width meta-variables there are.
  This parameter will usually be either `0`, indicating that all widths are known, concrete values,
  or `1`, indicating there is exactly one distinct width meta-variable.

  In particular, we only define a denotational semantics for concrete programs (i.e., where `φ = 0`)


  see https://releases.llvm.org/14.0.0/docs/LangRef.html#bitwise-binary-operations
-/

namespace InstCombine

open BitVec

open LLVM

abbrev Width φ := ConcreteOrMVar Nat φ

inductive MTy (φ : Nat)
  | bitvec (w : Width φ) : MTy φ
  deriving DecidableEq, Inhabited

abbrev Ty := MTy 0

@[match_pattern] abbrev Ty.bitvec (w : Nat) : Ty := MTy.bitvec (.concrete w)

instance : Repr (MTy φ) where
  reprPrec
    | .bitvec (.concrete w), _ => "i" ++ repr w
    | .bitvec (.mvar ⟨i, _⟩), _ => f!"i$\{%{i}}"

instance : Lean.ToFormat (MTy φ) where
  format := repr

instance : ToString (MTy φ) where
  toString t := repr t |>.pretty

def Ty.width : Ty → Nat
  | .bitvec w => w

@[simp]
theorem Ty.width_eq (ty : Ty) : .bitvec (ty.width) = ty := by
  rcases ty with ⟨w|i⟩
  · rfl
  · exact i.elim0

@[simp]
def BitVec.width {n : Nat} (_ : BitVec n) : Nat := n

instance : TyDenote Ty where
toType := fun
  | .bitvec w => LLVM.IntW w

instance (ty : Ty) : Coe ℤ (TyDenote.toType ty) where
  coe z := match ty with
    | .bitvec w => some <| BitVec.ofInt w z

instance (ty : Ty) : Inhabited (TyDenote.toType ty) where
  default := match ty with
    | .bitvec _ => pure default

instance : Repr (BitVec n) where
  reprPrec
    | v, n => reprPrec (BitVec.toInt v) n

/-- Homogeneous, unary operations -/
inductive MOp.UnaryOp : Type
  | neg
  | not
  | copy
deriving Repr, DecidableEq, Inhabited

/-- Homogeneous, binary operations -/
inductive MOp.BinaryOp : Type
  | and
  | or
  | xor
  | shl
  | lshr
  | ashr
  | urem
  | srem
  | add (nswnuw  : AdditionFlags := {nsw := false, nuw := false} )
  | mul
  | sub
  | sdiv
  | udiv
deriving DecidableEq, Inhabited

open Std (Format) in
/--
If both the nuw and nsw flags are the default value (false,false),
then we should not print them. This should be the default
behavior in Lean, but it isn't
-/
def reprWithoutFlags (op : MOp.BinaryOp) (prec : Nat) : Format :=
  let op  : String := match op with
    | .and    => "and"
    | .or     => "or"
    | .xor    => "xor"
    | .shl    => "shl"
    | .lshr   => "lshr"
    | .ashr   => "ashr"
    | .urem   => "urem"
    | .srem   => "srem"
    | .add ⟨false, false⟩ => "add"
    | .add ⟨nsw, nuw⟩    => toString f!"add {nsw} {nuw}"
    | .mul    => "mul"
    | .sub    => "sub"
    | .sdiv   => "sdiv"
    | .udiv   => "udiv"
  Repr.addAppParen (Format.group (Format.nest
    (if prec >= max_prec then 1 else 2) f!"InstCombine.MOp.BinaryOp.{op}"))
    prec

instance : Repr (MOp.BinaryOp) where
  reprPrec := reprWithoutFlags

-- See: https://releases.llvm.org/14.0.0/docs/LangRef.html#bitwise-binary-operations
inductive MOp (φ : Nat) : Type
  | unary   (w : Width φ) (op : MOp.UnaryOp) :  MOp φ
  | binary  (w : Width φ) (op : MOp.BinaryOp) :  MOp φ
  | select  (w : Width φ) : MOp φ
  | icmp    (c : IntPredicate) (w : Width φ) : MOp φ
  /-- Since the width of the const might not be known, we just store the value as an `Int` -/
  | const (w : Width φ) (val : ℤ) : MOp φ
deriving Repr, DecidableEq, Inhabited

namespace MOp

@[match_pattern] def neg    (w : Width φ) : MOp φ := .unary w .neg
@[match_pattern] def not    (w : Width φ) : MOp φ := .unary w .not
@[match_pattern] def copy   (w : Width φ) : MOp φ := .unary w .copy

@[match_pattern] def and    (w : Width φ) : MOp φ := .binary w .and
@[match_pattern] def or     (w : Width φ) : MOp φ := .binary w .or
@[match_pattern] def xor    (w : Width φ) : MOp φ := .binary w .xor
@[match_pattern] def shl    (w : Width φ) : MOp φ := .binary w .shl
@[match_pattern] def lshr   (w : Width φ) : MOp φ := .binary w .lshr
@[match_pattern] def ashr   (w : Width φ) : MOp φ := .binary w .ashr
@[match_pattern] def urem   (w : Width φ) : MOp φ := .binary w .urem
@[match_pattern] def srem   (w : Width φ) : MOp φ := .binary w .srem

@[match_pattern] def mul    (w : Width φ) : MOp φ := .binary w .mul
@[match_pattern] def sub    (w : Width φ) : MOp φ := .binary w .sub
@[match_pattern] def sdiv   (w : Width φ) : MOp φ := .binary w .sdiv
@[match_pattern] def udiv   (w : Width φ) : MOp φ := .binary w .udiv

/- This definition is off by itself because it is different-/
@[match_pattern] def add    (w : Width φ)
    (additionFlags: AdditionFlags := {nsw := false , nuw := false}) : MOp φ
      := .binary w (.add  additionFlags )

/-- Recursion principle in terms of individual operations, rather than `unary` or `binary` -/
def deepCasesOn {motive : ∀ {φ}, MOp φ → Sort*}
    (neg  : ∀ {φ} {w : Width φ}, motive (neg  w))
    (not  : ∀ {φ} {w : Width φ}, motive (not  w))
    (copy : ∀ {φ} {w : Width φ}, motive (copy w))
    (and  : ∀ {φ} {w : Width φ}, motive (and  w))
    (or   : ∀ {φ} {w : Width φ}, motive (or   w))
    (xor  : ∀ {φ} {w : Width φ}, motive (xor  w))
    (shl  : ∀ {φ} {w : Width φ}, motive (shl  w))
    (lshr : ∀ {φ} {w : Width φ}, motive (lshr w))
    (ashr : ∀ {φ} {w : Width φ}, motive (ashr w))
    (urem : ∀ {φ} {w : Width φ}, motive (urem w))
    (srem : ∀ {φ} {w : Width φ}, motive (srem w))
    (add  : ∀ {φ additionFlags} {w : Width φ}, motive (add w additionFlags))
    (mul  : ∀ {φ} {w : Width φ}, motive (mul  w))
    (sub  : ∀ {φ} {w : Width φ}, motive (sub  w))
    (sdiv : ∀ {φ} {w : Width φ}, motive (sdiv w))
    (udiv : ∀ {φ} {w : Width φ}, motive (udiv w))
    (select : ∀ {φ} {w : Width φ}, motive (select w))
    (icmp   : ∀ {φ c} {w : Width φ}, motive (icmp c w))
    (const  : ∀ {φ v} {w : Width φ}, motive (const w v)) :
    ∀ {φ} (op : MOp φ), motive op
  | _, .neg _   => neg
  | _, .not _   => not
  | _, .copy _  => copy
  | _, .and _   => and
  | _, .or _    => or
  | _, .xor _   => xor
  | _, .shl _   => shl
  | _, .lshr _  => lshr
  | _, .ashr _  => ashr
  | _, .urem _  => urem
  | _, .srem _  => srem
  | _, .add _ _  => add
  | _, .mul  _  => mul
  | _, .sub  _  => sub
  | _, .sdiv _  => sdiv
  | _, .udiv _  => udiv
  | _, .select _  => select
  | _, .icmp ..   => icmp
  | _, .const ..  => const

end MOp

instance : ToString (MOp φ) where
  toString
  | .and _ => "and"
  | .or _ => "or"
  | .not _ => "not"
  | .xor _ => "xor"
  | .shl _ => "shl"
  | .lshr _ => "lshr"
  | .ashr _ => "ashr"
  | .urem _ => "urem"
  | .srem _ => "srem"
  | .select _ => "select"
  | .add _ _ => "add"
  | .mul _ => "mul"
  | .sub _ => "sub"
  | .neg _ => "neg"
  | .copy _ => "copy"
  | .sdiv _ => "sdiv"
  | .udiv _ => "udiv"
  | .icmp ty _ => s!"icmp {ty}"
  | .const _ v => s!"const {v}"

abbrev Op := MOp 0

namespace Op

@[match_pattern] abbrev unary   (w : Nat) (op : MOp.UnaryOp)  : Op := MOp.unary (.concrete w) op
@[match_pattern] abbrev binary  (w : Nat) (op : MOp.BinaryOp) : Op := MOp.binary (.concrete w) op

@[match_pattern] abbrev and    : Nat → Op := MOp.and    ∘ .concrete
@[match_pattern] abbrev or     : Nat → Op := MOp.or     ∘ .concrete
@[match_pattern] abbrev not    : Nat → Op := MOp.not    ∘ .concrete
@[match_pattern] abbrev xor    : Nat → Op := MOp.xor    ∘ .concrete
@[match_pattern] abbrev shl    : Nat → Op := MOp.shl    ∘ .concrete
@[match_pattern] abbrev lshr   : Nat → Op := MOp.lshr   ∘ .concrete
@[match_pattern] abbrev ashr   : Nat → Op := MOp.ashr   ∘ .concrete
@[match_pattern] abbrev urem   : Nat → Op := MOp.urem   ∘ .concrete
@[match_pattern] abbrev srem   : Nat → Op := MOp.srem   ∘ .concrete
@[match_pattern] abbrev select : Nat → Op := MOp.select ∘ .concrete
@[match_pattern] abbrev mul    : Nat → Op := MOp.mul    ∘ .concrete
@[match_pattern] abbrev sub    : Nat → Op := MOp.sub    ∘ .concrete
@[match_pattern] abbrev neg    : Nat → Op := MOp.neg    ∘ .concrete
@[match_pattern] abbrev copy   : Nat → Op := MOp.copy   ∘ .concrete
@[match_pattern] abbrev sdiv   : Nat → Op := MOp.sdiv   ∘ .concrete
@[match_pattern] abbrev udiv   : Nat → Op := MOp.udiv   ∘ .concrete

@[match_pattern] abbrev icmp (c : IntPredicate)   : Nat → Op  := MOp.icmp c ∘ .concrete
@[match_pattern] abbrev const (w : Nat) (val : ℤ) : Op        := MOp.const (.concrete w) val


/- Add is separate from the other operations because it takes in 2 flags: nuw and nsw.-/
@[match_pattern] abbrev add (w : Nat) (flags: AdditionFlags :=
   {nsw := false , nuw := false}) : Op:=  MOp.add (.concrete w) flags

end Op

instance : ToString Op where
  toString o := repr o |>.pretty

@[simp, reducible]
def MOp.sig : MOp φ → List (MTy φ)
| .binary w _ | .icmp _ w =>
  [.bitvec w, .bitvec w]
| .unary w _ => [.bitvec w]
| .select w => [.bitvec 1, .bitvec w, .bitvec w]
| .const _ _ => []

@[simp, reducible]
def MOp.outTy : MOp φ → MTy φ
| .binary w _ | .unary w _ | .select w | .const w _ =>
  .bitvec w
| .icmp _ _ => .bitvec 1

/-- `MetaLLVM φ` is the `LLVM` dialect with at most `φ` metavariables -/
abbrev MetaLLVM (φ : Nat) : Dialect where
  Op := MOp φ
  Ty := MTy φ

abbrev LLVM : Dialect where
  Op := Op
  Ty := Ty

instance {φ} : DialectSignature (MetaLLVM φ) where
  signature op := ⟨op.sig, [], op.outTy, .pure⟩
instance : DialectSignature LLVM where
  signature op := ⟨op.sig, [], op.outTy, .pure⟩

@[simp]
def Op.denote (o : LLVM.Op) (op : HVector TyDenote.toType (DialectSignature.sig o)) :
    (TyDenote.toType <| DialectSignature.outTy o) :=
  match o with
  | Op.const _ val => const? val
  | Op.copy _      =>             (op.getN 0)
  | Op.not _       => LLVM.not    (op.getN 0)
  | Op.neg _       => LLVM.neg    (op.getN 0)
  | Op.and _       => LLVM.and    (op.getN 0) (op.getN 1)
  | Op.or _        => LLVM.or     (op.getN 0) (op.getN 1)
  | Op.xor _       => LLVM.xor    (op.getN 0) (op.getN 1)
  | Op.shl _       => LLVM.shl    (op.getN 0) (op.getN 1)
  | Op.lshr _      => LLVM.lshr   (op.getN 0) (op.getN 1)
  | Op.ashr _      => LLVM.ashr   (op.getN 0) (op.getN 1)
  | Op.sub _       => LLVM.sub    (op.getN 0) (op.getN 1)
  | Op.add _ flags => LLVM.add    (op.getN 0) (op.getN 1) flags
  | Op.mul _       => LLVM.mul    (op.getN 0) (op.getN 1)
  | Op.sdiv _      => LLVM.sdiv   (op.getN 0) (op.getN 1)
  | Op.udiv _      => LLVM.udiv   (op.getN 0) (op.getN 1)
  | Op.urem _      => LLVM.urem   (op.getN 0) (op.getN 1)
  | Op.srem _      => LLVM.srem   (op.getN 0) (op.getN 1)
  | Op.icmp c _    => LLVM.icmp c (op.getN 0) (op.getN 1)
  | Op.select _    => LLVM.select (op.getN 0) (op.getN 1) (op.getN 2)

instance : DialectDenote LLVM := ⟨
  fun o args _ => Op.denote o args
⟩

end InstCombine
