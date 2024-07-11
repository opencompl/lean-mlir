import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-04-29-VolatileLoadDontMerge
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.addressof @g_1 : !llvm.ptr
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.icmp "slt" %0, %1 : i32
    %6 = llvm.load volatile %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.br ^bb1(%0, %6 : i32, i32)
  ^bb1(%7: i32, %8: i32):  // 2 preds: ^bb0, ^bb1
    %9 = llvm.add %8, %3  : i32
    llvm.store volatile %9, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %10 = llvm.add %7, %4  : i32
    %11 = llvm.icmp "slt" %10, %1 : i32
    %12 = llvm.load volatile %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.cond_br %11, ^bb1(%10, %12 : i32, i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %0 : i32
  }]

def main_combined := [llvmfunc|
  llvm.func @main() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @g_1 : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(10 : i32) : i32
    %5 = llvm.load volatile %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb1(%0, %5 : i32, i32)
  ^bb1(%6: i32, %7: i32):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.add %7, %2  : i32
    llvm.store volatile %8, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    %9 = llvm.add %6, %3  : i32
    %10 = llvm.icmp "slt" %9, %4 : i32
    %11 = llvm.load volatile %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %10, ^bb1(%9, %11 : i32, i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %0 : i32
  }]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
