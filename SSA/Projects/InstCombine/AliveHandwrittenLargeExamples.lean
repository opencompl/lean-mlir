import SSA.Projects.InstCombine.ComWrappers
import SSA.Projects.InstCombine.ForLean
import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.ComWrappers
import Mathlib.Tactic

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
Name: MulDivRem:805
%r = sdiv 1, %X
  =>
%inc = add %X, 1
%c = icmp ult %inc, 3
%r = select %c, %X, 0

Proof:
======
  Values of LHS:
    - 1/x where x >= 2: 0
    - 1/1 = 1
    - 1/0 = UB
    - 1/ -1 = -1
    - 1/x where x <= -2: 0
  Values of RHS:
    RHS: (x + 2) <_u 3 ? x : 0
    - x >= 2: (x + 1) <_u 3 ? x : 0
              =  false ? x : 0 = false
    - x = 1: (1 + 1) <_u 3 ? x : 0
              = 2 <_u 3 ? x : 0
              = true ? x : 0
              = x = 1
    - x = 0: (0 + 1) <_u 3 ? x : 0
              = 1 <_u 3 ? 0 : 0
              = true ? 0 : 0
              = 0
    - x = -1: (-1 + 1) <_u 3 ? x : 0
              = 0 <_u 3 ? x : 0
              = true ? x : 0
              = x = -1
    - x <= -2 : (-2 + 1) <_u 3 ? x : 0
              = -1 <_u 3 ? x : 0
              = INT_MAX < 3 ? x : 0
              = false ? x : 0
              = 0
 Thus, LHS and RHS agree on values.
-/
open ComWrappers
def MulDivRem805_lhs (w : ℕ) : Com InstCombine.LLVM [/- %X -/ InstCombine.Ty.bitvec w] .pure (InstCombine.Ty.bitvec w) :=
  /- c1 = -/ Com.lete (const w 1) <|
  /- r = -/ Com.lete (sdiv w /- c1-/ 0 /-%X -/ 1) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

def MulDivRem805_rhs (w : ℕ) : Com InstCombine.LLVM [/- %X -/ InstCombine.Ty.bitvec w] .pure (InstCombine.Ty.bitvec w) :=
  /- c1 = -/ Com.lete (const w 1) <|
  /- inc = -/ Com.lete (add w /-c1 -/ 0 /-X-/ 1) <|
  /- c3 = -/ Com.lete (const w 3) <|
  /- c = -/ Com.lete (icmp w .ult /-inc -/ 1 /-c3-/ 0) <|
  /- c0 = -/ Com.lete (const w 0) <|
  /- r = -/ Com.lete (select w /-%c-/ 1 /-X-/ 5 /-c0-/ 0) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

open Std (BitVec) in
def alive_simplifyMulDivRem805 (w : Nat) :
  MulDivRem805_lhs w ⊑ MulDivRem805_rhs w := by
  unfold MulDivRem805_lhs MulDivRem805_rhs
  simp only [simp_llvm_wrap]
  simp_alive_ssa
  simp_alive_undef
  simp_alive_case_bash
  simp
  cases w
  case zero =>
    intros x
    simp only [BitVec.eq_nil]
    simp [LLVM.sdiv?]
  case succ w' =>
    intros x
    by_cases hx:(x = 0)
    case pos =>
      subst hx
      rw [LLVM.sdiv?_denom_zero_eq_none]
      apply Refinement.none_left
    case neg =>
      rw [BitVec.ult_toNat]
      rw [BitVec.toNat_ofNat]
      cases w'
      case zero =>
        simp only [Nat.zero_eq, toNat_add, toNat_ofNat, Nat.reduceSucc, pow_one,
          Nat.mod_succ, Nat.reduceMod, Nat.lt_one_iff]
        have hxcases := BitVec.width_one_cases x
        have hxone : x = 1 := by
          cases hxcases
          case inl => contradiction
          case inr => assumption
        subst x
        simp only [ofNat_eq_ofNat, Nat.zero_eq, toNat_ofNat, Nat.reduceSucc,
          pow_one, Nat.mod_succ,
          Nat.reduceAdd, Nat.mod_self, decide_True, ofBool_true]
        decide
      case succ w'' =>
        have htwopow_pos : 2^w'' > 0 := Nat.pow_pos (by omega)
        rw [Nat.mod_eq_of_lt (a := 3) (by omega)]
        split
        case h_1 c hugt => contradiction
        case h_2 c hugt =>
          clear c
          have hugt :
            (1 + BitVec.toNat x) % 2 ^ Nat.succ (Nat.succ w'') < 3 := by
              by_contra hcontra
              simp [hcontra] at hugt
              contradiction
          rw [LLVM.sdiv?_eq_pure_of_neq_allOnes (hy := by tauto)]
          · have hcases := Nat.cases_of_lt_mod_add hugt
              (by simp)
              (by apply BitVec.toNat_lt_self_mod)
            rcases hcases with ⟨h1, h2⟩ | ⟨h1, h2⟩
            · have h2 : BitVec.toNat x < 2 := by omega
              have hneq0 : BitVec.toNat x ≠ 0 := BitVec.toNat_neq_zero_of_neq_zero hx
              have h1 : BitVec.toNat x = 1 := by omega
              have h1 : x = 1 := by
                apply BitVec.eq_of_toNat_eq
                simp [h1]
                rw [Nat.mod_eq_of_lt (by omega)]
              subst h1
              simp [BitVec.sdiv_one_one]
            · have hcases : (1 + BitVec.toNat x = 2 ^ Nat.succ (Nat.succ w'') ∨
                  1 + BitVec.toNat x = 2 ^ Nat.succ (Nat.succ w'') + 1) := by
                omega
              rcases hcases with heqallones | heqzero
              · have heqallones : x = allOnes (Nat.succ (Nat.succ w'')) := by
                  apply BitVec.eq_of_toNat_eq
                  simp [heqallones]
                  omega
                subst heqallones
                simp [BitVec.sdiv_one_allOnes]
              · have heqzero : x = 0#_ := BitVec.eq_zero_of_toNat_mod_eq_zero (by omega)
                subst heqzero
                simp [BitVec.sdiv_zero]
          · exact intMin_neq_one (by omega)
        case h_3 c hugt =>
          clear c
          simp at hugt
          unfold LLVM.sdiv? -- TODO: delete this; write theorem to unfold sdiv?
          split <;> simp
          case inr hsdiv =>
            clear hsdiv
            apply BitVec.one_sdiv (ha0 := by assumption)
            · by_contra hone
              subst hone
              simp only [ofNat_eq_ofNat, toNat_ofNat,
                Nat.add_mod_mod, Nat.reduceAdd] at hugt
              rw [Nat.mod_eq_of_lt (a := 2) (by omega)] at hugt
              contradiction
            · by_contra hAllOnes
              subst hAllOnes
              rw [toNat_allOnes] at hugt
              rw [Nat.add_sub_of_le (by omega)] at hugt
              simp only [Nat.mod_self, Nat.ofNat_pos, decide_True,
                ofBool_true, ofNat_eq_ofNat] at hugt
              contradiction

/--info: 'AliveHandwritten.MulDivRem.alive_simplifyMulDivRem805' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms alive_simplifyMulDivRem805

open Std (BitVec) in
def alive_simplifyMulDivRem805' (w : Nat) :
  MulDivRem805_lhs w ⊑ MulDivRem805_rhs w := by
  unfold MulDivRem805_lhs MulDivRem805_rhs
  simp only [simp_llvm_wrap]
  simp_alive_ssa
  simp_alive_undef
  simp_alive_case_bash
  simp
  intros a
  simp_alive_ops
  simp
  split_ifs with c
  simp
  by_cases w_0 : w = 0; subst w_0; simp [BitVec.eq_nil a]
  by_cases h : 3#w >ᵤ 1#w + a
  · simp [h]
    by_cases a_0 : a = 0; subst a_0; simp at c
    by_cases a_1 : a = 1; subst a_1; simp [sdiv_one_one]
    rw [BitVec.toNat_eq] at a_0 a_1
    simp at a_0 a_1
    by_cases w_1 : w = 1; subst w_1; omega
    have w_gt_1 : 1 < w := by omega
    have el_one: 1 % 2^w = 1 := by rw [Nat.mod_eq_of_lt]; omega
    rw [el_one] at a_1
    have el_three: 3 % 2^w = 3 := by
      rw [Nat.mod_eq_of_lt];
      have x := @Nat.pow_le_pow_of_le 2 2 w (by omega) (by omega);
      omega
    unfold BitVec.ult at h
    simp at h
    simp [el_three] at h
    by_cases a_allones : a = allOnes w
    · have x := sdiv_one_allOnes w_gt_1
      rw [a_allones]
      simp [x]
    · rw [Nat.add_mod_of_add_mod_lt] at h
      simp [el_one] at h
      omega
      simp [el_one]
      rw [BitVec.toNat_eq] at a_allones
      rw [BitVec.toNat_allOnes] at a_allones
      omega

  · simp [h]
    simp at h
    have a_ne_zero : a ≠ 0 := by
      intro a_zero
      subst a_zero
      simp at c

    have a_ne_one : a ≠ 1 := by
      intro a_one
      subst a_one
      simp only [←BitVec.toNat_inj] at c
      simp only [ofNat_eq_ofNat, toNat_ofNat, Nat.zero_mod, toNat_ofInt, Nat.cast_pow,
        Nat.cast_ofNat, toNat_neg] at c
      norm_cast at c
      apply c.elim
      by_cases w_1 : w = 1; subst w_1; simp at h
      have w_gt_1 : 1 < w := by omega;
      simp only [BitVec.ult_toNat, toNat_add, toNat_ofInt, decide_eq_false_iff_not] at h
      norm_cast at h
      simp only [
        Nat.mod_eq_of_lt (@Nat.pow_le_pow_of_le 2 2 w (by omega) (by omega)),
        Nat.mod_eq_of_lt, ofNat_eq_ofNat, toNat_ofNat, Nat.add_mod_mod,
        Nat.mod_add_mod, Nat.reduceAdd, not_lt] at h
      simp [@Nat.mod_eq_of_lt 2 (2^w) (by omega)] at h

    have a_ne_allOnes : a ≠ allOnes w := by
      intro a_allOnes
      subst a_allOnes
      simp only [BitVec.ult, toNat_add, toNat_ofInt, decide_eq_false_iff_not, not_lt] at h
      norm_cast at h
      simp only [Int.toNat_natCast, toNat_allOnes, Nat.mod_add_mod] at h
      by_cases w_1 : w = 1; subst w_1; simp at h
      have et : _ := @Nat.pow_le_pow_of_le 2 2 w (by simp) (by omega)
      simp only [BitVec.toNat_ofNat] at h
      rw [Nat.mod_eq_of_lt (by omega), @Nat.mod_eq_of_lt 1 (2^w) (by omega),
        Nat.add_comm, Nat.sub_add_cancel, Nat.mod_self] at h
      norm_num at h
      omega
    rw [one_sdiv a_ne_zero a_ne_one a_ne_allOnes]
    rfl

/--info: 'AliveHandwritten.MulDivRem.alive_simplifyMulDivRem805'' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms alive_simplifyMulDivRem805'

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
    /- %Y -/ InstCombine.Ty.bitvec w] .pure (InstCombine.Ty.bitvec w) :=
  /- c1 = -/ Com.lete (const w 1) <|
  /- poty = -/ Com.lete (shl w /- c1 -/ 0 /-%Y -/ 1) <|
  /- r = -/ Com.lete (mul w /- poty -/ 0 /-%X -/ 3) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

def MulDivRem290_rhs (w : ℕ) :
  Com InstCombine.LLVM [/- %X -/ InstCombine.Ty.bitvec w, /- %Y -/ InstCombine.Ty.bitvec w] .pure (InstCombine.Ty.bitvec w) :=
  /- r = -/ Com.lete (shl w /-X-/ 1 /-Y-/ 0) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

def alive_simplifyMulDivRem290 (w : Nat) :
  MulDivRem290_lhs w ⊑ MulDivRem290_rhs w := by
  unfold MulDivRem290_lhs MulDivRem290_rhs
  simp only [simp_llvm_wrap]
  simp_alive_ssa
  simp_alive_undef
  simp_alive_ops
  intros A B
  rcases A with rfl | A  <;> (try (simp [Option.bind, Bind.bind]; done)) <;>
  rcases B with rfl | B  <;> (try (simp [Option.bind, Bind.bind]; done)) <;>
  by_cases h : w ≤ BitVec.toNat B <;> simp [h]
  apply BitVec.eq_of_toNat_eq
  simp [bv_toNat]
  ring_nf

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
     /- %X -/ InstCombine.Ty.bitvec w] .pure (InstCombine.Ty.bitvec w) :=
  /- e1  = -/ Com.lete (xor w /-x-/ 0 /-C1-/ 3) <|
  /- op0 = -/ Com.lete (lshr w /-e1-/ 0 /-C2-/ 3) <|
  /- r   = -/ Com.lete (xor w /-op0-/ 0 /-C3-/ 3) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

def AndOrXor2515_rhs (w : ℕ) :
  Com InstCombine.LLVM
    [/- C1 -/ InstCombine.Ty.bitvec w,
     /- C2 -/ InstCombine.Ty.bitvec w,
     /- C3 -/ InstCombine.Ty.bitvec w,
     /- %X -/ InstCombine.Ty.bitvec w] .pure (InstCombine.Ty.bitvec w) :=
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


namespace Select

/-
Name: Select:746
%c = icmp slt %A, 0
%minus = sub 0, %A
%abs = select %c, %A, %minus
%c2 = icmp sgt %abs, 0
%minus2 = sub 0, %abs
%abs2 = select %c2, %abs, %minus2
  =>
%c = icmp slt %A, 0
%minus = sub 0, %A
%abs = select %c, %A, %minus
%c3 = icmp sgt %A, 0
%abs2 = select %c3, %A, %minus
-/

open ComWrappers
def Select746_lhs (w : ℕ):
  Com InstCombine.LLVM
    [/- A -/ InstCombine.Ty.bitvec w] .pure (InstCombine.Ty.bitvec w) :=
  /- c0     = -/ Com.lete (const w 0) <|
  /- c      = -/ Com.lete (icmp w .slt /-A-/ 1 /-c0-/ 0) <|
  /- minus  = -/ Com.lete (sub w /-c0-/ 1 /-A-/ 2) <|
  /- abs    = -/ Com.lete (select w /-c-/ 1/-A-/ 3 /-minus-/ 0) <|
  /- c2     = -/ Com.lete (icmp w .sgt /-abs-/ 0 /-c0-/ 3) <|
  /- minus2 = -/ Com.lete (sub w /-c0-/ 4 /-abs-/ 1) <|
  /- abs2   = -/ Com.lete (select w /-c2-/ 1/-abs-/ 2 /-minus2-/ 0) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

def Select746_rhs (w : ℕ):
  Com InstCombine.LLVM
    [/- A -/ InstCombine.Ty.bitvec w] .pure (InstCombine.Ty.bitvec w) :=
  /- c0     = -/ Com.lete (const w 0) <|
  /- c      = -/ Com.lete (icmp w .slt /-A-/ 1 /-c0-/ 0) <|
  /- minus  = -/ Com.lete (sub w /-c0-/ 1 /-A-/ 2) <|
  /- abs    = -/ Com.lete (select w /-c-/ 1/-A-/ 3 /-minus-/ 0) <|
  /- c3     = -/ Com.lete (icmp w .sgt /-A-/ 4 /-c0-/ 3) <|
  /- abs2   = -/ Com.lete (select w /-c3-/ 0/-A-/ 5 /-minus-/ 2) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

def alive_simplifySelect764 (w : Nat) :
  Select746_lhs w ⊑ Select746_rhs w := by
  simp only [Select746_lhs, Select746_rhs]
  simp only [simp_llvm_wrap]
  simp_alive_ssa
  simp_alive_undef
  intros A
  rcases A with rfl | A  <;> simp [Option.bind, Bind.bind]
  by_cases zero_sgt_A : 0#w >ₛ A
  · simp [zero_sgt_A]
  · simp only [zero_sgt_A, ofBool_false, ofNat_eq_ofNat, sub_sub_cancel]
    by_cases neg_A_sgt_zero : -A >ₛ 0#w
    · simp [neg_A_sgt_zero, zero_sub_eq_neg]
      by_cases A_sgt_zero : A >ₛ 0#w
      simp only [A_sgt_zero, ofBool_true, ofNat_eq_ofNat, Refinement.some_some]
      · by_cases A_eq_zero : A = 0
        simp only [A_eq_zero, ofNat_eq_ofNat, BitVec.neg_zero]
        by_cases A_eq_intMin : A = intMin w
        simp only [A_eq_intMin, intMin_eq_neg_intMin]
        have A_ne_intMin : A ≠ intMin w := by
          simp [A_eq_intMin]
        have A_ne_zero : A ≠ 0 := by
          simp only [ofNat_eq_ofNat] at A_eq_zero
          simp [A_eq_zero]
        rw [sgt_zero_eq_not_neg_sgt_zero A A_ne_intMin A_ne_zero] at A_sgt_zero
        simp only at neg_A_sgt_zero
        simp [neg_A_sgt_zero] at A_sgt_zero
      simp [A_sgt_zero]
    · simp [neg_A_sgt_zero, zero_sub_eq_neg]
      by_cases A_sgt_zero : A >ₛ 0#w
      · simp [A_sgt_zero]
      · by_cases A_eq_zero : A = 0
        simp only [A_eq_zero, ofNat_eq_ofNat, ofInt_zero_eq, sgt_same, ofBool_false,
          BitVec.neg_zero, Refinement.refl]
        by_cases A_eq_intMin : A = intMin w
        · simp [A_eq_intMin, BitVec.ofInt_zero_eq, sgt_same, intMin_not_gt_zero,
            intMin_eq_neg_intMin]
        · have neg_not_sgt_zero : ¬(-A >ₛ 0#w) = true → (A >ₛ 0#w) = true
            := (sgt_zero_eq_not_neg_sgt_zero A A_eq_intMin A_eq_zero).mpr
          apply neg_not_sgt_zero at neg_A_sgt_zero
          simp only at neg_A_sgt_zero
          simp only [Bool.not_eq_true] at A_sgt_zero
          rw [A_sgt_zero] at neg_A_sgt_zero
          contradiction

/-- info: 'AliveHandwritten.Select.alive_simplifySelect764' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms alive_simplifySelect764

end Select
end AliveHandwritten
