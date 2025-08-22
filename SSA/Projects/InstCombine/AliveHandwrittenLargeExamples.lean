import SSA.Projects.InstCombine.ComWrappers
import SSA.Projects.InstCombine.ForLean
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.ComWrappers
import BvDecideParametric.ForLean

open BitVec
open MLIR AST
open InstCombine (LLVM)

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
  [llvm(w)| {
  ^bb0(%c: i1, %y : _, %x : _):
    %c0 = llvm.mlir.constant(0) : _
    %v1 = llvm.select %c, %y, %c0
    %v2 = llvm.udiv %x,  %v1
    llvm.return %v2
  }]

def alive_DivRemOfSelect_tgt (w : Nat) :=
  [llvm(w)| {
  ^bb0(%c: i1, %y : _, %x : _):
    %v1 = llvm.udiv %x, %y
    llvm.return %v1
  }]

theorem alive_DivRemOfSelect (w : Nat) :
    alive_DivRemOfSelect_src w ⊑ alive_DivRemOfSelect_tgt w := by
  unfold alive_DivRemOfSelect_src alive_DivRemOfSelect_tgt
  simp_alive_ssa
  simp_alive_undef
  simp_alive_case_bash
  simp_alive_split
  alive_auto

/--info: 'AliveHandwritten.DivRemOfSelect.alive_DivRemOfSelect' depends on
axioms: [propext, Quot.sound] -/
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
def MulDivRem805_lhs (w : ℕ) : Com InstCombine.LLVM
    [/- %X -/ LLVM.Ty.bitvec w] .pure (LLVM.Ty.bitvec w) :=
  /- c1 = -/ Com.var (const w 1) <|
  /- r = -/ Com.var (sdiv w /- c1-/ 0 /-%X -/ 1) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

def MulDivRem805_rhs (w : ℕ) : Com InstCombine.LLVM
    [/- %X -/ LLVM.Ty.bitvec w] .pure (LLVM.Ty.bitvec w) :=
  /- c1 = -/ Com.var (const w 1) <|
  /- inc = -/ Com.var (add w /-c1 -/ 0 /-X-/ 1) <|
  /- c3 = -/ Com.var (const w 3) <|
  /- c = -/ Com.var (icmp w .ult /-inc -/ 1 /-c3-/ 0) <|
  /- c0 = -/ Com.var (const w 0) <|
  /- r = -/ Com.var (select w /-%c-/ 1 /-X-/ 5 /-c0-/ 0) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

def alive_simplifyMulDivRem805 (w : Nat) :
  MulDivRem805_lhs w ⊑ MulDivRem805_rhs w := by
  unfold MulDivRem805_lhs MulDivRem805_rhs
  simp_alive_ssa
  simp_alive_ops
  simp_alive_undef
  simp_alive_case_bash
  simp only [LLVM.icmp?_ult_eq, PoisonOr.value_bind]
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
      rw [LLVM.sdiv?_denom_zero_eq_poison]
      simp
    case neg =>
      rw [BitVec.ult_toNat]
      rw [BitVec.toNat_ofNat]
      cases w'
      case zero =>
        simp only [toNat_add, toNat_ofNat, Nat.mod_succ]
        have hxcases := eq_zero_or_eq_one x
        have hxone : x = 1 := by
          cases hxcases
          case inl => contradiction
          case inr => assumption
        subst x
        simp only [ofNat_eq_ofNat, toNat_ofNat, pow_one, Nat.mod_succ, Nat.reduceAdd, Nat.mod_self]
        decide
      case succ w'' =>
        have htwopow_pos : 2^w'' > 0 := Nat.pow_pos (by omega)
        rw [Nat.mod_eq_of_lt (a := 3) (by omega)]
        split
        case isTrue hugt =>
          have hugt :
            (1 + BitVec.toNat x) % 2 ^ Nat.succ (Nat.succ w'') < 3 := by
              by_contra hcontra
              simp only [toNat_add, toNat_ofNat, Nat.mod_add_mod, hcontra, decide_false,
                ofBool_false, ofNat_eq_ofNat] at hugt
              contradiction
          rw [LLVM.sdiv?_eq_value_of_neq_allOnes (hy := by tauto)]
          · have hcases := Nat.cases_of_lt_mod_add hugt
              (by simp)
              (by apply BitVec.isLt)
            rcases hcases with ⟨h1, h2⟩ | ⟨h1, h2⟩
            · have h2 : BitVec.toNat x < 2 := by omega
              have hneq0 : BitVec.toNat x ≠ 0 := BitVec.toNat_neq_zero_of_neq_zero hx
              have h1 : BitVec.toNat x = 1 := by omega
              have h1 : x = 1 := by
                apply BitVec.eq_of_toNat_eq
                simp only [h1, ofNat_eq_ofNat, toNat_ofNat]
                rw [Nat.mod_eq_of_lt (by omega)]
              subst h1
              simp
            · have hcases : (1 + BitVec.toNat x = 2 ^ Nat.succ (Nat.succ w'') ∨
                  1 + BitVec.toNat x = 2 ^ Nat.succ (Nat.succ w'') + 1) := by
                omega
              rcases hcases with heqallones | heqzero
              · have heqallones : x = allOnes (Nat.succ (Nat.succ w'')) := by
                  apply BitVec.eq_of_toNat_eq
                  simp only [Nat.succ_eq_add_one, toNat_allOnes]
                  omega
                subst heqallones
                simp [BitVec.neg_one_eq_allOnes]
              · have heqzero : x = 0#_ := BitVec.eq_zero_of_toNat_mod_eq_zero (by omega)
                subst heqzero
                simp [BitVec.sdiv_zero]
          · exact intMin_neq_one (by omega)
        case isFalse hugt =>
          simp only [toNat_add, toNat_ofNat, Nat.mod_add_mod] at hugt
          unfold LLVM.sdiv? -- TODO: devar this; write theorem to unfold sdiv?
          split <;> simp
          case isFalse hsdiv =>
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
              simp only [Nat.mod_self, Nat.ofNat_pos, decide_true,
                ofBool_true, ofNat_eq_ofNat] at hugt
              contradiction

/--
info: 'AliveHandwritten.MulDivRem.alive_simplifyMulDivRem805' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms alive_simplifyMulDivRem805

def alive_simplifyMulDivRem805' (w : Nat) :
  MulDivRem805_lhs w ⊑ MulDivRem805_rhs w := by
  unfold MulDivRem805_lhs MulDivRem805_rhs
  simp_alive_ssa
  simp_alive_ops
  simp_alive_undef
  simp_alive_case_bash
  simp_alive_ops
  simp only [ofNat_eq_ofNat, Bool.or_eq_true, beq_iff_eq, Bool.and_eq_true, bne_iff_ne, ne_eq,
    PoisonOr.value_bind]
  intros a
  simp only [ofBool_1_iff_true]
  by_cases w_0 : w = 0; subst w_0; simp [BitVec.eq_nil a]
  split_ifs with c
  · simp
  · simp
  · by_cases h : 3#w >ᵤ 1#w + a
    · simp only [PoisonOr.value_isRefinedBy_value]
      by_cases a_0 : a = 0; subst a_0; simp at c
      by_cases a_1 : a = 1; subst a_1; simp
      rw [BitVec.toNat_eq] at a_0
      simp only [ofNat_eq_ofNat, toNat_ofNat, Nat.zero_mod] at a_0 a_1
      by_cases w_1 : w = 1
      · subst w_1
        have hh := BitVec.eq_zero_or_eq_one a
        simp at hh
        simp [a_1] at hh
        simp [hh]
      have w_gt_1 : 1 < w := by omega
      have el_one: 1 % 2^w = 1 := by
        simp only [Nat.one_lt_two_pow (n := w) (by omega), Nat.mod_eq_of_lt]
      have el_three: 3 % 2^w = 3 := by
        rw [Nat.mod_eq_of_lt];
        have x := @Nat.pow_le_pow_of_le 2 2 w (by omega) (by omega);
        omega
      unfold BitVec.ult at h
      simp only [toNat_add, toNat_ofNat, Nat.mod_add_mod, decide_eq_true_eq] at h
      simp only [el_three] at h
      by_cases a_allones : a = allOnes w
      · have x := sdiv_one_allOnes w_gt_1
        rw [a_allones]
        simp [x]
      · rw [Nat.add_mod_of_add_mod_lt] at h
        simp only [el_one, toNat_mod_cancel] at h
        simp_all
        simp [toNat_eq, show 0 < w by omega] at a_1
        omega
        simp only [el_one, toNat_mod_cancel]
        rw [BitVec.toNat_eq] at a_allones
        rw [BitVec.toNat_allOnes] at a_allones
        omega
    · simp_all
  · rename_i h
    simp only [PoisonOr.value_isRefinedBy_value]
    simp only [Bool.not_eq_true] at h
    have a_ne_zero : a ≠ 0 := by
      intro a_zero
      subst a_zero
      simp at c

    have a_ne_one : a ≠ 1 := by
      intro a_one
      subst a_one
      simp only [ofNat_eq_ofNat] at c
      apply c.elim
      by_cases w_1 : w = 1; subst w_1; simp at h
      have w_gt_1 : 1 < w := by omega
      simp only [BitVec.ult_toNat, toNat_add, decide_eq_false_iff_not] at h
      norm_cast at h
      simp only [Nat.mod_eq_of_lt (@Nat.pow_le_pow_of_le 2 2 w (by omega) (by omega)),
        ofNat_eq_ofNat, toNat_ofNat, Nat.add_mod_mod, Nat.mod_add_mod, Nat.reduceAdd, not_lt] at h
      simp [@Nat.mod_eq_of_lt 2 (2^w) (by omega)] at h

    have a_ne_allOnes : a ≠ allOnes w := by
      intro a_allOnes
      subst a_allOnes
      simp only [BitVec.ult, toNat_add, decide_eq_false_iff_not, not_lt] at h
      simp only [toNat_allOnes] at h
      by_cases w_1 : w = 1; subst w_1; simp at h
      have et : _ := @Nat.pow_le_pow_of_le 2 2 w (by simp) (by omega)
      simp only [BitVec.toNat_ofNat] at h
      rw [Nat.mod_eq_of_lt (by omega), @Nat.mod_eq_of_lt 1 (2^w) (by omega),
        Nat.add_comm, Nat.sub_add_cancel, Nat.mod_self] at h
      norm_num at h
      omega
    simp [one_sdiv a_ne_zero a_ne_one a_ne_allOnes]


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
    [/- %X -/ LLVM.Ty.bitvec w,
    /- %Y -/ LLVM.Ty.bitvec w] .pure (LLVM.Ty.bitvec w) :=
  /- c1 = -/ Com.var (const w 1) <|
  /- poty = -/ Com.var (shl w /- c1 -/ 0 /-%Y -/ 1) <|
  /- r = -/ Com.var (mul w /- poty -/ 0 /-%X -/ 3) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

def MulDivRem290_rhs (w : ℕ) :
    Com InstCombine.LLVM
    [/- %X -/ LLVM.Ty.bitvec w, /- %Y -/ LLVM.Ty.bitvec w]
    .pure (LLVM.Ty.bitvec w) :=
  /- r = -/ Com.var (shl w /-X-/ 1 /-Y-/ 0) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

def alive_simplifyMulDivRem290 (w : Nat) :
  MulDivRem290_lhs w ⊑ MulDivRem290_rhs w := by
  unfold MulDivRem290_lhs MulDivRem290_rhs
  simp_alive_ssa
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  alive_auto

/-- info: 'AliveHandwritten.MulDivRem.alive_simplifyMulDivRem290' depends on axioms: [propext, Classical.choice, Quot.sound] -/
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
    [/- C1 -/ LLVM.Ty.bitvec w,
     /- C2 -/ LLVM.Ty.bitvec w,
     /- C3 -/ LLVM.Ty.bitvec w,
     /- %X -/ LLVM.Ty.bitvec w] .pure (LLVM.Ty.bitvec w) :=
  /- e1  = -/ Com.var (xor w /-x-/ 0 /-C1-/ 3) <|
  /- op0 = -/ Com.var (lshr w /-e1-/ 0 /-C2-/ 3) <|
  /- r   = -/ Com.var (xor w /-op0-/ 0 /-C3-/ 3) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

def AndOrXor2515_rhs (w : ℕ) :
  Com InstCombine.LLVM
    [/- C1 -/ LLVM.Ty.bitvec w,
     /- C2 -/ LLVM.Ty.bitvec w,
     /- C3 -/ LLVM.Ty.bitvec w,
     /- %X -/ LLVM.Ty.bitvec w] .pure (LLVM.Ty.bitvec w) :=
  /- o = -/ Com.var (lshr w /-X-/ 0 /-C2-/ 2) <|
  /- p = -/ Com.var (lshr w /-C1-/ 4 /-C2-/ 3) <|
  /- q = -/ Com.var (xor w /-p-/ 0 /-C3-/ 3) <|
  /- r = -/ Com.var (xor w /-o-/ 2 /-q-/ 0) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

def alive_simplifyAndOrXor2515 (w : Nat) :
  AndOrXor2515_lhs w ⊑ AndOrXor2515_rhs w := by
  simp only [AndOrXor2515_lhs, AndOrXor2515_rhs]
  simp_alive_ssa
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  simp_alive_split
  alive_auto

/-- info: 'AliveHandwritten.AndOrXor.alive_simplifyAndOrXor2515' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms alive_simplifyAndOrXor2515

/-
Proof:
------
  bitwise reasoning.
  LHS:
  ----
  (((X^C1) >> C2)^C3))[i]
  = ((X^C1) >> C2)[i] ^ C3[i] [bit-of-lsh r]
  # NOTE: negative entries will be 0 because it is LOGICAL shift right.
    This is denoted by the []₀ operator.
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
    [/- A -/ LLVM.Ty.bitvec w] .pure (LLVM.Ty.bitvec w) :=
  /- c0     = -/ Com.var (const w 0) <|
  /- c      = -/ Com.var (icmp w .slt /-A-/ 1 /-c0-/ 0) <|
  /- minus  = -/ Com.var (sub w /-c0-/ 1 /-A-/ 2) <|
  /- abs    = -/ Com.var (select w /-c-/ 1/-A-/ 3 /-minus-/ 0) <|
  /- c2     = -/ Com.var (icmp w .sgt /-abs-/ 0 /-c0-/ 3) <|
  /- minus2 = -/ Com.var (sub w /-c0-/ 4 /-abs-/ 1) <|
  /- abs2   = -/ Com.var (select w /-c2-/ 1/-abs-/ 2 /-minus2-/ 0) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

def Select746_rhs (w : ℕ):
  Com InstCombine.LLVM
    [/- A -/ LLVM.Ty.bitvec w] .pure (LLVM.Ty.bitvec w) :=
  /- c0     = -/ Com.var (const w 0) <|
  /- c      = -/ Com.var (icmp w .slt /-A-/ 1 /-c0-/ 0) <|
  /- minus  = -/ Com.var (sub w /-c0-/ 1 /-A-/ 2) <|
  /- abs    = -/ Com.var (select w /-c-/ 1/-A-/ 3 /-minus-/ 0) <|
  /- c3     = -/ Com.var (icmp w .sgt /-A-/ 4 /-c0-/ 3) <|
  /- abs2   = -/ Com.var (select w /-c3-/ 0/-A-/ 5 /-minus-/ 2) <|
  Com.ret ⟨/-r-/0, by simp [Ctxt.snoc]⟩

--TODO: upstream (some of) these lemmas
private theorem ofBool_eq_one (x : Bool) :
    ofBool x = 1#1 ↔ x = true := by
  cases x <;> simp [ofBool]

private theorem zero_lt_toInt_iff {x : BitVec w} :
    0 < x.toInt ↔ (x.msb = false ∧ x ≠ 0#w) := by
  have : x ≠ 0#w ↔ x.toInt ≠ 0 := by
    simp [← toInt_inj]
  simp only [msb_eq_toInt, decide_eq_false_iff_not, not_lt, ne_eq, this]
  omega

def alive_simplifySelect764 (w : Nat) :
    Select746_lhs w ⊑ Select746_rhs w := by
  simp only [Select746_lhs, Select746_rhs]
  simp_alive_ssa
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intro A
  simp only [BitVec.slt, ofBool_eq_one, toInt_zero, decide_eq_true_eq, BitVec.zero_sub]
  split
  next => simp
  next A_ge_zero =>
    simp only [PoisonOr.value_bind, _root_.neg_neg]
    by_cases A_eq_zero : A = 0#w
    · simp [A_eq_zero]
    · have A_bne_zero : A != 0#w := by
        simp [bne, A_eq_zero]
      have A_bne_intMin : A != intMin w := by
        rcases w with _|w
        · simp [BitVec.of_length_zero] at A_eq_zero
        simp only [bne_iff_ne, ne_eq]
        rintro rfl
        simp_all only [toInt_intMin, add_tsub_cancel_right, Int.natCast_emod, Nat.cast_pow,
          Nat.cast_ofNat, Int.neg_neg_iff_pos, not_lt, intMin_eq_zero_iff, Nat.add_eq_zero,
          one_ne_zero, and_false, not_false_eq_true, bne_iff_ne, ne_eq]
        rw [Int.emod_eq_of_lt (by omega) (by omega)] at A_ge_zero
        norm_cast at A_ge_zero
        apply Nat.not_lt_of_le A_ge_zero <| Nat.two_pow_pos w
      simp only [zero_lt_toInt_iff, msb_neg, A_bne_zero, A_bne_intMin,
        Bool.true_and, bne_eq_false_iff_eq, ne_eq,
        neg_eq_zero_iff, A_eq_zero, not_false_eq_true, and_true]
      cases A.msb <;> simp

/-- info: 'AliveHandwritten.Select.alive_simplifySelect764' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms alive_simplifySelect764

end Select
end AliveHandwritten
