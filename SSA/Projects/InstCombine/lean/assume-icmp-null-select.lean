import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  assume-icmp-null-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def example_before := [llvmfunc|
  llvm.func @example(%arg0: !llvm.ptr {llvm.dereferenceable = 24 : i64}) -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr
    %3 = llvm.select %2, %0, %arg0 : i1, !llvm.ptr
    %4 = llvm.icmp "ne" %3, %0 : !llvm.ptr
    "llvm.intr.assume"(%4) : (i1) -> ()
    llvm.return %3 : !llvm.ptr
  }]

def example2_before := [llvmfunc|
  llvm.func @example2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr
    %3 = llvm.select %2, %0, %arg0 : i1, !llvm.ptr
    %4 = llvm.icmp "ne" %3, %0 : !llvm.ptr
    "llvm.intr.assume"(%4) : (i1) -> ()
    llvm.return %3 : !llvm.ptr
  }]

def example_combined := [llvmfunc|
  llvm.func @example(%arg0: !llvm.ptr {llvm.dereferenceable = 24 : i64}) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_example   : example_before  ⊑  example_combined := by
  unfold example_before example_combined
  simp_alive_peephole
  sorry
def example2_combined := [llvmfunc|
  llvm.func @example2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr
    %3 = llvm.select %2, %0, %arg0 : i1, !llvm.ptr
    %4 = llvm.icmp "ne" %3, %0 : !llvm.ptr
    "llvm.intr.assume"(%4) : (i1) -> ()
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_example2   : example2_before  ⊑  example2_combined := by
  unfold example2_before example2_combined
  simp_alive_peephole
  sorry
