import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  srem1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def func_56_before := [llvmfunc|
  llvm.func @func_56(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i16 {llvm.signext}) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1734012817166602727 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.addressof @g_127 : !llvm.ptr
    %4 = llvm.mlir.undef : i32
    %5 = llvm.call @rshift_s_s(%arg2, %0) vararg(!llvm.func<i32 (...)>) : (i32, i32) -> i32
    %6 = llvm.sext %5 : i32 to i64
    %7 = llvm.or %1, %6  : i64
    %8 = llvm.srem %7, %2  : i64
    %9 = llvm.icmp "eq" %8, %2 : i64
    %10 = llvm.zext %9 : i1 to i32
    llvm.store %10, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %4 : i32
  }]

def func_56_combined := [llvmfunc|
  llvm.func @func_56(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i16 {llvm.signext}) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @g_127 : !llvm.ptr
    %3 = llvm.mlir.undef : i32
    %4 = llvm.call @rshift_s_s(%arg2, %0) vararg(!llvm.func<i32 (...)>) : (i32, i32) -> i32
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %3 : i32
  }]

theorem inst_combine_func_56   : func_56_before  ⊑  func_56_combined := by
  unfold func_56_before func_56_combined
  simp_alive_peephole
  sorry
