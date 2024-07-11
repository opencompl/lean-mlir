import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-10-28-stacksave
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(47 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(32 : i64) : i64
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.addressof @p : !llvm.ptr
    %7 = llvm.mlir.constant(999999 : i32) : i32
    %8 = llvm.mlir.constant(0 : i8) : i8
    %9 = llvm.bitcast %0 : i32 to i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%10: i32):  // 2 preds: ^bb0, ^bb3
    %11 = llvm.intr.stacksave : !llvm.ptr
    %12 = llvm.srem %10, %1  : i32
    %13 = llvm.add %12, %2  : i32
    %14 = llvm.sub %13, %2  : i32
    %15 = llvm.zext %13 : i32 to i64
    %16 = llvm.mul %15, %3  : i64
    %17 = llvm.mul %13, %4  : i32
    %18 = llvm.zext %13 : i32 to i64
    %19 = llvm.mul %18, %3  : i64
    %20 = llvm.mul %13, %4  : i32
    %21 = llvm.alloca %20 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %22 = llvm.getelementptr %21[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %2, %22 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store volatile %21, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    %23 = llvm.add %10, %2  : i32
    %24 = llvm.icmp "sle" %23, %7 : i32
    %25 = llvm.zext %24 : i1 to i8
    %26 = llvm.icmp "ne" %25, %8 : i8
    llvm.cond_br %26, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.intr.stackrestore %11 : !llvm.ptr
    llvm.return %0 : i32
  ^bb3:  // pred: ^bb1
    llvm.intr.stackrestore %11 : !llvm.ptr
    llvm.br ^bb1(%23 : i32)
  }]

def main_combined := [llvmfunc|
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(47 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.addressof @p : !llvm.ptr
    %7 = llvm.mlir.constant(1000000 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%8: i32):  // 2 preds: ^bb0, ^bb3
    %9 = llvm.intr.stacksave : !llvm.ptr
    %10 = llvm.srem %8, %1  : i32
    %11 = llvm.shl %10, %2 overflow<nsw>  : i32
    %12 = llvm.add %11, %3 overflow<nsw>  : i32
    %13 = llvm.alloca %12 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    llvm.store %4, %13 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    llvm.store volatile %13, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    %14 = llvm.add %8, %4  : i32
    %15 = llvm.icmp "slt" %14, %7 : i32
    llvm.cond_br %15, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %0 : i32
  ^bb3:  // pred: ^bb1
    llvm.intr.stackrestore %9 : !llvm.ptr
    llvm.br ^bb1(%14 : i32)
  }]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
