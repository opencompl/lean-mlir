import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-06-24-StackRestore
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.addressof @p : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1000 : i32) : i32
    %6 = llvm.mlir.constant(999999 : i32) : i32
    %7 = llvm.intr.stacksave : !llvm.ptr
    %8 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %8 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store volatile %8, %3 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.br ^bb2(%4, %7 : i32, !llvm.ptr)
  ^bb1:  // pred: ^bb2
    llvm.return %4 : i32
  ^bb2(%9: i32, %10: !llvm.ptr):  // 2 preds: ^bb0, ^bb2
    %11 = llvm.add %9, %0  : i32
    llvm.intr.stackrestore %10 : !llvm.ptr
    %12 = llvm.intr.stacksave : !llvm.ptr
    %13 = llvm.srem %11, %5  : i32
    %14 = llvm.add %13, %0  : i32
    %15 = llvm.alloca %14 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %0, %15 {alignment = 4 : i64} : i32, !llvm.ptr]

    %16 = llvm.getelementptr %15[%13] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %1, %16 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store volatile %15, %3 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    %17 = llvm.icmp "eq" %11, %6 : i32
    llvm.cond_br %17, ^bb1, ^bb2(%11, %12 : i32, !llvm.ptr)
  }]

def main_combined := [llvmfunc|
  llvm.func @main() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.addressof @p : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1000 : i32) : i32
    %6 = llvm.mlir.constant(999999 : i32) : i32
    %7 = llvm.intr.stacksave : !llvm.ptr
    %8 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store volatile %8, %3 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.br ^bb2(%4, %7 : i32, !llvm.ptr)
  ^bb1:  // pred: ^bb2
    llvm.return %4 : i32
  ^bb2(%9: i32, %10: !llvm.ptr):  // 2 preds: ^bb0, ^bb2
    %11 = llvm.add %9, %0  : i32
    llvm.intr.stackrestore %10 : !llvm.ptr
    %12 = llvm.intr.stacksave : !llvm.ptr
    %13 = llvm.srem %11, %5  : i32
    %14 = llvm.add %13, %0 overflow<nsw>  : i32
    %15 = llvm.alloca %14 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %0, %15 {alignment = 4 : i64} : i32, !llvm.ptr
    %16 = llvm.getelementptr %15[%13] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %1, %16 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store volatile %15, %3 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    %17 = llvm.icmp "eq" %11, %6 : i32
    llvm.cond_br %17, ^bb1, ^bb2(%11, %12 : i32, !llvm.ptr)
  }]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
