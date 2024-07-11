import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vararg
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def func_before := [llvmfunc|
  llvm.func @func(%arg0: !llvm.ptr {llvm.nocapture, llvm.readnone}, ...) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x !llvm.struct<"struct.__va_list", (ptr, ptr, ptr, i32, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.alloca %0 x !llvm.struct<"struct.__va_list", (ptr, ptr, ptr, i32, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.lifetime.start 32, %2 : !llvm.ptr
    llvm.intr.vastart %2 : !llvm.ptr
    llvm.intr.lifetime.start 32, %3 : !llvm.ptr
    llvm.intr.vacopy %2 to %3 : !llvm.ptr, !llvm.ptr
    llvm.intr.vaend %3 : !llvm.ptr
    llvm.intr.lifetime.end 32, %3 : !llvm.ptr
    llvm.intr.vaend %2 : !llvm.ptr
    llvm.intr.lifetime.end 32, %2 : !llvm.ptr
    llvm.return %1 : i32
  }]

def func_combined := [llvmfunc|
  llvm.func @func(%arg0: !llvm.ptr {llvm.nocapture, llvm.readnone}, ...) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_func   : func_before  ⊑  func_combined := by
  unfold func_before func_combined
  simp_alive_peephole
  sorry
