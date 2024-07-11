import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  byval
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def add_byval_before := [llvmfunc|
  llvm.func @add_byval(%arg0: !llvm.ptr) {
    llvm.call @add_byval_callee(%arg0) : (!llvm.ptr) -> ()
    llvm.return
  }]

def add_byval_2_before := [llvmfunc|
  llvm.func @add_byval_2(%arg0: !llvm.ptr) {
    llvm.call @add_byval_callee_2(%arg0) : (!llvm.ptr) -> ()
    llvm.return
  }]

def vararg_byval_before := [llvmfunc|
  llvm.func @vararg_byval(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.undef : i8
    llvm.call @vararg_callee(%0, %arg0) vararg(!llvm.func<void (i8, ...)>) : (i8, !llvm.ptr) -> ()
    llvm.return
  }]

def add_byval_combined := [llvmfunc|
  llvm.func @add_byval(%arg0: !llvm.ptr) {
    llvm.call @add_byval_callee(%arg0) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_add_byval   : add_byval_before  ⊑  add_byval_combined := by
  unfold add_byval_before add_byval_combined
  simp_alive_peephole
  sorry
def add_byval_2_combined := [llvmfunc|
  llvm.func @add_byval_2(%arg0: !llvm.ptr) {
    llvm.call @add_byval_callee_2(%arg0) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_add_byval_2   : add_byval_2_before  ⊑  add_byval_2_combined := by
  unfold add_byval_2_before add_byval_2_combined
  simp_alive_peephole
  sorry
def vararg_byval_combined := [llvmfunc|
  llvm.func @vararg_byval(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.undef : i8
    llvm.call @vararg_callee(%0, %arg0) vararg(!llvm.func<void (i8, ...)>) : (i8, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_vararg_byval   : vararg_byval_before  ⊑  vararg_byval_combined := by
  unfold vararg_byval_before vararg_byval_combined
  simp_alive_peephole
  sorry
