import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-call-cast-target
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def ctime_before := [llvmfunc|
  llvm.func @ctime(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @main2 : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def main_before := [llvmfunc|
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.addressof @ctime2 : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.call %0(%1) : !llvm.ptr, (!llvm.ptr) -> i32
    llvm.return %2 : i32
  }]

def ctime_combined := [llvmfunc|
  llvm.func @ctime(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.call @main2() : () -> i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_ctime   : ctime_before  ⊑  ctime_combined := by
  unfold ctime_before ctime_combined
  simp_alive_peephole
  sorry
def main_combined := [llvmfunc|
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.call @ctime2(%0) : (!llvm.ptr) -> !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
