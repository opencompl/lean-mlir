import SSA.Projects.InstCombine.ComWrappers
import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.Tactic

open BitVec
open MLIR AST

namespace AliveHandwritten

namespace LLVMTheory

@[simp]
theorem LLVM.const?_eq : LLVM.const? i = .some (BitVec.ofInt w i) := rfl

@[simp]
theorem LLVM.xor?_eq : LLVM.xor? a b  = .some (BitVec.xor a b) := rfl

end LLVMTheory

namespace DivRemOfSelect

/--
Name: SimplifyDivRemOfSelect
precondition: true
%sel = select %c, %Y, 0
%r = udiv %X, %sel
  =>
%r = udiv %X, %Y
-/
def alive_DivRemOfSelect_src (w : Nat) :=
  [alive_icom (w)| {
  ^bb0(%c: i1, %y : _, %x : _):
    %c0 = "llvm.mlir.constant" () { value = 0 : _ } :() -> (_)
    %v1 = "llvm.select" (%c,%y, %c0) : (i1, _, _) -> (_)
    %v2 = "llvm.udiv"(%x, %v1) : (_, _) -> (_)
    "llvm.return" (%v2) : (_) -> ()
  }]

def alive_DivRemOfSelect_tgt (w : Nat) :=
  [alive_icom (w)| {
  ^bb0(%c: i1, %y : _, %x : _):
    %v1 = "llvm.udiv" (%x,%y) : (_, _) -> (_)
    "llvm.return" (%v1) : (_) -> ()
  }]

theorem alive_DivRemOfSelect (w : Nat) :
    alive_DivRemOfSelect_src w ⊑ alive_DivRemOfSelect_tgt w := by
  unfold alive_DivRemOfSelect_src alive_DivRemOfSelect_tgt
  simp_alive_ssa
  simp_alive_undef
  simp only [simp_llvm]
  rintro y (rfl | ⟨vcond, hcond⟩) x
  -- | select condition is itself `none`, nothing more to be done. propagate the `none`.
  · cases x <;> cases y <;> simp
  · simp at hcond
    (obtain (rfl | rfl) : vcond = 1 ∨ vcond = 0 := by omega) <;> simp

/--info: 'AliveHandwritten.DivRemOfSelect.alive_DivRemOfSelect' depends on
axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms alive_DivRemOfSelect

end DivRemOfSelect

namespace AndOrXor
/-
Name: AndOrXor:2515   ((X^C1) >> C2)^C3 = (X>>C2) ^ ((C1>>C2)^C3)
%e1  = xor %x, C1
%op0 = lshr %e1, C2
%r   = xor %op0, C3
  =>
%o = lshr %x, C2 -- (X>>C2)
%p = lshr(%C1,%C2)
%q = xor %p, %C3 -- ((C1>>C2)^C3)
%r = xor %o, %q
-/

open ComWrappers
open LLVMTheory

def AndOrXor2515_lhs (w : ℕ):
  Com InstCombine.LLVM
    [/- C1 -/ InstCombine.Ty.bitvec w,
     /- C2 -/ InstCombine.Ty.bitvec w,
     /- C3 -/ InstCombine.Ty.bitvec w,
     /- %X -/ InstCombine.Ty.bitvec w] (InstCombine.Ty.bitvec w) :=
  /- e1  = -/ Com.lete (xor w /-x-/ 0 /-C1-/ 3) <|
  /- op0 = -/ Com.lete (lshr w /-e1-/ 0 /-C2-/ 3) <|
  /- r   = -/ Com.lete (xor w /-op0-/ 0 /-C3-/ 3) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

def AndOrXor2515_rhs (w : ℕ) :
  Com InstCombine.LLVM
    [/- C1 -/ InstCombine.Ty.bitvec w,
     /- C2 -/ InstCombine.Ty.bitvec w,
     /- C3 -/ InstCombine.Ty.bitvec w,
     /- %X -/ InstCombine.Ty.bitvec w] (InstCombine.Ty.bitvec w) :=
  /- o = -/ Com.lete (lshr w /-X-/ 0 /-C2-/ 2) <|
  /- p = -/ Com.lete (lshr w /-C1-/ 4 /-C2-/ 3) <|
  /- q = -/ Com.lete (xor w /-p-/ 0 /-C3-/ 3) <|
  /- r = -/ Com.lete (xor w /-o-/ 2 /-q-/ 0) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

def ushr_xor_right_distrib (c1 c2 c3 : BitVec w): (c1 ^^^ c2) >>> c3 = (c1 >>> c3) ^^^ (c2 >>> c3) := by
  simp only [HShiftRight.hShiftRight]
  ext
  simp

def ushr_and_right_distrib (c1 c2 c3 : BitVec w): (c1 &&& c2) >>> c3 = (c1 >>> c3) &&& (c2 >>> c3) := by
  simp only [HShiftRight.hShiftRight]
  ext
  simp

def ushr_or_right_distrib (c1 c2 c3 : BitVec w): (c1 ||| c2) >>> c3 = (c1 >>> c3) ||| (c2 >>> c3) := by
  simp only [HShiftRight.hShiftRight]
  ext
  simp

def ushr_xor_left_distrib (c1 c2 c3 : BitVec w): c1 >>> (c2 ^^^ c3) = (c1 >>> c2) ^^^ (c1 >>> c3) := by
  simp only [HShiftRight.hShiftRight]
  ext
  simp?
  sorry

#check Nat.right_distrib
#check Nat.left_distrib

def xor_assoc (c1 c2 c3 : BitVec w): c1 ^^^ c2 ^^^ c3 = c1 ^^^ (c2 ^^^ c3) := by
  ext i
  simp

def and_assoc (c1 c2 c3 : BitVec w): c1 &&& c2 &&& c3 = c1 &&& (c2 &&& c3) := by
  ext i
  simp [Bool.and_assoc]

def or_assoc (c1 c2 c3 : BitVec w): c1 ||| c2 ||| c3 = c1 ||| (c2 ||| c3) := by
  ext i
  simp [Bool.or_assoc]


def alive_simplifyAndOrXor2515 (w : Nat) :
  AndOrXor2515_lhs w ⊑ AndOrXor2515_rhs w := by
  simp only [AndOrXor2515_lhs, AndOrXor2515_rhs]
  simp only [simp_llvm_wrap]
  simp_alive_ssa
  simp_alive_undef
  intros c1 c2 c3 x
  rcases c1 with none | c1 <;>
  rcases c2 with none | c2 <;>
  rcases c3 with none | c3 <;>
  rcases x with none | x <;>
  simp only [LLVM.xor?_eq, xor_eq, Option.bind_eq_bind, Option.none_bind, Option.bind_none,
    Option.some_bind, Refinement.refl]
  rw [←Option.bind_eq_bind]
  simp_alive_ops
  by_cases h : w ≤ BitVec.toNat c2 <;>
  simp only [ge_iff_le, h, ↓reduceIte, Option.bind_eq_bind, Option.none_bind, Option.bind_none,
    Refinement.refl, Option.some_bind, h, Option.pure_def, Option.some_bind, Refinement.some_some]
  simp only [ushr_xor_right_distrib, xor_assoc]

/-- info: 'AliveHandwritten.AndOrXor.alive_simplifyAndOrXor2515' depends on
axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms alive_simplifyAndOrXor2515

/-
Proof:
------
  bitwise reasoning.
  LHS:
  ----
  (((X^C1) >> C2)^C3))[i]
  = ((X^C1) >> C2)[i] ^ C3[i] [bit-of-lsh r]
  # NOTE: negative entries will be 0 because it is LOGICAL shift right. This is denoted by the []₀ operator.
  = ((X^C1))[i - C2]₀ ^ C3[i] [bit-of-lshr]
  = (X[i - C2]₀ ^ C1[i - C2]₀) ^ C3[i]  [bit-of-xor]
  = X[i - C2]₀ ^ C1[i - C2]₀ ^ C3[i] [assoc]


  RHS:
  ----
  ((X>>C2) ^ ((C1 >> C2)^C3))[i]
  = (X>>C2)[i] ^ (C1 >> C2)^C3)[i] [bit-of-xor]
  # NOTE: negative entries will be 0 because it is LOGICAL shift right
  = X[i - C2]₀ ^ ((C1 >> C2)[i] ^ C3[i]) [bit-of-lshr]
  = X[i - C2]₀ ^ (C1[i-C2] ^ C3[i]) [bit-of-lshr]
-/
end AndOrXor

end AliveHandwritten
