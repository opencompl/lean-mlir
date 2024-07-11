import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  call-intrinsics
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def zero_byte_test_before := [llvmfunc|
  llvm.func @zero_byte_test() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @X : !llvm.ptr
    %2 = llvm.mlir.constant(12 : i8) : i8
    %3 = llvm.mlir.addressof @Y : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(123 : i8) : i8
    "llvm.intr.memmove"(%1, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    "llvm.intr.memcpy"(%1, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    "llvm.intr.memset"(%1, %5, %4) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()]

    llvm.return
  }]

def zero_byte_test_combined := [llvmfunc|
  llvm.func @zero_byte_test() {
    llvm.return
  }]

theorem inst_combine_zero_byte_test   : zero_byte_test_before  ⊑  zero_byte_test_combined := by
  unfold zero_byte_test_before zero_byte_test_combined
  simp_alive_peephole
  sorry
