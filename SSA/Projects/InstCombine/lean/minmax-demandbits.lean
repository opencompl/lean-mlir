import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  minmax-demandbits
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def and_umax_less_before := [llvmfunc|
  llvm.func @and_umax_less(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(-32 : i32) : i32
    %2 = llvm.icmp "ugt" %0, %arg0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def and_umax_muchless_before := [llvmfunc|
  llvm.func @and_umax_muchless(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-32 : i32) : i32
    %2 = llvm.icmp "ugt" %0, %arg0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def and_umax_more_before := [llvmfunc|
  llvm.func @and_umax_more(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-32 : i32) : i32
    %2 = llvm.icmp "ugt" %0, %arg0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def shr_umax_before := [llvmfunc|
  llvm.func @shr_umax(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.icmp "ugt" %0, %arg0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }]

def t_0_1_before := [llvmfunc|
  llvm.func @t_0_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def t_0_10_before := [llvmfunc|
  llvm.func @t_0_10(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def t_1_10_before := [llvmfunc|
  llvm.func @t_1_10(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def t_2_4_before := [llvmfunc|
  llvm.func @t_2_4(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def t_2_192_before := [llvmfunc|
  llvm.func @t_2_192(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def t_2_63_or_before := [llvmfunc|
  llvm.func @t_2_63_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.or %3, %1  : i8
    llvm.return %4 : i8
  }]

def f_1_1_before := [llvmfunc|
  llvm.func @f_1_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    %2 = llvm.select %1, %arg0, %0 : i1, i8
    %3 = llvm.and %2, %0  : i8
    llvm.return %3 : i8
  }]

def f_32_32_before := [llvmfunc|
  llvm.func @f_32_32(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def f_191_192_before := [llvmfunc|
  llvm.func @f_191_192(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-65 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def f_10_1_before := [llvmfunc|
  llvm.func @f_10_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def and_umin_before := [llvmfunc|
  llvm.func @and_umin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(-32 : i32) : i32
    %2 = llvm.icmp "ult" %0, %arg0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def or_umin_before := [llvmfunc|
  llvm.func @or_umin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "ult" %0, %arg0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }]

def or_min_31_30_before := [llvmfunc|
  llvm.func @or_min_31_30(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-30 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.icmp "ult" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.or %3, %1  : i8
    llvm.return %4 : i8
  }]

def and_min_7_7_before := [llvmfunc|
  llvm.func @and_min_7_7(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-7 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.icmp "ult" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def and_min_7_8_before := [llvmfunc|
  llvm.func @and_min_7_8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    %2 = llvm.select %1, %arg0, %0 : i1, i8
    %3 = llvm.and %2, %0  : i8
    llvm.return %3 : i8
  }]

def and_min_7_9_before := [llvmfunc|
  llvm.func @and_min_7_9(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-9 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.icmp "ult" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def and_umax_less_combined := [llvmfunc|
  llvm.func @and_umax_less(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-32 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_and_umax_less   : and_umax_less_before  ⊑  and_umax_less_combined := by
  unfold and_umax_less_before and_umax_less_combined
  simp_alive_peephole
  sorry
def and_umax_muchless_combined := [llvmfunc|
  llvm.func @and_umax_muchless(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-32 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_and_umax_muchless   : and_umax_muchless_before  ⊑  and_umax_muchless_combined := by
  unfold and_umax_muchless_before and_umax_muchless_combined
  simp_alive_peephole
  sorry
def and_umax_more_combined := [llvmfunc|
  llvm.func @and_umax_more(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-32 : i32) : i32
    %2 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_umax_more   : and_umax_more_before  ⊑  and_umax_more_combined := by
  unfold and_umax_more_before and_umax_more_combined
  simp_alive_peephole
  sorry
def shr_umax_combined := [llvmfunc|
  llvm.func @shr_umax(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_shr_umax   : shr_umax_before  ⊑  shr_umax_combined := by
  unfold shr_umax_before shr_umax_combined
  simp_alive_peephole
  sorry
def t_0_1_combined := [llvmfunc|
  llvm.func @t_0_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t_0_1   : t_0_1_before  ⊑  t_0_1_combined := by
  unfold t_0_1_before t_0_1_combined
  simp_alive_peephole
  sorry
def t_0_10_combined := [llvmfunc|
  llvm.func @t_0_10(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t_0_10   : t_0_10_before  ⊑  t_0_10_combined := by
  unfold t_0_10_before t_0_10_combined
  simp_alive_peephole
  sorry
def t_1_10_combined := [llvmfunc|
  llvm.func @t_1_10(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t_1_10   : t_1_10_before  ⊑  t_1_10_combined := by
  unfold t_1_10_before t_1_10_combined
  simp_alive_peephole
  sorry
def t_2_4_combined := [llvmfunc|
  llvm.func @t_2_4(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t_2_4   : t_2_4_before  ⊑  t_2_4_combined := by
  unfold t_2_4_before t_2_4_combined
  simp_alive_peephole
  sorry
def t_2_192_combined := [llvmfunc|
  llvm.func @t_2_192(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t_2_192   : t_2_192_before  ⊑  t_2_192_combined := by
  unfold t_2_192_before t_2_192_combined
  simp_alive_peephole
  sorry
def t_2_63_or_combined := [llvmfunc|
  llvm.func @t_2_63_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t_2_63_or   : t_2_63_or_before  ⊑  t_2_63_or_combined := by
  unfold t_2_63_or_before t_2_63_or_combined
  simp_alive_peephole
  sorry
def f_1_1_combined := [llvmfunc|
  llvm.func @f_1_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    %2 = llvm.and %1, %0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_f_1_1   : f_1_1_before  ⊑  f_1_1_combined := by
  unfold f_1_1_before f_1_1_combined
  simp_alive_peephole
  sorry
def f_32_32_combined := [llvmfunc|
  llvm.func @f_32_32(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_f_32_32   : f_32_32_before  ⊑  f_32_32_combined := by
  unfold f_32_32_before f_32_32_combined
  simp_alive_peephole
  sorry
def f_191_192_combined := [llvmfunc|
  llvm.func @f_191_192(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-65 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_f_191_192   : f_191_192_before  ⊑  f_191_192_combined := by
  unfold f_191_192_before f_191_192_combined
  simp_alive_peephole
  sorry
def f_10_1_combined := [llvmfunc|
  llvm.func @f_10_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_f_10_1   : f_10_1_before  ⊑  f_10_1_combined := by
  unfold f_10_1_before f_10_1_combined
  simp_alive_peephole
  sorry
def and_umin_combined := [llvmfunc|
  llvm.func @and_umin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_and_umin   : and_umin_before  ⊑  and_umin_combined := by
  unfold and_umin_before and_umin_combined
  simp_alive_peephole
  sorry
def or_umin_combined := [llvmfunc|
  llvm.func @or_umin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_or_umin   : or_umin_before  ⊑  or_umin_combined := by
  unfold or_umin_before or_umin_combined
  simp_alive_peephole
  sorry
def or_min_31_30_combined := [llvmfunc|
  llvm.func @or_min_31_30(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_or_min_31_30   : or_min_31_30_before  ⊑  or_min_31_30_combined := by
  unfold or_min_31_30_before or_min_31_30_combined
  simp_alive_peephole
  sorry
def and_min_7_7_combined := [llvmfunc|
  llvm.func @and_min_7_7(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_and_min_7_7   : and_min_7_7_before  ⊑  and_min_7_7_combined := by
  unfold and_min_7_7_before and_min_7_7_combined
  simp_alive_peephole
  sorry
def and_min_7_8_combined := [llvmfunc|
  llvm.func @and_min_7_8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_and_min_7_8   : and_min_7_8_before  ⊑  and_min_7_8_combined := by
  unfold and_min_7_8_before and_min_7_8_combined
  simp_alive_peephole
  sorry
def and_min_7_9_combined := [llvmfunc|
  llvm.func @and_min_7_9(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-9 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.intr.umin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_and_min_7_9   : and_min_7_9_before  ⊑  and_min_7_9_combined := by
  unfold and_min_7_9_before and_min_7_9_combined
  simp_alive_peephole
  sorry
