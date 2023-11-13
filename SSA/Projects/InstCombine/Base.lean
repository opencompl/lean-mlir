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

open Std (BitVec)

open LLVM

abbrev Width φ := ConcreteOrMVar Nat φ

inductive MTy (φ : Nat)
  | bitvec (w : Width φ) : MTy φ
  deriving DecidableEq, Inhabited

abbrev Ty := MTy 0

instance : Repr (MTy φ) where
  reprPrec
    | .bitvec (.concrete w), _ => "i" ++ repr w
    | .bitvec (.mvar ⟨i, _⟩), _ => f!"i$\{%{i}}"

instance : ToString (MTy φ) where
  toString t := repr t |>.pretty

def Ty.width : Ty → Nat
  | .bitvec (.concrete w) => w

@[simp]
theorem Ty.width_eq (ty : Ty) : .bitvec (ty.width) = ty := by
  rcases ty with ⟨w|i⟩
  · rfl
  · exact i.elim0

@[simp]
def BitVec.width {n : Nat} (_ : BitVec n) : Nat := n

instance : Goedel Ty where
toType := fun
  | .bitvec (.concrete w) => Option $ BitVec w

instance : Repr (BitVec n) where
  reprPrec
    | v, n => reprPrec (BitVec.toInt v) n

-- See: https://releases.llvm.org/14.0.0/docs/LangRef.html#bitwise-binary-operations
inductive MOp (φ : Nat) : Type
  | and     (w : Width φ) : MOp φ
  | or      (w : Width φ) : MOp φ
  | not     (w : Width φ) : MOp φ
  | xor     (w : Width φ) : MOp φ
  | shl     (w : Width φ) : MOp φ
  | lshr    (w : Width φ) : MOp φ
  | ashr    (w : Width φ) : MOp φ
  | urem    (w : Width φ) : MOp φ
  | srem    (w : Width φ) : MOp φ
  | select  (w : Width φ) : MOp φ
  | add     (w : Width φ) : MOp φ
  | mul     (w : Width φ) : MOp φ
  | sub     (w : Width φ) : MOp φ
  | neg     (w : Width φ) : MOp φ
  | copy    (w : Width φ) : MOp φ
  | sdiv    (w : Width φ) : MOp φ
  | udiv    (w : Width φ) : MOp φ
  | icmp    (c : IntPredicate) (w : Width φ) : MOp φ
  /-- Since the width of the const might not be known, we just store the value as an `Int` -/
  | const (w : Width φ) (val : ℤ) : MOp φ
deriving Repr, DecidableEq, Inhabited

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
  | .add _ => "add"
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
@[match_pattern] abbrev add    : Nat → Op := MOp.add    ∘ .concrete
@[match_pattern] abbrev mul    : Nat → Op := MOp.mul    ∘ .concrete
@[match_pattern] abbrev sub    : Nat → Op := MOp.sub    ∘ .concrete
@[match_pattern] abbrev neg    : Nat → Op := MOp.neg    ∘ .concrete
@[match_pattern] abbrev copy   : Nat → Op := MOp.copy   ∘ .concrete
@[match_pattern] abbrev sdiv   : Nat → Op := MOp.sdiv   ∘ .concrete
@[match_pattern] abbrev udiv   : Nat → Op := MOp.udiv   ∘ .concrete

@[match_pattern] abbrev icmp (c : IntPredicate)   : Nat → Op  := MOp.icmp c ∘ .concrete
@[match_pattern] abbrev const (w : Nat) (val : ℤ) : Op        := MOp.const (.concrete w) val

end Op

instance : ToString Op where
  toString o := repr o |>.pretty

@[simp, reducible]
def MOp.sig : MOp φ → List (MTy φ)
| .and w | .or w | .xor w | .shl w | .lshr w | .ashr w
| .add w | .mul w | .sub w | .udiv w | .sdiv w
| .srem w | .urem w | .icmp _ w =>
  [.bitvec w, .bitvec w]
| .not w | .neg w | .copy w => [.bitvec w]
| .select w => [.bitvec 1, .bitvec w, .bitvec w]
| .const _ _ => []

@[simp, reducible]
def MOp.outTy : MOp φ → MTy φ
| .and w | .or w | .not w | .xor w | .shl w | .lshr w | .ashr w
| .sub w |  .select w | .neg w | .copy w =>
  .bitvec w
| .add w | .mul w |  .sdiv w | .udiv w | .srem w | .urem w =>
  .bitvec w
| .icmp _ _ => .bitvec 1
| .const width _ => .bitvec width

instance : OpSignature (MOp φ) (MTy φ) where
  signature op := ⟨op.sig, [], op.outTy⟩

@[simp]
def Op.denote (o : Op) (arg : HVector Goedel.toType (OpSignature.sig o)) :
    (Goedel.toType <| OpSignature.outTy o) :=
  match o with
  | Op.const _ val => const? val
  | Op.and _ => pairBind and? arg.toPair
  | Op.or _ => pairBind or? arg.toPair
  | Op.xor _ => pairBind xor? arg.toPair
  | Op.shl _ => pairBind shl? arg.toPair
  | Op.lshr _ => pairBind lshr? arg.toPair
  | Op.ashr _ => pairBind ashr? arg.toPair
  | Op.sub _ => pairBind sub?  arg.toPair
  | Op.add _ => pairBind add? arg.toPair
  | Op.mul _ => pairBind mul? arg.toPair
  | Op.sdiv _ => pairBind sdiv? arg.toPair
  | Op.udiv _ => pairBind udiv? arg.toPair
  | Op.urem _ => pairBind urem? arg.toPair
  | Op.srem _ => pairBind srem? arg.toPair
  | Op.not _ => Option.map (~~~.) arg.toSingle
  | Op.copy _ => arg.toSingle
  | Op.neg _ => Option.map (-.) arg.toSingle
  | Op.select _ => 
    let (ocond, otrue, ofalse) := arg.toTriple
    select? ocond otrue ofalse
  | Op.icmp c _ => pairBind (icmp? c) arg.toPair

instance : OpDenote Op Ty := ⟨
  fun o args _ => Op.denote o args
⟩

end InstCombine
