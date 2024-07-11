import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-divrem
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sdiv_common_divisor_before := [llvmfunc|
  llvm.func @sdiv_common_divisor(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.sdiv %arg2, %arg1  : i5
    %1 = llvm.sdiv %arg3, %arg1  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }]

def srem_common_divisor_before := [llvmfunc|
  llvm.func @srem_common_divisor(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.srem %arg2, %arg1  : i5
    %1 = llvm.srem %arg3, %arg1  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }]

def udiv_common_divisor_before := [llvmfunc|
  llvm.func @udiv_common_divisor(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.udiv %arg2, %arg1  : i5
    %1 = llvm.udiv %arg3, %arg1  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }]

def urem_common_divisor_before := [llvmfunc|
  llvm.func @urem_common_divisor(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.urem %arg2, %arg1  : i5
    %1 = llvm.urem %arg3, %arg1  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }]

def sdiv_common_dividend_before := [llvmfunc|
  llvm.func @sdiv_common_dividend(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.sdiv %arg1, %arg2  : i5
    %1 = llvm.sdiv %arg1, %arg3  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }]

def srem_common_dividend_before := [llvmfunc|
  llvm.func @srem_common_dividend(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.srem %arg1, %arg2  : i5
    %1 = llvm.srem %arg1, %arg3  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }]

def udiv_common_dividend_before := [llvmfunc|
  llvm.func @udiv_common_dividend(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.udiv %arg1, %arg2  : i5
    %1 = llvm.udiv %arg1, %arg3  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }]

def urem_common_dividend_before := [llvmfunc|
  llvm.func @urem_common_dividend(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.urem %arg1, %arg2  : i5
    %1 = llvm.urem %arg1, %arg3  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }]

def sdiv_common_divisor_defined_cond_before := [llvmfunc|
  llvm.func @sdiv_common_divisor_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.sdiv %arg2, %arg1  : i5
    %1 = llvm.sdiv %arg3, %arg1  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }]

def srem_common_divisor_defined_cond_before := [llvmfunc|
  llvm.func @srem_common_divisor_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.srem %arg2, %arg1  : i5
    %1 = llvm.srem %arg3, %arg1  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }]

def udiv_common_divisor_defined_cond_before := [llvmfunc|
  llvm.func @udiv_common_divisor_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.udiv %arg2, %arg1  : i5
    %1 = llvm.udiv %arg3, %arg1  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }]

def urem_common_divisor_defined_cond_before := [llvmfunc|
  llvm.func @urem_common_divisor_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.urem %arg2, %arg1  : i5
    %1 = llvm.urem %arg3, %arg1  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }]

def sdiv_common_dividend_defined_cond_before := [llvmfunc|
  llvm.func @sdiv_common_dividend_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.sdiv %arg1, %arg2  : i5
    %1 = llvm.sdiv %arg1, %arg3  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }]

def srem_common_dividend_defined_cond_before := [llvmfunc|
  llvm.func @srem_common_dividend_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.srem %arg1, %arg2  : i5
    %1 = llvm.srem %arg1, %arg3  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }]

def udiv_common_dividend_defined_cond_before := [llvmfunc|
  llvm.func @udiv_common_dividend_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.udiv %arg1, %arg2  : i5
    %1 = llvm.udiv %arg1, %arg3  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }]

def urem_common_dividend_defined_cond_before := [llvmfunc|
  llvm.func @urem_common_dividend_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.urem %arg1, %arg2  : i5
    %1 = llvm.urem %arg1, %arg3  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }]

def rem_euclid_1_before := [llvmfunc|
  llvm.func @rem_euclid_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.add %2, %0  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

def rem_euclid_2_before := [llvmfunc|
  llvm.func @rem_euclid_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.add %2, %0  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }]

def rem_euclid_wrong_sign_test_before := [llvmfunc|
  llvm.func @rem_euclid_wrong_sign_test(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.add %2, %0  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

def rem_euclid_add_different_const_before := [llvmfunc|
  llvm.func @rem_euclid_add_different_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.add %3, %2  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }]

def rem_euclid_wrong_operands_select_before := [llvmfunc|
  llvm.func @rem_euclid_wrong_operands_select(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.add %2, %0  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }]

def rem_euclid_vec_before := [llvmfunc|
  llvm.func @rem_euclid_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi32>
    %5 = llvm.add %3, %0  : vector<2xi32>
    %6 = llvm.select %4, %5, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def rem_euclid_i128_before := [llvmfunc|
  llvm.func @rem_euclid_i128(%arg0: i128) -> i128 {
    %0 = llvm.mlir.constant(8 : i128) : i128
    %1 = llvm.mlir.constant(0 : i128) : i128
    %2 = llvm.srem %arg0, %0  : i128
    %3 = llvm.icmp "slt" %2, %1 : i128
    %4 = llvm.add %2, %0  : i128
    %5 = llvm.select %3, %4, %2 : i1, i128
    llvm.return %5 : i128
  }]

def rem_euclid_non_const_pow2_before := [llvmfunc|
  llvm.func @rem_euclid_non_const_pow2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.srem %arg1, %2  : i8
    %4 = llvm.icmp "slt" %3, %1 : i8
    %5 = llvm.add %3, %2  : i8
    %6 = llvm.select %4, %5, %3 : i1, i8
    llvm.return %6 : i8
  }]

def rem_euclid_pow2_true_arm_folded_before := [llvmfunc|
  llvm.func @rem_euclid_pow2_true_arm_folded(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    llvm.return %5 : i32
  }]

def rem_euclid_pow2_false_arm_folded_before := [llvmfunc|
  llvm.func @rem_euclid_pow2_false_arm_folded(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.icmp "sge" %3, %1 : i32
    %5 = llvm.select %4, %3, %2 : i1, i32
    llvm.return %5 : i32
  }]

def pr89516_before := [llvmfunc|
  llvm.func @pr89516(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "slt" %arg1, %0 : i8
    %3 = llvm.shl %1, %arg0 overflow<nuw>  : i8
    %4 = llvm.srem %1, %3  : i8
    %5 = llvm.add %4, %3 overflow<nuw>  : i8
    %6 = llvm.select %2, %5, %4 : i1, i8
    llvm.return %6 : i8
  }]

def sdiv_common_divisor_combined := [llvmfunc|
  llvm.func @sdiv_common_divisor(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.freeze %arg0 : i1
    %1 = llvm.select %0, %arg3, %arg2 : i1, i5
    %2 = llvm.sdiv %1, %arg1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_sdiv_common_divisor   : sdiv_common_divisor_before  ⊑  sdiv_common_divisor_combined := by
  unfold sdiv_common_divisor_before sdiv_common_divisor_combined
  simp_alive_peephole
  sorry
def srem_common_divisor_combined := [llvmfunc|
  llvm.func @srem_common_divisor(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.freeze %arg0 : i1
    %1 = llvm.select %0, %arg3, %arg2 : i1, i5
    %2 = llvm.srem %1, %arg1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_srem_common_divisor   : srem_common_divisor_before  ⊑  srem_common_divisor_combined := by
  unfold srem_common_divisor_before srem_common_divisor_combined
  simp_alive_peephole
  sorry
def udiv_common_divisor_combined := [llvmfunc|
  llvm.func @udiv_common_divisor(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.select %arg0, %arg3, %arg2 : i1, i5
    %1 = llvm.udiv %0, %arg1  : i5
    llvm.return %1 : i5
  }]

theorem inst_combine_udiv_common_divisor   : udiv_common_divisor_before  ⊑  udiv_common_divisor_combined := by
  unfold udiv_common_divisor_before udiv_common_divisor_combined
  simp_alive_peephole
  sorry
def urem_common_divisor_combined := [llvmfunc|
  llvm.func @urem_common_divisor(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.select %arg0, %arg3, %arg2 : i1, i5
    %1 = llvm.urem %0, %arg1  : i5
    llvm.return %1 : i5
  }]

theorem inst_combine_urem_common_divisor   : urem_common_divisor_before  ⊑  urem_common_divisor_combined := by
  unfold urem_common_divisor_before urem_common_divisor_combined
  simp_alive_peephole
  sorry
def sdiv_common_dividend_combined := [llvmfunc|
  llvm.func @sdiv_common_dividend(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.freeze %arg0 : i1
    %1 = llvm.select %0, %arg3, %arg2 : i1, i5
    %2 = llvm.sdiv %arg1, %1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_sdiv_common_dividend   : sdiv_common_dividend_before  ⊑  sdiv_common_dividend_combined := by
  unfold sdiv_common_dividend_before sdiv_common_dividend_combined
  simp_alive_peephole
  sorry
def srem_common_dividend_combined := [llvmfunc|
  llvm.func @srem_common_dividend(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.freeze %arg0 : i1
    %1 = llvm.select %0, %arg3, %arg2 : i1, i5
    %2 = llvm.srem %arg1, %1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_srem_common_dividend   : srem_common_dividend_before  ⊑  srem_common_dividend_combined := by
  unfold srem_common_dividend_before srem_common_dividend_combined
  simp_alive_peephole
  sorry
def udiv_common_dividend_combined := [llvmfunc|
  llvm.func @udiv_common_dividend(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.freeze %arg0 : i1
    %1 = llvm.select %0, %arg3, %arg2 : i1, i5
    %2 = llvm.udiv %arg1, %1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_udiv_common_dividend   : udiv_common_dividend_before  ⊑  udiv_common_dividend_combined := by
  unfold udiv_common_dividend_before udiv_common_dividend_combined
  simp_alive_peephole
  sorry
def urem_common_dividend_combined := [llvmfunc|
  llvm.func @urem_common_dividend(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.freeze %arg0 : i1
    %1 = llvm.select %0, %arg3, %arg2 : i1, i5
    %2 = llvm.urem %arg1, %1  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_urem_common_dividend   : urem_common_dividend_before  ⊑  urem_common_dividend_combined := by
  unfold urem_common_dividend_before urem_common_dividend_combined
  simp_alive_peephole
  sorry
def sdiv_common_divisor_defined_cond_combined := [llvmfunc|
  llvm.func @sdiv_common_divisor_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.select %arg0, %arg3, %arg2 : i1, i5
    %1 = llvm.sdiv %0, %arg1  : i5
    llvm.return %1 : i5
  }]

theorem inst_combine_sdiv_common_divisor_defined_cond   : sdiv_common_divisor_defined_cond_before  ⊑  sdiv_common_divisor_defined_cond_combined := by
  unfold sdiv_common_divisor_defined_cond_before sdiv_common_divisor_defined_cond_combined
  simp_alive_peephole
  sorry
def srem_common_divisor_defined_cond_combined := [llvmfunc|
  llvm.func @srem_common_divisor_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.select %arg0, %arg3, %arg2 : i1, i5
    %1 = llvm.srem %0, %arg1  : i5
    llvm.return %1 : i5
  }]

theorem inst_combine_srem_common_divisor_defined_cond   : srem_common_divisor_defined_cond_before  ⊑  srem_common_divisor_defined_cond_combined := by
  unfold srem_common_divisor_defined_cond_before srem_common_divisor_defined_cond_combined
  simp_alive_peephole
  sorry
def udiv_common_divisor_defined_cond_combined := [llvmfunc|
  llvm.func @udiv_common_divisor_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.select %arg0, %arg3, %arg2 : i1, i5
    %1 = llvm.udiv %0, %arg1  : i5
    llvm.return %1 : i5
  }]

theorem inst_combine_udiv_common_divisor_defined_cond   : udiv_common_divisor_defined_cond_before  ⊑  udiv_common_divisor_defined_cond_combined := by
  unfold udiv_common_divisor_defined_cond_before udiv_common_divisor_defined_cond_combined
  simp_alive_peephole
  sorry
def urem_common_divisor_defined_cond_combined := [llvmfunc|
  llvm.func @urem_common_divisor_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.select %arg0, %arg3, %arg2 : i1, i5
    %1 = llvm.urem %0, %arg1  : i5
    llvm.return %1 : i5
  }]

theorem inst_combine_urem_common_divisor_defined_cond   : urem_common_divisor_defined_cond_before  ⊑  urem_common_divisor_defined_cond_combined := by
  unfold urem_common_divisor_defined_cond_before urem_common_divisor_defined_cond_combined
  simp_alive_peephole
  sorry
def sdiv_common_dividend_defined_cond_combined := [llvmfunc|
  llvm.func @sdiv_common_dividend_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.select %arg0, %arg3, %arg2 : i1, i5
    %1 = llvm.sdiv %arg1, %0  : i5
    llvm.return %1 : i5
  }]

theorem inst_combine_sdiv_common_dividend_defined_cond   : sdiv_common_dividend_defined_cond_before  ⊑  sdiv_common_dividend_defined_cond_combined := by
  unfold sdiv_common_dividend_defined_cond_before sdiv_common_dividend_defined_cond_combined
  simp_alive_peephole
  sorry
def srem_common_dividend_defined_cond_combined := [llvmfunc|
  llvm.func @srem_common_dividend_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.select %arg0, %arg3, %arg2 : i1, i5
    %1 = llvm.srem %arg1, %0  : i5
    llvm.return %1 : i5
  }]

theorem inst_combine_srem_common_dividend_defined_cond   : srem_common_dividend_defined_cond_before  ⊑  srem_common_dividend_defined_cond_combined := by
  unfold srem_common_dividend_defined_cond_before srem_common_dividend_defined_cond_combined
  simp_alive_peephole
  sorry
def udiv_common_dividend_defined_cond_combined := [llvmfunc|
  llvm.func @udiv_common_dividend_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.select %arg0, %arg3, %arg2 : i1, i5
    %1 = llvm.udiv %arg1, %0  : i5
    llvm.return %1 : i5
  }]

theorem inst_combine_udiv_common_dividend_defined_cond   : udiv_common_dividend_defined_cond_before  ⊑  udiv_common_dividend_defined_cond_combined := by
  unfold udiv_common_dividend_defined_cond_before udiv_common_dividend_defined_cond_combined
  simp_alive_peephole
  sorry
def urem_common_dividend_defined_cond_combined := [llvmfunc|
  llvm.func @urem_common_dividend_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.select %arg0, %arg3, %arg2 : i1, i5
    %1 = llvm.urem %arg1, %0  : i5
    llvm.return %1 : i5
  }]

theorem inst_combine_urem_common_dividend_defined_cond   : urem_common_dividend_defined_cond_before  ⊑  urem_common_dividend_defined_cond_combined := by
  unfold urem_common_dividend_defined_cond_before urem_common_dividend_defined_cond_combined
  simp_alive_peephole
  sorry
def rem_euclid_1_combined := [llvmfunc|
  llvm.func @rem_euclid_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_rem_euclid_1   : rem_euclid_1_before  ⊑  rem_euclid_1_combined := by
  unfold rem_euclid_1_before rem_euclid_1_combined
  simp_alive_peephole
  sorry
def rem_euclid_2_combined := [llvmfunc|
  llvm.func @rem_euclid_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_rem_euclid_2   : rem_euclid_2_before  ⊑  rem_euclid_2_combined := by
  unfold rem_euclid_2_before rem_euclid_2_combined
  simp_alive_peephole
  sorry
def rem_euclid_wrong_sign_test_combined := [llvmfunc|
  llvm.func @rem_euclid_wrong_sign_test(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.add %2, %0 overflow<nsw>  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_rem_euclid_wrong_sign_test   : rem_euclid_wrong_sign_test_before  ⊑  rem_euclid_wrong_sign_test_combined := by
  unfold rem_euclid_wrong_sign_test_before rem_euclid_wrong_sign_test_combined
  simp_alive_peephole
  sorry
def rem_euclid_add_different_const_combined := [llvmfunc|
  llvm.func @rem_euclid_add_different_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.add %3, %2 overflow<nsw>  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_rem_euclid_add_different_const   : rem_euclid_add_different_const_before  ⊑  rem_euclid_add_different_const_combined := by
  unfold rem_euclid_add_different_const_before rem_euclid_add_different_const_combined
  simp_alive_peephole
  sorry
def rem_euclid_wrong_operands_select_combined := [llvmfunc|
  llvm.func @rem_euclid_wrong_operands_select(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.add %2, %0 overflow<nsw>  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_rem_euclid_wrong_operands_select   : rem_euclid_wrong_operands_select_before  ⊑  rem_euclid_wrong_operands_select_combined := by
  unfold rem_euclid_wrong_operands_select_before rem_euclid_wrong_operands_select_combined
  simp_alive_peephole
  sorry
def rem_euclid_vec_combined := [llvmfunc|
  llvm.func @rem_euclid_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_rem_euclid_vec   : rem_euclid_vec_before  ⊑  rem_euclid_vec_combined := by
  unfold rem_euclid_vec_before rem_euclid_vec_combined
  simp_alive_peephole
  sorry
def rem_euclid_i128_combined := [llvmfunc|
  llvm.func @rem_euclid_i128(%arg0: i128) -> i128 {
    %0 = llvm.mlir.constant(7 : i128) : i128
    %1 = llvm.and %arg0, %0  : i128
    llvm.return %1 : i128
  }]

theorem inst_combine_rem_euclid_i128   : rem_euclid_i128_before  ⊑  rem_euclid_i128_combined := by
  unfold rem_euclid_i128_before rem_euclid_i128_combined
  simp_alive_peephole
  sorry
def rem_euclid_non_const_pow2_combined := [llvmfunc|
  llvm.func @rem_euclid_non_const_pow2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.and %2, %arg1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_rem_euclid_non_const_pow2   : rem_euclid_non_const_pow2_before  ⊑  rem_euclid_non_const_pow2_combined := by
  unfold rem_euclid_non_const_pow2_before rem_euclid_non_const_pow2_combined
  simp_alive_peephole
  sorry
def rem_euclid_pow2_true_arm_folded_combined := [llvmfunc|
  llvm.func @rem_euclid_pow2_true_arm_folded(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_rem_euclid_pow2_true_arm_folded   : rem_euclid_pow2_true_arm_folded_before  ⊑  rem_euclid_pow2_true_arm_folded_combined := by
  unfold rem_euclid_pow2_true_arm_folded_before rem_euclid_pow2_true_arm_folded_combined
  simp_alive_peephole
  sorry
def rem_euclid_pow2_false_arm_folded_combined := [llvmfunc|
  llvm.func @rem_euclid_pow2_false_arm_folded(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_rem_euclid_pow2_false_arm_folded   : rem_euclid_pow2_false_arm_folded_before  ⊑  rem_euclid_pow2_false_arm_folded_combined := by
  unfold rem_euclid_pow2_false_arm_folded_before rem_euclid_pow2_false_arm_folded_combined
  simp_alive_peephole
  sorry
def pr89516_combined := [llvmfunc|
  llvm.func @pr89516(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "slt" %arg1, %0 : i8
    %3 = llvm.shl %1, %arg0 overflow<nuw>  : i8
    %4 = llvm.srem %1, %3  : i8
    %5 = llvm.select %2, %3, %0 : i1, i8
    %6 = llvm.add %4, %5 overflow<nuw>  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_pr89516   : pr89516_before  ⊑  pr89516_combined := by
  unfold pr89516_before pr89516_combined
  simp_alive_peephole
  sorry
