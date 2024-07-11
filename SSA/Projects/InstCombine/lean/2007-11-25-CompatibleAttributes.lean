import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-11-25-CompatibleAttributes
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("%d\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : i32
    %4 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i32) -> i32
    llvm.return %3 : i32
  }]

def main_combined := [llvmfunc|
  llvm.func @main(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("%d\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : i32
    %4 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
