import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cttz
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def cttz_zext_zero_undef_before := [llvmfunc|
  llvm.func @cttz_zext_zero_undef(%arg0: i16) -> i32 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %1 : i32
  }]

def cttz_zext_zero_def_before := [llvmfunc|
  llvm.func @cttz_zext_zero_def(%arg0: i16) -> i32 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %1 : i32
  }]

def cttz_zext_zero_undef_extra_use_before := [llvmfunc|
  llvm.func @cttz_zext_zero_undef_extra_use(%arg0: i16) -> i32 {
    %0 = llvm.zext %arg0 : i16 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %1 : i32
  }]

def cttz_zext_zero_undef_vec_before := [llvmfunc|
  llvm.func @cttz_zext_zero_undef_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = true}> : (vector<2xi64>) -> vector<2xi64>]

    llvm.return %1 : vector<2xi64>
  }]

def cttz_zext_zero_def_vec_before := [llvmfunc|
  llvm.func @cttz_zext_zero_def_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>]

    llvm.return %1 : vector<2xi64>
  }]

def cttz_sext_zero_undef_before := [llvmfunc|
  llvm.func @cttz_sext_zero_undef(%arg0: i16) -> i32 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %1 : i32
  }]

def cttz_sext_zero_def_before := [llvmfunc|
  llvm.func @cttz_sext_zero_def(%arg0: i16) -> i32 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %1 : i32
  }]

def cttz_sext_zero_undef_extra_use_before := [llvmfunc|
  llvm.func @cttz_sext_zero_undef_extra_use(%arg0: i16) -> i32 {
    %0 = llvm.sext %arg0 : i16 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %1 : i32
  }]

def cttz_sext_zero_undef_vec_before := [llvmfunc|
  llvm.func @cttz_sext_zero_undef_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = true}> : (vector<2xi64>) -> vector<2xi64>]

    llvm.return %1 : vector<2xi64>
  }]

def cttz_sext_zero_def_vec_before := [llvmfunc|
  llvm.func @cttz_sext_zero_def_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>]

    llvm.return %1 : vector<2xi64>
  }]

def cttz_of_lowest_set_bit_before := [llvmfunc|
  llvm.func @cttz_of_lowest_set_bit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %3 : i32
  }]

def cttz_of_lowest_set_bit_commuted_before := [llvmfunc|
  llvm.func @cttz_of_lowest_set_bit_commuted(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.sub %1, %2  : i32
    %4 = llvm.and %2, %3  : i32
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %5 : i32
  }]

def cttz_of_lowest_set_bit_poison_flag_before := [llvmfunc|
  llvm.func @cttz_of_lowest_set_bit_poison_flag(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %3 : i32
  }]

def cttz_of_lowest_set_bit_vec_before := [llvmfunc|
  llvm.func @cttz_of_lowest_set_bit_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sub %1, %arg0  : vector<2xi64>
    %3 = llvm.and %2, %arg0  : vector<2xi64>
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>]

    llvm.return %4 : vector<2xi64>
  }]

def cttz_of_lowest_set_bit_vec_undef_before := [llvmfunc|
  llvm.func @cttz_of_lowest_set_bit_vec_undef(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sub %1, %arg0  : vector<2xi64>
    %3 = llvm.and %2, %arg0  : vector<2xi64>
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>]

    llvm.return %4 : vector<2xi64>
  }]

def cttz_of_lowest_set_bit_wrong_const_before := [llvmfunc|
  llvm.func @cttz_of_lowest_set_bit_wrong_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %3 : i32
  }]

def cttz_of_lowest_set_bit_wrong_operand_before := [llvmfunc|
  llvm.func @cttz_of_lowest_set_bit_wrong_operand(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %3 : i32
  }]

def cttz_of_lowest_set_bit_wrong_intrinsic_before := [llvmfunc|
  llvm.func @cttz_of_lowest_set_bit_wrong_intrinsic(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = "llvm.intr.ctlz"(%2) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %3 : i32
  }]

def cttz_of_power_of_two_before := [llvmfunc|
  llvm.func @cttz_of_power_of_two(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %0, %arg0  : i32
    %3 = llvm.add %2, %1  : i32
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %4 : i32
  }]

def cttz_of_power_of_two_zero_poison_before := [llvmfunc|
  llvm.func @cttz_of_power_of_two_zero_poison(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %0, %arg0  : i32
    %3 = llvm.add %2, %1  : i32
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %4 : i32
  }]

def cttz_of_power_of_two_wrong_intrinsic_before := [llvmfunc|
  llvm.func @cttz_of_power_of_two_wrong_intrinsic(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %0, %arg0  : i32
    %3 = llvm.add %2, %1  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %4 : i32
  }]

def cttz_of_power_of_two_wrong_constant_1_before := [llvmfunc|
  llvm.func @cttz_of_power_of_two_wrong_constant_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %0, %arg0  : i32
    %3 = llvm.add %2, %1  : i32
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %4 : i32
  }]

def cttz_of_power_of_two_wrong_constant_2_before := [llvmfunc|
  llvm.func @cttz_of_power_of_two_wrong_constant_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %3 : i32
  }]

def cttz_zext_zero_undef_combined := [llvmfunc|
  llvm.func @cttz_zext_zero_undef(%arg0: i16) -> i32 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i16) -> i16
    %1 = llvm.zext %0 : i16 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_cttz_zext_zero_undef   : cttz_zext_zero_undef_before  ⊑  cttz_zext_zero_undef_combined := by
  unfold cttz_zext_zero_undef_before cttz_zext_zero_undef_combined
  simp_alive_peephole
  sorry
def cttz_zext_zero_def_combined := [llvmfunc|
  llvm.func @cttz_zext_zero_def(%arg0: i16) -> i32 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_cttz_zext_zero_def   : cttz_zext_zero_def_before  ⊑  cttz_zext_zero_def_combined := by
  unfold cttz_zext_zero_def_before cttz_zext_zero_def_combined
  simp_alive_peephole
  sorry
def cttz_zext_zero_undef_extra_use_combined := [llvmfunc|
  llvm.func @cttz_zext_zero_undef_extra_use(%arg0: i16) -> i32 {
    %0 = llvm.zext %arg0 : i16 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_cttz_zext_zero_undef_extra_use   : cttz_zext_zero_undef_extra_use_before  ⊑  cttz_zext_zero_undef_extra_use_combined := by
  unfold cttz_zext_zero_undef_extra_use_before cttz_zext_zero_undef_extra_use_combined
  simp_alive_peephole
  sorry
def cttz_zext_zero_undef_vec_combined := [llvmfunc|
  llvm.func @cttz_zext_zero_undef_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.zext %0 : vector<2xi32> to vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

theorem inst_combine_cttz_zext_zero_undef_vec   : cttz_zext_zero_undef_vec_before  ⊑  cttz_zext_zero_undef_vec_combined := by
  unfold cttz_zext_zero_undef_vec_before cttz_zext_zero_undef_vec_combined
  simp_alive_peephole
  sorry
def cttz_zext_zero_def_vec_combined := [llvmfunc|
  llvm.func @cttz_zext_zero_def_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

theorem inst_combine_cttz_zext_zero_def_vec   : cttz_zext_zero_def_vec_before  ⊑  cttz_zext_zero_def_vec_combined := by
  unfold cttz_zext_zero_def_vec_before cttz_zext_zero_def_vec_combined
  simp_alive_peephole
  sorry
def cttz_sext_zero_undef_combined := [llvmfunc|
  llvm.func @cttz_sext_zero_undef(%arg0: i16) -> i32 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i16) -> i16
    %1 = llvm.zext %0 : i16 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_cttz_sext_zero_undef   : cttz_sext_zero_undef_before  ⊑  cttz_sext_zero_undef_combined := by
  unfold cttz_sext_zero_undef_before cttz_sext_zero_undef_combined
  simp_alive_peephole
  sorry
def cttz_sext_zero_def_combined := [llvmfunc|
  llvm.func @cttz_sext_zero_def(%arg0: i16) -> i32 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_cttz_sext_zero_def   : cttz_sext_zero_def_before  ⊑  cttz_sext_zero_def_combined := by
  unfold cttz_sext_zero_def_before cttz_sext_zero_def_combined
  simp_alive_peephole
  sorry
def cttz_sext_zero_undef_extra_use_combined := [llvmfunc|
  llvm.func @cttz_sext_zero_undef_extra_use(%arg0: i16) -> i32 {
    %0 = llvm.sext %arg0 : i16 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_cttz_sext_zero_undef_extra_use   : cttz_sext_zero_undef_extra_use_before  ⊑  cttz_sext_zero_undef_extra_use_combined := by
  unfold cttz_sext_zero_undef_extra_use_before cttz_sext_zero_undef_extra_use_combined
  simp_alive_peephole
  sorry
def cttz_sext_zero_undef_vec_combined := [llvmfunc|
  llvm.func @cttz_sext_zero_undef_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.zext %0 : vector<2xi32> to vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

theorem inst_combine_cttz_sext_zero_undef_vec   : cttz_sext_zero_undef_vec_before  ⊑  cttz_sext_zero_undef_vec_combined := by
  unfold cttz_sext_zero_undef_vec_before cttz_sext_zero_undef_vec_combined
  simp_alive_peephole
  sorry
def cttz_sext_zero_def_vec_combined := [llvmfunc|
  llvm.func @cttz_sext_zero_def_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

theorem inst_combine_cttz_sext_zero_def_vec   : cttz_sext_zero_def_vec_before  ⊑  cttz_sext_zero_def_vec_combined := by
  unfold cttz_sext_zero_def_vec_before cttz_sext_zero_def_vec_combined
  simp_alive_peephole
  sorry
def cttz_of_lowest_set_bit_combined := [llvmfunc|
  llvm.func @cttz_of_lowest_set_bit(%arg0: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_cttz_of_lowest_set_bit   : cttz_of_lowest_set_bit_before  ⊑  cttz_of_lowest_set_bit_combined := by
  unfold cttz_of_lowest_set_bit_before cttz_of_lowest_set_bit_combined
  simp_alive_peephole
  sorry
def cttz_of_lowest_set_bit_commuted_combined := [llvmfunc|
  llvm.func @cttz_of_lowest_set_bit_commuted(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_cttz_of_lowest_set_bit_commuted   : cttz_of_lowest_set_bit_commuted_before  ⊑  cttz_of_lowest_set_bit_commuted_combined := by
  unfold cttz_of_lowest_set_bit_commuted_before cttz_of_lowest_set_bit_commuted_combined
  simp_alive_peephole
  sorry
def cttz_of_lowest_set_bit_poison_flag_combined := [llvmfunc|
  llvm.func @cttz_of_lowest_set_bit_poison_flag(%arg0: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_cttz_of_lowest_set_bit_poison_flag   : cttz_of_lowest_set_bit_poison_flag_before  ⊑  cttz_of_lowest_set_bit_poison_flag_combined := by
  unfold cttz_of_lowest_set_bit_poison_flag_before cttz_of_lowest_set_bit_poison_flag_combined
  simp_alive_peephole
  sorry
def cttz_of_lowest_set_bit_vec_combined := [llvmfunc|
  llvm.func @cttz_of_lowest_set_bit_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %0 : vector<2xi64>
  }]

theorem inst_combine_cttz_of_lowest_set_bit_vec   : cttz_of_lowest_set_bit_vec_before  ⊑  cttz_of_lowest_set_bit_vec_combined := by
  unfold cttz_of_lowest_set_bit_vec_before cttz_of_lowest_set_bit_vec_combined
  simp_alive_peephole
  sorry
def cttz_of_lowest_set_bit_vec_undef_combined := [llvmfunc|
  llvm.func @cttz_of_lowest_set_bit_vec_undef(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %0 : vector<2xi64>
  }]

theorem inst_combine_cttz_of_lowest_set_bit_vec_undef   : cttz_of_lowest_set_bit_vec_undef_before  ⊑  cttz_of_lowest_set_bit_vec_undef_combined := by
  unfold cttz_of_lowest_set_bit_vec_undef_before cttz_of_lowest_set_bit_vec_undef_combined
  simp_alive_peephole
  sorry
def cttz_of_lowest_set_bit_wrong_const_combined := [llvmfunc|
  llvm.func @cttz_of_lowest_set_bit_wrong_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_cttz_of_lowest_set_bit_wrong_const   : cttz_of_lowest_set_bit_wrong_const_before  ⊑  cttz_of_lowest_set_bit_wrong_const_combined := by
  unfold cttz_of_lowest_set_bit_wrong_const_before cttz_of_lowest_set_bit_wrong_const_combined
  simp_alive_peephole
  sorry
def cttz_of_lowest_set_bit_wrong_operand_combined := [llvmfunc|
  llvm.func @cttz_of_lowest_set_bit_wrong_operand(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_cttz_of_lowest_set_bit_wrong_operand   : cttz_of_lowest_set_bit_wrong_operand_before  ⊑  cttz_of_lowest_set_bit_wrong_operand_combined := by
  unfold cttz_of_lowest_set_bit_wrong_operand_before cttz_of_lowest_set_bit_wrong_operand_combined
  simp_alive_peephole
  sorry
def cttz_of_lowest_set_bit_wrong_intrinsic_combined := [llvmfunc|
  llvm.func @cttz_of_lowest_set_bit_wrong_intrinsic(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = "llvm.intr.ctlz"(%2) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_cttz_of_lowest_set_bit_wrong_intrinsic   : cttz_of_lowest_set_bit_wrong_intrinsic_before  ⊑  cttz_of_lowest_set_bit_wrong_intrinsic_combined := by
  unfold cttz_of_lowest_set_bit_wrong_intrinsic_before cttz_of_lowest_set_bit_wrong_intrinsic_combined
  simp_alive_peephole
  sorry
def cttz_of_power_of_two_combined := [llvmfunc|
  llvm.func @cttz_of_power_of_two(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %0, %arg0  : i32
    %3 = llvm.add %2, %1  : i32
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_cttz_of_power_of_two   : cttz_of_power_of_two_before  ⊑  cttz_of_power_of_two_combined := by
  unfold cttz_of_power_of_two_before cttz_of_power_of_two_combined
  simp_alive_peephole
  sorry
def cttz_of_power_of_two_zero_poison_combined := [llvmfunc|
  llvm.func @cttz_of_power_of_two_zero_poison(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %0, %arg0  : i32
    %3 = llvm.add %2, %1  : i32
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_cttz_of_power_of_two_zero_poison   : cttz_of_power_of_two_zero_poison_before  ⊑  cttz_of_power_of_two_zero_poison_combined := by
  unfold cttz_of_power_of_two_zero_poison_before cttz_of_power_of_two_zero_poison_combined
  simp_alive_peephole
  sorry
def cttz_of_power_of_two_wrong_intrinsic_combined := [llvmfunc|
  llvm.func @cttz_of_power_of_two_wrong_intrinsic(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %0, %arg0  : i32
    %3 = llvm.add %2, %1  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_cttz_of_power_of_two_wrong_intrinsic   : cttz_of_power_of_two_wrong_intrinsic_before  ⊑  cttz_of_power_of_two_wrong_intrinsic_combined := by
  unfold cttz_of_power_of_two_wrong_intrinsic_before cttz_of_power_of_two_wrong_intrinsic_combined
  simp_alive_peephole
  sorry
def cttz_of_power_of_two_wrong_constant_1_combined := [llvmfunc|
  llvm.func @cttz_of_power_of_two_wrong_constant_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %0, %arg0  : i32
    %3 = llvm.add %2, %1 overflow<nuw>  : i32
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_cttz_of_power_of_two_wrong_constant_1   : cttz_of_power_of_two_wrong_constant_1_before  ⊑  cttz_of_power_of_two_wrong_constant_1_combined := by
  unfold cttz_of_power_of_two_wrong_constant_1_before cttz_of_power_of_two_wrong_constant_1_combined
  simp_alive_peephole
  sorry
def cttz_of_power_of_two_wrong_constant_2_combined := [llvmfunc|
  llvm.func @cttz_of_power_of_two_wrong_constant_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    %2 = llvm.add %1, %0 overflow<nsw>  : i32
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_cttz_of_power_of_two_wrong_constant_2   : cttz_of_power_of_two_wrong_constant_2_before  ⊑  cttz_of_power_of_two_wrong_constant_2_combined := by
  unfold cttz_of_power_of_two_wrong_constant_2_before cttz_of_power_of_two_wrong_constant_2_combined
  simp_alive_peephole
  sorry
