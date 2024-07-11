import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  urem-simplify-bug
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-5 : i32) : i32
    %1 = llvm.mlir.constant(251 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(95 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant("foo\0A\00") : !llvm.array<5 x i8>
    %6 = llvm.mlir.addressof @".str" : !llvm.ptr
    %7 = llvm.mlir.constant("bar\0A\00") : !llvm.array<5 x i8>
    %8 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %9 = llvm.call @func_11() : () -> i32
    %10 = llvm.or %9, %0  : i32
    %11 = llvm.urem %1, %10  : i32
    %12 = llvm.icmp "ne" %11, %2 : i32
    %13 = llvm.zext %12 : i1 to i32
    %14 = llvm.urem %13, %3  : i32
    %15 = llvm.and %14, %4  : i32
    %16 = llvm.icmp "eq" %15, %2 : i32
    llvm.cond_br %16, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%6 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%8 : !llvm.ptr)
  ^bb3(%17: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %18 = llvm.call @printf(%17) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    llvm.return %2 : i32
  }]

def main_combined := [llvmfunc|
  llvm.func @main() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %2 = llvm.mlir.addressof @str : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @func_11() : () -> i32
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %5 = llvm.call @puts(%2) : (!llvm.ptr) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
