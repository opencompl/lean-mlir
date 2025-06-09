/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
--import SSA.Core.WellTypedFramework
import SSA.Core.Framework
import SSA.Core.Tactic.SimpSet
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

/-! ### Types -/

abbrev Width φ := ConcreteOrMVar Nat φ

inductive MTy (φ : Nat)
  | bitvec (w : Width φ) : MTy φ
  deriving DecidableEq, Inhabited, Lean.ToExpr

/-! ### Operations -/

/-- Homogeneous, unary operations -/
inductive MOp.UnaryOp (φ : Nat) : Type
  | neg
  | not
  | copy
  | trunc (w' : Width φ) (noWrapFlags : NoWrapFlags := {nsw := false, nuw := false} )
  | zext  (w' : Width φ) (nneg : NonNegFlag := {nneg := false} )
  | sext  (w' : Width φ)
deriving Repr, DecidableEq, Inhabited, Lean.ToExpr

/-- Homogeneous, binary operations -/
inductive MOp.BinaryOp : Type
  | and
  | or   (disjoint : DisjointFlag := {disjoint := false} )
  | xor
  | shl  (nswnuw : NoWrapFlags := {nsw := false, nuw := false} )
  | lshr (exact : ExactFlag := {exact := false} )
  | ashr (exact : ExactFlag := {exact := false} )
  | urem
  | srem
  | add  (nswnuw : NoWrapFlags := {nsw := false, nuw := false} )
  | mul  (nswnuw : NoWrapFlags := {nsw := false, nuw := false} )
  | sub  (nswnuw : NoWrapFlags := {nsw := false, nuw := false} )
  | sdiv (exact : ExactFlag := {exact := false} )
  | udiv (exact : ExactFlag := {exact := false} )
deriving DecidableEq, Inhabited, Lean.ToExpr

open Std (Format) in
/--
If both the nuw and nsw flags are the default value (false,false),
then we should not print them. This should be the default
behavior in Lean, but it isn't
-/
def reprWithoutFlags (op : MOp.BinaryOp) (prec : Nat) : Format :=
  let op  : String := match op with
    | .and                => "and"
    | .or   ⟨false⟩        => "or"
    | .or   ⟨true⟩         => "or disjoint"
    | .xor                => "xor"
    | .shl  ⟨false, false⟩ => "shl"
    | .shl  ⟨nsw, nuw⟩     => toString f!"shl {nsw} {nuw}"
    | .lshr ⟨false⟩        => "lshr"
    | .lshr ⟨true⟩         => "lshr exact"
    | .ashr ⟨false⟩        => "ashr"
    | .ashr ⟨true⟩         => "ashr exact"
    | .urem               => "urem"
    | .srem               => "srem"
    | .add  ⟨false, false⟩ => "add"
    | .add  ⟨nsw, nuw⟩     => toString f!"add {nsw} {nuw}"
    | .mul  ⟨false, false⟩ => "mul"
    | .mul  ⟨nsw, nuw⟩     => toString f!"mul {nsw} {nuw}"
    | .sub  ⟨false, false⟩ => "sub"
    | .sub  ⟨nsw, nuw⟩     => toString f!"sub {nsw} {nuw}"
    | .sdiv ⟨false⟩        => "sdiv"
    | .sdiv ⟨true⟩         => "sdiv exact"
    | .udiv ⟨false⟩        => "udiv"
    | .udiv ⟨true⟩         => "udiv exact"
  Repr.addAppParen (Format.group (Format.nest
    (if prec >= max_prec then 1 else 2) f!"InstCombine.MOp.BinaryOp.{op}"))
    prec

instance : Repr (MOp.BinaryOp) where
  reprPrec := reprWithoutFlags

-- See: https://releases.llvm.org/14.0.0/docs/LangRef.html#bitwise-binary-operations
inductive MOp (φ : Nat) : Type
  | unary   (w : Width φ) (op : MOp.UnaryOp φ) :  MOp φ
  | binary  (w : Width φ) (op : MOp.BinaryOp) :  MOp φ
  | select  (w : Width φ) : MOp φ
  | icmp    (c : IntPred) (w : Width φ) : MOp φ
  /-- Since the width of the const might not be known, we just store the value as an `Int` -/
  | const (w : Width φ) (val : ℤ) : MOp φ
deriving Repr, DecidableEq, Inhabited, Lean.ToExpr

def toStringWithFlags (op : MOp.BinaryOp) : String :=
  let op  : String := match op with
    | .and                  => "and"
    | .or   ⟨false⟩         => "or"
    | .or   ⟨true⟩          => "or disjoint"
    | .xor                  => "xor"
    | .shl  ⟨false, false⟩  => "shl"
    | .shl  ⟨nsw, nuw⟩      => toString f!"shl {nsw} {nuw}"
    | .lshr ⟨false⟩         => "lshr"
    | .lshr ⟨true⟩          => "lshr exact"
    | .ashr ⟨false⟩         => "ashr"
    | .ashr ⟨true⟩          => "ashr exact"
    | .urem                 => "urem"
    | .srem                 => "srem"
    | .add  ⟨false, false⟩  => "add"
    | .add  ⟨nsw, nuw⟩      => toString f!"add {nsw} {nuw}"
    | .mul  ⟨false, false⟩  => "mul"
    | .mul  ⟨nsw, nuw⟩      => toString f!"mul {nsw} {nuw}"
    | .sub  ⟨false, false⟩  => "sub"
    | .sub  ⟨nsw, nuw⟩      => toString f!"sub {nsw} {nuw}"
    | .sdiv ⟨false⟩         => "sdiv"
    | .sdiv ⟨true⟩          => "sdiv exact"
    | .udiv ⟨false⟩         => "udiv"
    | .udiv ⟨true⟩          => "udiv exact"
  op

instance : ToString (MOp.BinaryOp) where
  toString := toStringWithFlags

instance : ToString (MOp.UnaryOp (φ : Nat)) where
  toString t := repr t |>.pretty

instance : ToString (MOp 0) where
   toString  op :=
     match op with
     | .unary _w op => s!"{toString op}"
     | .binary _w op => s!"{toString  op}"
     | .select  _w => "select"
     | .icmp  _pred _w => "icmp"
     | .const _w _val => s!"mlir.constant"

/-! ## Dialect -/

/-- `MetaLLVM φ` is the `LLVM` dialect with at most `φ` metavariables -/
abbrev MetaLLVM (φ : Nat) : Dialect where
  Op := MOp φ
  Ty := MTy φ

def LLVM : Dialect where
  Op := MOp 0
  Ty := MTy 0

/-- Defining an instance for LLVM.Ty from InstCombine.Ty instance.-/
instance : DecidableEq LLVM.Ty :=
  inferInstanceAs <| DecidableEq (InstCombine.MTy _)

/-- Defining an instance for LLVM.Op from InstCombine.Op instance. -/
instance : DecidableEq LLVM.Op :=
    inferInstanceAs <| DecidableEq (InstCombine.MOp 0)

@[deprecated "Use `LLVM.Op` instead" (since:="2025-04-30")] abbrev Op := LLVM.Op
@[deprecated "Use `LLVM.Ty` instead" (since:="2025-04-30")] abbrev Ty := LLVM.Ty

namespace MOp

@[match_pattern] def neg    (w : Width φ) : MOp φ := .unary w .neg
@[match_pattern] def not    (w : Width φ) : MOp φ := .unary w .not
@[match_pattern] def copy   (w : Width φ) : MOp φ := .unary w .copy
@[match_pattern] def sext   (w w' : Width φ) : MOp φ := .unary w (.sext w')

/- This definition uses a nneg flag -/
@[match_pattern] def zext (w w' : Width φ)
  (NonNegFlag: NonNegFlag := {nneg := false}) : MOp φ
    := .unary w (.zext w' NonNegFlag)

@[match_pattern] def and    (w : Width φ) : MOp φ := .binary w .and
@[match_pattern] def xor    (w : Width φ) : MOp φ := .binary w .xor
@[match_pattern] def urem   (w : Width φ) : MOp φ := .binary w .urem
@[match_pattern] def srem   (w : Width φ) : MOp φ := .binary w .srem

/- This definition uses a disjoint flag -/
@[match_pattern] def or (w : Width φ)
  (DisjointFlag : DisjointFlag := {disjoint := false} ) : MOp φ
    := .binary w (.or DisjointFlag )

/- These definitions use NoWrapFlags -/
@[match_pattern] def trunc  (w w' : Width φ)
  (noWrapFlags: NoWrapFlags := {nsw := false , nuw := false}) : MOp φ
    := .unary w (.trunc w' noWrapFlags)

@[match_pattern] def shl (w : Width φ)
  (NoWrapFlags: NoWrapFlags := {nsw := false , nuw := false}) : MOp φ
    := .binary w (.shl NoWrapFlags )
@[match_pattern] def add (w : Width φ)
  (NoWrapFlags: NoWrapFlags := {nsw := false , nuw := false}) : MOp φ
    := .binary w (.add NoWrapFlags )
@[match_pattern] def mul (w : Width φ)
  (NoWrapFlags: NoWrapFlags := {nsw := false , nuw := false}) : MOp φ
    := .binary w (.mul NoWrapFlags )
@[match_pattern] def sub (w : Width φ)
  (NoWrapFlags: NoWrapFlags := {nsw := false , nuw := false}) : MOp φ
    := .binary w (.sub NoWrapFlags )

/- These definitions use an exact flag -/
@[match_pattern] def lshr (w : Width φ)
  (ExactFlag : ExactFlag := {exact := false} ) : MOp φ
    := .binary w (.lshr ExactFlag )
@[match_pattern] def ashr (w : Width φ)
  (ExactFlag : ExactFlag := {exact := false} ) : MOp φ
    := .binary w (.ashr ExactFlag )
@[match_pattern] def sdiv (w : Width φ)
  (ExactFlag : ExactFlag := {exact := false} ) : MOp φ
    := .binary w (.sdiv ExactFlag )
@[match_pattern] def udiv (w : Width φ)
  (ExactFlag : ExactFlag := {exact := false} ) : MOp φ
    := .binary w (.udiv ExactFlag )

/-- Recursion principle in terms of individual operations, rather than `unary` or `binary` -/
def deepCasesOn {motive : ∀ {φ}, MOp φ → Sort*}
    (neg    : ∀ {φ} {w : Width φ},               motive (neg  w))
    (not    : ∀ {φ} {w : Width φ},               motive (not  w))
    (trunc  : ∀ {φ noWrapFlags} {w w' : Width φ},            motive (trunc w w' noWrapFlags))
    (zext   : ∀ {φ NonNegFlag} {w w' : Width φ}, motive (zext  w w' NonNegFlag))
    (sext   : ∀ {φ} {w w' : Width φ},            motive (sext  w w'))
    (copy   : ∀ {φ} {w : Width φ},               motive (copy w))
    (and    : ∀ {φ} {w : Width φ},               motive (and  w))
    (or     : ∀ {φ DisjointFlag} {w : Width φ},  motive (or w DisjointFlag))
    (xor    : ∀ {φ} {w : Width φ},               motive (xor  w))
    (shl    : ∀ {φ NoWrapFlags} {w : Width φ},   motive (shl  w NoWrapFlags))
    (lshr   : ∀ {φ ExactFlag} {w : Width φ},     motive (lshr w ExactFlag))
    (ashr   : ∀ {φ ExactFlag} {w : Width φ},     motive (ashr w ExactFlag))
    (urem   : ∀ {φ} {w : Width φ},               motive (urem w))
    (srem   : ∀ {φ} {w : Width φ},               motive (srem w))
    (add    : ∀ {φ NoWrapFlags} {w : Width φ},   motive (add w NoWrapFlags))
    (mul    : ∀ {φ NoWrapFlags} {w : Width φ},   motive (mul w NoWrapFlags))
    (sub    : ∀ {φ NoWrapFlags} {w : Width φ},   motive (sub w NoWrapFlags))
    (sdiv   : ∀ {φ ExactFlag} {w : Width φ},     motive (sdiv w ExactFlag))
    (udiv   : ∀ {φ ExactFlag} {w : Width φ},     motive (udiv w ExactFlag))
    (select : ∀ {φ} {w : Width φ},               motive (select w))
    (icmp   : ∀ {φ c} {w : Width φ},             motive (icmp c w))
    (const  : ∀ {φ v} {w : Width φ},             motive (const w v)) :
    ∀ {φ} (op : MOp φ), motive op
  | _, .neg _      => neg
  | _, .not _      => not
  | _, .trunc _ _ _  => trunc
  | _, .zext _ _ _ => zext
  | _, .sext _ _   => sext
  | _, .copy _     => copy
  | _, .and _      => and
  | _, .or _ _     => or
  | _, .xor _      => xor
  | _, .shl _ _    => shl
  | _, .lshr _ _   => lshr
  | _, .ashr _ _   => ashr
  | _, .urem _     => urem
  | _, .srem _     => srem
  | _, .add _ _    => add
  | _, .mul _ _    => mul
  | _, .sub _ _    => sub
  | _, .sdiv _ _   => sdiv
  | _, .udiv _ _   => udiv
  | _, .select _   => select
  | _, .icmp ..    => icmp
  | _, .const ..   => const

end MOp

namespace LLVM.Op

@[match_pattern] abbrev unary  (w : Nat) (op : MOp.UnaryOp 0) : LLVM.Op :=
  MOp.unary (.concrete w) op

@[match_pattern] abbrev binary (w : Nat) (op : MOp.BinaryOp) : LLVM.Op :=
  MOp.binary (.concrete w) op

@[match_pattern] abbrev and    : Nat → LLVM.Op := MOp.and    ∘ .concrete
@[match_pattern] abbrev not    : Nat → LLVM.Op := MOp.not    ∘ .concrete
@[match_pattern] abbrev sext   : Nat → Nat → LLVM.Op := fun w w' => MOp.sext (.concrete w) (.concrete w')
@[match_pattern] abbrev xor    : Nat → LLVM.Op := MOp.xor    ∘ .concrete
@[match_pattern] abbrev urem   : Nat → LLVM.Op := MOp.urem   ∘ .concrete
@[match_pattern] abbrev srem   : Nat → LLVM.Op := MOp.srem   ∘ .concrete
@[match_pattern] abbrev select : Nat → LLVM.Op := MOp.select ∘ .concrete
@[match_pattern] abbrev neg    : Nat → LLVM.Op := MOp.neg    ∘ .concrete
@[match_pattern] abbrev copy   : Nat → LLVM.Op := MOp.copy   ∘ .concrete

@[match_pattern] abbrev icmp (c : IntPred)   : Nat → LLVM.Op  := MOp.icmp c ∘ .concrete
@[match_pattern] abbrev const (w : Nat) (val : ℤ) : LLVM.Op        := MOp.const (.concrete w) val

/- This operation is separate from the others because it takes in a flag: nneg. -/
@[match_pattern] abbrev zext (w w': Nat) (flag : NonNegFlag := {nneg := false}) : LLVM.Op :=
  MOp.zext (.concrete w) (.concrete w') flag

/- This operation is separate from the others because it takes in a flag: disjoint. -/
@[match_pattern] abbrev or (w : Nat) (flag : DisjointFlag := {disjoint := false} ) : LLVM.Op :=
  MOp.or (.concrete w) flag

/- These operations are separate from the others because they take in 2 flags: nuw and nsw.-/
@[match_pattern] abbrev trunc (w w': Nat) (flags: NoWrapFlags := {}) : LLVM.Op :=
  MOp.trunc (.concrete w) (.concrete w') flags

@[match_pattern] abbrev shl (w : Nat) (flags: NoWrapFlags := {}) : LLVM.Op := MOp.shl (.concrete w) flags
@[match_pattern] abbrev add (w : Nat) (flags: NoWrapFlags := {}) : LLVM.Op := MOp.add (.concrete w) flags
@[match_pattern] abbrev mul (w : Nat) (flags: NoWrapFlags := {}) : LLVM.Op := MOp.mul (.concrete w) flags
@[match_pattern] abbrev sub (w : Nat) (flags: NoWrapFlags := {}) : LLVM.Op := MOp.sub (.concrete w) flags

/- These operations are separate from the others because they take in 1 flag: exact.-/
@[match_pattern] abbrev lshr (w : Nat) (flag : ExactFlag := {} ) : LLVM.Op := MOp.lshr (.concrete w) flag
@[match_pattern] abbrev ashr (w : Nat) (flag : ExactFlag := {} ) : LLVM.Op := MOp.ashr (.concrete w) flag
@[match_pattern] abbrev sdiv (w : Nat) (flag : ExactFlag := {} ) : LLVM.Op := MOp.sdiv (.concrete w) flag
@[match_pattern] abbrev udiv (w : Nat) (flag : ExactFlag := {} ) : LLVM.Op := MOp.udiv (.concrete w) flag

end LLVM.Op

/-! ### Basic Instances -/

instance : Monad (MetaLLVM φ).m := by unfold MetaLLVM; infer_instance
instance : LawfulMonad (MetaLLVM φ).m := by unfold MetaLLVM; infer_instance
instance : Monad LLVM.m := by unfold LLVM; infer_instance
instance : LawfulMonad LLVM.m := by unfold LLVM; infer_instance

instance {φ} : DialectToExpr (MetaLLVM φ) where
  toExprM := .const ``Id [0]
  toExprDialect := .app (.const ``MetaLLVM []) (Lean.toExpr φ)

instance : Lean.ToExpr (LLVM.Op) := by unfold LLVM; infer_instance
instance : Lean.ToExpr (LLVM.Ty) := by unfold LLVM; infer_instance
instance : DialectToExpr LLVM where
  toExprM := .const ``Id [0]
  toExprDialect := .const ``LLVM []

/-! ### Operation Formatting -/

instance : ToString (MOp φ) where
  toString
  | .and _      => "and"
  | .or _ _     => "or"
  | .not _      => "not"
  | .xor _      => "xor"
  | .shl _ _    => "shl"
  | .lshr _ _   => "lshr"
  | .ashr _ _   => "ashr"
  | .urem _     => "urem"
  | .srem _     => "srem"
  | .select _   => "select"
  | .add _ _    => "add"
  | .mul _ _    => "mul"
  | .sub _ _    => "sub"
  | .neg _      => "neg"
  | .copy _     => "copy"
  | .trunc _ _ _  => "trunc"
  | .zext _ _ _ => "zext"
  | .sext _ _   => "sext"
  | .sdiv _ _   => "sdiv"
  | .udiv _ _   => "udiv"
  | .icmp ty _  => s!"icmp {ty}"
  | .const _ v  => s!"const {v}"

-- TODO: the `ToString Op` and `ToString MOp` instances have different behaviour;
--       this is not likely to be what we want
-- instance : ToString Op where
--   toString o := repr o |>.pretty
def printOverflowFlags (flags : NoWrapFlags) : String :=
  match flags with
  | ⟨false, false⟩ => "<{overflowFlags = #llvm.overflow<none>}>"
  | ⟨true, false⟩  => "<{overflowFlags = #llvm.overflow<nsw>}>"
  | ⟨false, true⟩  => "<{overflowFlags = #llvm.overflow<nuw>}>"
  | ⟨true, true⟩   => "<{overflowFlags = #llvm.overflow<nsw,nuw>}>"

def attributesToPrint (op : LLVM.Op) : String :=
  match op with
  | .const w v => s!"\{value = {v} : {w}}"
  | .or w ⟨true⟩ => s!"\{disjoint = true : {w}}"
  | .add _ f |.shl _ f | .sub _ f | .mul _ f => printOverflowFlags f -- overflowflag support
  | .udiv _ ⟨true⟩ | .sdiv _ ⟨true⟩ | .lshr _ ⟨true⟩ => "<{isExact}> "
  | .icmp ty _ => s!"{ty}"
  |_ => ""

def printOverflowFlags (flags : NoWrapFlags) : String :=
  match flags with
  | ⟨false, false⟩ => "<{overflowFlags = #llvm.overflow<none>}>"
  | ⟨true, false⟩  => "<{overflowFlags = #llvm.overflow<nsw>}>"
  | ⟨false, true⟩  => "<{overflowFlags = #llvm.overflow<nuw>}>"
  | ⟨true, true⟩   => "<{overflowFlags = #llvm.overflow<nsw,nuw>}>"

def attributesToPrint (op : LLVM.Op) : String :=
  match op with
  | .const w v => s!"\{value = {v} : {w}}"
  | .or w ⟨true⟩ => s!"\{disjoint = true : {w}}"
  | .add _ f |.shl _ f | .sub _ f | .mul _ f => printOverflowFlags f -- overflowflag support
  | .udiv _ ⟨true⟩ | .sdiv _ ⟨true⟩ | .lshr _ ⟨true⟩ => "<{isExact}> "
  | .icmp ty _ => s!"{ty}"
  |_ => ""

instance : ToString LLVM.Op := by unfold LLVM; infer_instance
instance : Repr LLVM.Op := by unfold LLVM; infer_instance

/-! ### Type Formatting -/

instance : Repr (MTy φ) where
  reprPrec
    | .bitvec (.concrete w), _ => "i" ++ repr w
    | .bitvec (.mvar ⟨i, _⟩), _ => f!"i$\{%{i}}"
instance : Repr LLVM.Ty := by unfold LLVM; infer_instance

instance : Lean.ToFormat (MTy φ) where
  format := repr
instance : Lean.ToFormat LLVM.Ty := by unfold LLVM; infer_instance

instance : ToString (MTy φ) where
  toString t := repr t |>.pretty
instance : ToString LLVM.Ty := by unfold LLVM; infer_instance

instance : DialectPrint (LLVM) where
  printOpName
  | op => "llvm."++toString op
  printTy := toString
  printAttributes := attributesToPrint
  printDialect:= "llvm"
  printReturn _:= "llvm.return"
  printFunc _:= "^bb0"
/-! ### Signature -/

@[simp, reducible]
def MOp.sig : MOp φ → List (MTy φ)
| .binary w _ | .icmp _ w =>
  [.bitvec w, .bitvec w]
| .unary w _ => [.bitvec w]
| .select w => [.bitvec 1, .bitvec w, .bitvec w]
| .const _ _ => []

@[simp, reducible]
def MOp.UnaryOp.outTy (w : Width φ) : MOp.UnaryOp φ → MTy φ
| .trunc w' _ => .bitvec w'
| .zext w' _ => .bitvec w'
| .sext w' => .bitvec w'
| _ => .bitvec w

@[simp, reducible]
def MOp.outTy : MOp φ → MTy φ
| .binary w _ | .select w | .const w _ =>
  .bitvec w
| .unary w op => UnaryOp.outTy w op
| .icmp _ _ => .bitvec 1

instance {φ} : DialectSignature (MetaLLVM φ) where
  signature op := ⟨op.sig, [], op.outTy, .pure⟩
instance : DialectSignature LLVM where
  signature op := ⟨op.sig, [], op.outTy, .pure⟩

/-! ### Type Semantics -/

namespace LLVM.Ty

@[match_pattern] abbrev bitvec (w : Nat) : LLVM.Ty :=
  MTy.bitvec (.concrete w)

def width : LLVM.Ty → Nat
  | bitvec w => w

@[simp]
theorem width_eq (ty : LLVM.Ty) : .bitvec (width ty) = ty := by
  rcases ty with ⟨w|i⟩
  · rfl
  · exact i.elim0

@[simp] -- TODO: this def should not live here
def BitVec.width {n : Nat} (_ : BitVec n) : Nat := n

instance : TyDenote LLVM.Ty where
  toType := fun
    | bitvec w => LLVM.IntW w

@[simp_denote] lemma toType_bitvec : TyDenote.toType (Ty.bitvec w) = LLVM.IntW w := rfl

instance (ty : LLVM.Ty) : Coe ℤ (TyDenote.toType ty) where
  coe z := match ty with
    | bitvec w => .value <| BitVec.ofInt w z

instance (ty : LLVM.Ty) : Inhabited (TyDenote.toType ty) where
  default := match ty with
    | bitvec _ => (default : LLVM.IntW _)

-- TODO: this instance should not live here
instance : Repr (BitVec n) where
  reprPrec
    | v, n => reprPrec (BitVec.toInt v) n

end LLVM.Ty

/-! ### Operation Semantics -/

@[simp]
def Op.denote (o : LLVM.Op) (op : HVector TyDenote.toType (DialectSignature.sig o)) :
    (TyDenote.toType <| DialectSignature.outTy o) :=
  match o with
  | LLVM.Op.const _ val    => const? _ val
  | LLVM.Op.copy _         =>               (op.getN 0 (by simp [DialectSignature.sig, signature]))
  | LLVM.Op.not _          => LLVM.not      (op.getN 0 (by simp [DialectSignature.sig, signature]))
  | LLVM.Op.neg _          => LLVM.neg      (op.getN 0 (by simp [DialectSignature.sig, signature]))
  | LLVM.Op.trunc w w'    flags => LLVM.trunc w' (op.getN 0 (by simp [DialectSignature.sig, signature])) flags
  | LLVM.Op.zext w w' flag => LLVM.zext  w' (op.getN 0 (by simp [DialectSignature.sig, signature])) flag
  | LLVM.Op.sext w w'      => LLVM.sext  w' (op.getN 0 (by simp [DialectSignature.sig, signature]))
  | LLVM.Op.and _          => LLVM.and      (op.getN 0 (by simp [DialectSignature.sig, signature])) (op.getN 1 (by simp [DialectSignature.sig, signature]))
  | LLVM.Op.or _ flag      => LLVM.or       (op.getN 0 (by simp [DialectSignature.sig, signature])) (op.getN 1 (by simp [DialectSignature.sig, signature])) flag
  | LLVM.Op.xor _          => LLVM.xor      (op.getN 0 (by simp [DialectSignature.sig, signature])) (op.getN 1 (by simp [DialectSignature.sig, signature]))
  | LLVM.Op.shl _ flags    => LLVM.shl      (op.getN 0 (by simp [DialectSignature.sig, signature])) (op.getN 1 (by simp [DialectSignature.sig, signature])) flags
  | LLVM.Op.lshr _ flag    => LLVM.lshr     (op.getN 0 (by simp [DialectSignature.sig, signature])) (op.getN 1 (by simp [DialectSignature.sig, signature])) flag
  | LLVM.Op.ashr _ flag    => LLVM.ashr     (op.getN 0 (by simp [DialectSignature.sig, signature])) (op.getN 1 (by simp [DialectSignature.sig, signature])) flag
  | LLVM.Op.sub _ flags    => LLVM.sub      (op.getN 0 (by simp [DialectSignature.sig, signature])) (op.getN 1 (by simp [DialectSignature.sig, signature])) flags
  | LLVM.Op.add _ flags    => LLVM.add      (op.getN 0 (by simp [DialectSignature.sig, signature])) (op.getN 1 (by simp [DialectSignature.sig, signature])) flags
  | LLVM.Op.mul _ flags    => LLVM.mul      (op.getN 0 (by simp [DialectSignature.sig, signature])) (op.getN 1 (by simp [DialectSignature.sig, signature])) flags
  | LLVM.Op.sdiv _ flag    => LLVM.sdiv     (op.getN 0 (by simp [DialectSignature.sig, signature])) (op.getN 1 (by simp [DialectSignature.sig, signature])) flag
  | LLVM.Op.udiv _ flag    => LLVM.udiv     (op.getN 0 (by simp [DialectSignature.sig, signature])) (op.getN 1 (by simp [DialectSignature.sig, signature])) flag
  | LLVM.Op.urem _         => LLVM.urem     (op.getN 0 (by simp [DialectSignature.sig, signature])) (op.getN 1 (by simp [DialectSignature.sig, signature]))
  | LLVM.Op.srem _         => LLVM.srem     (op.getN 0 (by simp [DialectSignature.sig, signature])) (op.getN 1 (by simp [DialectSignature.sig, signature]))
  | LLVM.Op.icmp c _       => LLVM.icmp  c  (op.getN 0 (by simp [DialectSignature.sig, signature])) (op.getN 1 (by simp [DialectSignature.sig, signature]))
  | LLVM.Op.select _       => LLVM.select   (op.getN 0 (by simp [DialectSignature.sig, signature])) (op.getN 1 (by simp [DialectSignature.sig, signature])) (op.getN 2 (by simp [DialectSignature.sig, signature]))

instance : DialectDenote LLVM := ⟨
  fun o args _ => Op.denote o args
⟩

end InstCombine
