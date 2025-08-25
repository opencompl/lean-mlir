import SSA.Projects.RISCV64.PrettyEDSL
import SSA.Core.Framework
import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

namespace BitVec
open LLVMRiscV
-- background LEAN
theorem add_eq_sll (a : Nat) : a + a = a <<< 1 := by omega --

theorem not_and_eq_not_or_not (x y : BitVec 64) :
  ~~~ (x &&& y) + x  = (~~~ x ||| ~~~ y) + x := by
    bv_decide

-- riscv Dialect chapter
def riscv_asm := [RV64_com| {
 ^bb0(%r1 : !riscv.reg, %r2 : !riscv.reg ):
 %0 = and %r1, %r2 : !riscv.reg
 %1 = div %0, %r1 : !riscv.reg
    ret %1 : !riscv.reg
}]

def riscv_generic := [RV64_com| {
 ^bb0(%r1 : !riscv.reg, %r2 : !riscv.reg ):
 %0 = "and" (%r1, %r2) : (!riscv.reg, !riscv.reg) -> !riscv.reg
 %1 = "div" (%0, %r1) : (!riscv.reg, !riscv.reg) -> !riscv.reg
 "ret" (%1) : (!riscv.reg) -> ()
}]

-- llvm dialect chapter

def  shift_mul:=
  [llvm(64)| {
  ^bb0(%X : _, %Y : _):
    %c1 = llvm.mlir.constant(1)
    %poty = llvm.shl %c1, %Y
    %r = llvm.mul %poty, %X
    llvm.return %r
  }]

def llvm_generic :=
  [llvm(64)| {
  ^bb0(%r1 : i64 , %r2 : i64 ):
    %0 = "llvm.and" (%r1, %r2) : (i64, i64) -> i64
    %1 = "llvm.sdiv" (%0, %r1) : (i64, i64) -> i64
  "llvm.return" (%1) : (i64) -> ()
}]




-- hybrid dialect chapter
def icmp_then_sub := [LV| {
  ^entry (%a: i64, %b: i64):
    %0= llvm.icmp.eq %a, %b : i64
    %1 = "builtin.unrealized_conversion_cast" (%0) : (i1) -> (!riscv.reg)
    %2= add %1, %1: !riscv.reg
    %3 = "builtin.unrealized_conversion_cast" (%2) : (!riscv.reg) -> (i1)
    llvm.return %3 : i1
  }]

  -- implementing reported SelectionDAG bug
def original_sdiv_srem := [LV| {
  ^entry (%a: i64, %b: i64):
    %0= llvm.sdiv exact %a, %b : i64
    %1 = llvm.srem %a, %b : i64
    llvm.return %1 : i64
  }]

def combined_sdiv_srem := [LV| {
  ^entry (%a: i64, %b: i64):
    %0= llvm.sdiv exact %a, %b : i64
    %1 = llvm.mul %b, %0 : i64
    %2 = llvm.sub %a, %1 : i64
    llvm.return %2 : i64
  }]

theorem mul_sdiv_cancel_of_dvd_of_ne {w : Nat} {x y : BitVec w}
  (h₁ : y.smod x = 0#_)
  (h₂ : y ≠ intMin w ∨ x ≠ -1#w) :
  x * y.sdiv x = y := by
  apply eq_of_toInt_eq
  simp only [toInt_mul]
  rw [BitVec.toInt_sdiv_of_ne_or_ne _ _ h₂]
  rw [← BitVec.toInt_inj, BitVec.toInt_smod, BitVec.toInt_zero] at h₁
  rw [Int.mul_tdiv_cancel' (Int.dvd_of_fmod_eq_zero h₁)]
  exact toInt_bmod_cancel y

theorem srem_eq_zero_of_smod {w : Nat} {x y : BitVec w} :
  x.smod y = 0#_ → x.srem y = 0#_ := by
  simp only [← toInt_inj, toInt_smod, toInt_zero, toInt_srem]
  intro h
  simp [Int.tmod_eq_fmod, Int.dvd_of_fmod_eq_zero h, h]

def buggy_ISEL_pattern : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs:= original_sdiv_srem
  rhs:= combined_sdiv_srem
  correct := by
  unfold original_sdiv_srem combined_sdiv_srem
  simp_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intro x x1
  split
  case value.value.isTrue ht =>
    simp [ht]
  case value.value.isFalse hf =>
    simp
    split
    case isTrue ht =>
    simp [ht, hf]
    simp at hf
    obtain ⟨hf₁, hf₂⟩ := hf
    replace hf₂ : x ≠ intMin _ ∨ x1 ≠ -1#64 := by
    by_cases h : x = intMin _
    · exact .inr <| hf₂ h
    · exact .inl h
    simp only [mul_sdiv_cancel_of_dvd_of_ne ht hf₂, BitVec.sub_self]
    apply srem_eq_zero_of_smod ht
    case isFalse hf =>
    sorry
     -- sorry -- this case shows how the pattern is wrong in the case of an exact flag.

def original_sdiv_srem_correct := [LV| {
  ^entry (%a: i64, %b: i64):
    %0= llvm.sdiv %a, %b : i64
    %1 = llvm.srem %a, %b : i64
    llvm.return %1 : i64
  }]

def combined_sdiv_srem_correct := [LV| {
  ^entry (%a: i64, %b: i64):
    %0= llvm.sdiv %a, %b : i64
    %1 = llvm.mul %b, %0 : i64
    %2 = llvm.sub %a, %1 : i64
    llvm.return %2 : i64
  }]

theorem srem_eq_sub_sdiv (x y : BitVec w) (h1 :  ¬y = 0#_ ) (hf₂ : x ≠ intMin w ∨ y ≠ -1#w) :
   x.srem y = x - y * x.sdiv y := by
  rw [← toInt_inj]
  rw [BitVec.toInt_srem]
  rw [BitVec.toInt_sub]
  rw [BitVec.toInt_mul]
  simp
  rw [BitVec.toInt_sdiv_of_ne_or_ne x y (h:= hf₂)]
  rw [ Int.bmod_eq_of_le (by sorry) (by sorry)]
  rw [Int.tmod_def]
-- x x1 : BitVec 64
-- hf₁ : ¬x1 = 0#64
-- hf₂ : x ≠ intMin 64 ∨ x1 ≠ sorry
-- ⊢ x.srem x1 = x - x1 * x.sdiv x1


def corrected_ISEL_pattern : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs:= original_sdiv_srem_correct
  rhs:= combined_sdiv_srem_correct
  correct := by
  unfold original_sdiv_srem_correct combined_sdiv_srem_correct
  simp_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intro x x1
  split
  case value.value.isFalse hf =>
    simp at hf
    obtain ⟨hf₁, hf₂⟩ := hf
    replace hf₂ : x ≠ intMin _ ∨ x1 ≠ -1#64 := by
    by_cases h : x = intMin _
    · exact .inr <| hf₂ h
    · exact .inl h
    simp only [PoisonOr.value_isRefinedBy_value, InstCombine.bv_isRefinedBy_iff]
    --bv_decide
    sorry
    --simp [hf₁, hf₂]
  case value.value.isTrue ht =>
    simp only [PoisonOr.isRefinedBy_self]

def llvm_sub_self_ex := [LV| {
  ^entry (%x: i64 ):
    %1 = llvm.sub %x, %x : i64
    llvm.return %1 : i64
  }]

  -- simp riscv example

@[simp_denote]
def sub_riscv_self_ex := [LV| {
  ^entry (%x: i64):
    %0 = "builtin.unrealized_conversion_cast"(%x) : (i64) -> (!i64)
    %2 = sub %0, %0 : !i64
    %4 = sltu %0, %0 : !i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]



def example00 := [RV64_com| {
^bb0(%0 : !riscv.reg, %1 : !riscv.reg):
    %2 = "slt"(%0, %1) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
    %3 = "andi" (%2){imm = 1 : !i64} : (!riscv.reg) -> (!riscv.reg)
    %4 = "sra"(%0, %0) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
    %5 = "add"(%0, %0) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
    %6 = "sra"(%2, %5) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  "ret" (%0) : (!riscv.reg) -> ()
 }].denote


def example01 := [RV64_com| {
^bb0(%0 : !i64, %1 : !i64):
  --%2 = "riscv.slt"(%0, %1) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  --%2 = "riscv.andi"(%2){immediate = 1 : i12 } : (!riscv.reg) -> (!riscv.reg)
 -- %4 = "riscv.sra"(%0, %0) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
    %5 = "add"(%0, %0) : (!i64, !i64) -> (!i64)
  --%6 = "riscv.sra"(%2, %5) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  "ret" (%0) : (!i64) -> ()
 }]



def llvm_sub_lower_riscv_no_flag_self: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs := llvm_sub_self_ex
  rhs := sub_riscv_self_ex
  correct := by
  unfold llvm_sub_self_ex sub_riscv_self_ex
  simp_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  simp_riscv
  simp_peephole
  sorry


@[simp_denote]
def llvm_urem: Com  LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
  .pure (.llvm (.bitvec 64)) := [LV| {
  ^entry (%x: i64, %y: i64 ):
    %1 = llvm.urem    %x, %y : i64
    llvm.return %1 : i64
  }]
@[simp_denote]
def urem_riscv: Com  LLVMPlusRiscV ⟨[.llvm (.bitvec 64), .llvm (.bitvec 64)]⟩
  .pure (.llvm (.bitvec 64)) := [LV| {
  ^entry (%reg1: i64, %reg2: i64):
    %0 = "builtin.unrealized_conversion_cast"(%reg1) : (i64) -> (!i64)
    %1 = "builtin.unrealized_conversion_cast"(%reg2) : (i64) -> (!i64)
    %2 = remu %0, %1 : !i64
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!i64) -> (i64)
    llvm.return %3 : i64
  }]
  def llvm_urem_lower_riscv: LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] :=
  {lhs := llvm_urem, rhs := urem_riscv }


def intro_example_lhs := [LV| {
  ^entry (%arg: i64, %amount: i64):
    %0 = llvm.shl %arg, %amount : i64
    %1 = llvm.lshr %0, %amount : i64
    llvm.return %1 : i64
  }]

def intro_example_rhs := [LV| {
  ^entry (%arg: i64, %amount: i64):
    llvm.return %arg : i64
  }]

def rewrite00 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64), Ty.llvm (.bitvec 64)] where
  lhs:= [LV| {
  ^entry (%arg: i64, %amount: i64):
    %0 = llvm.shl %arg, %amount : i64
    %1 = llvm.lshr %0, %amount : i64
    llvm.return %1 : i64
  }]

  rhs:= [LV| {
  ^entry (%arg: i64, %amount: i64):
    llvm.return %arg : i64
  }]
  correct := by
  simp_lowering
  sorry
  --bv_decide

@[simp_denote]
def intro_example_correct_lhs := [LV| {
  ^entry (%arg0: i64):
    %c = llvm.mlir.constant (4) : i64
    %1 = llvm.mul %arg0, %c : i64
    llvm.return %1 : i64
  }]

@[simp_denote]
def intro_example_correct_rhs := [LV| {
  ^entry (%arg0: i64):
    %r1 = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!riscv.reg)
    %c = slli %r1, 2 : !riscv.reg
    %rd = "builtin.unrealized_conversion_cast" (%c) : (!riscv.reg) -> (i64)
    llvm.return %rd : i64
  }]

def selection00 : LLVMPeepholeRewriteRefine 64 [Ty.llvm (.bitvec 64)] where
  lhs:= [LV| {
  ^entry (%arg0: i64):
    %c = llvm.mlir.constant (4) : i64
    %1 = llvm.mul %arg0, %c : i64
    llvm.return %1 : i64
  }]
  rhs:= [LV| {
  ^entry (%arg0: i64):
    %r1 = "builtin.unrealized_conversion_cast" (%arg0) : (i64) -> (!riscv.reg)
    %c = slli %r1, 2 : !riscv.reg
    %rd = "builtin.unrealized_conversion_cast" (%c) : (!riscv.reg) -> (i64)
    llvm.return %rd : i64
  }]


/- Below are two example programs to test our instruction selector.-/
def llvm00:=
  [LV|{
  ^bb0(%X : i64, %Y : i64 ):
    %1 = llvm.add %X, %Y : i64
    %2 = llvm.sub %X, %X : i64
    %3 = llvm.add %1, %Y : i64
    %4 = llvm.add %3, %Y : i64
    %5 = llvm.add %3, %4 : i64
    llvm.return %5 : i64
  }]
def llvm01:=
  [LV|{
  ^bb0(%X : i64, %Y : i64 ):
    %1 = llvm.icmp.eq %X, %Y : i64
    %2 = llvm.sub %X, %X : i64
    llvm.return %1 : i1
  }]

def llvm02:=
  [LV|{
  ^bb0(%X : i64, %Y : i64 ):
    %1 = llvm.mlir.constant 9 : i64
    %2 = llvm.sub %X, %X : i64
    llvm.return %1 : i64
  }]
