import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  reassociate-nuw
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def reassoc_add_nuw_before := [llvmfunc|
  llvm.func @reassoc_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.add %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

def reassoc_sub_nuw_before := [llvmfunc|
  llvm.func @reassoc_sub_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.sub %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.sub %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

def reassoc_mul_nuw_before := [llvmfunc|
  llvm.func @reassoc_mul_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(65 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.mul %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

def no_reassoc_add_nuw_none_before := [llvmfunc|
  llvm.func @no_reassoc_add_nuw_none(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

def no_reassoc_add_none_nuw_before := [llvmfunc|
  llvm.func @no_reassoc_add_none_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

def reassoc_x2_add_nuw_before := [llvmfunc|
  llvm.func @reassoc_x2_add_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.add %arg1, %1 overflow<nuw>  : i32
    %4 = llvm.add %2, %3 overflow<nuw>  : i32
    llvm.return %4 : i32
  }]

def reassoc_x2_mul_nuw_before := [llvmfunc|
  llvm.func @reassoc_x2_mul_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.mul %arg1, %1 overflow<nuw>  : i32
    %4 = llvm.mul %2, %3 overflow<nuw>  : i32
    llvm.return %4 : i32
  }]

def reassoc_x2_sub_nuw_before := [llvmfunc|
  llvm.func @reassoc_x2_sub_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.sub %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.sub %arg1, %1 overflow<nuw>  : i32
    %4 = llvm.sub %2, %3 overflow<nuw>  : i32
    llvm.return %4 : i32
  }]

def tryFactorization_add_nuw_mul_nuw_before := [llvmfunc|
  llvm.func @tryFactorization_add_nuw_mul_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.add %1, %arg0 overflow<nuw>  : i32
    llvm.return %2 : i32
  }]

def tryFactorization_add_nuw_mul_nuw_int_max_before := [llvmfunc|
  llvm.func @tryFactorization_add_nuw_mul_nuw_int_max(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.add %1, %arg0 overflow<nuw>  : i32
    llvm.return %2 : i32
  }]

def tryFactorization_add_mul_nuw_before := [llvmfunc|
  llvm.func @tryFactorization_add_mul_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.add %1, %arg0 overflow<nuw>  : i32
    llvm.return %2 : i32
  }]

def tryFactorization_add_nuw_mul_before := [llvmfunc|
  llvm.func @tryFactorization_add_nuw_mul(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.add %1, %arg0  : i32
    llvm.return %2 : i32
  }]

def tryFactorization_add_nuw_mul_nuw_mul_nuw_var_before := [llvmfunc|
  llvm.func @tryFactorization_add_nuw_mul_nuw_mul_nuw_var(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.mul %arg0, %arg2 overflow<nuw>  : i32
    %2 = llvm.add %0, %1 overflow<nuw>  : i32
    llvm.return %2 : i32
  }]

def tryFactorization_add_nuw_mul_mul_nuw_var_before := [llvmfunc|
  llvm.func @tryFactorization_add_nuw_mul_mul_nuw_var(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1  : i32
    %1 = llvm.mul %arg0, %arg2 overflow<nuw>  : i32
    %2 = llvm.add %0, %1 overflow<nuw>  : i32
    llvm.return %2 : i32
  }]

def tryFactorization_add_nuw_mul_nuw_mul_var_before := [llvmfunc|
  llvm.func @tryFactorization_add_nuw_mul_nuw_mul_var(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.mul %arg0, %arg2  : i32
    %2 = llvm.add %0, %1 overflow<nuw>  : i32
    llvm.return %2 : i32
  }]

def tryFactorization_add_mul_nuw_mul_var_before := [llvmfunc|
  llvm.func @tryFactorization_add_mul_nuw_mul_var(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.mul %arg0, %arg2 overflow<nuw>  : i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }]

def reassoc_add_nuw_combined := [llvmfunc|
  llvm.func @reassoc_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(68 : i32) : i32
    %1 = llvm.add %arg0, %0 overflow<nuw>  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_reassoc_add_nuw   : reassoc_add_nuw_before  ⊑  reassoc_add_nuw_combined := by
  unfold reassoc_add_nuw_before reassoc_add_nuw_combined
  simp_alive_peephole
  sorry
def reassoc_sub_nuw_combined := [llvmfunc|
  llvm.func @reassoc_sub_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-68 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_reassoc_sub_nuw   : reassoc_sub_nuw_before  ⊑  reassoc_sub_nuw_combined := by
  unfold reassoc_sub_nuw_before reassoc_sub_nuw_combined
  simp_alive_peephole
  sorry
def reassoc_mul_nuw_combined := [llvmfunc|
  llvm.func @reassoc_mul_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(260 : i32) : i32
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_reassoc_mul_nuw   : reassoc_mul_nuw_before  ⊑  reassoc_mul_nuw_combined := by
  unfold reassoc_mul_nuw_before reassoc_mul_nuw_combined
  simp_alive_peephole
  sorry
def no_reassoc_add_nuw_none_combined := [llvmfunc|
  llvm.func @no_reassoc_add_nuw_none(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(68 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_no_reassoc_add_nuw_none   : no_reassoc_add_nuw_none_before  ⊑  no_reassoc_add_nuw_none_combined := by
  unfold no_reassoc_add_nuw_none_before no_reassoc_add_nuw_none_combined
  simp_alive_peephole
  sorry
def no_reassoc_add_none_nuw_combined := [llvmfunc|
  llvm.func @no_reassoc_add_none_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(68 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_no_reassoc_add_none_nuw   : no_reassoc_add_none_nuw_before  ⊑  no_reassoc_add_none_nuw_combined := by
  unfold no_reassoc_add_none_nuw_before no_reassoc_add_none_nuw_combined
  simp_alive_peephole
  sorry
def reassoc_x2_add_nuw_combined := [llvmfunc|
  llvm.func @reassoc_x2_add_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.add %arg0, %arg1 overflow<nuw>  : i32
    %2 = llvm.add %1, %0 overflow<nuw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_reassoc_x2_add_nuw   : reassoc_x2_add_nuw_before  ⊑  reassoc_x2_add_nuw_combined := by
  unfold reassoc_x2_add_nuw_before reassoc_x2_add_nuw_combined
  simp_alive_peephole
  sorry
def reassoc_x2_mul_nuw_combined := [llvmfunc|
  llvm.func @reassoc_x2_mul_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(45 : i32) : i32
    %1 = llvm.mul %arg0, %arg1  : i32
    %2 = llvm.mul %1, %0 overflow<nuw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_reassoc_x2_mul_nuw   : reassoc_x2_mul_nuw_before  ⊑  reassoc_x2_mul_nuw_combined := by
  unfold reassoc_x2_mul_nuw_before reassoc_x2_mul_nuw_combined
  simp_alive_peephole
  sorry
def reassoc_x2_sub_nuw_combined := [llvmfunc|
  llvm.func @reassoc_x2_sub_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_reassoc_x2_sub_nuw   : reassoc_x2_sub_nuw_before  ⊑  reassoc_x2_sub_nuw_combined := by
  unfold reassoc_x2_sub_nuw_before reassoc_x2_sub_nuw_combined
  simp_alive_peephole
  sorry
def tryFactorization_add_nuw_mul_nuw_combined := [llvmfunc|
  llvm.func @tryFactorization_add_nuw_mul_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_tryFactorization_add_nuw_mul_nuw   : tryFactorization_add_nuw_mul_nuw_before  ⊑  tryFactorization_add_nuw_mul_nuw_combined := by
  unfold tryFactorization_add_nuw_mul_nuw_before tryFactorization_add_nuw_mul_nuw_combined
  simp_alive_peephole
  sorry
def tryFactorization_add_nuw_mul_nuw_int_max_combined := [llvmfunc|
  llvm.func @tryFactorization_add_nuw_mul_nuw_int_max(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_tryFactorization_add_nuw_mul_nuw_int_max   : tryFactorization_add_nuw_mul_nuw_int_max_before  ⊑  tryFactorization_add_nuw_mul_nuw_int_max_combined := by
  unfold tryFactorization_add_nuw_mul_nuw_int_max_before tryFactorization_add_nuw_mul_nuw_int_max_combined
  simp_alive_peephole
  sorry
def tryFactorization_add_mul_nuw_combined := [llvmfunc|
  llvm.func @tryFactorization_add_mul_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_tryFactorization_add_mul_nuw   : tryFactorization_add_mul_nuw_before  ⊑  tryFactorization_add_mul_nuw_combined := by
  unfold tryFactorization_add_mul_nuw_before tryFactorization_add_mul_nuw_combined
  simp_alive_peephole
  sorry
def tryFactorization_add_nuw_mul_combined := [llvmfunc|
  llvm.func @tryFactorization_add_nuw_mul(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_tryFactorization_add_nuw_mul   : tryFactorization_add_nuw_mul_before  ⊑  tryFactorization_add_nuw_mul_combined := by
  unfold tryFactorization_add_nuw_mul_before tryFactorization_add_nuw_mul_combined
  simp_alive_peephole
  sorry
def tryFactorization_add_nuw_mul_nuw_mul_nuw_var_combined := [llvmfunc|
  llvm.func @tryFactorization_add_nuw_mul_nuw_mul_nuw_var(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.add %arg1, %arg2  : i32
    %1 = llvm.mul %0, %arg0 overflow<nuw>  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_tryFactorization_add_nuw_mul_nuw_mul_nuw_var   : tryFactorization_add_nuw_mul_nuw_mul_nuw_var_before  ⊑  tryFactorization_add_nuw_mul_nuw_mul_nuw_var_combined := by
  unfold tryFactorization_add_nuw_mul_nuw_mul_nuw_var_before tryFactorization_add_nuw_mul_nuw_mul_nuw_var_combined
  simp_alive_peephole
  sorry
def tryFactorization_add_nuw_mul_mul_nuw_var_combined := [llvmfunc|
  llvm.func @tryFactorization_add_nuw_mul_mul_nuw_var(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.add %arg1, %arg2  : i32
    %1 = llvm.mul %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_tryFactorization_add_nuw_mul_mul_nuw_var   : tryFactorization_add_nuw_mul_mul_nuw_var_before  ⊑  tryFactorization_add_nuw_mul_mul_nuw_var_combined := by
  unfold tryFactorization_add_nuw_mul_mul_nuw_var_before tryFactorization_add_nuw_mul_mul_nuw_var_combined
  simp_alive_peephole
  sorry
def tryFactorization_add_nuw_mul_nuw_mul_var_combined := [llvmfunc|
  llvm.func @tryFactorization_add_nuw_mul_nuw_mul_var(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.add %arg1, %arg2  : i32
    %1 = llvm.mul %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_tryFactorization_add_nuw_mul_nuw_mul_var   : tryFactorization_add_nuw_mul_nuw_mul_var_before  ⊑  tryFactorization_add_nuw_mul_nuw_mul_var_combined := by
  unfold tryFactorization_add_nuw_mul_nuw_mul_var_before tryFactorization_add_nuw_mul_nuw_mul_var_combined
  simp_alive_peephole
  sorry
def tryFactorization_add_mul_nuw_mul_var_combined := [llvmfunc|
  llvm.func @tryFactorization_add_mul_nuw_mul_var(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.add %arg1, %arg2  : i32
    %1 = llvm.mul %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_tryFactorization_add_mul_nuw_mul_var   : tryFactorization_add_mul_nuw_mul_var_before  ⊑  tryFactorization_add_mul_nuw_mul_var_combined := by
  unfold tryFactorization_add_mul_nuw_mul_var_before tryFactorization_add_mul_nuw_mul_var_combined
  simp_alive_peephole
  sorry
