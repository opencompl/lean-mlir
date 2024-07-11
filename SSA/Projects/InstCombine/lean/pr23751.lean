import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr23751
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f(%arg0: i8 {llvm.zeroext}) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @d : !llvm.ptr
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.zext %arg0 : i8 to i32
    %4 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %5 = llvm.or %4, %2  : i32
    %6 = llvm.add %5, %3 overflow<nsw>  : i32
    %7 = llvm.icmp "ugt" %3, %6 : i32
    llvm.return %7 : i1
  }]

def f_combined := [llvmfunc|
  llvm.func @f(%arg0: i8 {llvm.zeroext}) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @d : !llvm.ptr
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.zext %arg0 : i8 to i32
    %5 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
    %6 = llvm.or %5, %2  : i32
    %7 = llvm.xor %4, %3  : i32
    %8 = llvm.icmp "ugt" %6, %7 : i32
    llvm.return %8 : i1
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
