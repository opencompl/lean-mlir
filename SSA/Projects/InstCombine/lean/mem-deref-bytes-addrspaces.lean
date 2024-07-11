import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  mem-deref-bytes-addrspaces
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def memcmp_const_size_update_deref_before := [llvmfunc|
  llvm.func @memcmp_const_size_update_deref(%arg0: !llvm.ptr<1> {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr<1> {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr<1>, !llvm.ptr<1>, i64) -> i32
    llvm.return %1 : i32
  }]

def memcmp_nonconst_size_nonnnull_before := [llvmfunc|
  llvm.func @memcmp_nonconst_size_nonnnull(%arg0: !llvm.ptr<1> {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr<1> {llvm.nocapture, llvm.readonly}, %arg2: i64) -> i32 {
    %0 = llvm.call @memcmp(%arg0, %arg1, %arg2) : (!llvm.ptr<1>, !llvm.ptr<1>, i64) -> i32
    llvm.return %0 : i32
  }]

def memcmp_const_size_update_deref_combined := [llvmfunc|
  llvm.func @memcmp_const_size_update_deref(%arg0: !llvm.ptr<1> {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr<1> {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr<1>, !llvm.ptr<1>, i64) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_memcmp_const_size_update_deref   : memcmp_const_size_update_deref_before  ⊑  memcmp_const_size_update_deref_combined := by
  unfold memcmp_const_size_update_deref_before memcmp_const_size_update_deref_combined
  simp_alive_peephole
  sorry
def memcmp_nonconst_size_nonnnull_combined := [llvmfunc|
  llvm.func @memcmp_nonconst_size_nonnnull(%arg0: !llvm.ptr<1> {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr<1> {llvm.nocapture, llvm.readonly}, %arg2: i64) -> i32 {
    %0 = llvm.call @memcmp(%arg0, %arg1, %arg2) : (!llvm.ptr<1>, !llvm.ptr<1>, i64) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_memcmp_nonconst_size_nonnnull   : memcmp_nonconst_size_nonnnull_before  ⊑  memcmp_nonconst_size_nonnnull_combined := by
  unfold memcmp_nonconst_size_nonnnull_before memcmp_nonconst_size_nonnnull_combined
  simp_alive_peephole
  sorry
