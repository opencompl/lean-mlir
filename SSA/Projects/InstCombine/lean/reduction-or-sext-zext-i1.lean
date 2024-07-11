import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  reduction-or-sext-zext-i1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def reduce_or_self_before := [llvmfunc|
  llvm.func @reduce_or_self(%arg0: vector<8xi1>) -> i1 {
    %0 = "llvm.intr.vector.reduce.or"(%arg0) : (vector<8xi1>) -> i1
    llvm.return %0 : i1
  }]

def reduce_or_sext_before := [llvmfunc|
  llvm.func @reduce_or_sext(%arg0: vector<4xi1>) -> i32 {
    %0 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %1 = "llvm.intr.vector.reduce.or"(%0) : (vector<4xi32>) -> i32
    llvm.return %1 : i32
  }]

def reduce_or_zext_before := [llvmfunc|
  llvm.func @reduce_or_zext(%arg0: vector<8xi1>) -> i64 {
    %0 = llvm.zext %arg0 : vector<8xi1> to vector<8xi64>
    %1 = "llvm.intr.vector.reduce.or"(%0) : (vector<8xi64>) -> i64
    llvm.return %1 : i64
  }]

def reduce_or_sext_same_before := [llvmfunc|
  llvm.func @reduce_or_sext_same(%arg0: vector<16xi1>) -> i16 {
    %0 = llvm.sext %arg0 : vector<16xi1> to vector<16xi16>
    %1 = "llvm.intr.vector.reduce.or"(%0) : (vector<16xi16>) -> i16
    llvm.return %1 : i16
  }]

def reduce_or_zext_long_before := [llvmfunc|
  llvm.func @reduce_or_zext_long(%arg0: vector<128xi1>) -> i8 {
    %0 = llvm.sext %arg0 : vector<128xi1> to vector<128xi8>
    %1 = "llvm.intr.vector.reduce.or"(%0) : (vector<128xi8>) -> i8
    llvm.return %1 : i8
  }]

def reduce_or_zext_long_external_use_before := [llvmfunc|
  llvm.func @reduce_or_zext_long_external_use(%arg0: vector<128xi1>) -> i8 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @glob : !llvm.ptr
    %2 = llvm.sext %arg0 : vector<128xi1> to vector<128xi8>
    %3 = "llvm.intr.vector.reduce.or"(%2) : (vector<128xi8>) -> i8
    %4 = llvm.extractelement %2[%0 : i32] : vector<128xi8>
    llvm.store %4, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return %3 : i8
  }]

def reduce_or_zext_external_use_before := [llvmfunc|
  llvm.func @reduce_or_zext_external_use(%arg0: vector<8xi1>) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @glob1 : !llvm.ptr
    %2 = llvm.zext %arg0 : vector<8xi1> to vector<8xi64>
    %3 = "llvm.intr.vector.reduce.or"(%2) : (vector<8xi64>) -> i64
    %4 = llvm.extractelement %2[%0 : i32] : vector<8xi64>
    llvm.store %4, %1 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.return %3 : i64
  }]

def reduce_or_pointer_cast_before := [llvmfunc|
  llvm.func @reduce_or_pointer_cast(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.load %arg1 {alignment = 8 : i64} : !llvm.ptr -> vector<8xi8>]

    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<8xi8>]

    %3 = llvm.icmp "ne" %1, %2 : vector<8xi8>
    %4 = "llvm.intr.vector.reduce.or"(%3) : (vector<8xi1>) -> i1
    %5 = llvm.xor %4, %0  : i1
    llvm.return %5 : i1
  }]

def reduce_or_pointer_cast_wide_before := [llvmfunc|
  llvm.func @reduce_or_pointer_cast_wide(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.load %arg1 {alignment = 16 : i64} : !llvm.ptr -> vector<8xi16>]

    %2 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<8xi16>]

    %3 = llvm.icmp "ne" %1, %2 : vector<8xi16>
    %4 = "llvm.intr.vector.reduce.or"(%3) : (vector<8xi1>) -> i1
    %5 = llvm.xor %4, %0  : i1
    llvm.return %5 : i1
  }]

def reduce_or_pointer_cast_ne_before := [llvmfunc|
  llvm.func @reduce_or_pointer_cast_ne(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.load %arg1 {alignment = 8 : i64} : !llvm.ptr -> vector<8xi8>]

    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<8xi8>]

    %2 = llvm.icmp "ne" %0, %1 : vector<8xi8>
    %3 = "llvm.intr.vector.reduce.or"(%2) : (vector<8xi1>) -> i1
    llvm.return %3 : i1
  }]

def reduce_or_pointer_cast_ne_wide_before := [llvmfunc|
  llvm.func @reduce_or_pointer_cast_ne_wide(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.load %arg1 {alignment = 16 : i64} : !llvm.ptr -> vector<8xi16>]

    %1 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<8xi16>]

    %2 = llvm.icmp "ne" %0, %1 : vector<8xi16>
    %3 = "llvm.intr.vector.reduce.or"(%2) : (vector<8xi1>) -> i1
    llvm.return %3 : i1
  }]

def reduce_or_self_combined := [llvmfunc|
  llvm.func @reduce_or_self(%arg0: vector<8xi1>) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : vector<8xi1> to i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_reduce_or_self   : reduce_or_self_before  ⊑  reduce_or_self_combined := by
  unfold reduce_or_self_before reduce_or_self_combined
  simp_alive_peephole
  sorry
def reduce_or_sext_combined := [llvmfunc|
  llvm.func @reduce_or_sext(%arg0: vector<4xi1>) -> i32 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.bitcast %arg0 : vector<4xi1> to i4
    %2 = llvm.icmp "ne" %1, %0 : i4
    %3 = llvm.sext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_reduce_or_sext   : reduce_or_sext_before  ⊑  reduce_or_sext_combined := by
  unfold reduce_or_sext_before reduce_or_sext_combined
  simp_alive_peephole
  sorry
def reduce_or_zext_combined := [llvmfunc|
  llvm.func @reduce_or_zext(%arg0: vector<8xi1>) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : vector<8xi1> to i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    %3 = llvm.zext %2 : i1 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_reduce_or_zext   : reduce_or_zext_before  ⊑  reduce_or_zext_combined := by
  unfold reduce_or_zext_before reduce_or_zext_combined
  simp_alive_peephole
  sorry
def reduce_or_sext_same_combined := [llvmfunc|
  llvm.func @reduce_or_sext_same(%arg0: vector<16xi1>) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.bitcast %arg0 : vector<16xi1> to i16
    %2 = llvm.icmp "ne" %1, %0 : i16
    %3 = llvm.sext %2 : i1 to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_reduce_or_sext_same   : reduce_or_sext_same_before  ⊑  reduce_or_sext_same_combined := by
  unfold reduce_or_sext_same_before reduce_or_sext_same_combined
  simp_alive_peephole
  sorry
def reduce_or_zext_long_combined := [llvmfunc|
  llvm.func @reduce_or_zext_long(%arg0: vector<128xi1>) -> i8 {
    %0 = llvm.mlir.constant(0 : i128) : i128
    %1 = llvm.bitcast %arg0 : vector<128xi1> to i128
    %2 = llvm.icmp "ne" %1, %0 : i128
    %3 = llvm.sext %2 : i1 to i8
    llvm.return %3 : i8
  }]

theorem inst_combine_reduce_or_zext_long   : reduce_or_zext_long_before  ⊑  reduce_or_zext_long_combined := by
  unfold reduce_or_zext_long_before reduce_or_zext_long_combined
  simp_alive_peephole
  sorry
def reduce_or_zext_long_external_use_combined := [llvmfunc|
  llvm.func @reduce_or_zext_long_external_use(%arg0: vector<128xi1>) -> i8 {
    %0 = llvm.mlir.constant(0 : i128) : i128
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @glob : !llvm.ptr
    %3 = llvm.bitcast %arg0 : vector<128xi1> to i128
    %4 = llvm.icmp "ne" %3, %0 : i128
    %5 = llvm.sext %4 : i1 to i8
    %6 = llvm.extractelement %arg0[%1 : i64] : vector<128xi1>
    %7 = llvm.sext %6 : i1 to i8
    llvm.store %7, %2 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return %5 : i8
  }]

theorem inst_combine_reduce_or_zext_long_external_use   : reduce_or_zext_long_external_use_before  ⊑  reduce_or_zext_long_external_use_combined := by
  unfold reduce_or_zext_long_external_use_before reduce_or_zext_long_external_use_combined
  simp_alive_peephole
  sorry
def reduce_or_zext_external_use_combined := [llvmfunc|
  llvm.func @reduce_or_zext_external_use(%arg0: vector<8xi1>) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @glob1 : !llvm.ptr
    %3 = llvm.bitcast %arg0 : vector<8xi1> to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.extractelement %arg0[%1 : i64] : vector<8xi1>
    %7 = llvm.zext %6 : i1 to i64
    llvm.store %7, %2 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return %5 : i64
  }]

theorem inst_combine_reduce_or_zext_external_use   : reduce_or_zext_external_use_before  ⊑  reduce_or_zext_external_use_combined := by
  unfold reduce_or_zext_external_use_before reduce_or_zext_external_use_combined
  simp_alive_peephole
  sorry
def reduce_or_pointer_cast_combined := [llvmfunc|
  llvm.func @reduce_or_pointer_cast(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.load %arg1 {alignment = 8 : i64} : !llvm.ptr -> i64
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    llvm.return %2 : i1
  }]

theorem inst_combine_reduce_or_pointer_cast   : reduce_or_pointer_cast_before  ⊑  reduce_or_pointer_cast_combined := by
  unfold reduce_or_pointer_cast_before reduce_or_pointer_cast_combined
  simp_alive_peephole
  sorry
def reduce_or_pointer_cast_wide_combined := [llvmfunc|
  llvm.func @reduce_or_pointer_cast_wide(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.load %arg1 {alignment = 16 : i64} : !llvm.ptr -> vector<8xi16>
    %2 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<8xi16>
    %3 = llvm.icmp "ne" %1, %2 : vector<8xi16>
    %4 = llvm.bitcast %3 : vector<8xi1> to i8
    %5 = llvm.icmp "eq" %4, %0 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_reduce_or_pointer_cast_wide   : reduce_or_pointer_cast_wide_before  ⊑  reduce_or_pointer_cast_wide_combined := by
  unfold reduce_or_pointer_cast_wide_before reduce_or_pointer_cast_wide_combined
  simp_alive_peephole
  sorry
def reduce_or_pointer_cast_ne_combined := [llvmfunc|
  llvm.func @reduce_or_pointer_cast_ne(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.load %arg1 {alignment = 8 : i64} : !llvm.ptr -> i64
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    llvm.return %2 : i1
  }]

theorem inst_combine_reduce_or_pointer_cast_ne   : reduce_or_pointer_cast_ne_before  ⊑  reduce_or_pointer_cast_ne_combined := by
  unfold reduce_or_pointer_cast_ne_before reduce_or_pointer_cast_ne_combined
  simp_alive_peephole
  sorry
def reduce_or_pointer_cast_ne_wide_combined := [llvmfunc|
  llvm.func @reduce_or_pointer_cast_ne_wide(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.load %arg1 {alignment = 16 : i64} : !llvm.ptr -> vector<8xi16>
    %2 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<8xi16>
    %3 = llvm.icmp "ne" %1, %2 : vector<8xi16>
    %4 = llvm.bitcast %3 : vector<8xi1> to i8
    %5 = llvm.icmp "ne" %4, %0 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_reduce_or_pointer_cast_ne_wide   : reduce_or_pointer_cast_ne_wide_before  ⊑  reduce_or_pointer_cast_ne_wide_combined := by
  unfold reduce_or_pointer_cast_ne_wide_before reduce_or_pointer_cast_ne_wide_combined
  simp_alive_peephole
  sorry
