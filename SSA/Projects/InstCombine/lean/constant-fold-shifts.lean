import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  constant-fold-shifts
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def ossfuzz_14169_test1_before := [llvmfunc|
  llvm.func @ossfuzz_14169_test1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @A : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i712) : i712
    %3 = llvm.mlir.constant(1 : i712) : i712
    %4 = llvm.mlir.constant(146783911423364576743092537299333564210980159306769991919205685720763064069663027716481187399048043939495936 : i712) : i712
    %5 = llvm.mlir.undef : !llvm.ptr
    %6 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %7 = llvm.icmp "sge" %6, %1 : i64
    %8 = llvm.select %7, %2, %3 : i1, i712
    %9 = llvm.lshr %8, %4  : i712
    %10 = llvm.getelementptr %5[%9] : (!llvm.ptr, i712) -> !llvm.ptr, i64
    llvm.store %10, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def ossfuzz_14169_test2_before := [llvmfunc|
  llvm.func @ossfuzz_14169_test2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @A : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i712) : i712
    %3 = llvm.mlir.constant(1 : i712) : i712
    %4 = llvm.mlir.constant(146783911423364576743092537299333564210980159306769991919205685720763064069663027716481187399048043939495936 : i712) : i712
    %5 = llvm.mlir.undef : !llvm.ptr
    %6 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %7 = llvm.icmp "sge" %6, %1 : i64
    %8 = llvm.select %7, %2, %3 : i1, i712
    %9 = llvm.shl %8, %4  : i712
    %10 = llvm.getelementptr %5[%9] : (!llvm.ptr, i712) -> !llvm.ptr, i64
    llvm.store %10, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def ossfuzz_14169_test1_combined := [llvmfunc|
  llvm.func @ossfuzz_14169_test1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.poison : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.ptr
    llvm.store %0, %1 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_ossfuzz_14169_test1   : ossfuzz_14169_test1_before  ⊑  ossfuzz_14169_test1_combined := by
  unfold ossfuzz_14169_test1_before ossfuzz_14169_test1_combined
  simp_alive_peephole
  sorry
def ossfuzz_14169_test2_combined := [llvmfunc|
  llvm.func @ossfuzz_14169_test2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.poison : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.ptr
    llvm.store %0, %1 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_ossfuzz_14169_test2   : ossfuzz_14169_test2_before  ⊑  ossfuzz_14169_test2_combined := by
  unfold ossfuzz_14169_test2_before ossfuzz_14169_test2_combined
  simp_alive_peephole
  sorry
