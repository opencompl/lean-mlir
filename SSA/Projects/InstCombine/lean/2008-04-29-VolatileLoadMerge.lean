import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-04-29-VolatileLoadMerge
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main(%arg0: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @g_1 : !llvm.ptr
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.load volatile %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.cond_br %3, ^bb2(%4 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.load volatile %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.br ^bb2(%5 : i32)
  ^bb2(%6: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %6 : i32
  }]

def main_combined := [llvmfunc|
  llvm.func @main(%arg0: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @g_1 : !llvm.ptr
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.load volatile %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %3, ^bb2(%4 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.load volatile %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb2(%5 : i32)
  ^bb2(%6: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %6 : i32
  }]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
