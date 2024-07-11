import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  invert-variable-mask-in-masked-merge-scalar
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def scalar_before := [llvmfunc|
  llvm.func @scalar(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg1  : i4
    llvm.return %4 : i4
  }]

def in_constant_varx_mone_invmask_before := [llvmfunc|
  llvm.func @in_constant_varx_mone_invmask(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg1, %0  : i4
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %0  : i4
    llvm.return %4 : i4
  }]

def in_constant_varx_6_invmask_before := [llvmfunc|
  llvm.func @in_constant_varx_6_invmask(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.xor %arg1, %0  : i4
    %3 = llvm.xor %arg0, %1  : i4
    %4 = llvm.and %3, %2  : i4
    %5 = llvm.xor %4, %1  : i4
    llvm.return %5 : i4
  }]

def in_constant_mone_vary_invmask_before := [llvmfunc|
  llvm.func @in_constant_mone_vary_invmask(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg1, %0  : i4
    %2 = llvm.xor %0, %arg0  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg0  : i4
    llvm.return %4 : i4
  }]

def in_constant_6_vary_invmask_before := [llvmfunc|
  llvm.func @in_constant_6_vary_invmask(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.xor %arg1, %0  : i4
    %3 = llvm.xor %arg0, %1  : i4
    %4 = llvm.and %3, %2  : i4
    %5 = llvm.xor %4, %arg0  : i4
    llvm.return %5 : i4
  }]

def c_1_0_0_before := [llvmfunc|
  llvm.func @c_1_0_0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg1, %arg0  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg1  : i4
    llvm.return %4 : i4
  }]

def c_0_1_0_before := [llvmfunc|
  llvm.func @c_0_1_0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg0  : i4
    llvm.return %4 : i4
  }]

def c_0_0_1_before := [llvmfunc|
  llvm.func @c_0_0_1(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg0, %0  : i4
    %2 = llvm.call @gen4() : () -> i4
    %3 = llvm.call @gen4() : () -> i4
    %4 = llvm.xor %2, %3  : i4
    %5 = llvm.and %4, %1  : i4
    %6 = llvm.xor %3, %5  : i4
    llvm.return %6 : i4
  }]

def c_1_1_0_before := [llvmfunc|
  llvm.func @c_1_1_0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg1, %arg0  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg0  : i4
    llvm.return %4 : i4
  }]

def c_1_0_1_before := [llvmfunc|
  llvm.func @c_1_0_1(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg1, %0  : i4
    %2 = llvm.call @gen4() : () -> i4
    %3 = llvm.xor %2, %arg0  : i4
    %4 = llvm.and %3, %1  : i4
    %5 = llvm.xor %2, %4  : i4
    llvm.return %5 : i4
  }]

def c_0_1_1_before := [llvmfunc|
  llvm.func @c_0_1_1(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg1, %0  : i4
    %2 = llvm.call @gen4() : () -> i4
    %3 = llvm.xor %2, %arg0  : i4
    %4 = llvm.and %3, %1  : i4
    %5 = llvm.xor %2, %4  : i4
    llvm.return %5 : i4
  }]

def c_1_1_1_before := [llvmfunc|
  llvm.func @c_1_1_1(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg0, %0  : i4
    %2 = llvm.call @gen4() : () -> i4
    %3 = llvm.call @gen4() : () -> i4
    %4 = llvm.xor %3, %2  : i4
    %5 = llvm.and %4, %1  : i4
    %6 = llvm.xor %2, %5  : i4
    llvm.return %6 : i4
  }]

def commutativity_constant_varx_6_invmask_before := [llvmfunc|
  llvm.func @commutativity_constant_varx_6_invmask(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.xor %arg1, %0  : i4
    %3 = llvm.xor %arg0, %1  : i4
    %4 = llvm.and %2, %3  : i4
    %5 = llvm.xor %4, %1  : i4
    llvm.return %5 : i4
  }]

def commutativity_constant_6_vary_invmask_before := [llvmfunc|
  llvm.func @commutativity_constant_6_vary_invmask(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.xor %arg1, %0  : i4
    %3 = llvm.xor %arg0, %1  : i4
    %4 = llvm.and %2, %3  : i4
    %5 = llvm.xor %4, %arg0  : i4
    llvm.return %5 : i4
  }]

def n_oneuse_D_is_ok_before := [llvmfunc|
  llvm.func @n_oneuse_D_is_ok(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg1  : i4
    llvm.call @use4(%2) : (i4) -> ()
    llvm.return %4 : i4
  }]

def n_oneuse_A_before := [llvmfunc|
  llvm.func @n_oneuse_A(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg1  : i4
    llvm.call @use4(%3) : (i4) -> ()
    llvm.return %4 : i4
  }]

def n_oneuse_AD_before := [llvmfunc|
  llvm.func @n_oneuse_AD(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg1  : i4
    llvm.call @use4(%2) : (i4) -> ()
    llvm.call @use4(%3) : (i4) -> ()
    llvm.return %4 : i4
  }]

def n_third_var_before := [llvmfunc|
  llvm.func @n_third_var(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg3, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg2  : i4
    llvm.return %4 : i4
  }]

def n_badxor_before := [llvmfunc|
  llvm.func @n_badxor(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg1  : i4
    llvm.return %4 : i4
  }]

def scalar_combined := [llvmfunc|
  llvm.func @scalar(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.xor %arg0, %arg1  : i4
    %1 = llvm.and %0, %arg2  : i4
    %2 = llvm.xor %1, %arg0  : i4
    llvm.return %2 : i4
  }]

theorem inst_combine_scalar   : scalar_before  ⊑  scalar_combined := by
  unfold scalar_before scalar_combined
  simp_alive_peephole
  sorry
def in_constant_varx_mone_invmask_combined := [llvmfunc|
  llvm.func @in_constant_varx_mone_invmask(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.or %arg0, %arg1  : i4
    llvm.return %0 : i4
  }]

theorem inst_combine_in_constant_varx_mone_invmask   : in_constant_varx_mone_invmask_before  ⊑  in_constant_varx_mone_invmask_combined := by
  unfold in_constant_varx_mone_invmask_before in_constant_varx_mone_invmask_combined
  simp_alive_peephole
  sorry
def in_constant_varx_6_invmask_combined := [llvmfunc|
  llvm.func @in_constant_varx_6_invmask(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.xor %arg0, %0  : i4
    %2 = llvm.and %1, %arg1  : i4
    %3 = llvm.xor %2, %arg0  : i4
    llvm.return %3 : i4
  }]

theorem inst_combine_in_constant_varx_6_invmask   : in_constant_varx_6_invmask_before  ⊑  in_constant_varx_6_invmask_combined := by
  unfold in_constant_varx_6_invmask_before in_constant_varx_6_invmask_combined
  simp_alive_peephole
  sorry
def in_constant_mone_vary_invmask_combined := [llvmfunc|
  llvm.func @in_constant_mone_vary_invmask(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg1, %0  : i4
    %2 = llvm.or %1, %arg0  : i4
    llvm.return %2 : i4
  }]

theorem inst_combine_in_constant_mone_vary_invmask   : in_constant_mone_vary_invmask_before  ⊑  in_constant_mone_vary_invmask_combined := by
  unfold in_constant_mone_vary_invmask_before in_constant_mone_vary_invmask_combined
  simp_alive_peephole
  sorry
def in_constant_6_vary_invmask_combined := [llvmfunc|
  llvm.func @in_constant_6_vary_invmask(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.xor %arg0, %0  : i4
    %2 = llvm.and %1, %arg1  : i4
    %3 = llvm.xor %2, %0  : i4
    llvm.return %3 : i4
  }]

theorem inst_combine_in_constant_6_vary_invmask   : in_constant_6_vary_invmask_before  ⊑  in_constant_6_vary_invmask_combined := by
  unfold in_constant_6_vary_invmask_before in_constant_6_vary_invmask_combined
  simp_alive_peephole
  sorry
def c_1_0_0_combined := [llvmfunc|
  llvm.func @c_1_0_0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.xor %arg1, %arg0  : i4
    %1 = llvm.and %0, %arg2  : i4
    %2 = llvm.xor %1, %arg0  : i4
    llvm.return %2 : i4
  }]

theorem inst_combine_c_1_0_0   : c_1_0_0_before  ⊑  c_1_0_0_combined := by
  unfold c_1_0_0_before c_1_0_0_combined
  simp_alive_peephole
  sorry
def c_0_1_0_combined := [llvmfunc|
  llvm.func @c_0_1_0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.xor %arg0, %arg1  : i4
    %1 = llvm.and %0, %arg2  : i4
    %2 = llvm.xor %1, %arg1  : i4
    llvm.return %2 : i4
  }]

theorem inst_combine_c_0_1_0   : c_0_1_0_before  ⊑  c_0_1_0_combined := by
  unfold c_0_1_0_before c_0_1_0_combined
  simp_alive_peephole
  sorry
def c_0_0_1_combined := [llvmfunc|
  llvm.func @c_0_0_1(%arg0: i4) -> i4 {
    %0 = llvm.call @gen4() : () -> i4
    %1 = llvm.call @gen4() : () -> i4
    %2 = llvm.xor %0, %1  : i4
    %3 = llvm.and %2, %arg0  : i4
    %4 = llvm.xor %3, %0  : i4
    llvm.return %4 : i4
  }]

theorem inst_combine_c_0_0_1   : c_0_0_1_before  ⊑  c_0_0_1_combined := by
  unfold c_0_0_1_before c_0_0_1_combined
  simp_alive_peephole
  sorry
def c_1_1_0_combined := [llvmfunc|
  llvm.func @c_1_1_0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.xor %arg1, %arg0  : i4
    %1 = llvm.and %0, %arg2  : i4
    %2 = llvm.xor %1, %arg1  : i4
    llvm.return %2 : i4
  }]

theorem inst_combine_c_1_1_0   : c_1_1_0_before  ⊑  c_1_1_0_combined := by
  unfold c_1_1_0_before c_1_1_0_combined
  simp_alive_peephole
  sorry
def c_1_0_1_combined := [llvmfunc|
  llvm.func @c_1_0_1(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.call @gen4() : () -> i4
    %1 = llvm.xor %0, %arg0  : i4
    %2 = llvm.and %1, %arg1  : i4
    %3 = llvm.xor %2, %arg0  : i4
    llvm.return %3 : i4
  }]

theorem inst_combine_c_1_0_1   : c_1_0_1_before  ⊑  c_1_0_1_combined := by
  unfold c_1_0_1_before c_1_0_1_combined
  simp_alive_peephole
  sorry
def c_0_1_1_combined := [llvmfunc|
  llvm.func @c_0_1_1(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.call @gen4() : () -> i4
    %1 = llvm.xor %0, %arg0  : i4
    %2 = llvm.and %1, %arg1  : i4
    %3 = llvm.xor %2, %arg0  : i4
    llvm.return %3 : i4
  }]

theorem inst_combine_c_0_1_1   : c_0_1_1_before  ⊑  c_0_1_1_combined := by
  unfold c_0_1_1_before c_0_1_1_combined
  simp_alive_peephole
  sorry
def c_1_1_1_combined := [llvmfunc|
  llvm.func @c_1_1_1(%arg0: i4) -> i4 {
    %0 = llvm.call @gen4() : () -> i4
    %1 = llvm.call @gen4() : () -> i4
    %2 = llvm.xor %1, %0  : i4
    %3 = llvm.and %2, %arg0  : i4
    %4 = llvm.xor %3, %1  : i4
    llvm.return %4 : i4
  }]

theorem inst_combine_c_1_1_1   : c_1_1_1_before  ⊑  c_1_1_1_combined := by
  unfold c_1_1_1_before c_1_1_1_combined
  simp_alive_peephole
  sorry
def commutativity_constant_varx_6_invmask_combined := [llvmfunc|
  llvm.func @commutativity_constant_varx_6_invmask(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.xor %arg0, %0  : i4
    %2 = llvm.and %1, %arg1  : i4
    %3 = llvm.xor %2, %arg0  : i4
    llvm.return %3 : i4
  }]

theorem inst_combine_commutativity_constant_varx_6_invmask   : commutativity_constant_varx_6_invmask_before  ⊑  commutativity_constant_varx_6_invmask_combined := by
  unfold commutativity_constant_varx_6_invmask_before commutativity_constant_varx_6_invmask_combined
  simp_alive_peephole
  sorry
def commutativity_constant_6_vary_invmask_combined := [llvmfunc|
  llvm.func @commutativity_constant_6_vary_invmask(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.xor %arg0, %0  : i4
    %2 = llvm.and %1, %arg1  : i4
    %3 = llvm.xor %2, %0  : i4
    llvm.return %3 : i4
  }]

theorem inst_combine_commutativity_constant_6_vary_invmask   : commutativity_constant_6_vary_invmask_before  ⊑  commutativity_constant_6_vary_invmask_combined := by
  unfold commutativity_constant_6_vary_invmask_before commutativity_constant_6_vary_invmask_combined
  simp_alive_peephole
  sorry
def n_oneuse_D_is_ok_combined := [llvmfunc|
  llvm.func @n_oneuse_D_is_ok(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.xor %arg0, %arg1  : i4
    %1 = llvm.and %0, %arg2  : i4
    %2 = llvm.xor %1, %arg0  : i4
    llvm.call @use4(%0) : (i4) -> ()
    llvm.return %2 : i4
  }]

theorem inst_combine_n_oneuse_D_is_ok   : n_oneuse_D_is_ok_before  ⊑  n_oneuse_D_is_ok_combined := by
  unfold n_oneuse_D_is_ok_before n_oneuse_D_is_ok_combined
  simp_alive_peephole
  sorry
def n_oneuse_A_combined := [llvmfunc|
  llvm.func @n_oneuse_A(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg1  : i4
    llvm.call @use4(%3) : (i4) -> ()
    llvm.return %4 : i4
  }]

theorem inst_combine_n_oneuse_A   : n_oneuse_A_before  ⊑  n_oneuse_A_combined := by
  unfold n_oneuse_A_before n_oneuse_A_combined
  simp_alive_peephole
  sorry
def n_oneuse_AD_combined := [llvmfunc|
  llvm.func @n_oneuse_AD(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg1  : i4
    llvm.call @use4(%2) : (i4) -> ()
    llvm.call @use4(%3) : (i4) -> ()
    llvm.return %4 : i4
  }]

theorem inst_combine_n_oneuse_AD   : n_oneuse_AD_before  ⊑  n_oneuse_AD_combined := by
  unfold n_oneuse_AD_before n_oneuse_AD_combined
  simp_alive_peephole
  sorry
def n_third_var_combined := [llvmfunc|
  llvm.func @n_third_var(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg3, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg2  : i4
    llvm.return %4 : i4
  }]

theorem inst_combine_n_third_var   : n_third_var_before  ⊑  n_third_var_combined := by
  unfold n_third_var_before n_third_var_combined
  simp_alive_peephole
  sorry
def n_badxor_combined := [llvmfunc|
  llvm.func @n_badxor(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg1  : i4
    llvm.return %4 : i4
  }]

theorem inst_combine_n_badxor   : n_badxor_before  ⊑  n_badxor_combined := by
  unfold n_badxor_before n_badxor_combined
  simp_alive_peephole
  sorry
