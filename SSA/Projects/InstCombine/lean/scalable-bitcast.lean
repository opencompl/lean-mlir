import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  scalable-bitcast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def bitcast_of_insert_i8_i16_before := [llvmfunc|
  llvm.func @bitcast_of_insert_i8_i16(%arg0: i16) -> !llvm.vec<? x 2 x  i8> {
    %0 = llvm.mlir.undef : !llvm.vec<? x 1 x  i16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<? x 1 x  i16>
    %3 = llvm.bitcast %2 : !llvm.vec<? x 1 x  i16> to !llvm.vec<? x 2 x  i8>
    llvm.return %3 : !llvm.vec<? x 2 x  i8>
  }]

def bitcast_of_insert_i8_i16_combined := [llvmfunc|
  llvm.func @bitcast_of_insert_i8_i16(%arg0: i16) -> !llvm.vec<? x 2 x  i8> {
    %0 = llvm.mlir.undef : !llvm.vec<? x 1 x  i16>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : !llvm.vec<? x 1 x  i16>
    %3 = llvm.bitcast %2 : !llvm.vec<? x 1 x  i16> to !llvm.vec<? x 2 x  i8>
    llvm.return %3 : !llvm.vec<? x 2 x  i8>
  }]

theorem inst_combine_bitcast_of_insert_i8_i16   : bitcast_of_insert_i8_i16_before  ⊑  bitcast_of_insert_i8_i16_combined := by
  unfold bitcast_of_insert_i8_i16_before bitcast_of_insert_i8_i16_combined
  simp_alive_peephole
  sorry
