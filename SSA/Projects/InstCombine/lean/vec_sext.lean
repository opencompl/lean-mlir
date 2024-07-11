import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vec_sext
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def vec_select_before := [llvmfunc|
  llvm.func @vec_select(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.icmp "slt" %arg1, %1 : vector<4xi32>
    %4 = llvm.sext %3 : vector<4xi1> to vector<4xi32>
    %5 = llvm.sub %1, %arg0 overflow<nsw>  : vector<4xi32>
    %6 = llvm.icmp "slt" %4, %1 : vector<4xi32>
    %7 = llvm.sext %6 : vector<4xi1> to vector<4xi32>
    %8 = llvm.xor %7, %2  : vector<4xi32>
    %9 = llvm.and %arg0, %8  : vector<4xi32>
    %10 = llvm.and %7, %5  : vector<4xi32>
    %11 = llvm.or %9, %10  : vector<4xi32>
    llvm.return %11 : vector<4xi32>
  }]

def vec_select_alternate_sign_bit_test_before := [llvmfunc|
  llvm.func @vec_select_alternate_sign_bit_test(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.icmp "sgt" %arg1, %0 : vector<4xi32>
    %4 = llvm.sext %3 : vector<4xi1> to vector<4xi32>
    %5 = llvm.sub %2, %arg0 overflow<nsw>  : vector<4xi32>
    %6 = llvm.icmp "slt" %4, %2 : vector<4xi32>
    %7 = llvm.sext %6 : vector<4xi1> to vector<4xi32>
    %8 = llvm.xor %7, %0  : vector<4xi32>
    %9 = llvm.and %arg0, %8  : vector<4xi32>
    %10 = llvm.and %7, %5  : vector<4xi32>
    %11 = llvm.or %9, %10  : vector<4xi32>
    llvm.return %11 : vector<4xi32>
  }]

def is_negative_poison_elt_before := [llvmfunc|
  llvm.func @is_negative_poison_elt(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.icmp "slt" %arg0, %6 : vector<2xi32>
    %8 = llvm.sext %7 : vector<2xi1> to vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def is_positive_poison_elt_before := [llvmfunc|
  llvm.func @is_positive_poison_elt(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.icmp "sgt" %arg0, %6 : vector<2xi32>
    %8 = llvm.sext %7 : vector<2xi1> to vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def vec_select_combined := [llvmfunc|
  llvm.func @vec_select(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %1, %arg0 overflow<nsw>  : vector<4xi32>
    %3 = llvm.icmp "slt" %arg1, %1 : vector<4xi32>
    %4 = llvm.select %3, %1, %arg0 : vector<4xi1>, vector<4xi32>
    %5 = llvm.icmp "slt" %arg1, %1 : vector<4xi32>
    %6 = llvm.select %5, %2, %1 : vector<4xi1>, vector<4xi32>
    %7 = llvm.or %4, %6  : vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }]

theorem inst_combine_vec_select   : vec_select_before  ⊑  vec_select_combined := by
  unfold vec_select_before vec_select_combined
  simp_alive_peephole
  sorry
def vec_select_alternate_sign_bit_test_combined := [llvmfunc|
  llvm.func @vec_select_alternate_sign_bit_test(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %1, %arg0 overflow<nsw>  : vector<4xi32>
    %3 = llvm.icmp "slt" %arg1, %1 : vector<4xi32>
    %4 = llvm.select %3, %arg0, %2 : vector<4xi1>, vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_vec_select_alternate_sign_bit_test   : vec_select_alternate_sign_bit_test_before  ⊑  vec_select_alternate_sign_bit_test_combined := by
  unfold vec_select_alternate_sign_bit_test_before vec_select_alternate_sign_bit_test_combined
  simp_alive_peephole
  sorry
def is_negative_poison_elt_combined := [llvmfunc|
  llvm.func @is_negative_poison_elt(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.ashr %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_is_negative_poison_elt   : is_negative_poison_elt_before  ⊑  is_negative_poison_elt_combined := by
  unfold is_negative_poison_elt_before is_negative_poison_elt_combined
  simp_alive_peephole
  sorry
def is_positive_poison_elt_combined := [llvmfunc|
  llvm.func @is_positive_poison_elt(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.icmp "sgt" %arg0, %6 : vector<2xi32>
    %8 = llvm.sext %7 : vector<2xi1> to vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

theorem inst_combine_is_positive_poison_elt   : is_positive_poison_elt_before  ⊑  is_positive_poison_elt_combined := by
  unfold is_positive_poison_elt_before is_positive_poison_elt_combined
  simp_alive_peephole
  sorry
