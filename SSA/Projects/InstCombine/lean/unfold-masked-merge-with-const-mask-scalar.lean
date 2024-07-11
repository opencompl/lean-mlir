import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  unfold-masked-merge-with-const-mask-scalar
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def scalar0_before := [llvmfunc|
  llvm.func @scalar0(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg1  : i4
    llvm.return %3 : i4
  }]

def scalar1_before := [llvmfunc|
  llvm.func @scalar1(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg1  : i4
    llvm.return %3 : i4
  }]

def in_constant_varx_mone_before := [llvmfunc|
  llvm.func @in_constant_varx_mone(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %0  : i4
    llvm.return %4 : i4
  }]

def in_constant_varx_14_before := [llvmfunc|
  llvm.func @in_constant_varx_14(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %0  : i4
    llvm.return %4 : i4
  }]

def in_constant_mone_vary_before := [llvmfunc|
  llvm.func @in_constant_mone_vary(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg0  : i4
    llvm.return %4 : i4
  }]

def in_constant_14_vary_before := [llvmfunc|
  llvm.func @in_constant_14_vary(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg0  : i4
    llvm.return %4 : i4
  }]

def c_1_0_0_before := [llvmfunc|
  llvm.func @c_1_0_0(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg1, %arg0  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg1  : i4
    llvm.return %3 : i4
  }]

def c_0_1_0_before := [llvmfunc|
  llvm.func @c_0_1_0(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg0  : i4
    llvm.return %3 : i4
  }]

def c_0_0_1_before := [llvmfunc|
  llvm.func @c_0_0_1() -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.call @gen4() : () -> i4
    %2 = llvm.call @gen4() : () -> i4
    %3 = llvm.xor %1, %2  : i4
    %4 = llvm.and %3, %0  : i4
    %5 = llvm.xor %2, %4  : i4
    llvm.return %5 : i4
  }]

def c_1_1_0_before := [llvmfunc|
  llvm.func @c_1_1_0(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg1, %arg0  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg0  : i4
    llvm.return %3 : i4
  }]

def c_1_0_1_before := [llvmfunc|
  llvm.func @c_1_0_1(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.call @gen4() : () -> i4
    %2 = llvm.xor %1, %arg0  : i4
    %3 = llvm.and %2, %0  : i4
    %4 = llvm.xor %1, %3  : i4
    llvm.return %4 : i4
  }]

def c_0_1_1_before := [llvmfunc|
  llvm.func @c_0_1_1(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.call @gen4() : () -> i4
    %2 = llvm.xor %1, %arg0  : i4
    %3 = llvm.and %2, %0  : i4
    %4 = llvm.xor %1, %3  : i4
    llvm.return %4 : i4
  }]

def c_1_1_1_before := [llvmfunc|
  llvm.func @c_1_1_1() -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.call @gen4() : () -> i4
    %2 = llvm.call @gen4() : () -> i4
    %3 = llvm.xor %2, %1  : i4
    %4 = llvm.and %3, %0  : i4
    %5 = llvm.xor %1, %4  : i4
    llvm.return %5 : i4
  }]

def commutativity_constant_14_vary_before := [llvmfunc|
  llvm.func @commutativity_constant_14_vary(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %arg0, %3  : i4
    llvm.return %4 : i4
  }]

def n_oneuse_D_before := [llvmfunc|
  llvm.func @n_oneuse_D(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg1  : i4
    llvm.call @use4(%1) : (i4) -> ()
    llvm.return %3 : i4
  }]

def n_oneuse_A_before := [llvmfunc|
  llvm.func @n_oneuse_A(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg1  : i4
    llvm.call @use4(%2) : (i4) -> ()
    llvm.return %3 : i4
  }]

def n_oneuse_AD_before := [llvmfunc|
  llvm.func @n_oneuse_AD(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg1  : i4
    llvm.call @use4(%1) : (i4) -> ()
    llvm.call @use4(%2) : (i4) -> ()
    llvm.return %3 : i4
  }]

def n_var_mask_before := [llvmfunc|
  llvm.func @n_var_mask(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.xor %arg0, %arg1  : i4
    %1 = llvm.and %0, %arg2  : i4
    %2 = llvm.xor %1, %arg1  : i4
    llvm.return %2 : i4
  }]

def n_third_var_before := [llvmfunc|
  llvm.func @n_third_var(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg2  : i4
    llvm.return %3 : i4
  }]

def scalar0_combined := [llvmfunc|
  llvm.func @scalar0(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.and %arg0, %0  : i4
    %3 = llvm.and %arg1, %1  : i4
    %4 = llvm.or %2, %3  : i4
    llvm.return %4 : i4
  }]

theorem inst_combine_scalar0   : scalar0_before  ⊑  scalar0_combined := by
  unfold scalar0_before scalar0_combined
  simp_alive_peephole
  sorry
def scalar1_combined := [llvmfunc|
  llvm.func @scalar1(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.and %arg0, %0  : i4
    %3 = llvm.and %arg1, %1  : i4
    %4 = llvm.or %2, %3  : i4
    llvm.return %4 : i4
  }]

theorem inst_combine_scalar1   : scalar1_before  ⊑  scalar1_combined := by
  unfold scalar1_before scalar1_combined
  simp_alive_peephole
  sorry
def in_constant_varx_mone_combined := [llvmfunc|
  llvm.func @in_constant_varx_mone(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.or %arg0, %0  : i4
    llvm.return %1 : i4
  }]

theorem inst_combine_in_constant_varx_mone   : in_constant_varx_mone_before  ⊑  in_constant_varx_mone_combined := by
  unfold in_constant_varx_mone_before in_constant_varx_mone_combined
  simp_alive_peephole
  sorry
def in_constant_varx_14_combined := [llvmfunc|
  llvm.func @in_constant_varx_14(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.or %arg0, %0  : i4
    llvm.return %1 : i4
  }]

theorem inst_combine_in_constant_varx_14   : in_constant_varx_14_before  ⊑  in_constant_varx_14_combined := by
  unfold in_constant_varx_14_before in_constant_varx_14_combined
  simp_alive_peephole
  sorry
def in_constant_mone_vary_combined := [llvmfunc|
  llvm.func @in_constant_mone_vary(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.or %arg0, %0  : i4
    llvm.return %1 : i4
  }]

theorem inst_combine_in_constant_mone_vary   : in_constant_mone_vary_before  ⊑  in_constant_mone_vary_combined := by
  unfold in_constant_mone_vary_before in_constant_mone_vary_combined
  simp_alive_peephole
  sorry
def in_constant_14_vary_combined := [llvmfunc|
  llvm.func @in_constant_14_vary(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.and %arg0, %0  : i4
    llvm.return %1 : i4
  }]

theorem inst_combine_in_constant_14_vary   : in_constant_14_vary_before  ⊑  in_constant_14_vary_combined := by
  unfold in_constant_14_vary_before in_constant_14_vary_combined
  simp_alive_peephole
  sorry
def c_1_0_0_combined := [llvmfunc|
  llvm.func @c_1_0_0(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.and %arg0, %0  : i4
    %3 = llvm.and %arg1, %1  : i4
    %4 = llvm.or %2, %3  : i4
    llvm.return %4 : i4
  }]

theorem inst_combine_c_1_0_0   : c_1_0_0_before  ⊑  c_1_0_0_combined := by
  unfold c_1_0_0_before c_1_0_0_combined
  simp_alive_peephole
  sorry
def c_0_1_0_combined := [llvmfunc|
  llvm.func @c_0_1_0(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.and %arg1, %0  : i4
    %3 = llvm.and %arg0, %1  : i4
    %4 = llvm.or %2, %3  : i4
    llvm.return %4 : i4
  }]

theorem inst_combine_c_0_1_0   : c_0_1_0_before  ⊑  c_0_1_0_combined := by
  unfold c_0_1_0_before c_0_1_0_combined
  simp_alive_peephole
  sorry
def c_0_0_1_combined := [llvmfunc|
  llvm.func @c_0_0_1() -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.call @gen4() : () -> i4
    %3 = llvm.call @gen4() : () -> i4
    %4 = llvm.and %2, %0  : i4
    %5 = llvm.and %3, %1  : i4
    %6 = llvm.or %4, %5  : i4
    llvm.return %6 : i4
  }]

theorem inst_combine_c_0_0_1   : c_0_0_1_before  ⊑  c_0_0_1_combined := by
  unfold c_0_0_1_before c_0_0_1_combined
  simp_alive_peephole
  sorry
def c_1_1_0_combined := [llvmfunc|
  llvm.func @c_1_1_0(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.and %arg1, %0  : i4
    %3 = llvm.and %arg0, %1  : i4
    %4 = llvm.or %2, %3  : i4
    llvm.return %4 : i4
  }]

theorem inst_combine_c_1_1_0   : c_1_1_0_before  ⊑  c_1_1_0_combined := by
  unfold c_1_1_0_before c_1_1_0_combined
  simp_alive_peephole
  sorry
def c_1_0_1_combined := [llvmfunc|
  llvm.func @c_1_0_1(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.call @gen4() : () -> i4
    %3 = llvm.and %arg0, %0  : i4
    %4 = llvm.and %2, %1  : i4
    %5 = llvm.or %3, %4  : i4
    llvm.return %5 : i4
  }]

theorem inst_combine_c_1_0_1   : c_1_0_1_before  ⊑  c_1_0_1_combined := by
  unfold c_1_0_1_before c_1_0_1_combined
  simp_alive_peephole
  sorry
def c_0_1_1_combined := [llvmfunc|
  llvm.func @c_0_1_1(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.call @gen4() : () -> i4
    %3 = llvm.and %arg0, %0  : i4
    %4 = llvm.and %2, %1  : i4
    %5 = llvm.or %3, %4  : i4
    llvm.return %5 : i4
  }]

theorem inst_combine_c_0_1_1   : c_0_1_1_before  ⊑  c_0_1_1_combined := by
  unfold c_0_1_1_before c_0_1_1_combined
  simp_alive_peephole
  sorry
def c_1_1_1_combined := [llvmfunc|
  llvm.func @c_1_1_1() -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.call @gen4() : () -> i4
    %3 = llvm.call @gen4() : () -> i4
    %4 = llvm.and %3, %0  : i4
    %5 = llvm.and %2, %1  : i4
    %6 = llvm.or %4, %5  : i4
    llvm.return %6 : i4
  }]

theorem inst_combine_c_1_1_1   : c_1_1_1_before  ⊑  c_1_1_1_combined := by
  unfold c_1_1_1_before c_1_1_1_combined
  simp_alive_peephole
  sorry
def commutativity_constant_14_vary_combined := [llvmfunc|
  llvm.func @commutativity_constant_14_vary(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.and %arg0, %0  : i4
    llvm.return %1 : i4
  }]

theorem inst_combine_commutativity_constant_14_vary   : commutativity_constant_14_vary_before  ⊑  commutativity_constant_14_vary_combined := by
  unfold commutativity_constant_14_vary_before commutativity_constant_14_vary_combined
  simp_alive_peephole
  sorry
def n_oneuse_D_combined := [llvmfunc|
  llvm.func @n_oneuse_D(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg1  : i4
    llvm.call @use4(%1) : (i4) -> ()
    llvm.return %3 : i4
  }]

theorem inst_combine_n_oneuse_D   : n_oneuse_D_before  ⊑  n_oneuse_D_combined := by
  unfold n_oneuse_D_before n_oneuse_D_combined
  simp_alive_peephole
  sorry
def n_oneuse_A_combined := [llvmfunc|
  llvm.func @n_oneuse_A(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg1  : i4
    llvm.call @use4(%2) : (i4) -> ()
    llvm.return %3 : i4
  }]

theorem inst_combine_n_oneuse_A   : n_oneuse_A_before  ⊑  n_oneuse_A_combined := by
  unfold n_oneuse_A_before n_oneuse_A_combined
  simp_alive_peephole
  sorry
def n_oneuse_AD_combined := [llvmfunc|
  llvm.func @n_oneuse_AD(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg1  : i4
    llvm.call @use4(%1) : (i4) -> ()
    llvm.call @use4(%2) : (i4) -> ()
    llvm.return %3 : i4
  }]

theorem inst_combine_n_oneuse_AD   : n_oneuse_AD_before  ⊑  n_oneuse_AD_combined := by
  unfold n_oneuse_AD_before n_oneuse_AD_combined
  simp_alive_peephole
  sorry
def n_var_mask_combined := [llvmfunc|
  llvm.func @n_var_mask(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.xor %arg0, %arg1  : i4
    %1 = llvm.and %0, %arg2  : i4
    %2 = llvm.xor %1, %arg1  : i4
    llvm.return %2 : i4
  }]

theorem inst_combine_n_var_mask   : n_var_mask_before  ⊑  n_var_mask_combined := by
  unfold n_var_mask_before n_var_mask_combined
  simp_alive_peephole
  sorry
def n_third_var_combined := [llvmfunc|
  llvm.func @n_third_var(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg2  : i4
    llvm.return %3 : i4
  }]

theorem inst_combine_n_third_var   : n_third_var_before  ⊑  n_third_var_combined := by
  unfold n_third_var_before n_third_var_combined
  simp_alive_peephole
  sorry
