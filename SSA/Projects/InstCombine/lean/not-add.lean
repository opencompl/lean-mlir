import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  not-add
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def basic_before := [llvmfunc|
  llvm.func @basic(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.add %1, %arg1  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

def basic_com_add_before := [llvmfunc|
  llvm.func @basic_com_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.add %arg0, %1  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

def basic_use_xor_before := [llvmfunc|
  llvm.func @basic_use_xor(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.add %1, %arg1  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

def basic_use_add_before := [llvmfunc|
  llvm.func @basic_use_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.add %1, %arg1  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

def basic_use_both_before := [llvmfunc|
  llvm.func @basic_use_both(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.add %1, %arg1  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

def basic_preserve_nsw_before := [llvmfunc|
  llvm.func @basic_preserve_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.add %1, %arg1 overflow<nsw>  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

def basic_preserve_nuw_before := [llvmfunc|
  llvm.func @basic_preserve_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.add %1, %arg1 overflow<nuw>  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

def basic_preserve_nuw_nsw_before := [llvmfunc|
  llvm.func @basic_preserve_nuw_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.add %1, %arg1 overflow<nsw, nuw>  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

def vector_test_before := [llvmfunc|
  llvm.func @vector_test(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.xor %arg0, %0  : vector<4xi32>
    %2 = llvm.add %1, %arg1  : vector<4xi32>
    %3 = llvm.xor %2, %0  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def vector_test_poison_before := [llvmfunc|
  llvm.func @vector_test_poison(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.undef : vector<4xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %0, %11[%12 : i32] : vector<4xi32>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %0, %13[%14 : i32] : vector<4xi32>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %1, %15[%16 : i32] : vector<4xi32>
    %18 = llvm.mlir.constant(3 : i32) : i32
    %19 = llvm.insertelement %1, %17[%18 : i32] : vector<4xi32>
    %20 = llvm.xor %arg0, %10  : vector<4xi32>
    %21 = llvm.add %20, %arg1  : vector<4xi32>
    %22 = llvm.xor %21, %19  : vector<4xi32>
    llvm.return %22 : vector<4xi32>
  }]

def vector_test_poison_nsw_nuw_before := [llvmfunc|
  llvm.func @vector_test_poison_nsw_nuw(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.undef : vector<4xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %0, %11[%12 : i32] : vector<4xi32>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %0, %13[%14 : i32] : vector<4xi32>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %1, %15[%16 : i32] : vector<4xi32>
    %18 = llvm.mlir.constant(3 : i32) : i32
    %19 = llvm.insertelement %1, %17[%18 : i32] : vector<4xi32>
    %20 = llvm.xor %arg0, %10  : vector<4xi32>
    %21 = llvm.add %20, %arg1 overflow<nsw, nuw>  : vector<4xi32>
    %22 = llvm.xor %21, %19  : vector<4xi32>
    llvm.return %22 : vector<4xi32>
  }]

def pr50308_before := [llvmfunc|
  llvm.func @pr50308(%arg0: i1, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.add %1, %arg1 overflow<nsw>  : i32
    %3 = llvm.xor %2, %arg2  : i32
    %4 = llvm.add %1, %3 overflow<nsw>  : i32
    llvm.br ^bb2(%4 : i32)
  ^bb2(%5: i32):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.sub %arg3, %5 overflow<nsw>  : i32
    llvm.return %6 : i32
  }]

def pr50370_before := [llvmfunc|
  llvm.func @pr50370(%arg0: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(65536 : i32) : i32
    %4 = llvm.mlir.constant(2147483647 : i32) : i32
    %5 = llvm.mlir.undef : i32
    %6 = llvm.mlir.undef : !llvm.ptr
    %7 = llvm.xor %arg0, %0  : i32
    %8 = llvm.icmp "eq" %1, %2 : !llvm.ptr
    %9 = llvm.zext %8 : i1 to i32
    %10 = llvm.or %9, %0  : i32
    %11 = llvm.or %10, %3  : i32
    %12 = llvm.ashr %3, %11  : i32
    %13 = llvm.srem %12, %7  : i32
    %14 = llvm.sdiv %11, %4  : i32
    %15 = llvm.add %13, %14  : i32
    %16 = llvm.srem %12, %15  : i32
    %17 = llvm.add %13, %12  : i32
    %18 = llvm.shl %14, %16  : i32
    %19 = llvm.xor %17, %18  : i32
    %20 = llvm.or %17, %5  : i32
    %21 = llvm.xor %19, %20  : i32
    llvm.store %21, %6 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def basic_combined := [llvmfunc|
  llvm.func @basic(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_basic   : basic_before  ⊑  basic_combined := by
  unfold basic_before basic_combined
  simp_alive_peephole
  sorry
def basic_com_add_combined := [llvmfunc|
  llvm.func @basic_com_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg1, %arg0  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_basic_com_add   : basic_com_add_before  ⊑  basic_com_add_combined := by
  unfold basic_com_add_before basic_com_add_combined
  simp_alive_peephole
  sorry
def basic_use_xor_combined := [llvmfunc|
  llvm.func @basic_use_xor(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_basic_use_xor   : basic_use_xor_before  ⊑  basic_use_xor_combined := by
  unfold basic_use_xor_before basic_use_xor_combined
  simp_alive_peephole
  sorry
def basic_use_add_combined := [llvmfunc|
  llvm.func @basic_use_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.add %1, %arg1  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %arg1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_basic_use_add   : basic_use_add_before  ⊑  basic_use_add_combined := by
  unfold basic_use_add_before basic_use_add_combined
  simp_alive_peephole
  sorry
def basic_use_both_combined := [llvmfunc|
  llvm.func @basic_use_both(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.add %1, %arg1  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %arg1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_basic_use_both   : basic_use_both_before  ⊑  basic_use_both_combined := by
  unfold basic_use_both_before basic_use_both_combined
  simp_alive_peephole
  sorry
def basic_preserve_nsw_combined := [llvmfunc|
  llvm.func @basic_preserve_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_basic_preserve_nsw   : basic_preserve_nsw_before  ⊑  basic_preserve_nsw_combined := by
  unfold basic_preserve_nsw_before basic_preserve_nsw_combined
  simp_alive_peephole
  sorry
def basic_preserve_nuw_combined := [llvmfunc|
  llvm.func @basic_preserve_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nuw>  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_basic_preserve_nuw   : basic_preserve_nuw_before  ⊑  basic_preserve_nuw_combined := by
  unfold basic_preserve_nuw_before basic_preserve_nuw_combined
  simp_alive_peephole
  sorry
def basic_preserve_nuw_nsw_combined := [llvmfunc|
  llvm.func @basic_preserve_nuw_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw, nuw>  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_basic_preserve_nuw_nsw   : basic_preserve_nuw_nsw_before  ⊑  basic_preserve_nuw_nsw_combined := by
  unfold basic_preserve_nuw_nsw_before basic_preserve_nuw_nsw_combined
  simp_alive_peephole
  sorry
def vector_test_combined := [llvmfunc|
  llvm.func @vector_test(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.sub %arg0, %arg1  : vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_vector_test   : vector_test_before  ⊑  vector_test_combined := by
  unfold vector_test_before vector_test_combined
  simp_alive_peephole
  sorry
def vector_test_poison_combined := [llvmfunc|
  llvm.func @vector_test_poison(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.sub %arg0, %arg1  : vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_vector_test_poison   : vector_test_poison_before  ⊑  vector_test_poison_combined := by
  unfold vector_test_poison_before vector_test_poison_combined
  simp_alive_peephole
  sorry
def vector_test_poison_nsw_nuw_combined := [llvmfunc|
  llvm.func @vector_test_poison_nsw_nuw(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw, nuw>  : vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_vector_test_poison_nsw_nuw   : vector_test_poison_nsw_nuw_before  ⊑  vector_test_poison_nsw_nuw_combined := by
  unfold vector_test_poison_nsw_nuw_before vector_test_poison_nsw_nuw_combined
  simp_alive_peephole
  sorry
def pr50308_combined := [llvmfunc|
  llvm.func @pr50308(%arg0: i1, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %1, %arg1  : i32
    %3 = llvm.xor %2, %arg2  : i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.add %4, %arg3  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_pr50308   : pr50308_before  ⊑  pr50308_combined := by
  unfold pr50308_before pr50308_combined
  simp_alive_peephole
  sorry
def pr50370_combined := [llvmfunc|
  llvm.func @pr50370(%arg0: i32) {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.undef : !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_pr50370   : pr50370_before  ⊑  pr50370_combined := by
  unfold pr50370_before pr50370_combined
  simp_alive_peephole
  sorry
