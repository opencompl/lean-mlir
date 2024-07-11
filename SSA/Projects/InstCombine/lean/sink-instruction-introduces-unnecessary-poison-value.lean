import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sink-instruction-introduces-unnecessary-poison-value
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def "?test@@YAHXZ"() -> _before := [llvmfunc|
  llvm.func @"?test@@YAHXZ"() -> (i32 {llvm.noundef}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.intr.dbg.value #di_local_variable = %0 : i32
    %1 = llvm.mlir.addressof @"?Two@@3HA" : !llvm.ptr
    %2 = llvm.mlir.addressof @"?One@@3HA" : !llvm.ptr
    %3 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.dbg.value #di_local_variable = %3 : i32
    %4 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.intr.dbg.value #di_local_variable = %4 : i32
    llvm.intr.dbg.value #di_local_variable1 = %4 : i32
    %5 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.switch %5 : i32, ^bb3(%0 : i32) [
      0: ^bb1,
      2: ^bb2
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%4 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%3 : i32)
  ^bb3(%6: i32):  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.intr.dbg.value #di_local_variable = %6 : i32
    llvm.return %6 : i32
  }]

def "?test@@YAHXZ"() -> _combined := [llvmfunc|
  llvm.func @"?test@@YAHXZ"() -> (i32 {llvm.noundef}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.intr.dbg.value #di_local_variable = %0 : i32
    %1 = llvm.mlir.addressof @"?One@@3HA" : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.dbg.value #di_local_variable = %2 : i32
    %3 = llvm.mlir.addressof @"?Two@@3HA" : !llvm.ptr
    %4 = llvm.mlir.poison : i32
    llvm.intr.dbg.value #di_local_variable1 = %4 : i32
    %5 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.switch %5 : i32, ^bb3(%0 : i32) [
      0: ^bb1,
      2: ^bb2
    ]
  ^bb1:  // pred: ^bb0
    %6 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.intr.dbg.value #di_local_variable = %6 : i32
    llvm.intr.dbg.value #di_local_variable1 = %6 : i32
    llvm.br ^bb3(%6 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%2 : i32)
  ^bb3(%7: i32):  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.intr.dbg.value #di_local_variable = %7 : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_"?test@@YAHXZ"() ->    : "?test@@YAHXZ"() -> _before  ⊑  "?test@@YAHXZ"() -> _combined := by
  unfold "?test@@YAHXZ"() -> _before "?test@@YAHXZ"() -> _combined
  simp_alive_peephole
  sorry
