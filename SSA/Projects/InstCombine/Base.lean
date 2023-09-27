import SSA.Core.Framework
import SSA.Core.Util
import SSA.Projects.InstCombine.ForMathlib


namespace InstCombine

inductive IntPredicate where
| eq
| ne
| ugt
| uge
| ult
| ule
| sgt
| sge
| slt
| sle
deriving Inhabited, DecidableEq, Repr

inductive Ty
  | bitvec (w : Nat) : Ty
  deriving DecidableEq, Inhabited, Repr

instance : ToString Ty where
  toString t := repr t |>.pretty

instance : Repr Ty where 
  reprPrec 
    | .bitvec w, _ => "i" ++ repr w

instance {w : Nat} : Inhabited Ty := ⟨Ty.bitvec w⟩

def Ty.width : Ty → Nat
  | .bitvec w => w

@[simp]
theorem Ty.width_eq (ty : Ty) :  Ty.bitvec (ty.width) = ty :=
 by simp [width]

@[simp]
def Bitvec.width {n : Nat} (_ : Bitvec n) : Nat := n

instance : Goedel Ty where
toType := fun
  | .bitvec w => Option $ Bitvec w

instance : Repr (Bitvec n) where
  reprPrec
    | v, n => reprPrec (Bitvec.toInt v) n

-- See: https://releases.llvm.org/14.0.0/docs/LangRef.html#bitwise-binary-operations
inductive Op
| and (w : Nat) : Op
| or (w : Nat) : Op
| not (w : Nat) : Op
| xor (w : Nat) : Op
| shl (w : Nat) : Op
| lshr (w : Nat) : Op
| ashr (w : Nat) : Op
| urem (w : Nat) : Op
| srem (w : Nat) : Op
| select (w : Nat) : Op
| add (w : Nat) : Op
| mul (w : Nat) : Op
| sub (w : Nat) : Op
| neg (w: Nat) : Op
| copy (w: Nat) : Op
| sdiv (w : Nat) : Op
| udiv (w : Nat) : Op
| icmp (c : IntPredicate) (w : Nat) : Op
| const {w : Nat} (val : Bitvec w) : Op
deriving Repr, DecidableEq, Inhabited

instance : ToString Op where
  toString o := repr o |>.pretty

@[simp, reducible]
def Op.sig : Op → List Ty
| Op.and w | Op.or w | Op.xor w | Op.shl w | Op.lshr w | Op.ashr w
| Op.add w | Op.mul w | Op.sub w | Op.udiv w | Op.sdiv w 
| Op.srem w | Op.urem w | Op.icmp _ w =>
  [Ty.bitvec w, Ty.bitvec w]
| Op.not w | Op.neg w | Op.copy w => [Ty.bitvec w]
| Op.select w => [Ty.bitvec 1, Ty.bitvec w, Ty.bitvec w]
| Op.const _ => []

@[simp, reducible]
def Op.outTy : Op → Ty
| Op.and w | Op.or w | Op.not w | Op.xor w | Op.shl w | Op.lshr w | Op.ashr w
| Op.sub w |  Op.select w | Op.neg w | Op.copy w =>
  Ty.bitvec w
| Op.add w | Op.mul w |  Op.sdiv w | Op.udiv w | Op.srem w | Op.urem w =>
  Ty.bitvec w
| Op.icmp _ _ => Ty.bitvec 1
| @Op.const width _ => Ty.bitvec width

instance : OpSignature Op Ty where 
  sig := Op.sig
  outTy := Op.outTy
  regSig _ := []

@[simp]
def Op.denote (o : Op) (arg : HVector Goedel.toType (OpSignature.sig o)) :
    (Goedel.toType <| OpSignature.outTy o) :=
  match o with
  | Op.const c => Option.some c
  | Op.and _ => pairMapM (.&&&.) arg.toPair
  | Op.or _ => pairMapM (.|||.) arg.toPair
  | Op.xor _ => pairMapM (.^^^.) arg.toPair
  | Op.shl _ => pairMapM (. <<< .) arg.toPair
  | Op.lshr _ => pairMapM (. >>> .) arg.toPair
  | Op.ashr _ => pairMapM (. >>>ₛ .) arg.toPair
  | Op.sub _ => pairMapM (.-.) arg.toPair
  | Op.add _ => pairMapM (.+.) arg.toPair
  | Op.mul _ => pairMapM (.*.) arg.toPair
  | Op.sdiv _ => pairBind Bitvec.sdiv? arg.toPair
  | Op.udiv _ => pairBind Bitvec.udiv? arg.toPair
  | Op.urem _ => pairBind Bitvec.urem? arg.toPair
  | Op.srem _ => pairBind Bitvec.srem? arg.toPair
  | Op.not _ => Option.map (~~~.) arg.toSingle
  | Op.copy _ => arg.toSingle
  | Op.neg _ => Option.map (-.) arg.toSingle
  | Op.select _ => tripleMapM Bitvec.select arg.toTriple
  | Op.icmp c _ => match c with
    | .eq => pairMapM (fun x y => ↑(x == y)) arg.toPair
    | .ne => pairMapM (fun x y => ↑(x != y)) arg.toPair
    | .sgt => pairMapM (. >ₛ .) arg.toPair
    | .sge => pairMapM (. ≥ₛ .) arg.toPair
    | .slt => pairMapM (. <ₛ .) arg.toPair
    | .sle => pairMapM (. ≤ₛ .) arg.toPair
    | .ugt => pairMapM (. >ᵤ .) arg.toPair
    | .uge => pairMapM (. ≥ᵤ .) arg.toPair
    | .ult => pairMapM (. <ᵤ .) arg.toPair
    | .ule => pairMapM (. ≤ᵤ .) arg.toPair

instance : OpDenote Op Ty := ⟨
  fun o args _ => Op.denote o args
⟩

end InstCombine
