import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr43893
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.addressof @b : !llvm.ptr
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(-8 : i32) : i32
    llvm.intr.dbg.value #di_local_variable = %6 : i32
    %7 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %8 = llvm.add %7, %2  : i8
    llvm.store %8, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

    %9 = llvm.sext %8 : i8 to i32
    %10 = llvm.udiv %9, %3  : i32
    llvm.intr.dbg.value #di_local_variable = %10 : i32
    llvm.intr.dbg.value #di_local_variable1 = %10 : i32
    llvm.store %0, %4 {alignment = 1 : i64} : i8, !llvm.ptr]

    %11 = llvm.icmp "sgt" %9, %5 : i32
    %12 = llvm.zext %11 : i1 to i32
    llvm.return %5 : i32
  }]

def main_combined := [llvmfunc|
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.poison : i32
    llvm.intr.dbg.value #di_local_variable = %5 : i32
    %6 = llvm.mlir.constant(-8 : i32) : i32
    llvm.intr.dbg.value #di_local_variable = %6 : i32
    llvm.intr.dbg.value #di_local_variable1 = %5 : i32
    %7 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    %8 = llvm.add %7, %2  : i8
    llvm.store %8, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    llvm.store %0, %3 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i32
  }]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
