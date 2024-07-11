import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr32686
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def tinkywinky_before := [llvmfunc|
  llvm.func @tinkywinky() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %6 = llvm.icmp "ne" %5, %0 : i8
    %7 = llvm.xor %6, %2  : i1
    %8 = llvm.zext %7 : i1 to i32
    %9 = llvm.icmp "ne" %1, %3 : !llvm.ptr
    %10 = llvm.zext %9 : i1 to i32
    %11 = llvm.xor %10, %4  : i32
    %12 = llvm.or %11, %8  : i32
    llvm.store %12, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def tinkywinky_combined := [llvmfunc|
  llvm.func @tinkywinky() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.addressof @b : !llvm.ptr
    %3 = llvm.icmp "ne" %1, %2 : !llvm.ptr
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> i8
    %6 = llvm.icmp "eq" %5, %0 : i8
    %7 = llvm.zext %6 : i1 to i32
    %8 = llvm.zext %3 : i1 to i32
    %9 = llvm.or %8, %7  : i32
    %10 = llvm.or %9, %4  : i32
    llvm.store %10, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_tinkywinky   : tinkywinky_before  ⊑  tinkywinky_combined := by
  unfold tinkywinky_before tinkywinky_combined
  simp_alive_peephole
  sorry
