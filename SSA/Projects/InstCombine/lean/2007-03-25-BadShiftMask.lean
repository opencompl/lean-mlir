import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-03-25-BadShiftMask
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(21 : i32) : i32
    %4 = llvm.mlir.constant(2047 : i16) : i16
    %5 = llvm.mlir.constant(0 : i8) : i8
    %6 = llvm.alloca %0 x !llvm.struct<"struct..1anon", (f64)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %6 {alignment = 8 : i64} : f64, !llvm.ptr]

    %7 = llvm.getelementptr %6[%2, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct..0anon", (i32, i32)>
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %9 = llvm.shl %8, %0  : i32
    %10 = llvm.lshr %9, %3  : i32
    %11 = llvm.trunc %10 : i32 to i16
    %12 = llvm.icmp "ne" %11, %4 : i16
    %13 = llvm.zext %12 : i1 to i8
    %14 = llvm.icmp "ne" %13, %5 : i8
    llvm.cond_br %14, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def main_combined := [llvmfunc|
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(2146435072 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.alloca %0 x !llvm.struct<"struct..1anon", (f64)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %5 {alignment = 8 : i64} : f64, !llvm.ptr]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    %6 = llvm.getelementptr inbounds %5[%2, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct..0anon", (i32, i32)>
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    %8 = llvm.and %7, %3  : i32
    %9 = llvm.icmp "eq" %8, %3 : i32
    llvm.cond_br %9, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %4 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
