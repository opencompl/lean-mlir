import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2009-03-18-vector-ashr-crash
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def <<INVALID EMPTY SYMBOL>>_before := [llvmfunc|
  llvm.func @<<INVALID EMPTY SYMBOL>>(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(dense<5> : vector<4xi16>) : vector<4xi16>
    %3 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> vector<4xi16>]

    %5 = llvm.ashr %4, %2  : vector<4xi16>
    %6 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.store %5, %6 {alignment = 1 : i64} : vector<4xi16>, !llvm.ptr]

    llvm.return
  }]

def <<INVALID EMPTY SYMBOL>>_combined := [llvmfunc|
  llvm.func @<<INVALID EMPTY SYMBOL>>(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : !llvm.ptr
    llvm.store %0, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_<<INVALID EMPTY SYMBOL>>   : <<INVALID EMPTY SYMBOL>>_before  ⊑  <<INVALID EMPTY SYMBOL>>_combined := by
  unfold <<INVALID EMPTY SYMBOL>>_before <<INVALID EMPTY SYMBOL>>_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_<<INVALID EMPTY SYMBOL>>   : <<INVALID EMPTY SYMBOL>>_before  ⊑  <<INVALID EMPTY SYMBOL>>_combined := by
  unfold <<INVALID EMPTY SYMBOL>>_before <<INVALID EMPTY SYMBOL>>_combined
  simp_alive_peephole
  sorry
