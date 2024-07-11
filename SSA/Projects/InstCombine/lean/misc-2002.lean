import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  misc-2002
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def "hang_2002-03-11"_before := [llvmfunc|
  llvm.func @"hang_2002-03-11"(%arg0: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return
  }]

def "sub_failure_2002-05-14"_before := [llvmfunc|
  llvm.func @"sub_failure_2002-05-14"(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mul %arg0, %arg1  : i32
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

def "cast_test_2002-08-02"_before := [llvmfunc|
  llvm.func @"cast_test_2002-08-02"(%arg0: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i64 to i8
    %1 = llvm.zext %0 : i8 to i64
    llvm.return %1 : i64
  }]

def "missed_const_prop_2002-12-05"_before := [llvmfunc|
  llvm.func @"missed_const_prop_2002-12-05"(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.sub %0, %1  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.add %arg0, %4  : i32
    %6 = llvm.add %2, %5  : i32
    llvm.return %6 : i32
  }]

def "hang_2002-03-11"_combined := [llvmfunc|
  llvm.func @"hang_2002-03-11"(%arg0: i32) {
    llvm.return
  }]

theorem inst_combine_"hang_2002-03-11"   : "hang_2002-03-11"_before  ⊑  "hang_2002-03-11"_combined := by
  unfold "hang_2002-03-11"_before "hang_2002-03-11"_combined
  simp_alive_peephole
  sorry
def "sub_failure_2002-05-14"_combined := [llvmfunc|
  llvm.func @"sub_failure_2002-05-14"(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mul %arg0, %arg1  : i32
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_"sub_failure_2002-05-14"   : "sub_failure_2002-05-14"_before  ⊑  "sub_failure_2002-05-14"_combined := by
  unfold "sub_failure_2002-05-14"_before "sub_failure_2002-05-14"_combined
  simp_alive_peephole
  sorry
def "cast_test_2002-08-02"_combined := [llvmfunc|
  llvm.func @"cast_test_2002-08-02"(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(255 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_"cast_test_2002-08-02"   : "cast_test_2002-08-02"_before  ⊑  "cast_test_2002-08-02"_combined := by
  unfold "cast_test_2002-08-02"_before "cast_test_2002-08-02"_combined
  simp_alive_peephole
  sorry
def "missed_const_prop_2002-12-05"_combined := [llvmfunc|
  llvm.func @"missed_const_prop_2002-12-05"(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_"missed_const_prop_2002-12-05"   : "missed_const_prop_2002-12-05"_before  ⊑  "missed_const_prop_2002-12-05"_combined := by
  unfold "missed_const_prop_2002-12-05"_before "missed_const_prop_2002-12-05"_combined
  simp_alive_peephole
  sorry
