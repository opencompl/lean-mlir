import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  printf-i16
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def xform_printf_before := [llvmfunc|
  llvm.func @xform_printf(%arg0: i8, %arg1: i16) {
    %0 = llvm.mlir.constant("\01\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @s1 : !llvm.ptr
    %2 = llvm.mlir.constant("%c\00") : !llvm.array<3 x i8>
    %3 = llvm.mlir.addressof @pcnt_c : !llvm.ptr
    %4 = llvm.mlir.constant(1 : i16) : i16
    %5 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %6 = llvm.mlir.addressof @pcnt_s : !llvm.ptr
    %7 = llvm.mlir.constant("\7F\00") : !llvm.array<2 x i8>
    %8 = llvm.mlir.addressof @s7f : !llvm.ptr
    %9 = llvm.mlir.constant(127 : i16) : i16
    %10 = llvm.mlir.constant("\80\00") : !llvm.array<2 x i8>
    %11 = llvm.mlir.addressof @s80 : !llvm.ptr
    %12 = llvm.mlir.constant(128 : i16) : i16
    %13 = llvm.mlir.constant("\FF\00") : !llvm.array<2 x i8>
    %14 = llvm.mlir.addressof @sff : !llvm.ptr
    %15 = llvm.mlir.constant(255 : i16) : i16
    %16 = llvm.call @printf(%1) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr) -> i16
    %17 = llvm.call @printf(%3, %4) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, i16) -> i16
    %18 = llvm.call @printf(%6, %1) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i16
    %19 = llvm.call @printf(%8) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr) -> i16
    %20 = llvm.call @printf(%3, %9) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, i16) -> i16
    %21 = llvm.call @printf(%6, %8) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i16
    %22 = llvm.call @printf(%11) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr) -> i16
    %23 = llvm.call @printf(%3, %12) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, i16) -> i16
    %24 = llvm.call @printf(%6, %11) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i16
    %25 = llvm.call @printf(%14) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr) -> i16
    %26 = llvm.call @printf(%3, %15) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, i16) -> i16
    %27 = llvm.call @printf(%6, %14) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i16
    %28 = llvm.call @printf(%3, %arg0) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, i8) -> i16
    %29 = llvm.call @printf(%3, %arg1) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, i16) -> i16
    llvm.return
  }]

def xform_printf_combined := [llvmfunc|
  llvm.func @xform_printf(%arg0: i8, %arg1: i16) {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(127 : i16) : i16
    %2 = llvm.mlir.constant(128 : i16) : i16
    %3 = llvm.mlir.constant(255 : i16) : i16
    %4 = llvm.call @putchar(%0) : (i16) -> i16
    %5 = llvm.call @putchar(%0) : (i16) -> i16
    %6 = llvm.call @putchar(%0) : (i16) -> i16
    %7 = llvm.call @putchar(%1) : (i16) -> i16
    %8 = llvm.call @putchar(%1) : (i16) -> i16
    %9 = llvm.call @putchar(%1) : (i16) -> i16
    %10 = llvm.call @putchar(%2) : (i16) -> i16
    %11 = llvm.call @putchar(%2) : (i16) -> i16
    %12 = llvm.call @putchar(%2) : (i16) -> i16
    %13 = llvm.call @putchar(%3) : (i16) -> i16
    %14 = llvm.call @putchar(%3) : (i16) -> i16
    %15 = llvm.call @putchar(%3) : (i16) -> i16
    %16 = llvm.zext %arg0 : i8 to i16
    %17 = llvm.call @putchar(%16) : (i16) -> i16
    %18 = llvm.call @putchar(%arg1) : (i16) -> i16
    llvm.return
  }]

theorem inst_combine_xform_printf   : xform_printf_before  ⊑  xform_printf_combined := by
  unfold xform_printf_before xform_printf_combined
  simp_alive_peephole
  sorry
