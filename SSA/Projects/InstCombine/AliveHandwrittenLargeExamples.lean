import SSA.Projects.InstCombine.ComWrappers
import SSA.Projects.InstCombine.ForLean
import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.Tactic

open BitVec
open MLIR AST

namespace AliveHandwritten

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

namespace MulDivRem

/-
Name: MulDivRem:290

%poty = shl 1, %Y
%r = mul %poty, %X
  =>
%r = shl %X, %Y

Proof
======
  1. Without taking UB into account
    ⟦LHS₁⟧: (1 << Y) . X = ( 2^Y) X = 2^Y . X
    ⟦RHS₁⟧: X << Y = X . 2^Y
    equal by ring.

  2. With UB into account
    ⟦LHS₂⟧: (1 << Y) . Op1 = Y >= n ? UB : ⟦LHS₁⟧
    ⟦RHS₂⟧: Op1 << Y = Y >= n ? UB : ⟦RHS₁⟧
    but ⟦LHS₁⟧ = ⟦ RHS₁⟧ and thus we are done.
-/

open ComWrappers
def MulDivRem290_lhs (w : ℕ) :
  Com InstCombine.LLVM
    [/- %X -/ InstCombine.Ty.bitvec w,
    /- %Y -/ InstCombine.Ty.bitvec w] (InstCombine.Ty.bitvec w) :=
  /- c1 = -/ Com.lete (const w 1) <|
  /- poty = -/ Com.lete (shl w /- c1 -/ 0 /-%Y -/ 1) <|
  /- r = -/ Com.lete (mul w /- poty -/ 0 /-%X -/ 3) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

def MulDivRem290_rhs (w : ℕ) :
  Com InstCombine.LLVM [/- %X -/ InstCombine.Ty.bitvec w, /- %Y -/ InstCombine.Ty.bitvec w] (InstCombine.Ty.bitvec w) :=
  /- r = -/ Com.lete (shl w /-X-/ 1 /-Y-/ 0) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

def rkf (A B : BitVec w):
    BitVec.toNat (A <<< B) = ((BitVec.toNat A) * (2 ^ (BitVec.toNat B)))
    % 2 ^w := by
  unfold HShiftLeft.hShiftLeft
  unfold instHShiftLeftBitVec
  simp only [toNat_shiftLeft]
  rw [Nat.shiftLeft_eq_mul_pow]

def trsa' {A B : BitVec w} (h : BitVec.toNat B < w):
    1 <<< B * A = A <<< B := by
  apply BitVec.eq_of_toNat_eq
  rw [rkf]
  rw [BitVec.toNat_mul]
  rw [rkf]
  by_cases hw : w = 0
  subst hw
  simp
  have hww : 0 < w := by
    omega
  clear hw
  by_cases hw : w = 1
  subst hw
  ring_nf
  have sn : BitVec.toNat A * 2 ^ BitVec.toNat B < 2 := by
    simp at h
    simp at hww
    rw [h]
    simp
    omega
  ·
    repeat (rw [Nat.mod_eq_of_lt])
    ring_nf
    simp [sn]
    simp at h
    simp only [h]
    simp
    rw [Nat.mod_eq_of_lt]
    ring_nf
    simp [sn]
    simp at h
    simp [h]
  · simp
    ring_nf

def hra :BitVec.ofInt w 1  = 1 := by
  rfl

def trsa {A B : BitVec w} (h : BitVec.toNat B < w):
    BitVec.ofInt w 1 <<< B * A = A <<< B := by
  rw [hra]
  apply trsa' h

def alive_simplifyMulDivRem290 (w : Nat) :
  MulDivRem290_lhs w ⊑ MulDivRem290_rhs w := by
  unfold MulDivRem290_lhs MulDivRem290_rhs
  simp only [simp_llvm_wrap]
  simp_alive_ssa
  simp_alive_undef
  simp_alive_ops
  intros A B
  rcases A with none | A  <;> (try (simp [Option.bind, Bind.bind]; done)) <;>
  rcases B with none | B  <;> (try (simp [Option.bind, Bind.bind]; done)) <;>
  by_cases h : w ≤ BitVec.toNat B <;> simp [h]
  rw [trsa]
  omega

/-- info: 'AliveHandwritten.MulDivRem.alive_simplifyMulDivRem290' depends on
axioms: [propext, Classical.choice, Quot.sound]-/
#guard_msgs in #print axioms alive_simplifyMulDivRem290

end MulDivRem

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

def alive_simplifyAndOrXor2515 (w : Nat) :
  AndOrXor2515_lhs w ⊑ AndOrXor2515_rhs w := by
  simp only [AndOrXor2515_lhs, AndOrXor2515_rhs]
  simp only [simp_llvm_wrap]
  simp_alive_ssa
  simp_alive_undef
  intros c1 c2 c3 x
  rcases c1 with rfl | c1 <;> try (simp; done)
  rcases c2 with rfl | c2 <;> try (simp; done)
  rcases c3 with rfl | c3 <;> try (simp; done)
  rcases x with rfl | x <;> try (simp; done)
  simp_alive_ops
  by_cases h : BitVec.toNat c2 ≥ w <;>
    simp [h, ushr_xor_distrib, xor_assoc]

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
