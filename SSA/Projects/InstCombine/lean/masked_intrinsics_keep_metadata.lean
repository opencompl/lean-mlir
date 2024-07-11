import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  masked_intrinsics_keep_metadata
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def mload1(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> _before := [llvmfunc|
  llvm.func @mload1(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> (vector<4xi32> {llvm.inreg}) attributes {passthrough = ["norecurse", "nounwind"]} {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.intr.masked.load %arg0, %1, %2 {alignment = 16 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>]

    llvm.return %4 : vector<4xi32>
  }]

def mload2() -> _before := [llvmfunc|
  llvm.func @mload2() -> (vector<4xi32> {llvm.inreg}) attributes {passthrough = ["norecurse", "nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.addressof @g0 : !llvm.ptr
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(dense<[false, true, true, true]> : vector<4xi1>) : vector<4xi1>
    %6 = llvm.mlir.constant(16 : i32) : i32
    %7 = llvm.intr.masked.load %2, %5, %1 {alignment = 16 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>]

    llvm.return %7 : vector<4xi32>
  }]

def mstore_before := [llvmfunc|
  llvm.func @mstore(%arg0: vector<4xi32>, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) attributes {passthrough = ["norecurse", "nounwind"]} {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(16 : i32) : i32
    llvm.intr.masked.store %arg0, %arg1, %1 {alignment = 16 : i32} : vector<4xi32>, vector<4xi1> into !llvm.ptr]

    llvm.return
  }]

def mload1(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> _combined := [llvmfunc|
  llvm.func @mload1(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> (vector<4xi32> {llvm.inreg}) attributes {passthrough = ["norecurse", "nounwind"]} {
    %0 = llvm.load %arg0 {alignment = 16 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> vector<4xi32>]

theorem inst_combine_mload1(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) ->    : mload1(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> _before  ⊑  mload1(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> _combined := by
  unfold mload1(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> _before mload1(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> _combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_mload1(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) ->    : mload1(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> _before  ⊑  mload1(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> _combined := by
  unfold mload1(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> _before mload1(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> _combined
  simp_alive_peephole
  sorry
def mload2() -> _combined := [llvmfunc|
  llvm.func @mload2() -> (vector<4xi32> {llvm.inreg}) attributes {passthrough = ["norecurse", "nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.addressof @g0 : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.load %2 {alignment = 16 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> vector<4xi32>]

theorem inst_combine_mload2() ->    : mload2() -> _before  ⊑  mload2() -> _combined := by
  unfold mload2() -> _before mload2() -> _combined
  simp_alive_peephole
  sorry
    %5 = llvm.insertelement %0, %4[%3 : i64] : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

theorem inst_combine_mload2() ->    : mload2() -> _before  ⊑  mload2() -> _combined := by
  unfold mload2() -> _before mload2() -> _combined
  simp_alive_peephole
  sorry
def mstore_combined := [llvmfunc|
  llvm.func @mstore(%arg0: vector<4xi32>, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) attributes {passthrough = ["norecurse", "nounwind"]} {
    llvm.store %arg0, %arg1 {alignment = 16 : i64, tbaa = [#tbaa_tag]} : vector<4xi32>, !llvm.ptr]

theorem inst_combine_mstore   : mstore_before  ⊑  mstore_combined := by
  unfold mstore_before mstore_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_mstore   : mstore_before  ⊑  mstore_combined := by
  unfold mstore_before mstore_combined
  simp_alive_peephole
  sorry
