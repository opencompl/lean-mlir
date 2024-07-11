import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  reduction-add-sext-zext-i1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def reduce_add_self_before := [llvmfunc|
  llvm.func @reduce_add_self(%arg0: vector<8xi1>) -> i1 {
    %0 = "llvm.intr.vector.reduce.add"(%arg0) : (vector<8xi1>) -> i1
    llvm.return %0 : i1
  }]

def reduce_add_sext_before := [llvmfunc|
  llvm.func @reduce_add_sext(%arg0: vector<4xi1>) -> i32 {
    %0 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %1 = "llvm.intr.vector.reduce.add"(%0) : (vector<4xi32>) -> i32
    llvm.return %1 : i32
  }]

def reduce_add_zext_before := [llvmfunc|
  llvm.func @reduce_add_zext(%arg0: vector<8xi1>) -> i64 {
    %0 = llvm.zext %arg0 : vector<8xi1> to vector<8xi64>
    %1 = "llvm.intr.vector.reduce.add"(%0) : (vector<8xi64>) -> i64
    llvm.return %1 : i64
  }]

def reduce_add_sext_same_before := [llvmfunc|
  llvm.func @reduce_add_sext_same(%arg0: vector<16xi1>) -> i16 {
    %0 = llvm.sext %arg0 : vector<16xi1> to vector<16xi16>
    %1 = "llvm.intr.vector.reduce.add"(%0) : (vector<16xi16>) -> i16
    llvm.return %1 : i16
  }]

def reduce_add_zext_long_before := [llvmfunc|
  llvm.func @reduce_add_zext_long(%arg0: vector<128xi1>) -> i8 {
    %0 = llvm.sext %arg0 : vector<128xi1> to vector<128xi8>
    %1 = "llvm.intr.vector.reduce.add"(%0) : (vector<128xi8>) -> i8
    llvm.return %1 : i8
  }]

def reduce_add_zext_long_external_use_before := [llvmfunc|
  llvm.func @reduce_add_zext_long_external_use(%arg0: vector<128xi1>) -> i8 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @glob : !llvm.ptr
    %2 = llvm.sext %arg0 : vector<128xi1> to vector<128xi8>
    %3 = "llvm.intr.vector.reduce.add"(%2) : (vector<128xi8>) -> i8
    %4 = llvm.extractelement %2[%0 : i32] : vector<128xi8>
    llvm.store %4, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return %3 : i8
  }]

def reduce_add_zext_external_use_before := [llvmfunc|
  llvm.func @reduce_add_zext_external_use(%arg0: vector<8xi1>) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @glob1 : !llvm.ptr
    %2 = llvm.zext %arg0 : vector<8xi1> to vector<8xi64>
    %3 = "llvm.intr.vector.reduce.add"(%2) : (vector<8xi64>) -> i64
    %4 = llvm.extractelement %2[%0 : i32] : vector<8xi64>
    llvm.store %4, %1 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.return %3 : i64
  }]

def reduce_add_self_combined := [llvmfunc|
  llvm.func @reduce_add_self(%arg0: vector<8xi1>) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.bitcast %arg0 : vector<8xi1> to i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.and %3, %0  : i8
    %5 = llvm.icmp "ne" %4, %1 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_reduce_add_self   : reduce_add_self_before  ⊑  reduce_add_self_combined := by
  unfold reduce_add_self_before reduce_add_self_combined
  simp_alive_peephole
  sorry
def reduce_add_sext_combined := [llvmfunc|
  llvm.func @reduce_add_sext(%arg0: vector<4xi1>) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : vector<4xi1> to i4
    %2 = llvm.intr.ctpop(%1)  : (i4) -> i4
    %3 = llvm.zext %2 : i4 to i32
    %4 = llvm.sub %0, %3 overflow<nsw>  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_reduce_add_sext   : reduce_add_sext_before  ⊑  reduce_add_sext_combined := by
  unfold reduce_add_sext_before reduce_add_sext_combined
  simp_alive_peephole
  sorry
def reduce_add_zext_combined := [llvmfunc|
  llvm.func @reduce_add_zext(%arg0: vector<8xi1>) -> i64 {
    %0 = llvm.bitcast %arg0 : vector<8xi1> to i8
    %1 = llvm.intr.ctpop(%0)  : (i8) -> i8
    %2 = llvm.zext %1 : i8 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_reduce_add_zext   : reduce_add_zext_before  ⊑  reduce_add_zext_combined := by
  unfold reduce_add_zext_before reduce_add_zext_combined
  simp_alive_peephole
  sorry
def reduce_add_sext_same_combined := [llvmfunc|
  llvm.func @reduce_add_sext_same(%arg0: vector<16xi1>) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.bitcast %arg0 : vector<16xi1> to i16
    %2 = llvm.intr.ctpop(%1)  : (i16) -> i16
    %3 = llvm.sub %0, %2 overflow<nsw>  : i16
    llvm.return %3 : i16
  }]

theorem inst_combine_reduce_add_sext_same   : reduce_add_sext_same_before  ⊑  reduce_add_sext_same_combined := by
  unfold reduce_add_sext_same_before reduce_add_sext_same_combined
  simp_alive_peephole
  sorry
def reduce_add_zext_long_combined := [llvmfunc|
  llvm.func @reduce_add_zext_long(%arg0: vector<128xi1>) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : vector<128xi1> to i128
    %2 = llvm.intr.ctpop(%1)  : (i128) -> i128
    %3 = llvm.trunc %2 : i128 to i8
    %4 = llvm.sub %0, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_reduce_add_zext_long   : reduce_add_zext_long_before  ⊑  reduce_add_zext_long_combined := by
  unfold reduce_add_zext_long_before reduce_add_zext_long_combined
  simp_alive_peephole
  sorry
def reduce_add_zext_long_external_use_combined := [llvmfunc|
  llvm.func @reduce_add_zext_long_external_use(%arg0: vector<128xi1>) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @glob : !llvm.ptr
    %3 = llvm.bitcast %arg0 : vector<128xi1> to i128
    %4 = llvm.intr.ctpop(%3)  : (i128) -> i128
    %5 = llvm.trunc %4 : i128 to i8
    %6 = llvm.sub %0, %5  : i8
    %7 = llvm.extractelement %arg0[%1 : i64] : vector<128xi1>
    %8 = llvm.sext %7 : i1 to i8
    llvm.store %8, %2 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_reduce_add_zext_long_external_use   : reduce_add_zext_long_external_use_before  ⊑  reduce_add_zext_long_external_use_combined := by
  unfold reduce_add_zext_long_external_use_before reduce_add_zext_long_external_use_combined
  simp_alive_peephole
  sorry
    llvm.return %6 : i8
  }]

theorem inst_combine_reduce_add_zext_long_external_use   : reduce_add_zext_long_external_use_before  ⊑  reduce_add_zext_long_external_use_combined := by
  unfold reduce_add_zext_long_external_use_before reduce_add_zext_long_external_use_combined
  simp_alive_peephole
  sorry
def reduce_add_zext_external_use_combined := [llvmfunc|
  llvm.func @reduce_add_zext_external_use(%arg0: vector<8xi1>) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @glob1 : !llvm.ptr
    %2 = llvm.bitcast %arg0 : vector<8xi1> to i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.zext %3 : i8 to i64
    %5 = llvm.extractelement %arg0[%0 : i64] : vector<8xi1>
    %6 = llvm.zext %5 : i1 to i64
    llvm.store %6, %1 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_reduce_add_zext_external_use   : reduce_add_zext_external_use_before  ⊑  reduce_add_zext_external_use_combined := by
  unfold reduce_add_zext_external_use_before reduce_add_zext_external_use_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i64
  }]

theorem inst_combine_reduce_add_zext_external_use   : reduce_add_zext_external_use_before  ⊑  reduce_add_zext_external_use_combined := by
  unfold reduce_add_zext_external_use_before reduce_add_zext_external_use_combined
  simp_alive_peephole
  sorry
