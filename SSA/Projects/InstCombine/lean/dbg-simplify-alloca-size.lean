import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  dbg-simplify-alloca-size
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def toplevel_before := [llvmfunc|
  llvm.func @toplevel() {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.dbg.declare #di_local_variable = %1 : !llvm.ptr
    llvm.call @foo(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def toplevel_combined := [llvmfunc|
  llvm.func @toplevel() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<3 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_toplevel   : toplevel_before  ⊑  toplevel_combined := by
  unfold toplevel_before toplevel_combined
  simp_alive_peephole
  sorry
    llvm.intr.dbg.declare #di_local_variable = %1 : !llvm.ptr
    llvm.call @foo(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_toplevel   : toplevel_before  ⊑  toplevel_combined := by
  unfold toplevel_before toplevel_combined
  simp_alive_peephole
  sorry
