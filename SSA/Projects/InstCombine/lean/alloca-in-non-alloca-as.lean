import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  alloca-in-non-alloca-as
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def spam_before := [llvmfunc|
  llvm.func @spam(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<30 x struct<"struct.widget", (array<8 x i8>)>> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    llvm.call @zot(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def alloca_addrspace_0_nonnull_before := [llvmfunc|
  llvm.func @alloca_addrspace_0_nonnull() -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.call @use(%2) : (!llvm.ptr) -> ()
    %3 = llvm.icmp "ne" %2, %1 : !llvm.ptr
    llvm.return %3 : i1
  }]

def alloca_addrspace_5_nonnull_before := [llvmfunc|
  llvm.func @alloca_addrspace_5_nonnull() -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr<5>
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr<5>]

    llvm.call %1(%3) : !llvm.ptr, (!llvm.ptr<5>) -> ()
    %4 = llvm.icmp "ne" %3, %2 : !llvm.ptr<5>
    llvm.return %4 : i1
  }]

def spam_combined := [llvmfunc|
  llvm.func @spam(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<0 x array<30 x struct<"struct.widget", (array<8 x i8>)>>> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_spam   : spam_before  ⊑  spam_combined := by
  unfold spam_before spam_combined
  simp_alive_peephole
  sorry
    llvm.call @zot(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_spam   : spam_before  ⊑  spam_combined := by
  unfold spam_before spam_combined
  simp_alive_peephole
  sorry
def alloca_addrspace_0_nonnull_combined := [llvmfunc|
  llvm.func @alloca_addrspace_0_nonnull() -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_alloca_addrspace_0_nonnull   : alloca_addrspace_0_nonnull_before  ⊑  alloca_addrspace_0_nonnull_combined := by
  unfold alloca_addrspace_0_nonnull_before alloca_addrspace_0_nonnull_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%2) : (!llvm.ptr) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_alloca_addrspace_0_nonnull   : alloca_addrspace_0_nonnull_before  ⊑  alloca_addrspace_0_nonnull_combined := by
  unfold alloca_addrspace_0_nonnull_before alloca_addrspace_0_nonnull_combined
  simp_alive_peephole
  sorry
def alloca_addrspace_5_nonnull_combined := [llvmfunc|
  llvm.func @alloca_addrspace_5_nonnull() -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr<5>
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr<5>]

theorem inst_combine_alloca_addrspace_5_nonnull   : alloca_addrspace_5_nonnull_before  ⊑  alloca_addrspace_5_nonnull_combined := by
  unfold alloca_addrspace_5_nonnull_before alloca_addrspace_5_nonnull_combined
  simp_alive_peephole
  sorry
    llvm.call %1(%3) : !llvm.ptr, (!llvm.ptr<5>) -> ()
    %4 = llvm.icmp "ne" %3, %2 : !llvm.ptr<5>
    llvm.return %4 : i1
  }]

theorem inst_combine_alloca_addrspace_5_nonnull   : alloca_addrspace_5_nonnull_before  ⊑  alloca_addrspace_5_nonnull_combined := by
  unfold alloca_addrspace_5_nonnull_before alloca_addrspace_5_nonnull_combined
  simp_alive_peephole
  sorry
