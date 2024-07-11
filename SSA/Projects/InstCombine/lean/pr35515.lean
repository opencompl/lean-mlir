import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr35515
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def func_24_before := [llvmfunc|
  llvm.func @func_24() -> i40 {
    %0 = llvm.mlir.addressof @g_49 : !llvm.ptr
    %1 = llvm.mlir.constant(-274869518337 : i40) : i40
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.addressof @g_461 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%3, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %6 = llvm.mlir.addressof @g_40 : !llvm.ptr
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.mlir.constant(23 : i40) : i40
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.mlir.constant(23 : i32) : i32
    %11 = llvm.load %0 {alignment = 2 : i64} : !llvm.ptr -> i40]

    %12 = llvm.and %11, %1  : i40
    %13 = llvm.icmp "eq" %5, %6 : !llvm.ptr
    %14 = llvm.zext %13 : i1 to i32
    %15 = llvm.icmp "sgt" %14, %7 : i32
    %16 = llvm.zext %15 : i1 to i40
    %17 = llvm.shl %16, %8  : i40
    %18 = llvm.or %12, %17  : i40
    %19 = llvm.lshr %18, %8  : i40
    %20 = llvm.trunc %19 : i40 to i32
    %21 = llvm.and %9, %20  : i32
    %22 = llvm.shl %21, %10 overflow<nsw, nuw>  : i32
    %23 = llvm.zext %22 : i32 to i40
    %24 = llvm.or %12, %23  : i40
    llvm.return %24 : i40
  }]

def func_24_combined := [llvmfunc|
  llvm.func @func_24() -> i40 {
    %0 = llvm.mlir.addressof @g_49 : !llvm.ptr
    %1 = llvm.mlir.constant(-274869518337 : i40) : i40
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.addressof @g_40 : !llvm.ptr
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.mlir.addressof @g_461 : !llvm.ptr
    %7 = llvm.getelementptr inbounds %6[%5, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %8 = llvm.icmp "eq" %7, %3 : !llvm.ptr
    %9 = llvm.icmp "ugt" %8, %2 : i1
    %10 = llvm.mlir.constant(8388608 : i40) : i40
    %11 = llvm.mlir.constant(0 : i40) : i40
    %12 = llvm.load %0 {alignment = 2 : i64} : !llvm.ptr -> i40
    %13 = llvm.and %12, %1  : i40
    %14 = llvm.select %9, %10, %11 : i1, i40
    %15 = llvm.or %13, %14  : i40
    llvm.return %15 : i40
  }]

theorem inst_combine_func_24   : func_24_before  ⊑  func_24_combined := by
  unfold func_24_before func_24_combined
  simp_alive_peephole
  sorry
