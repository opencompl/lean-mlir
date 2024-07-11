import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  puts-i16
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def xform_puts_before := [llvmfunc|
  llvm.func @xform_puts(%arg0: i16) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @empty : !llvm.ptr
    %3 = llvm.call @puts(%2) : (!llvm.ptr) -> i16
    llvm.return
  }]

def xform_puts_combined := [llvmfunc|
  llvm.func @xform_puts(%arg0: i16) {
    %0 = llvm.mlir.constant(10 : i16) : i16
    %1 = llvm.call @putchar(%0) : (i16) -> i16
    llvm.return
  }]

theorem inst_combine_xform_puts   : xform_puts_before  ⊑  xform_puts_combined := by
  unfold xform_puts_before xform_puts_combined
  simp_alive_peephole
  sorry
