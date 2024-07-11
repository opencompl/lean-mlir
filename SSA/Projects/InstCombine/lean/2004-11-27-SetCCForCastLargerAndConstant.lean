import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2004-11-27-SetCCForCastLargerAndConstant
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def lt_signed_to_large_unsigned_before := [llvmfunc|
  llvm.func @lt_signed_to_large_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1024 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }]

def PR28011_before := [llvmfunc|
  llvm.func @PR28011(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi32>) : !llvm.array<1 x i32>
    %2 = llvm.mlir.addressof @b : !llvm.ptr
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.mlir.addressof @a : !llvm.ptr
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.sext %arg0 : i16 to i32
    %7 = llvm.icmp "ne" %2, %4 : !llvm.ptr
    %8 = llvm.zext %7 : i1 to i32
    %9 = llvm.or %8, %5  : i32
    %10 = llvm.icmp "ne" %6, %9 : i32
    llvm.return %10 : i1
  }]

def lt_signed_to_large_unsigned_vec_before := [llvmfunc|
  llvm.func @lt_signed_to_large_unsigned_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1024, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def lt_signed_to_large_signed_before := [llvmfunc|
  llvm.func @lt_signed_to_large_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1024 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def lt_signed_to_large_negative_before := [llvmfunc|
  llvm.func @lt_signed_to_large_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1024 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def lt_signed_to_small_unsigned_before := [llvmfunc|
  llvm.func @lt_signed_to_small_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }]

def lt_signed_to_small_signed_before := [llvmfunc|
  llvm.func @lt_signed_to_small_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def lt_signed_to_small_negative_before := [llvmfunc|
  llvm.func @lt_signed_to_small_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def lt_unsigned_to_large_unsigned_before := [llvmfunc|
  llvm.func @lt_unsigned_to_large_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1024 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }]

def lt_unsigned_to_large_signed_before := [llvmfunc|
  llvm.func @lt_unsigned_to_large_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1024 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def lt_unsigned_to_large_negative_before := [llvmfunc|
  llvm.func @lt_unsigned_to_large_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1024 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def lt_unsigned_to_small_unsigned_before := [llvmfunc|
  llvm.func @lt_unsigned_to_small_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }]

def lt_unsigned_to_small_signed_before := [llvmfunc|
  llvm.func @lt_unsigned_to_small_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def lt_unsigned_to_small_negative_before := [llvmfunc|
  llvm.func @lt_unsigned_to_small_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def gt_signed_to_large_unsigned_before := [llvmfunc|
  llvm.func @gt_signed_to_large_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1024 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def gt_signed_to_large_signed_before := [llvmfunc|
  llvm.func @gt_signed_to_large_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1024 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def gt_signed_to_large_negative_before := [llvmfunc|
  llvm.func @gt_signed_to_large_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1024 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def gt_signed_to_small_unsigned_before := [llvmfunc|
  llvm.func @gt_signed_to_small_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def gt_signed_to_small_signed_before := [llvmfunc|
  llvm.func @gt_signed_to_small_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def gt_signed_to_small_negative_before := [llvmfunc|
  llvm.func @gt_signed_to_small_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def gt_unsigned_to_large_unsigned_before := [llvmfunc|
  llvm.func @gt_unsigned_to_large_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1024 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def gt_unsigned_to_large_signed_before := [llvmfunc|
  llvm.func @gt_unsigned_to_large_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1024 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def gt_unsigned_to_large_negative_before := [llvmfunc|
  llvm.func @gt_unsigned_to_large_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1024 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def gt_unsigned_to_small_unsigned_before := [llvmfunc|
  llvm.func @gt_unsigned_to_small_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def gt_unsigned_to_small_signed_before := [llvmfunc|
  llvm.func @gt_unsigned_to_small_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def gt_unsigned_to_small_negative_before := [llvmfunc|
  llvm.func @gt_unsigned_to_small_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def different_size_zext_zext_ugt_before := [llvmfunc|
  llvm.func @different_size_zext_zext_ugt(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.zext %arg0 : i7 to i25
    %1 = llvm.zext %arg1 : i4 to i25
    %2 = llvm.icmp "ugt" %0, %1 : i25
    llvm.return %2 : i1
  }]

def different_size_zext_zext_ugt_commute_before := [llvmfunc|
  llvm.func @different_size_zext_zext_ugt_commute(%arg0: vector<2xi4>, %arg1: vector<2xi7>) -> vector<2xi1> {
    %0 = llvm.zext %arg0 : vector<2xi4> to vector<2xi25>
    %1 = llvm.zext %arg1 : vector<2xi7> to vector<2xi25>
    %2 = llvm.icmp "ugt" %0, %1 : vector<2xi25>
    llvm.return %2 : vector<2xi1>
  }]

def different_size_zext_zext_ult_before := [llvmfunc|
  llvm.func @different_size_zext_zext_ult(%arg0: i4, %arg1: i7) -> i1 {
    %0 = llvm.zext %arg0 : i4 to i25
    %1 = llvm.zext %arg1 : i7 to i25
    %2 = llvm.icmp "ult" %0, %1 : i25
    llvm.return %2 : i1
  }]

def different_size_zext_zext_eq_before := [llvmfunc|
  llvm.func @different_size_zext_zext_eq(%arg0: i4, %arg1: i7) -> i1 {
    %0 = llvm.zext %arg0 : i4 to i25
    %1 = llvm.zext %arg1 : i7 to i25
    %2 = llvm.icmp "eq" %0, %1 : i25
    llvm.return %2 : i1
  }]

def different_size_zext_zext_ne_commute_before := [llvmfunc|
  llvm.func @different_size_zext_zext_ne_commute(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.zext %arg0 : i7 to i25
    %1 = llvm.zext %arg1 : i4 to i25
    %2 = llvm.icmp "ne" %0, %1 : i25
    llvm.return %2 : i1
  }]

def different_size_zext_zext_slt_before := [llvmfunc|
  llvm.func @different_size_zext_zext_slt(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.zext %arg0 : i7 to i25
    %1 = llvm.zext %arg1 : i4 to i25
    %2 = llvm.icmp "slt" %0, %1 : i25
    llvm.return %2 : i1
  }]

def different_size_zext_zext_sgt_before := [llvmfunc|
  llvm.func @different_size_zext_zext_sgt(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.zext %arg0 : i7 to i25
    %1 = llvm.zext %arg1 : i4 to i25
    %2 = llvm.icmp "sgt" %0, %1 : i25
    llvm.return %2 : i1
  }]

def different_size_sext_sext_sgt_before := [llvmfunc|
  llvm.func @different_size_sext_sext_sgt(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    %1 = llvm.sext %arg1 : i4 to i25
    %2 = llvm.icmp "sgt" %0, %1 : i25
    llvm.return %2 : i1
  }]

def different_size_sext_sext_sle_before := [llvmfunc|
  llvm.func @different_size_sext_sext_sle(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    %1 = llvm.sext %arg1 : i4 to i25
    %2 = llvm.icmp "sle" %0, %1 : i25
    llvm.return %2 : i1
  }]

def different_size_sext_sext_eq_before := [llvmfunc|
  llvm.func @different_size_sext_sext_eq(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    %1 = llvm.sext %arg1 : i4 to i25
    %2 = llvm.icmp "eq" %0, %1 : i25
    llvm.return %2 : i1
  }]

def different_size_sext_sext_ule_before := [llvmfunc|
  llvm.func @different_size_sext_sext_ule(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    %1 = llvm.sext %arg1 : i4 to i25
    %2 = llvm.icmp "ule" %0, %1 : i25
    llvm.return %2 : i1
  }]

def different_size_sext_zext_ne_before := [llvmfunc|
  llvm.func @different_size_sext_zext_ne(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    %1 = llvm.zext %arg1 : i4 to i25
    %2 = llvm.icmp "ne" %0, %1 : i25
    llvm.return %2 : i1
  }]

def different_size_sext_sext_ule_extra_use1_before := [llvmfunc|
  llvm.func @different_size_sext_sext_ule_extra_use1(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    %1 = llvm.sext %arg1 : i4 to i25
    llvm.call @use(%1) : (i25) -> ()
    %2 = llvm.icmp "ule" %0, %1 : i25
    llvm.return %2 : i1
  }]

def different_size_sext_sext_ule_extra_use2_before := [llvmfunc|
  llvm.func @different_size_sext_sext_ule_extra_use2(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    llvm.call @use(%0) : (i25) -> ()
    %1 = llvm.sext %arg1 : i4 to i25
    %2 = llvm.icmp "ule" %0, %1 : i25
    llvm.return %2 : i1
  }]

def different_size_sext_sext_ule_extra_use3_before := [llvmfunc|
  llvm.func @different_size_sext_sext_ule_extra_use3(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    llvm.call @use(%0) : (i25) -> ()
    %1 = llvm.sext %arg1 : i4 to i25
    llvm.call @use(%1) : (i25) -> ()
    %2 = llvm.icmp "ule" %0, %1 : i25
    llvm.return %2 : i1
  }]

def lt_signed_to_large_unsigned_combined := [llvmfunc|
  llvm.func @lt_signed_to_large_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_lt_signed_to_large_unsigned   : lt_signed_to_large_unsigned_before  ⊑  lt_signed_to_large_unsigned_combined := by
  unfold lt_signed_to_large_unsigned_before lt_signed_to_large_unsigned_combined
  simp_alive_peephole
  sorry
def PR28011_combined := [llvmfunc|
  llvm.func @PR28011(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.icmp "ne" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_PR28011   : PR28011_before  ⊑  PR28011_combined := by
  unfold PR28011_before PR28011_combined
  simp_alive_peephole
  sorry
def lt_signed_to_large_unsigned_vec_combined := [llvmfunc|
  llvm.func @lt_signed_to_large_unsigned_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1024, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_lt_signed_to_large_unsigned_vec   : lt_signed_to_large_unsigned_vec_before  ⊑  lt_signed_to_large_unsigned_vec_combined := by
  unfold lt_signed_to_large_unsigned_vec_before lt_signed_to_large_unsigned_vec_combined
  simp_alive_peephole
  sorry
def lt_signed_to_large_signed_combined := [llvmfunc|
  llvm.func @lt_signed_to_large_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lt_signed_to_large_signed   : lt_signed_to_large_signed_before  ⊑  lt_signed_to_large_signed_combined := by
  unfold lt_signed_to_large_signed_before lt_signed_to_large_signed_combined
  simp_alive_peephole
  sorry
def lt_signed_to_large_negative_combined := [llvmfunc|
  llvm.func @lt_signed_to_large_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lt_signed_to_large_negative   : lt_signed_to_large_negative_before  ⊑  lt_signed_to_large_negative_combined := by
  unfold lt_signed_to_large_negative_before lt_signed_to_large_negative_combined
  simp_alive_peephole
  sorry
def lt_signed_to_small_unsigned_combined := [llvmfunc|
  llvm.func @lt_signed_to_small_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_lt_signed_to_small_unsigned   : lt_signed_to_small_unsigned_before  ⊑  lt_signed_to_small_unsigned_combined := by
  unfold lt_signed_to_small_unsigned_before lt_signed_to_small_unsigned_combined
  simp_alive_peephole
  sorry
def lt_signed_to_small_signed_combined := [llvmfunc|
  llvm.func @lt_signed_to_small_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_lt_signed_to_small_signed   : lt_signed_to_small_signed_before  ⊑  lt_signed_to_small_signed_combined := by
  unfold lt_signed_to_small_signed_before lt_signed_to_small_signed_combined
  simp_alive_peephole
  sorry
def lt_signed_to_small_negative_combined := [llvmfunc|
  llvm.func @lt_signed_to_small_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_lt_signed_to_small_negative   : lt_signed_to_small_negative_before  ⊑  lt_signed_to_small_negative_combined := by
  unfold lt_signed_to_small_negative_before lt_signed_to_small_negative_combined
  simp_alive_peephole
  sorry
def lt_unsigned_to_large_unsigned_combined := [llvmfunc|
  llvm.func @lt_unsigned_to_large_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lt_unsigned_to_large_unsigned   : lt_unsigned_to_large_unsigned_before  ⊑  lt_unsigned_to_large_unsigned_combined := by
  unfold lt_unsigned_to_large_unsigned_before lt_unsigned_to_large_unsigned_combined
  simp_alive_peephole
  sorry
def lt_unsigned_to_large_signed_combined := [llvmfunc|
  llvm.func @lt_unsigned_to_large_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lt_unsigned_to_large_signed   : lt_unsigned_to_large_signed_before  ⊑  lt_unsigned_to_large_signed_combined := by
  unfold lt_unsigned_to_large_signed_before lt_unsigned_to_large_signed_combined
  simp_alive_peephole
  sorry
def lt_unsigned_to_large_negative_combined := [llvmfunc|
  llvm.func @lt_unsigned_to_large_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lt_unsigned_to_large_negative   : lt_unsigned_to_large_negative_before  ⊑  lt_unsigned_to_large_negative_combined := by
  unfold lt_unsigned_to_large_negative_before lt_unsigned_to_large_negative_combined
  simp_alive_peephole
  sorry
def lt_unsigned_to_small_unsigned_combined := [llvmfunc|
  llvm.func @lt_unsigned_to_small_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_lt_unsigned_to_small_unsigned   : lt_unsigned_to_small_unsigned_before  ⊑  lt_unsigned_to_small_unsigned_combined := by
  unfold lt_unsigned_to_small_unsigned_before lt_unsigned_to_small_unsigned_combined
  simp_alive_peephole
  sorry
def lt_unsigned_to_small_signed_combined := [llvmfunc|
  llvm.func @lt_unsigned_to_small_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_lt_unsigned_to_small_signed   : lt_unsigned_to_small_signed_before  ⊑  lt_unsigned_to_small_signed_combined := by
  unfold lt_unsigned_to_small_signed_before lt_unsigned_to_small_signed_combined
  simp_alive_peephole
  sorry
def lt_unsigned_to_small_negative_combined := [llvmfunc|
  llvm.func @lt_unsigned_to_small_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lt_unsigned_to_small_negative   : lt_unsigned_to_small_negative_before  ⊑  lt_unsigned_to_small_negative_combined := by
  unfold lt_unsigned_to_small_negative_before lt_unsigned_to_small_negative_combined
  simp_alive_peephole
  sorry
def gt_signed_to_large_unsigned_combined := [llvmfunc|
  llvm.func @gt_signed_to_large_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_gt_signed_to_large_unsigned   : gt_signed_to_large_unsigned_before  ⊑  gt_signed_to_large_unsigned_combined := by
  unfold gt_signed_to_large_unsigned_before gt_signed_to_large_unsigned_combined
  simp_alive_peephole
  sorry
def gt_signed_to_large_signed_combined := [llvmfunc|
  llvm.func @gt_signed_to_large_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_gt_signed_to_large_signed   : gt_signed_to_large_signed_before  ⊑  gt_signed_to_large_signed_combined := by
  unfold gt_signed_to_large_signed_before gt_signed_to_large_signed_combined
  simp_alive_peephole
  sorry
def gt_signed_to_large_negative_combined := [llvmfunc|
  llvm.func @gt_signed_to_large_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_gt_signed_to_large_negative   : gt_signed_to_large_negative_before  ⊑  gt_signed_to_large_negative_combined := by
  unfold gt_signed_to_large_negative_before gt_signed_to_large_negative_combined
  simp_alive_peephole
  sorry
def gt_signed_to_small_unsigned_combined := [llvmfunc|
  llvm.func @gt_signed_to_small_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_gt_signed_to_small_unsigned   : gt_signed_to_small_unsigned_before  ⊑  gt_signed_to_small_unsigned_combined := by
  unfold gt_signed_to_small_unsigned_before gt_signed_to_small_unsigned_combined
  simp_alive_peephole
  sorry
def gt_signed_to_small_signed_combined := [llvmfunc|
  llvm.func @gt_signed_to_small_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_gt_signed_to_small_signed   : gt_signed_to_small_signed_before  ⊑  gt_signed_to_small_signed_combined := by
  unfold gt_signed_to_small_signed_before gt_signed_to_small_signed_combined
  simp_alive_peephole
  sorry
def gt_signed_to_small_negative_combined := [llvmfunc|
  llvm.func @gt_signed_to_small_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_gt_signed_to_small_negative   : gt_signed_to_small_negative_before  ⊑  gt_signed_to_small_negative_combined := by
  unfold gt_signed_to_small_negative_before gt_signed_to_small_negative_combined
  simp_alive_peephole
  sorry
def gt_unsigned_to_large_unsigned_combined := [llvmfunc|
  llvm.func @gt_unsigned_to_large_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_gt_unsigned_to_large_unsigned   : gt_unsigned_to_large_unsigned_before  ⊑  gt_unsigned_to_large_unsigned_combined := by
  unfold gt_unsigned_to_large_unsigned_before gt_unsigned_to_large_unsigned_combined
  simp_alive_peephole
  sorry
def gt_unsigned_to_large_signed_combined := [llvmfunc|
  llvm.func @gt_unsigned_to_large_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_gt_unsigned_to_large_signed   : gt_unsigned_to_large_signed_before  ⊑  gt_unsigned_to_large_signed_combined := by
  unfold gt_unsigned_to_large_signed_before gt_unsigned_to_large_signed_combined
  simp_alive_peephole
  sorry
def gt_unsigned_to_large_negative_combined := [llvmfunc|
  llvm.func @gt_unsigned_to_large_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_gt_unsigned_to_large_negative   : gt_unsigned_to_large_negative_before  ⊑  gt_unsigned_to_large_negative_combined := by
  unfold gt_unsigned_to_large_negative_before gt_unsigned_to_large_negative_combined
  simp_alive_peephole
  sorry
def gt_unsigned_to_small_unsigned_combined := [llvmfunc|
  llvm.func @gt_unsigned_to_small_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_gt_unsigned_to_small_unsigned   : gt_unsigned_to_small_unsigned_before  ⊑  gt_unsigned_to_small_unsigned_combined := by
  unfold gt_unsigned_to_small_unsigned_before gt_unsigned_to_small_unsigned_combined
  simp_alive_peephole
  sorry
def gt_unsigned_to_small_signed_combined := [llvmfunc|
  llvm.func @gt_unsigned_to_small_signed(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_gt_unsigned_to_small_signed   : gt_unsigned_to_small_signed_before  ⊑  gt_unsigned_to_small_signed_combined := by
  unfold gt_unsigned_to_small_signed_before gt_unsigned_to_small_signed_combined
  simp_alive_peephole
  sorry
def gt_unsigned_to_small_negative_combined := [llvmfunc|
  llvm.func @gt_unsigned_to_small_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_gt_unsigned_to_small_negative   : gt_unsigned_to_small_negative_before  ⊑  gt_unsigned_to_small_negative_combined := by
  unfold gt_unsigned_to_small_negative_before gt_unsigned_to_small_negative_combined
  simp_alive_peephole
  sorry
def different_size_zext_zext_ugt_combined := [llvmfunc|
  llvm.func @different_size_zext_zext_ugt(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.zext %arg1 : i4 to i7
    %1 = llvm.icmp "ult" %0, %arg0 : i7
    llvm.return %1 : i1
  }]

theorem inst_combine_different_size_zext_zext_ugt   : different_size_zext_zext_ugt_before  ⊑  different_size_zext_zext_ugt_combined := by
  unfold different_size_zext_zext_ugt_before different_size_zext_zext_ugt_combined
  simp_alive_peephole
  sorry
def different_size_zext_zext_ugt_commute_combined := [llvmfunc|
  llvm.func @different_size_zext_zext_ugt_commute(%arg0: vector<2xi4>, %arg1: vector<2xi7>) -> vector<2xi1> {
    %0 = llvm.zext %arg0 : vector<2xi4> to vector<2xi7>
    %1 = llvm.icmp "ugt" %0, %arg1 : vector<2xi7>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_different_size_zext_zext_ugt_commute   : different_size_zext_zext_ugt_commute_before  ⊑  different_size_zext_zext_ugt_commute_combined := by
  unfold different_size_zext_zext_ugt_commute_before different_size_zext_zext_ugt_commute_combined
  simp_alive_peephole
  sorry
def different_size_zext_zext_ult_combined := [llvmfunc|
  llvm.func @different_size_zext_zext_ult(%arg0: i4, %arg1: i7) -> i1 {
    %0 = llvm.zext %arg0 : i4 to i7
    %1 = llvm.icmp "ult" %0, %arg1 : i7
    llvm.return %1 : i1
  }]

theorem inst_combine_different_size_zext_zext_ult   : different_size_zext_zext_ult_before  ⊑  different_size_zext_zext_ult_combined := by
  unfold different_size_zext_zext_ult_before different_size_zext_zext_ult_combined
  simp_alive_peephole
  sorry
def different_size_zext_zext_eq_combined := [llvmfunc|
  llvm.func @different_size_zext_zext_eq(%arg0: i4, %arg1: i7) -> i1 {
    %0 = llvm.zext %arg0 : i4 to i7
    %1 = llvm.icmp "eq" %0, %arg1 : i7
    llvm.return %1 : i1
  }]

theorem inst_combine_different_size_zext_zext_eq   : different_size_zext_zext_eq_before  ⊑  different_size_zext_zext_eq_combined := by
  unfold different_size_zext_zext_eq_before different_size_zext_zext_eq_combined
  simp_alive_peephole
  sorry
def different_size_zext_zext_ne_commute_combined := [llvmfunc|
  llvm.func @different_size_zext_zext_ne_commute(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.zext %arg1 : i4 to i7
    %1 = llvm.icmp "ne" %0, %arg0 : i7
    llvm.return %1 : i1
  }]

theorem inst_combine_different_size_zext_zext_ne_commute   : different_size_zext_zext_ne_commute_before  ⊑  different_size_zext_zext_ne_commute_combined := by
  unfold different_size_zext_zext_ne_commute_before different_size_zext_zext_ne_commute_combined
  simp_alive_peephole
  sorry
def different_size_zext_zext_slt_combined := [llvmfunc|
  llvm.func @different_size_zext_zext_slt(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.zext %arg1 : i4 to i7
    %1 = llvm.icmp "ugt" %0, %arg0 : i7
    llvm.return %1 : i1
  }]

theorem inst_combine_different_size_zext_zext_slt   : different_size_zext_zext_slt_before  ⊑  different_size_zext_zext_slt_combined := by
  unfold different_size_zext_zext_slt_before different_size_zext_zext_slt_combined
  simp_alive_peephole
  sorry
def different_size_zext_zext_sgt_combined := [llvmfunc|
  llvm.func @different_size_zext_zext_sgt(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.zext %arg1 : i4 to i7
    %1 = llvm.icmp "ult" %0, %arg0 : i7
    llvm.return %1 : i1
  }]

theorem inst_combine_different_size_zext_zext_sgt   : different_size_zext_zext_sgt_before  ⊑  different_size_zext_zext_sgt_combined := by
  unfold different_size_zext_zext_sgt_before different_size_zext_zext_sgt_combined
  simp_alive_peephole
  sorry
def different_size_sext_sext_sgt_combined := [llvmfunc|
  llvm.func @different_size_sext_sext_sgt(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg1 : i4 to i7
    %1 = llvm.icmp "slt" %0, %arg0 : i7
    llvm.return %1 : i1
  }]

theorem inst_combine_different_size_sext_sext_sgt   : different_size_sext_sext_sgt_before  ⊑  different_size_sext_sext_sgt_combined := by
  unfold different_size_sext_sext_sgt_before different_size_sext_sext_sgt_combined
  simp_alive_peephole
  sorry
def different_size_sext_sext_sle_combined := [llvmfunc|
  llvm.func @different_size_sext_sext_sle(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg1 : i4 to i7
    %1 = llvm.icmp "sge" %0, %arg0 : i7
    llvm.return %1 : i1
  }]

theorem inst_combine_different_size_sext_sext_sle   : different_size_sext_sext_sle_before  ⊑  different_size_sext_sext_sle_combined := by
  unfold different_size_sext_sext_sle_before different_size_sext_sext_sle_combined
  simp_alive_peephole
  sorry
def different_size_sext_sext_eq_combined := [llvmfunc|
  llvm.func @different_size_sext_sext_eq(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg1 : i4 to i7
    %1 = llvm.icmp "eq" %0, %arg0 : i7
    llvm.return %1 : i1
  }]

theorem inst_combine_different_size_sext_sext_eq   : different_size_sext_sext_eq_before  ⊑  different_size_sext_sext_eq_combined := by
  unfold different_size_sext_sext_eq_before different_size_sext_sext_eq_combined
  simp_alive_peephole
  sorry
def different_size_sext_sext_ule_combined := [llvmfunc|
  llvm.func @different_size_sext_sext_ule(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg1 : i4 to i7
    %1 = llvm.icmp "uge" %0, %arg0 : i7
    llvm.return %1 : i1
  }]

theorem inst_combine_different_size_sext_sext_ule   : different_size_sext_sext_ule_before  ⊑  different_size_sext_sext_ule_combined := by
  unfold different_size_sext_sext_ule_before different_size_sext_sext_ule_combined
  simp_alive_peephole
  sorry
def different_size_sext_zext_ne_combined := [llvmfunc|
  llvm.func @different_size_sext_zext_ne(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    %1 = llvm.zext %arg1 : i4 to i25
    %2 = llvm.icmp "ne" %0, %1 : i25
    llvm.return %2 : i1
  }]

theorem inst_combine_different_size_sext_zext_ne   : different_size_sext_zext_ne_before  ⊑  different_size_sext_zext_ne_combined := by
  unfold different_size_sext_zext_ne_before different_size_sext_zext_ne_combined
  simp_alive_peephole
  sorry
def different_size_sext_sext_ule_extra_use1_combined := [llvmfunc|
  llvm.func @different_size_sext_sext_ule_extra_use1(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg1 : i4 to i25
    llvm.call @use(%0) : (i25) -> ()
    %1 = llvm.sext %arg1 : i4 to i7
    %2 = llvm.icmp "uge" %1, %arg0 : i7
    llvm.return %2 : i1
  }]

theorem inst_combine_different_size_sext_sext_ule_extra_use1   : different_size_sext_sext_ule_extra_use1_before  ⊑  different_size_sext_sext_ule_extra_use1_combined := by
  unfold different_size_sext_sext_ule_extra_use1_before different_size_sext_sext_ule_extra_use1_combined
  simp_alive_peephole
  sorry
def different_size_sext_sext_ule_extra_use2_combined := [llvmfunc|
  llvm.func @different_size_sext_sext_ule_extra_use2(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    llvm.call @use(%0) : (i25) -> ()
    %1 = llvm.sext %arg1 : i4 to i7
    %2 = llvm.icmp "uge" %1, %arg0 : i7
    llvm.return %2 : i1
  }]

theorem inst_combine_different_size_sext_sext_ule_extra_use2   : different_size_sext_sext_ule_extra_use2_before  ⊑  different_size_sext_sext_ule_extra_use2_combined := by
  unfold different_size_sext_sext_ule_extra_use2_before different_size_sext_sext_ule_extra_use2_combined
  simp_alive_peephole
  sorry
def different_size_sext_sext_ule_extra_use3_combined := [llvmfunc|
  llvm.func @different_size_sext_sext_ule_extra_use3(%arg0: i7, %arg1: i4) -> i1 {
    %0 = llvm.sext %arg0 : i7 to i25
    llvm.call @use(%0) : (i25) -> ()
    %1 = llvm.sext %arg1 : i4 to i25
    llvm.call @use(%1) : (i25) -> ()
    %2 = llvm.icmp "ule" %0, %1 : i25
    llvm.return %2 : i1
  }]

theorem inst_combine_different_size_sext_sext_ule_extra_use3   : different_size_sext_sext_ule_extra_use3_before  ⊑  different_size_sext_sext_ule_extra_use3_combined := by
  unfold different_size_sext_sext_ule_extra_use3_before different_size_sext_sext_ule_extra_use3_combined
  simp_alive_peephole
  sorry
