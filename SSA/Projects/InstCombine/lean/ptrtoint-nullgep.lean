import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  ptrtoint-nullgep
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def constant_fold_ptrtoint_gep_zero_before := [llvmfunc|
  llvm.func @constant_fold_ptrtoint_gep_zero() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

def constant_fold_ptrtoint_gep_nonzero_before := [llvmfunc|
  llvm.func @constant_fold_ptrtoint_gep_nonzero() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i32
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    llvm.return %3 : i64
  }]

def constant_fold_ptrtoint_gep_zero_inbounds_before := [llvmfunc|
  llvm.func @constant_fold_ptrtoint_gep_zero_inbounds() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

def constant_fold_ptrtoint_gep_nonzero_inbounds_before := [llvmfunc|
  llvm.func @constant_fold_ptrtoint_gep_nonzero_inbounds() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i32
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    llvm.return %3 : i64
  }]

def constant_fold_ptrtoint_of_gep_of_nullgep_before := [llvmfunc|
  llvm.func @constant_fold_ptrtoint_of_gep_of_nullgep() {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    %4 = llvm.getelementptr %1[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %5 = llvm.ptrtoint %4 : !llvm.ptr<1> to i64
    %6 = llvm.mlir.constant(0 : i64) : i64
    llvm.call @use_i64(%3) : (i64) -> ()
    llvm.call @use_i64(%5) : (i64) -> ()
    llvm.call @use_i64(%3) : (i64) -> ()
    llvm.call @use_i64(%5) : (i64) -> ()
    llvm.call @use_i64(%3) : (i64) -> ()
    llvm.call @use_i64(%3) : (i64) -> ()
    llvm.call @use_i64(%5) : (i64) -> ()
    llvm.call @use_i64(%5) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.return
  }]

def fold_ptrtoint_nullgep_zero_before := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_zero() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.add %0, %0  : i64
    %3 = llvm.getelementptr %1[%2] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %4 = llvm.ptrtoint %3 : !llvm.ptr<1> to i64
    llvm.return %4 : i64
  }]

def fold_ptrtoint_nullgep_zero_inbounds_before := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_zero_inbounds() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.add %0, %0  : i64
    %3 = llvm.getelementptr inbounds %1[%2] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %4 = llvm.ptrtoint %3 : !llvm.ptr<1> to i64
    llvm.return %4 : i64
  }]

def fold_ptrtoint_nullgep_nonzero_before := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_nonzero() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr<1>
    %3 = llvm.add %0, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %5 = llvm.ptrtoint %4 : !llvm.ptr<1> to i64
    llvm.return %5 : i64
  }]

def fold_ptrtoint_nullgep_nonzero_inbounds_before := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_nonzero_inbounds() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr<1>
    %3 = llvm.add %0, %1  : i64
    %4 = llvm.getelementptr inbounds %2[%3] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %5 = llvm.ptrtoint %4 : !llvm.ptr<1> to i64
    llvm.return %5 : i64
  }]

def fold_ptrtoint_nullgep_variable_before := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_variable(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i64
    llvm.return %2 : i64
  }]

def fold_ptrtoint_nullgep_variable_known_nonzero_before := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_variable_known_nonzero(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.getelementptr %1[%2] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %4 = llvm.ptrtoint %3 : !llvm.ptr<1> to i64
    llvm.return %4 : i64
  }]

def fold_ptrtoint_nullgep_variable_inbounds_before := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_variable_inbounds(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.getelementptr inbounds %0[%arg0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i64
    llvm.return %2 : i64
  }]

def fold_ptrtoint_nullgep_variable_known_nonzero_inbounds_before := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_variable_known_nonzero_inbounds(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.getelementptr inbounds %1[%2] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %4 = llvm.ptrtoint %3 : !llvm.ptr<1> to i64
    llvm.return %4 : i64
  }]

def fold_ptrtoint_nullgep_variable_known_nonzero_inbounds_multiple_indices_before := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_variable_known_nonzero_inbounds_multiple_indices(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.or %arg0, %0  : i64
    %4 = llvm.getelementptr inbounds %1[%3, %2] : (!llvm.ptr<1>, i64, i32) -> !llvm.ptr<1>, !llvm.array<2 x i8>
    %5 = llvm.ptrtoint %4 : !llvm.ptr<1> to i64
    llvm.return %5 : i64
  }]

def fold_ptrtoint_nullgep_i32_variable_before := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_i32_variable(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i32
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i64
    llvm.return %2 : i64
  }]

def fold_ptrtoint_nullgep_variable_trunc_before := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_variable_trunc(%arg0: i64) -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i32
    llvm.return %2 : i32
  }]

def fold_ptrtoint_zero_nullgep_of_nonzero_inbounds_nullgep_before := [llvmfunc|
  llvm.func @fold_ptrtoint_zero_nullgep_of_nonzero_inbounds_nullgep() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr<1>
    %3 = llvm.add %0, %1  : i64
    %4 = llvm.sub %3, %0  : i64
    %5 = llvm.getelementptr inbounds %2[%3] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %6 = llvm.getelementptr %5[%4] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %7 = llvm.ptrtoint %6 : !llvm.ptr<1> to i64
    llvm.return %7 : i64
  }]

def fold_ptrtoint_nonzero_inbounds_nullgep_of_zero_noninbounds_nullgep_before := [llvmfunc|
  llvm.func @fold_ptrtoint_nonzero_inbounds_nullgep_of_zero_noninbounds_nullgep() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr<1>
    %3 = llvm.add %0, %1  : i64
    %4 = llvm.sub %3, %0  : i64
    %5 = llvm.getelementptr %2[%4] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %6 = llvm.getelementptr inbounds %5[%3] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %7 = llvm.ptrtoint %6 : !llvm.ptr<1> to i64
    llvm.return %7 : i64
  }]

def fold_ptrtoint_inbounds_nullgep_of_nonzero_inbounds_nullgep_before := [llvmfunc|
  llvm.func @fold_ptrtoint_inbounds_nullgep_of_nonzero_inbounds_nullgep() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr<1>
    %3 = llvm.add %0, %1  : i64
    %4 = llvm.sub %3, %0  : i64
    %5 = llvm.getelementptr inbounds %2[%3] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %6 = llvm.getelementptr inbounds %5[%4] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %7 = llvm.ptrtoint %6 : !llvm.ptr<1> to i64
    llvm.return %7 : i64
  }]

def fold_ptrtoint_nullgep_array_one_var_1_before := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_array_one_var_1(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.getelementptr %0[%arg0, %1] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<2 x i16>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    llvm.return %3 : i64
  }]

def fold_ptrtoint_nullgep_array_one_var_2_before := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_array_one_var_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.getelementptr %0[%1, %arg0] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<2 x i16>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    llvm.return %3 : i64
  }]

def fold_ptrtoint_nested_array_two_vars_before := [llvmfunc|
  llvm.func @fold_ptrtoint_nested_array_two_vars(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.getelementptr %0[%arg0, %arg1] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<2 x i16>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i64
    llvm.return %2 : i64
  }]

def fold_ptrtoint_nested_array_two_vars_plus_zero_before := [llvmfunc|
  llvm.func @fold_ptrtoint_nested_array_two_vars_plus_zero(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.getelementptr %0[%arg0, %arg1, %1] : (!llvm.ptr<1>, i64, i64, i64) -> !llvm.ptr<1>, !llvm.array<2 x array<2 x i16>>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    llvm.return %3 : i64
  }]

def fold_ptrtoint_nested_array_two_vars_plus_const_before := [llvmfunc|
  llvm.func @fold_ptrtoint_nested_array_two_vars_plus_const(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %0[%arg0, %arg1, %1] : (!llvm.ptr<1>, i64, i64, i64) -> !llvm.ptr<1>, !llvm.array<2 x array<2 x i16>>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    llvm.return %3 : i64
  }]

def fold_ptrtoint_nested_nullgep_array_variable_multiple_uses_before := [llvmfunc|
  llvm.func @fold_ptrtoint_nested_nullgep_array_variable_multiple_uses(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.getelementptr %0[%arg0, %arg1] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<2 x i16>
    llvm.call @use_ptr(%1) : (!llvm.ptr<1>) -> ()
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i64
    llvm.return %2 : i64
  }]

def constant_fold_ptrtoint_gep_zero_combined := [llvmfunc|
  llvm.func @constant_fold_ptrtoint_gep_zero() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_constant_fold_ptrtoint_gep_zero   : constant_fold_ptrtoint_gep_zero_before  ⊑  constant_fold_ptrtoint_gep_zero_combined := by
  unfold constant_fold_ptrtoint_gep_zero_before constant_fold_ptrtoint_gep_zero_combined
  simp_alive_peephole
  sorry
def constant_fold_ptrtoint_gep_nonzero_combined := [llvmfunc|
  llvm.func @constant_fold_ptrtoint_gep_nonzero() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i32
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_constant_fold_ptrtoint_gep_nonzero   : constant_fold_ptrtoint_gep_nonzero_before  ⊑  constant_fold_ptrtoint_gep_nonzero_combined := by
  unfold constant_fold_ptrtoint_gep_nonzero_before constant_fold_ptrtoint_gep_nonzero_combined
  simp_alive_peephole
  sorry
def constant_fold_ptrtoint_gep_zero_inbounds_combined := [llvmfunc|
  llvm.func @constant_fold_ptrtoint_gep_zero_inbounds() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_constant_fold_ptrtoint_gep_zero_inbounds   : constant_fold_ptrtoint_gep_zero_inbounds_before  ⊑  constant_fold_ptrtoint_gep_zero_inbounds_combined := by
  unfold constant_fold_ptrtoint_gep_zero_inbounds_before constant_fold_ptrtoint_gep_zero_inbounds_combined
  simp_alive_peephole
  sorry
def constant_fold_ptrtoint_gep_nonzero_inbounds_combined := [llvmfunc|
  llvm.func @constant_fold_ptrtoint_gep_nonzero_inbounds() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i32
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_constant_fold_ptrtoint_gep_nonzero_inbounds   : constant_fold_ptrtoint_gep_nonzero_inbounds_before  ⊑  constant_fold_ptrtoint_gep_nonzero_inbounds_combined := by
  unfold constant_fold_ptrtoint_gep_nonzero_inbounds_before constant_fold_ptrtoint_gep_nonzero_inbounds_combined
  simp_alive_peephole
  sorry
def constant_fold_ptrtoint_of_gep_of_nullgep_combined := [llvmfunc|
  llvm.func @constant_fold_ptrtoint_of_gep_of_nullgep() {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    %4 = llvm.getelementptr %1[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %5 = llvm.ptrtoint %4 : !llvm.ptr<1> to i64
    %6 = llvm.mlir.constant(0 : i64) : i64
    llvm.call @use_i64(%3) : (i64) -> ()
    llvm.call @use_i64(%5) : (i64) -> ()
    llvm.call @use_i64(%3) : (i64) -> ()
    llvm.call @use_i64(%5) : (i64) -> ()
    llvm.call @use_i64(%3) : (i64) -> ()
    llvm.call @use_i64(%3) : (i64) -> ()
    llvm.call @use_i64(%5) : (i64) -> ()
    llvm.call @use_i64(%5) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.call @use_i64(%6) : (i64) -> ()
    llvm.return
  }]

theorem inst_combine_constant_fold_ptrtoint_of_gep_of_nullgep   : constant_fold_ptrtoint_of_gep_of_nullgep_before  ⊑  constant_fold_ptrtoint_of_gep_of_nullgep_combined := by
  unfold constant_fold_ptrtoint_of_gep_of_nullgep_before constant_fold_ptrtoint_of_gep_of_nullgep_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_nullgep_zero_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_zero() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.add %0, %0  : i64
    %3 = llvm.getelementptr %1[%2] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %4 = llvm.ptrtoint %3 : !llvm.ptr<1> to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_fold_ptrtoint_nullgep_zero   : fold_ptrtoint_nullgep_zero_before  ⊑  fold_ptrtoint_nullgep_zero_combined := by
  unfold fold_ptrtoint_nullgep_zero_before fold_ptrtoint_nullgep_zero_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_nullgep_zero_inbounds_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_zero_inbounds() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.add %0, %0  : i64
    %3 = llvm.getelementptr inbounds %1[%2] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %4 = llvm.ptrtoint %3 : !llvm.ptr<1> to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_fold_ptrtoint_nullgep_zero_inbounds   : fold_ptrtoint_nullgep_zero_inbounds_before  ⊑  fold_ptrtoint_nullgep_zero_inbounds_combined := by
  unfold fold_ptrtoint_nullgep_zero_inbounds_before fold_ptrtoint_nullgep_zero_inbounds_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_nullgep_nonzero_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_nonzero() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr<1>
    %3 = llvm.add %0, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %5 = llvm.ptrtoint %4 : !llvm.ptr<1> to i64
    llvm.return %5 : i64
  }]

theorem inst_combine_fold_ptrtoint_nullgep_nonzero   : fold_ptrtoint_nullgep_nonzero_before  ⊑  fold_ptrtoint_nullgep_nonzero_combined := by
  unfold fold_ptrtoint_nullgep_nonzero_before fold_ptrtoint_nullgep_nonzero_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_nullgep_nonzero_inbounds_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_nonzero_inbounds() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr<1>
    %3 = llvm.add %0, %1  : i64
    %4 = llvm.getelementptr inbounds %2[%3] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %5 = llvm.ptrtoint %4 : !llvm.ptr<1> to i64
    llvm.return %5 : i64
  }]

theorem inst_combine_fold_ptrtoint_nullgep_nonzero_inbounds   : fold_ptrtoint_nullgep_nonzero_inbounds_before  ⊑  fold_ptrtoint_nullgep_nonzero_inbounds_combined := by
  unfold fold_ptrtoint_nullgep_nonzero_inbounds_before fold_ptrtoint_nullgep_nonzero_inbounds_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_nullgep_variable_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_variable(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_fold_ptrtoint_nullgep_variable   : fold_ptrtoint_nullgep_variable_before  ⊑  fold_ptrtoint_nullgep_variable_combined := by
  unfold fold_ptrtoint_nullgep_variable_before fold_ptrtoint_nullgep_variable_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_nullgep_variable_known_nonzero_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_variable_known_nonzero(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.getelementptr %1[%2] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %4 = llvm.ptrtoint %3 : !llvm.ptr<1> to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_fold_ptrtoint_nullgep_variable_known_nonzero   : fold_ptrtoint_nullgep_variable_known_nonzero_before  ⊑  fold_ptrtoint_nullgep_variable_known_nonzero_combined := by
  unfold fold_ptrtoint_nullgep_variable_known_nonzero_before fold_ptrtoint_nullgep_variable_known_nonzero_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_nullgep_variable_inbounds_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_variable_inbounds(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.getelementptr inbounds %0[%arg0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_fold_ptrtoint_nullgep_variable_inbounds   : fold_ptrtoint_nullgep_variable_inbounds_before  ⊑  fold_ptrtoint_nullgep_variable_inbounds_combined := by
  unfold fold_ptrtoint_nullgep_variable_inbounds_before fold_ptrtoint_nullgep_variable_inbounds_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_nullgep_variable_known_nonzero_inbounds_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_variable_known_nonzero_inbounds(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.getelementptr inbounds %1[%2] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %4 = llvm.ptrtoint %3 : !llvm.ptr<1> to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_fold_ptrtoint_nullgep_variable_known_nonzero_inbounds   : fold_ptrtoint_nullgep_variable_known_nonzero_inbounds_before  ⊑  fold_ptrtoint_nullgep_variable_known_nonzero_inbounds_combined := by
  unfold fold_ptrtoint_nullgep_variable_known_nonzero_inbounds_before fold_ptrtoint_nullgep_variable_known_nonzero_inbounds_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_nullgep_variable_known_nonzero_inbounds_multiple_indices_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_variable_known_nonzero_inbounds_multiple_indices(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr<1>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.or %arg0, %0  : i64
    %4 = llvm.getelementptr inbounds %1[%3, %2] : (!llvm.ptr<1>, i64, i32) -> !llvm.ptr<1>, !llvm.array<2 x i8>
    %5 = llvm.ptrtoint %4 : !llvm.ptr<1> to i64
    llvm.return %5 : i64
  }]

theorem inst_combine_fold_ptrtoint_nullgep_variable_known_nonzero_inbounds_multiple_indices   : fold_ptrtoint_nullgep_variable_known_nonzero_inbounds_multiple_indices_before  ⊑  fold_ptrtoint_nullgep_variable_known_nonzero_inbounds_multiple_indices_combined := by
  unfold fold_ptrtoint_nullgep_variable_known_nonzero_inbounds_multiple_indices_before fold_ptrtoint_nullgep_variable_known_nonzero_inbounds_multiple_indices_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_nullgep_i32_variable_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_i32_variable(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i32
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_fold_ptrtoint_nullgep_i32_variable   : fold_ptrtoint_nullgep_i32_variable_before  ⊑  fold_ptrtoint_nullgep_i32_variable_combined := by
  unfold fold_ptrtoint_nullgep_i32_variable_before fold_ptrtoint_nullgep_i32_variable_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_nullgep_variable_trunc_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_variable_trunc(%arg0: i64) -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_fold_ptrtoint_nullgep_variable_trunc   : fold_ptrtoint_nullgep_variable_trunc_before  ⊑  fold_ptrtoint_nullgep_variable_trunc_combined := by
  unfold fold_ptrtoint_nullgep_variable_trunc_before fold_ptrtoint_nullgep_variable_trunc_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_zero_nullgep_of_nonzero_inbounds_nullgep_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_zero_nullgep_of_nonzero_inbounds_nullgep() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr<1>
    %3 = llvm.add %0, %1  : i64
    %4 = llvm.sub %3, %0  : i64
    %5 = llvm.getelementptr inbounds %2[%3] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %6 = llvm.getelementptr %5[%4] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %7 = llvm.ptrtoint %6 : !llvm.ptr<1> to i64
    llvm.return %7 : i64
  }]

theorem inst_combine_fold_ptrtoint_zero_nullgep_of_nonzero_inbounds_nullgep   : fold_ptrtoint_zero_nullgep_of_nonzero_inbounds_nullgep_before  ⊑  fold_ptrtoint_zero_nullgep_of_nonzero_inbounds_nullgep_combined := by
  unfold fold_ptrtoint_zero_nullgep_of_nonzero_inbounds_nullgep_before fold_ptrtoint_zero_nullgep_of_nonzero_inbounds_nullgep_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_nonzero_inbounds_nullgep_of_zero_noninbounds_nullgep_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_nonzero_inbounds_nullgep_of_zero_noninbounds_nullgep() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr<1>
    %3 = llvm.add %0, %1  : i64
    %4 = llvm.sub %3, %0  : i64
    %5 = llvm.getelementptr %2[%4] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %6 = llvm.getelementptr inbounds %5[%3] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %7 = llvm.ptrtoint %6 : !llvm.ptr<1> to i64
    llvm.return %7 : i64
  }]

theorem inst_combine_fold_ptrtoint_nonzero_inbounds_nullgep_of_zero_noninbounds_nullgep   : fold_ptrtoint_nonzero_inbounds_nullgep_of_zero_noninbounds_nullgep_before  ⊑  fold_ptrtoint_nonzero_inbounds_nullgep_of_zero_noninbounds_nullgep_combined := by
  unfold fold_ptrtoint_nonzero_inbounds_nullgep_of_zero_noninbounds_nullgep_before fold_ptrtoint_nonzero_inbounds_nullgep_of_zero_noninbounds_nullgep_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_inbounds_nullgep_of_nonzero_inbounds_nullgep_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_inbounds_nullgep_of_nonzero_inbounds_nullgep() -> i64 {
    %0 = llvm.mlir.constant(1234 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr<1>
    %3 = llvm.add %0, %1  : i64
    %4 = llvm.sub %3, %0  : i64
    %5 = llvm.getelementptr inbounds %2[%3] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %6 = llvm.getelementptr inbounds %5[%4] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %7 = llvm.ptrtoint %6 : !llvm.ptr<1> to i64
    llvm.return %7 : i64
  }]

theorem inst_combine_fold_ptrtoint_inbounds_nullgep_of_nonzero_inbounds_nullgep   : fold_ptrtoint_inbounds_nullgep_of_nonzero_inbounds_nullgep_before  ⊑  fold_ptrtoint_inbounds_nullgep_of_nonzero_inbounds_nullgep_combined := by
  unfold fold_ptrtoint_inbounds_nullgep_of_nonzero_inbounds_nullgep_before fold_ptrtoint_inbounds_nullgep_of_nonzero_inbounds_nullgep_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_nullgep_array_one_var_1_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_array_one_var_1(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.getelementptr %0[%arg0, %1] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<2 x i16>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_fold_ptrtoint_nullgep_array_one_var_1   : fold_ptrtoint_nullgep_array_one_var_1_before  ⊑  fold_ptrtoint_nullgep_array_one_var_1_combined := by
  unfold fold_ptrtoint_nullgep_array_one_var_1_before fold_ptrtoint_nullgep_array_one_var_1_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_nullgep_array_one_var_2_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_nullgep_array_one_var_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.getelementptr %0[%1, %arg0] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<2 x i16>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_fold_ptrtoint_nullgep_array_one_var_2   : fold_ptrtoint_nullgep_array_one_var_2_before  ⊑  fold_ptrtoint_nullgep_array_one_var_2_combined := by
  unfold fold_ptrtoint_nullgep_array_one_var_2_before fold_ptrtoint_nullgep_array_one_var_2_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_nested_array_two_vars_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_nested_array_two_vars(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.getelementptr %0[%arg0, %arg1] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<2 x i16>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_fold_ptrtoint_nested_array_two_vars   : fold_ptrtoint_nested_array_two_vars_before  ⊑  fold_ptrtoint_nested_array_two_vars_combined := by
  unfold fold_ptrtoint_nested_array_two_vars_before fold_ptrtoint_nested_array_two_vars_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_nested_array_two_vars_plus_zero_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_nested_array_two_vars_plus_zero(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.getelementptr %0[%arg0, %arg1, %1] : (!llvm.ptr<1>, i64, i64, i64) -> !llvm.ptr<1>, !llvm.array<2 x array<2 x i16>>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_fold_ptrtoint_nested_array_two_vars_plus_zero   : fold_ptrtoint_nested_array_two_vars_plus_zero_before  ⊑  fold_ptrtoint_nested_array_two_vars_plus_zero_combined := by
  unfold fold_ptrtoint_nested_array_two_vars_plus_zero_before fold_ptrtoint_nested_array_two_vars_plus_zero_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_nested_array_two_vars_plus_const_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_nested_array_two_vars_plus_const(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %0[%arg0, %arg1, %1] : (!llvm.ptr<1>, i64, i64, i64) -> !llvm.ptr<1>, !llvm.array<2 x array<2 x i16>>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<1> to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_fold_ptrtoint_nested_array_two_vars_plus_const   : fold_ptrtoint_nested_array_two_vars_plus_const_before  ⊑  fold_ptrtoint_nested_array_two_vars_plus_const_combined := by
  unfold fold_ptrtoint_nested_array_two_vars_plus_const_before fold_ptrtoint_nested_array_two_vars_plus_const_combined
  simp_alive_peephole
  sorry
def fold_ptrtoint_nested_nullgep_array_variable_multiple_uses_combined := [llvmfunc|
  llvm.func @fold_ptrtoint_nested_nullgep_array_variable_multiple_uses(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.getelementptr %0[%arg0, %arg1] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<2 x i16>
    llvm.call @use_ptr(%1) : (!llvm.ptr<1>) -> ()
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_fold_ptrtoint_nested_nullgep_array_variable_multiple_uses   : fold_ptrtoint_nested_nullgep_array_variable_multiple_uses_before  ⊑  fold_ptrtoint_nested_nullgep_array_variable_multiple_uses_combined := by
  unfold fold_ptrtoint_nested_nullgep_array_variable_multiple_uses_before fold_ptrtoint_nested_nullgep_array_variable_multiple_uses_combined
  simp_alive_peephole
  sorry
