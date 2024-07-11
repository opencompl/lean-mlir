import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  zext-bool-add-sub
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def a_before := [llvmfunc|
  llvm.func @a(%arg0: i1 {llvm.zeroext}, %arg1: i1 {llvm.zeroext}) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.zext %arg0 : i1 to i32
    %3 = llvm.zext %arg1 : i1 to i32
    %4 = llvm.sub %0, %3  : i32
    %5 = llvm.add %2, %1  : i32
    %6 = llvm.add %5, %4  : i32
    llvm.return %6 : i32
  }]

def PR30273_select_before := [llvmfunc|
  llvm.func @PR30273_select(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.zext %arg0 : i1 to i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.select %arg1, %3, %2 : i1, i32
    llvm.return %4 : i32
  }]

def PR30273_zext_add_before := [llvmfunc|
  llvm.func @PR30273_zext_add(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.add %1, %0 overflow<nsw, nuw>  : i32
    llvm.return %2 : i32
  }]

def PR30273_three_bools_before := [llvmfunc|
  llvm.func @PR30273_three_bools(%arg0: i1, %arg1: i1, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.add %1, %0 overflow<nsw>  : i32
    %3 = llvm.select %arg1, %2, %1 : i1, i32
    %4 = llvm.add %3, %0 overflow<nsw>  : i32
    %5 = llvm.select %arg2, %4, %3 : i1, i32
    llvm.return %5 : i32
  }]

def zext_add_scalar_before := [llvmfunc|
  llvm.func @zext_add_scalar(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.add %1, %0  : i32
    llvm.return %2 : i32
  }]

def zext_add_vec_splat_before := [llvmfunc|
  llvm.func @zext_add_vec_splat(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.add %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def zext_add_vec_before := [llvmfunc|
  llvm.func @zext_add_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 23]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.add %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def zext_negate_before := [llvmfunc|
  llvm.func @zext_negate(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.sub %0, %1  : i64
    llvm.return %2 : i64
  }]

def zext_negate_extra_use_before := [llvmfunc|
  llvm.func @zext_negate_extra_use(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.sub %0, %1  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.return %2 : i64
  }]

def zext_negate_vec_before := [llvmfunc|
  llvm.func @zext_negate_vec(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.zext %arg0 : vector<2xi1> to vector<2xi64>
    %3 = llvm.sub %1, %2  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

def zext_negate_vec_poison_elt_before := [llvmfunc|
  llvm.func @zext_negate_vec_poison_elt(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.zext %arg0 : vector<2xi1> to vector<2xi64>
    %8 = llvm.sub %6, %7  : vector<2xi64>
    llvm.return %8 : vector<2xi64>
  }]

def zext_sub_const_before := [llvmfunc|
  llvm.func @zext_sub_const(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.sub %0, %1  : i64
    llvm.return %2 : i64
  }]

def zext_sub_const_extra_use_before := [llvmfunc|
  llvm.func @zext_sub_const_extra_use(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.sub %0, %1  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.return %2 : i64
  }]

def zext_sub_const_vec_before := [llvmfunc|
  llvm.func @zext_sub_const_vec(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[42, 3]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi64>
    %2 = llvm.sub %0, %1  : vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

def zext_sub_const_vec_poison_elt_before := [llvmfunc|
  llvm.func @zext_sub_const_vec_poison_elt(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(42 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.zext %arg0 : vector<2xi1> to vector<2xi64>
    %8 = llvm.sub %6, %7  : vector<2xi64>
    llvm.return %8 : vector<2xi64>
  }]

def sext_negate_before := [llvmfunc|
  llvm.func @sext_negate(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.sub %0, %1  : i64
    llvm.return %2 : i64
  }]

def sext_negate_extra_use_before := [llvmfunc|
  llvm.func @sext_negate_extra_use(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.sub %0, %1  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.return %2 : i64
  }]

def sext_negate_vec_before := [llvmfunc|
  llvm.func @sext_negate_vec(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sext %arg0 : vector<2xi1> to vector<2xi64>
    %3 = llvm.sub %1, %2  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

def sext_negate_vec_poison_elt_before := [llvmfunc|
  llvm.func @sext_negate_vec_poison_elt(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.sext %arg0 : vector<2xi1> to vector<2xi64>
    %8 = llvm.sub %6, %7  : vector<2xi64>
    llvm.return %8 : vector<2xi64>
  }]

def sext_sub_const_before := [llvmfunc|
  llvm.func @sext_sub_const(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.sub %0, %1  : i64
    llvm.return %2 : i64
  }]

def sext_sub_const_extra_use_before := [llvmfunc|
  llvm.func @sext_sub_const_extra_use(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.sub %0, %1  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.return %2 : i64
  }]

def sext_sub_const_vec_before := [llvmfunc|
  llvm.func @sext_sub_const_vec(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[42, 3]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi64>
    %2 = llvm.sub %0, %1  : vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

def sext_sub_const_vec_poison_elt_before := [llvmfunc|
  llvm.func @sext_sub_const_vec_poison_elt(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.sext %arg0 : vector<2xi1> to vector<2xi64>
    %8 = llvm.sub %6, %7  : vector<2xi64>
    llvm.return %8 : vector<2xi64>
  }]

def sext_sub_before := [llvmfunc|
  llvm.func @sext_sub(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def sext_sub_vec_before := [llvmfunc|
  llvm.func @sext_sub_vec(%arg0: vector<2xi8>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.sext %arg1 : vector<2xi1> to vector<2xi8>
    %1 = llvm.sub %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def sext_sub_vec_nsw_before := [llvmfunc|
  llvm.func @sext_sub_vec_nsw(%arg0: vector<2xi8>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.sext %arg1 : vector<2xi1> to vector<2xi8>
    %1 = llvm.sub %arg0, %0 overflow<nsw>  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def sext_sub_nuw_before := [llvmfunc|
  llvm.func @sext_sub_nuw(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.sub %arg0, %0 overflow<nuw>  : i8
    llvm.return %1 : i8
  }]

def sextbool_add_before := [llvmfunc|
  llvm.func @sextbool_add(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.sext %arg0 : i1 to i32
    %1 = llvm.add %0, %arg1  : i32
    llvm.return %1 : i32
  }]

def sextbool_add_commute_before := [llvmfunc|
  llvm.func @sextbool_add_commute(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.urem %arg1, %0  : i32
    %2 = llvm.sext %arg0 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    llvm.return %3 : i32
  }]

def sextbool_add_uses_before := [llvmfunc|
  llvm.func @sextbool_add_uses(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.sext %arg0 : i1 to i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.add %0, %arg1  : i32
    llvm.return %1 : i32
  }]

def sextbool_add_vector_before := [llvmfunc|
  llvm.func @sextbool_add_vector(%arg0: vector<4xi1>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %1 = llvm.add %arg1, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

def zextbool_sub_before := [llvmfunc|
  llvm.func @zextbool_sub(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i32
    %1 = llvm.sub %0, %arg1  : i32
    llvm.return %1 : i32
  }]

def zextbool_sub_uses_before := [llvmfunc|
  llvm.func @zextbool_sub_uses(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.sub %arg1, %0  : i32
    llvm.return %1 : i32
  }]

def zextbool_sub_vector_before := [llvmfunc|
  llvm.func @zextbool_sub_vector(%arg0: vector<4xi1>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.zext %arg0 : vector<4xi1> to vector<4xi32>
    %1 = llvm.sub %arg1, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

def a_combined := [llvmfunc|
  llvm.func @a(%arg0: i1 {llvm.zeroext}, %arg1: i1 {llvm.zeroext}) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.add %3, %2 overflow<nsw>  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_a   : a_before  ⊑  a_combined := by
  unfold a_before a_combined
  simp_alive_peephole
  sorry
def PR30273_select_combined := [llvmfunc|
  llvm.func @PR30273_select(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.zext %arg0 : i1 to i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.select %arg1, %3, %2 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_PR30273_select   : PR30273_select_before  ⊑  PR30273_select_combined := by
  unfold PR30273_select_before PR30273_select_combined
  simp_alive_peephole
  sorry
def PR30273_zext_add_combined := [llvmfunc|
  llvm.func @PR30273_zext_add(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.add %1, %0 overflow<nsw, nuw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_PR30273_zext_add   : PR30273_zext_add_before  ⊑  PR30273_zext_add_combined := by
  unfold PR30273_zext_add_before PR30273_zext_add_combined
  simp_alive_peephole
  sorry
def PR30273_three_bools_combined := [llvmfunc|
  llvm.func @PR30273_three_bools(%arg0: i1, %arg1: i1, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.zext %arg0 : i1 to i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.select %arg1, %3, %2 : i1, i32
    %5 = llvm.zext %arg2 : i1 to i32
    %6 = llvm.add %4, %5 overflow<nsw, nuw>  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_PR30273_three_bools   : PR30273_three_bools_before  ⊑  PR30273_three_bools_combined := by
  unfold PR30273_three_bools_before PR30273_three_bools_combined
  simp_alive_peephole
  sorry
def zext_add_scalar_combined := [llvmfunc|
  llvm.func @zext_add_scalar(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(43 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_zext_add_scalar   : zext_add_scalar_before  ⊑  zext_add_scalar_combined := by
  unfold zext_add_scalar_before zext_add_scalar_combined
  simp_alive_peephole
  sorry
def zext_add_vec_splat_combined := [llvmfunc|
  llvm.func @zext_add_vec_splat(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<43> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_zext_add_vec_splat   : zext_add_vec_splat_before  ⊑  zext_add_vec_splat_combined := by
  unfold zext_add_vec_splat_before zext_add_vec_splat_combined
  simp_alive_peephole
  sorry
def zext_add_vec_combined := [llvmfunc|
  llvm.func @zext_add_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[43, 24]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[42, 23]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_zext_add_vec   : zext_add_vec_before  ⊑  zext_add_vec_combined := by
  unfold zext_add_vec_before zext_add_vec_combined
  simp_alive_peephole
  sorry
def zext_negate_combined := [llvmfunc|
  llvm.func @zext_negate(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    llvm.return %0 : i64
  }]

theorem inst_combine_zext_negate   : zext_negate_before  ⊑  zext_negate_combined := by
  unfold zext_negate_before zext_negate_combined
  simp_alive_peephole
  sorry
def zext_negate_extra_use_combined := [llvmfunc|
  llvm.func @zext_negate_extra_use(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.return %0 : i64
  }]

theorem inst_combine_zext_negate_extra_use   : zext_negate_extra_use_before  ⊑  zext_negate_extra_use_combined := by
  unfold zext_negate_extra_use_before zext_negate_extra_use_combined
  simp_alive_peephole
  sorry
def zext_negate_vec_combined := [llvmfunc|
  llvm.func @zext_negate_vec(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.sext %arg0 : vector<2xi1> to vector<2xi64>
    llvm.return %0 : vector<2xi64>
  }]

theorem inst_combine_zext_negate_vec   : zext_negate_vec_before  ⊑  zext_negate_vec_combined := by
  unfold zext_negate_vec_before zext_negate_vec_combined
  simp_alive_peephole
  sorry
def zext_negate_vec_poison_elt_combined := [llvmfunc|
  llvm.func @zext_negate_vec_poison_elt(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.sext %arg0 : vector<2xi1> to vector<2xi64>
    llvm.return %0 : vector<2xi64>
  }]

theorem inst_combine_zext_negate_vec_poison_elt   : zext_negate_vec_poison_elt_before  ⊑  zext_negate_vec_poison_elt_combined := by
  unfold zext_negate_vec_poison_elt_before zext_negate_vec_poison_elt_combined
  simp_alive_peephole
  sorry
def zext_sub_const_combined := [llvmfunc|
  llvm.func @zext_sub_const(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(41 : i64) : i64
    %1 = llvm.mlir.constant(42 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    llvm.return %2 : i64
  }]

theorem inst_combine_zext_sub_const   : zext_sub_const_before  ⊑  zext_sub_const_combined := by
  unfold zext_sub_const_before zext_sub_const_combined
  simp_alive_peephole
  sorry
def zext_sub_const_extra_use_combined := [llvmfunc|
  llvm.func @zext_sub_const_extra_use(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(41 : i64) : i64
    %1 = llvm.mlir.constant(42 : i64) : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.select %arg0, %0, %1 : i1, i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.return %3 : i64
  }]

theorem inst_combine_zext_sub_const_extra_use   : zext_sub_const_extra_use_before  ⊑  zext_sub_const_extra_use_combined := by
  unfold zext_sub_const_extra_use_before zext_sub_const_extra_use_combined
  simp_alive_peephole
  sorry
def zext_sub_const_vec_combined := [llvmfunc|
  llvm.func @zext_sub_const_vec(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[41, 2]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[42, 3]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_zext_sub_const_vec   : zext_sub_const_vec_before  ⊑  zext_sub_const_vec_combined := by
  unfold zext_sub_const_vec_before zext_sub_const_vec_combined
  simp_alive_peephole
  sorry
def zext_sub_const_vec_poison_elt_combined := [llvmfunc|
  llvm.func @zext_sub_const_vec_poison_elt(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(41 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.mlir.constant(42 : i64) : i64
    %8 = llvm.mlir.undef : vector<2xi64>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi64>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi64>
    %13 = llvm.select %arg0, %6, %12 : vector<2xi1>, vector<2xi64>
    llvm.return %13 : vector<2xi64>
  }]

theorem inst_combine_zext_sub_const_vec_poison_elt   : zext_sub_const_vec_poison_elt_before  ⊑  zext_sub_const_vec_poison_elt_combined := by
  unfold zext_sub_const_vec_poison_elt_before zext_sub_const_vec_poison_elt_combined
  simp_alive_peephole
  sorry
def sext_negate_combined := [llvmfunc|
  llvm.func @sext_negate(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    llvm.return %0 : i64
  }]

theorem inst_combine_sext_negate   : sext_negate_before  ⊑  sext_negate_combined := by
  unfold sext_negate_before sext_negate_combined
  simp_alive_peephole
  sorry
def sext_negate_extra_use_combined := [llvmfunc|
  llvm.func @sext_negate_extra_use(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.return %0 : i64
  }]

theorem inst_combine_sext_negate_extra_use   : sext_negate_extra_use_before  ⊑  sext_negate_extra_use_combined := by
  unfold sext_negate_extra_use_before sext_negate_extra_use_combined
  simp_alive_peephole
  sorry
def sext_negate_vec_combined := [llvmfunc|
  llvm.func @sext_negate_vec(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.zext %arg0 : vector<2xi1> to vector<2xi64>
    llvm.return %0 : vector<2xi64>
  }]

theorem inst_combine_sext_negate_vec   : sext_negate_vec_before  ⊑  sext_negate_vec_combined := by
  unfold sext_negate_vec_before sext_negate_vec_combined
  simp_alive_peephole
  sorry
def sext_negate_vec_poison_elt_combined := [llvmfunc|
  llvm.func @sext_negate_vec_poison_elt(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.zext %arg0 : vector<2xi1> to vector<2xi64>
    llvm.return %0 : vector<2xi64>
  }]

theorem inst_combine_sext_negate_vec_poison_elt   : sext_negate_vec_poison_elt_before  ⊑  sext_negate_vec_poison_elt_combined := by
  unfold sext_negate_vec_poison_elt_before sext_negate_vec_poison_elt_combined
  simp_alive_peephole
  sorry
def sext_sub_const_combined := [llvmfunc|
  llvm.func @sext_sub_const(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(43 : i64) : i64
    %1 = llvm.mlir.constant(42 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    llvm.return %2 : i64
  }]

theorem inst_combine_sext_sub_const   : sext_sub_const_before  ⊑  sext_sub_const_combined := by
  unfold sext_sub_const_before sext_sub_const_combined
  simp_alive_peephole
  sorry
def sext_sub_const_extra_use_combined := [llvmfunc|
  llvm.func @sext_sub_const_extra_use(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(43 : i64) : i64
    %1 = llvm.mlir.constant(42 : i64) : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.select %arg0, %0, %1 : i1, i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.return %3 : i64
  }]

theorem inst_combine_sext_sub_const_extra_use   : sext_sub_const_extra_use_before  ⊑  sext_sub_const_extra_use_combined := by
  unfold sext_sub_const_extra_use_before sext_sub_const_extra_use_combined
  simp_alive_peephole
  sorry
def sext_sub_const_vec_combined := [llvmfunc|
  llvm.func @sext_sub_const_vec(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[43, 4]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[42, 3]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_sext_sub_const_vec   : sext_sub_const_vec_before  ⊑  sext_sub_const_vec_combined := by
  unfold sext_sub_const_vec_before sext_sub_const_vec_combined
  simp_alive_peephole
  sorry
def sext_sub_const_vec_poison_elt_combined := [llvmfunc|
  llvm.func @sext_sub_const_vec_poison_elt(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(43 : i64) : i64
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.mlir.constant(42 : i64) : i64
    %8 = llvm.mlir.undef : vector<2xi64>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<2xi64>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %7, %10[%11 : i32] : vector<2xi64>
    %13 = llvm.select %arg0, %6, %12 : vector<2xi1>, vector<2xi64>
    llvm.return %13 : vector<2xi64>
  }]

theorem inst_combine_sext_sub_const_vec_poison_elt   : sext_sub_const_vec_poison_elt_before  ⊑  sext_sub_const_vec_poison_elt_combined := by
  unfold sext_sub_const_vec_poison_elt_before sext_sub_const_vec_poison_elt_combined
  simp_alive_peephole
  sorry
def sext_sub_combined := [llvmfunc|
  llvm.func @sext_sub(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.zext %arg1 : i1 to i8
    %1 = llvm.add %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_sext_sub   : sext_sub_before  ⊑  sext_sub_combined := by
  unfold sext_sub_before sext_sub_combined
  simp_alive_peephole
  sorry
def sext_sub_vec_combined := [llvmfunc|
  llvm.func @sext_sub_vec(%arg0: vector<2xi8>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.zext %arg1 : vector<2xi1> to vector<2xi8>
    %1 = llvm.add %0, %arg0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_sext_sub_vec   : sext_sub_vec_before  ⊑  sext_sub_vec_combined := by
  unfold sext_sub_vec_before sext_sub_vec_combined
  simp_alive_peephole
  sorry
def sext_sub_vec_nsw_combined := [llvmfunc|
  llvm.func @sext_sub_vec_nsw(%arg0: vector<2xi8>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.zext %arg1 : vector<2xi1> to vector<2xi8>
    %1 = llvm.add %0, %arg0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_sext_sub_vec_nsw   : sext_sub_vec_nsw_before  ⊑  sext_sub_vec_nsw_combined := by
  unfold sext_sub_vec_nsw_before sext_sub_vec_nsw_combined
  simp_alive_peephole
  sorry
def sext_sub_nuw_combined := [llvmfunc|
  llvm.func @sext_sub_nuw(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.zext %arg1 : i1 to i8
    %1 = llvm.add %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_sext_sub_nuw   : sext_sub_nuw_before  ⊑  sext_sub_nuw_combined := by
  unfold sext_sub_nuw_before sext_sub_nuw_combined
  simp_alive_peephole
  sorry
def sextbool_add_combined := [llvmfunc|
  llvm.func @sextbool_add(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.sext %arg0 : i1 to i32
    %1 = llvm.add %0, %arg1  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_sextbool_add   : sextbool_add_before  ⊑  sextbool_add_combined := by
  unfold sextbool_add_before sextbool_add_combined
  simp_alive_peephole
  sorry
def sextbool_add_commute_combined := [llvmfunc|
  llvm.func @sextbool_add_commute(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.urem %arg1, %0  : i32
    %2 = llvm.sext %arg0 : i1 to i32
    %3 = llvm.add %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sextbool_add_commute   : sextbool_add_commute_before  ⊑  sextbool_add_commute_combined := by
  unfold sextbool_add_commute_before sextbool_add_commute_combined
  simp_alive_peephole
  sorry
def sextbool_add_uses_combined := [llvmfunc|
  llvm.func @sextbool_add_uses(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.sext %arg0 : i1 to i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.add %0, %arg1  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_sextbool_add_uses   : sextbool_add_uses_before  ⊑  sextbool_add_uses_combined := by
  unfold sextbool_add_uses_before sextbool_add_uses_combined
  simp_alive_peephole
  sorry
def sextbool_add_vector_combined := [llvmfunc|
  llvm.func @sextbool_add_vector(%arg0: vector<4xi1>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %1 = llvm.add %0, %arg1  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_sextbool_add_vector   : sextbool_add_vector_before  ⊑  sextbool_add_vector_combined := by
  unfold sextbool_add_vector_before sextbool_add_vector_combined
  simp_alive_peephole
  sorry
def zextbool_sub_combined := [llvmfunc|
  llvm.func @zextbool_sub(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i32
    %1 = llvm.sub %0, %arg1  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_zextbool_sub   : zextbool_sub_before  ⊑  zextbool_sub_combined := by
  unfold zextbool_sub_before zextbool_sub_combined
  simp_alive_peephole
  sorry
def zextbool_sub_uses_combined := [llvmfunc|
  llvm.func @zextbool_sub_uses(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.sub %arg1, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_zextbool_sub_uses   : zextbool_sub_uses_before  ⊑  zextbool_sub_uses_combined := by
  unfold zextbool_sub_uses_before zextbool_sub_uses_combined
  simp_alive_peephole
  sorry
def zextbool_sub_vector_combined := [llvmfunc|
  llvm.func @zextbool_sub_vector(%arg0: vector<4xi1>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %1 = llvm.add %0, %arg1  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_zextbool_sub_vector   : zextbool_sub_vector_before  ⊑  zextbool_sub_vector_combined := by
  unfold zextbool_sub_vector_before zextbool_sub_vector_combined
  simp_alive_peephole
  sorry
