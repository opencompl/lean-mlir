import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  load-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def b_before := [llvmfunc|
  llvm.func @b(%arg0: i32) -> i32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[3, 6]> : tensor<2xi32>) : !llvm.array<2 x i32>
    %3 = llvm.mlir.addressof @a : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%0, %1] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<2 x i32>
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.select %5, %4, %3 : i1, !llvm.ptr
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %7 : i32
  }]

def b_combined := [llvmfunc|
  llvm.func @b(%arg0: i32) -> i32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_b   : b_before  ⊑  b_combined := by
  unfold b_before b_combined
  simp_alive_peephole
  sorry
