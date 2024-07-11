import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-logical
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def masked_and_notallzeroes_before := [llvmfunc|
  llvm.func @masked_and_notallzeroes(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(39 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

def masked_and_notallzeroes_splat_before := [llvmfunc|
  llvm.func @masked_and_notallzeroes_splat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<39> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi32>
    %6 = llvm.and %arg0, %3  : vector<2xi32>
    %7 = llvm.icmp "ne" %6, %2 : vector<2xi32>
    %8 = llvm.and %5, %7  : vector<2xi1>
    llvm.return %8 : vector<2xi1>
  }]

def masked_and_notallzeroes_logical_before := [llvmfunc|
  llvm.func @masked_and_notallzeroes_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(39 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }]

def masked_or_allzeroes_before := [llvmfunc|
  llvm.func @masked_or_allzeroes(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(39 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def masked_or_allzeroes_logical_before := [llvmfunc|
  llvm.func @masked_or_allzeroes_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(39 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }]

def masked_and_notallones_before := [llvmfunc|
  llvm.func @masked_and_notallones(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def masked_and_notallones_logical_before := [llvmfunc|
  llvm.func @masked_and_notallones_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    %5 = llvm.and %arg0, %1  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.select %4, %6, %2 : i1, i1
    llvm.return %7 : i1
  }]

def masked_or_allones_before := [llvmfunc|
  llvm.func @masked_or_allones(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def masked_or_allones_logical_before := [llvmfunc|
  llvm.func @masked_or_allones_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.and %arg0, %1  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.select %4, %2, %6 : i1, i1
    llvm.return %7 : i1
  }]

def masked_and_notA_before := [llvmfunc|
  llvm.func @masked_and_notA(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(78 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %arg0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.icmp "ne" %4, %arg0 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def masked_and_notA_logical_before := [llvmfunc|
  llvm.func @masked_and_notA_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(78 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %arg0 : i32
    %5 = llvm.and %arg0, %1  : i32
    %6 = llvm.icmp "ne" %5, %arg0 : i32
    %7 = llvm.select %4, %6, %2 : i1, i1
    llvm.return %7 : i1
  }]

def masked_and_notA_slightly_optimized_before := [llvmfunc|
  llvm.func @masked_and_notA_slightly_optimized(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.icmp "uge" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %arg0 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }]

def masked_and_notA_slightly_optimized_logical_before := [llvmfunc|
  llvm.func @masked_and_notA_slightly_optimized_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "uge" %arg0, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.icmp "ne" %4, %arg0 : i32
    %6 = llvm.select %3, %5, %2 : i1, i1
    llvm.return %6 : i1
  }]

def masked_or_A_before := [llvmfunc|
  llvm.func @masked_or_A(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(78 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %arg0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.icmp "eq" %4, %arg0 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def masked_or_A_logical_before := [llvmfunc|
  llvm.func @masked_or_A_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(78 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %arg0 : i32
    %5 = llvm.and %arg0, %1  : i32
    %6 = llvm.icmp "eq" %5, %arg0 : i32
    %7 = llvm.select %4, %2, %6 : i1, i1
    llvm.return %7 : i1
  }]

def masked_or_A_slightly_optimized_before := [llvmfunc|
  llvm.func @masked_or_A_slightly_optimized(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "eq" %3, %arg0 : i32
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }]

def masked_or_A_slightly_optimized_logical_before := [llvmfunc|
  llvm.func @masked_or_A_slightly_optimized_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.icmp "eq" %4, %arg0 : i32
    %6 = llvm.select %3, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

def masked_or_allzeroes_notoptimised_before := [llvmfunc|
  llvm.func @masked_or_allzeroes_notoptimised(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(39 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def masked_or_allzeroes_notoptimised_logical_before := [llvmfunc|
  llvm.func @masked_or_allzeroes_notoptimised_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(39 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }]

def nomask_lhs_before := [llvmfunc|
  llvm.func @nomask_lhs(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }]

def nomask_lhs_logical_before := [llvmfunc|
  llvm.func @nomask_lhs_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    %6 = llvm.select %3, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

def nomask_rhs_before := [llvmfunc|
  llvm.func @nomask_rhs(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

def nomask_rhs_logical_before := [llvmfunc|
  llvm.func @nomask_rhs_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

def fold_mask_cmps_to_false_before := [llvmfunc|
  llvm.func @fold_mask_cmps_to_false(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def fold_mask_cmps_to_false_logical_before := [llvmfunc|
  llvm.func @fold_mask_cmps_to_false_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }]

def fold_mask_cmps_to_true_before := [llvmfunc|
  llvm.func @fold_mask_cmps_to_true(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.icmp "ne" %arg0, %0 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

def fold_mask_cmps_to_true_logical_before := [llvmfunc|
  llvm.func @fold_mask_cmps_to_true_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.icmp "ne" %arg0, %0 : i32
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }]

def nomask_splat_and_B_allones_before := [llvmfunc|
  llvm.func @nomask_splat_and_B_allones(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<1879048192> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.icmp "slt" %arg0, %6 : vector<2xi32>
    %9 = llvm.and %arg0, %7  : vector<2xi32>
    %10 = llvm.icmp "eq" %9, %7 : vector<2xi32>
    %11 = llvm.and %8, %10  : vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }]

def nomask_splat_and_B_mixed_before := [llvmfunc|
  llvm.func @nomask_splat_and_B_mixed(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<1879048192> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.icmp "sgt" %arg0, %6 : vector<2xi32>
    %9 = llvm.and %arg0, %7  : vector<2xi32>
    %10 = llvm.icmp "eq" %9, %7 : vector<2xi32>
    %11 = llvm.and %8, %10  : vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }]

def cmpeq_bitwise_before := [llvmfunc|
  llvm.func @cmpeq_bitwise(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.xor %arg0, %arg1  : i8
    %2 = llvm.xor %arg2, %arg3  : i8
    %3 = llvm.or %1, %2  : i8
    %4 = llvm.icmp "eq" %3, %0 : i8
    llvm.return %4 : i1
  }]

def cmpne_bitwise_before := [llvmfunc|
  llvm.func @cmpne_bitwise(%arg0: vector<2xi64>, %arg1: vector<2xi64>, %arg2: vector<2xi64>, %arg3: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.xor %arg0, %arg1  : vector<2xi64>
    %3 = llvm.xor %arg2, %arg3  : vector<2xi64>
    %4 = llvm.or %2, %3  : vector<2xi64>
    %5 = llvm.icmp "ne" %4, %1 : vector<2xi64>
    llvm.return %5 : vector<2xi1>
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_0_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_0_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_0_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_1_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_1_vector_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_1_vector(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi32>
    %7 = llvm.and %arg0, %3  : vector<2xi32>
    %8 = llvm.icmp "eq" %7, %4 : vector<2xi32>
    %9 = llvm.and %6, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_1_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_1b_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_1b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_1b_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_1b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_2_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_2_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_3_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_3_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_3_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_3b_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_3b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_3b_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_3b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_4_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_4_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_4_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_5_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_5_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_5_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "eq" %6, %2 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_6_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_6_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_6_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_7_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_7_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_7_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_7b_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_7b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_7b_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_7b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_0_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %6, %4, %8 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_1_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %6, %4, %8 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_1b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %6, %4, %8 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_2_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_3_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_3b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_4_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %6, %4, %8 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_5_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %2 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_6_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %6, %4, %8 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_7_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %6, %4, %8 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_7b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %6, %4, %8 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %7, %5  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %8, %6, %4 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %7, %5  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %8, %6, %4 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %7, %5  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %8, %6, %4 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %6, %4  : i1
    llvm.return %7 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %7, %5, %3 : i1, i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %6, %4  : i1
    llvm.return %7 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %7, %5, %3 : i1, i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %6, %4  : i1
    llvm.return %7 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %7, %5, %3 : i1, i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %7, %5  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %8, %6, %4 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    %7 = llvm.and %6, %4  : i1
    llvm.return %7 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "eq" %6, %2 : i32
    %8 = llvm.select %7, %5, %3 : i1, i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %7, %5  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %8, %6, %4 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %7, %5  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %8, %6, %4 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %7, %5  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %8, %6, %4 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %7, %5  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %8, %4, %6 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %7, %5  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %8, %4, %6 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %7, %5  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %8, %4, %6 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.or %6, %4  : i1
    llvm.return %7 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.select %7, %3, %5 : i1, i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.or %6, %4  : i1
    llvm.return %7 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.select %7, %3, %5 : i1, i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.or %6, %4  : i1
    llvm.return %7 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.select %7, %3, %5 : i1, i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %7, %5  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %8, %4, %6 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %2 : i32
    %7 = llvm.or %6, %4  : i1
    llvm.return %7 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    %8 = llvm.select %7, %3, %5 : i1, i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %7, %5  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %8, %4, %6 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %7, %5  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %8, %4, %6 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %7, %5  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical_before := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %8, %4, %6 : i1, i1
    llvm.return %9 : i1
  }]

def masked_icmps_bmask_notmixed_or_before := [llvmfunc|
  llvm.func @masked_icmps_bmask_notmixed_or(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.mlir.constant(243 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_bmask_notmixed_or_vec_before := [llvmfunc|
  llvm.func @masked_icmps_bmask_notmixed_or_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<-13> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.and %arg0, %0  : vector<2xi8>
    %5 = llvm.icmp "eq" %4, %1 : vector<2xi8>
    %6 = llvm.and %arg0, %2  : vector<2xi8>
    %7 = llvm.icmp "eq" %6, %3 : vector<2xi8>
    %8 = llvm.or %5, %7  : vector<2xi1>
    llvm.return %8 : vector<2xi1>
  }]

def masked_icmps_bmask_notmixed_or_vec_poison1_before := [llvmfunc|
  llvm.func @masked_icmps_bmask_notmixed_or_vec_poison1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.mlir.constant(dense<-13> : vector<2xi8>) : vector<2xi8>
    %10 = llvm.and %arg0, %0  : vector<2xi8>
    %11 = llvm.icmp "eq" %10, %7 : vector<2xi8>
    %12 = llvm.and %arg0, %8  : vector<2xi8>
    %13 = llvm.icmp "eq" %12, %9 : vector<2xi8>
    %14 = llvm.or %11, %13  : vector<2xi1>
    llvm.return %14 : vector<2xi1>
  }]

def masked_icmps_bmask_notmixed_or_vec_poison2_before := [llvmfunc|
  llvm.func @masked_icmps_bmask_notmixed_or_vec_poison2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.poison : i8
    %4 = llvm.mlir.constant(-13 : i8) : i8
    %5 = llvm.mlir.undef : vector<2xi8>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<2xi8>
    %10 = llvm.and %arg0, %0  : vector<2xi8>
    %11 = llvm.icmp "eq" %10, %1 : vector<2xi8>
    %12 = llvm.and %arg0, %2  : vector<2xi8>
    %13 = llvm.icmp "eq" %12, %9 : vector<2xi8>
    %14 = llvm.or %11, %13  : vector<2xi1>
    llvm.return %14 : vector<2xi1>
  }]

def masked_icmps_bmask_notmixed_or_contradict_notoptimized_before := [llvmfunc|
  llvm.func @masked_icmps_bmask_notmixed_or_contradict_notoptimized(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.mlir.constant(242 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_bmask_notmixed_and_before := [llvmfunc|
  llvm.func @masked_icmps_bmask_notmixed_and(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.mlir.constant(243 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_bmask_notmixed_and_contradict_notoptimized_before := [llvmfunc|
  llvm.func @masked_icmps_bmask_notmixed_and_contradict_notoptimized(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.mlir.constant(242 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_bmask_notmixed_and_expected_false_before := [llvmfunc|
  llvm.func @masked_icmps_bmask_notmixed_and_expected_false(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.mlir.constant(242 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def masked_icmps_bmask_notmixed_not_subset_notoptimized_before := [llvmfunc|
  llvm.func @masked_icmps_bmask_notmixed_not_subset_notoptimized(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(254 : i32) : i32
    %1 = llvm.mlir.constant(252 : i32) : i32
    %2 = llvm.mlir.constant(253 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

def masked_and_notallzeroes_combined := [llvmfunc|
  llvm.func @masked_and_notallzeroes(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_and_notallzeroes   : masked_and_notallzeroes_before  ⊑  masked_and_notallzeroes_combined := by
  unfold masked_and_notallzeroes_before masked_and_notallzeroes_combined
  simp_alive_peephole
  sorry
def masked_and_notallzeroes_splat_combined := [llvmfunc|
  llvm.func @masked_and_notallzeroes_splat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_masked_and_notallzeroes_splat   : masked_and_notallzeroes_splat_before  ⊑  masked_and_notallzeroes_splat_combined := by
  unfold masked_and_notallzeroes_splat_before masked_and_notallzeroes_splat_combined
  simp_alive_peephole
  sorry
def masked_and_notallzeroes_logical_combined := [llvmfunc|
  llvm.func @masked_and_notallzeroes_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_and_notallzeroes_logical   : masked_and_notallzeroes_logical_before  ⊑  masked_and_notallzeroes_logical_combined := by
  unfold masked_and_notallzeroes_logical_before masked_and_notallzeroes_logical_combined
  simp_alive_peephole
  sorry
def masked_or_allzeroes_combined := [llvmfunc|
  llvm.func @masked_or_allzeroes(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_or_allzeroes   : masked_or_allzeroes_before  ⊑  masked_or_allzeroes_combined := by
  unfold masked_or_allzeroes_before masked_or_allzeroes_combined
  simp_alive_peephole
  sorry
def masked_or_allzeroes_logical_combined := [llvmfunc|
  llvm.func @masked_or_allzeroes_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_or_allzeroes_logical   : masked_or_allzeroes_logical_before  ⊑  masked_or_allzeroes_logical_combined := by
  unfold masked_or_allzeroes_logical_before masked_or_allzeroes_logical_combined
  simp_alive_peephole
  sorry
def masked_and_notallones_combined := [llvmfunc|
  llvm.func @masked_and_notallones(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_masked_and_notallones   : masked_and_notallones_before  ⊑  masked_and_notallones_combined := by
  unfold masked_and_notallones_before masked_and_notallones_combined
  simp_alive_peephole
  sorry
def masked_and_notallones_logical_combined := [llvmfunc|
  llvm.func @masked_and_notallones_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_masked_and_notallones_logical   : masked_and_notallones_logical_before  ⊑  masked_and_notallones_logical_combined := by
  unfold masked_and_notallones_logical_before masked_and_notallones_logical_combined
  simp_alive_peephole
  sorry
def masked_or_allones_combined := [llvmfunc|
  llvm.func @masked_or_allones(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_masked_or_allones   : masked_or_allones_before  ⊑  masked_or_allones_combined := by
  unfold masked_or_allones_before masked_or_allones_combined
  simp_alive_peephole
  sorry
def masked_or_allones_logical_combined := [llvmfunc|
  llvm.func @masked_or_allones_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_masked_or_allones_logical   : masked_or_allones_logical_before  ⊑  masked_or_allones_logical_combined := by
  unfold masked_or_allones_logical_before masked_or_allones_logical_combined
  simp_alive_peephole
  sorry
def masked_and_notA_combined := [llvmfunc|
  llvm.func @masked_and_notA(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-79 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_and_notA   : masked_and_notA_before  ⊑  masked_and_notA_combined := by
  unfold masked_and_notA_before masked_and_notA_combined
  simp_alive_peephole
  sorry
def masked_and_notA_logical_combined := [llvmfunc|
  llvm.func @masked_and_notA_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-79 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_and_notA_logical   : masked_and_notA_logical_before  ⊑  masked_and_notA_logical_combined := by
  unfold masked_and_notA_logical_before masked_and_notA_logical_combined
  simp_alive_peephole
  sorry
def masked_and_notA_slightly_optimized_combined := [llvmfunc|
  llvm.func @masked_and_notA_slightly_optimized(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-40 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_and_notA_slightly_optimized   : masked_and_notA_slightly_optimized_before  ⊑  masked_and_notA_slightly_optimized_combined := by
  unfold masked_and_notA_slightly_optimized_before masked_and_notA_slightly_optimized_combined
  simp_alive_peephole
  sorry
def masked_and_notA_slightly_optimized_logical_combined := [llvmfunc|
  llvm.func @masked_and_notA_slightly_optimized_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-40 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_and_notA_slightly_optimized_logical   : masked_and_notA_slightly_optimized_logical_before  ⊑  masked_and_notA_slightly_optimized_logical_combined := by
  unfold masked_and_notA_slightly_optimized_logical_before masked_and_notA_slightly_optimized_logical_combined
  simp_alive_peephole
  sorry
def masked_or_A_combined := [llvmfunc|
  llvm.func @masked_or_A(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-79 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_or_A   : masked_or_A_before  ⊑  masked_or_A_combined := by
  unfold masked_or_A_before masked_or_A_combined
  simp_alive_peephole
  sorry
def masked_or_A_logical_combined := [llvmfunc|
  llvm.func @masked_or_A_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-79 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_or_A_logical   : masked_or_A_logical_before  ⊑  masked_or_A_logical_combined := by
  unfold masked_or_A_logical_before masked_or_A_logical_combined
  simp_alive_peephole
  sorry
def masked_or_A_slightly_optimized_combined := [llvmfunc|
  llvm.func @masked_or_A_slightly_optimized(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-40 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_or_A_slightly_optimized   : masked_or_A_slightly_optimized_before  ⊑  masked_or_A_slightly_optimized_combined := by
  unfold masked_or_A_slightly_optimized_before masked_or_A_slightly_optimized_combined
  simp_alive_peephole
  sorry
def masked_or_A_slightly_optimized_logical_combined := [llvmfunc|
  llvm.func @masked_or_A_slightly_optimized_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-40 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_or_A_slightly_optimized_logical   : masked_or_A_slightly_optimized_logical_before  ⊑  masked_or_A_slightly_optimized_logical_combined := by
  unfold masked_or_A_slightly_optimized_logical_before masked_or_A_slightly_optimized_logical_combined
  simp_alive_peephole
  sorry
def masked_or_allzeroes_notoptimised_combined := [llvmfunc|
  llvm.func @masked_or_allzeroes_notoptimised(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(39 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_masked_or_allzeroes_notoptimised   : masked_or_allzeroes_notoptimised_before  ⊑  masked_or_allzeroes_notoptimised_combined := by
  unfold masked_or_allzeroes_notoptimised_before masked_or_allzeroes_notoptimised_combined
  simp_alive_peephole
  sorry
def masked_or_allzeroes_notoptimised_logical_combined := [llvmfunc|
  llvm.func @masked_or_allzeroes_notoptimised_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(39 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_masked_or_allzeroes_notoptimised_logical   : masked_or_allzeroes_notoptimised_logical_before  ⊑  masked_or_allzeroes_notoptimised_logical_combined := by
  unfold masked_or_allzeroes_notoptimised_logical_before masked_or_allzeroes_notoptimised_logical_combined
  simp_alive_peephole
  sorry
def nomask_lhs_combined := [llvmfunc|
  llvm.func @nomask_lhs(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_nomask_lhs   : nomask_lhs_before  ⊑  nomask_lhs_combined := by
  unfold nomask_lhs_before nomask_lhs_combined
  simp_alive_peephole
  sorry
def nomask_lhs_logical_combined := [llvmfunc|
  llvm.func @nomask_lhs_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_nomask_lhs_logical   : nomask_lhs_logical_before  ⊑  nomask_lhs_logical_combined := by
  unfold nomask_lhs_logical_before nomask_lhs_logical_combined
  simp_alive_peephole
  sorry
def nomask_rhs_combined := [llvmfunc|
  llvm.func @nomask_rhs(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_nomask_rhs   : nomask_rhs_before  ⊑  nomask_rhs_combined := by
  unfold nomask_rhs_before nomask_rhs_combined
  simp_alive_peephole
  sorry
def nomask_rhs_logical_combined := [llvmfunc|
  llvm.func @nomask_rhs_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_nomask_rhs_logical   : nomask_rhs_logical_before  ⊑  nomask_rhs_logical_combined := by
  unfold nomask_rhs_logical_before nomask_rhs_logical_combined
  simp_alive_peephole
  sorry
def fold_mask_cmps_to_false_combined := [llvmfunc|
  llvm.func @fold_mask_cmps_to_false(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fold_mask_cmps_to_false   : fold_mask_cmps_to_false_before  ⊑  fold_mask_cmps_to_false_combined := by
  unfold fold_mask_cmps_to_false_before fold_mask_cmps_to_false_combined
  simp_alive_peephole
  sorry
def fold_mask_cmps_to_false_logical_combined := [llvmfunc|
  llvm.func @fold_mask_cmps_to_false_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fold_mask_cmps_to_false_logical   : fold_mask_cmps_to_false_logical_before  ⊑  fold_mask_cmps_to_false_logical_combined := by
  unfold fold_mask_cmps_to_false_logical_before fold_mask_cmps_to_false_logical_combined
  simp_alive_peephole
  sorry
def fold_mask_cmps_to_true_combined := [llvmfunc|
  llvm.func @fold_mask_cmps_to_true(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fold_mask_cmps_to_true   : fold_mask_cmps_to_true_before  ⊑  fold_mask_cmps_to_true_combined := by
  unfold fold_mask_cmps_to_true_before fold_mask_cmps_to_true_combined
  simp_alive_peephole
  sorry
def fold_mask_cmps_to_true_logical_combined := [llvmfunc|
  llvm.func @fold_mask_cmps_to_true_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fold_mask_cmps_to_true_logical   : fold_mask_cmps_to_true_logical_before  ⊑  fold_mask_cmps_to_true_logical_combined := by
  unfold fold_mask_cmps_to_true_logical_before fold_mask_cmps_to_true_logical_combined
  simp_alive_peephole
  sorry
def nomask_splat_and_B_allones_combined := [llvmfunc|
  llvm.func @nomask_splat_and_B_allones(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-268435457> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_nomask_splat_and_B_allones   : nomask_splat_and_B_allones_before  ⊑  nomask_splat_and_B_allones_combined := by
  unfold nomask_splat_and_B_allones_before nomask_splat_and_B_allones_combined
  simp_alive_peephole
  sorry
def nomask_splat_and_B_mixed_combined := [llvmfunc|
  llvm.func @nomask_splat_and_B_mixed(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-268435456> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1879048192> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_nomask_splat_and_B_mixed   : nomask_splat_and_B_mixed_before  ⊑  nomask_splat_and_B_mixed_combined := by
  unfold nomask_splat_and_B_mixed_before nomask_splat_and_B_mixed_combined
  simp_alive_peephole
  sorry
def cmpeq_bitwise_combined := [llvmfunc|
  llvm.func @cmpeq_bitwise(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    %1 = llvm.icmp "eq" %arg2, %arg3 : i8
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_cmpeq_bitwise   : cmpeq_bitwise_before  ⊑  cmpeq_bitwise_combined := by
  unfold cmpeq_bitwise_before cmpeq_bitwise_combined
  simp_alive_peephole
  sorry
def cmpne_bitwise_combined := [llvmfunc|
  llvm.func @cmpne_bitwise(%arg0: vector<2xi64>, %arg1: vector<2xi64>, %arg2: vector<2xi64>, %arg3: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.icmp "ne" %arg0, %arg1 : vector<2xi64>
    %1 = llvm.icmp "ne" %arg2, %arg3 : vector<2xi64>
    %2 = llvm.or %0, %1  : vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_cmpne_bitwise   : cmpne_bitwise_before  ⊑  cmpne_bitwise_combined := by
  unfold cmpne_bitwise_before cmpne_bitwise_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_0_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_0   : masked_icmps_mask_notallzeros_bmask_mixed_0_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_0_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_0_before masked_icmps_mask_notallzeros_bmask_mixed_0_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_0_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_0_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_0_logical   : masked_icmps_mask_notallzeros_bmask_mixed_0_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_0_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_0_logical_before masked_icmps_mask_notallzeros_bmask_mixed_0_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_1_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_1   : masked_icmps_mask_notallzeros_bmask_mixed_1_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_1_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_1_before masked_icmps_mask_notallzeros_bmask_mixed_1_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_1_vector_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_1_vector(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_1_vector   : masked_icmps_mask_notallzeros_bmask_mixed_1_vector_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_1_vector_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_1_vector_before masked_icmps_mask_notallzeros_bmask_mixed_1_vector_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_1_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_1_logical   : masked_icmps_mask_notallzeros_bmask_mixed_1_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_1_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_1_logical_before masked_icmps_mask_notallzeros_bmask_mixed_1_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_1b_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_1b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_1b   : masked_icmps_mask_notallzeros_bmask_mixed_1b_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_1b_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_1b_before masked_icmps_mask_notallzeros_bmask_mixed_1b_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_1b_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_1b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_1b_logical   : masked_icmps_mask_notallzeros_bmask_mixed_1b_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_1b_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_1b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_1b_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_2_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_2   : masked_icmps_mask_notallzeros_bmask_mixed_2_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_2_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_2_before masked_icmps_mask_notallzeros_bmask_mixed_2_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_2_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_2_logical   : masked_icmps_mask_notallzeros_bmask_mixed_2_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_2_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_2_logical_before masked_icmps_mask_notallzeros_bmask_mixed_2_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_3_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_3   : masked_icmps_mask_notallzeros_bmask_mixed_3_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_3_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_3_before masked_icmps_mask_notallzeros_bmask_mixed_3_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_3_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_3_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_3_logical   : masked_icmps_mask_notallzeros_bmask_mixed_3_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_3_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_3_logical_before masked_icmps_mask_notallzeros_bmask_mixed_3_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_3b_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_3b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_3b   : masked_icmps_mask_notallzeros_bmask_mixed_3b_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_3b_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_3b_before masked_icmps_mask_notallzeros_bmask_mixed_3b_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_3b_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_3b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_3b_logical   : masked_icmps_mask_notallzeros_bmask_mixed_3b_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_3b_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_3b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_3b_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_4_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_4   : masked_icmps_mask_notallzeros_bmask_mixed_4_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_4_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_4_before masked_icmps_mask_notallzeros_bmask_mixed_4_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_4_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_4_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_4_logical   : masked_icmps_mask_notallzeros_bmask_mixed_4_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_4_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_4_logical_before masked_icmps_mask_notallzeros_bmask_mixed_4_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_5_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_5   : masked_icmps_mask_notallzeros_bmask_mixed_5_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_5_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_5_before masked_icmps_mask_notallzeros_bmask_mixed_5_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_5_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_5_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_5_logical   : masked_icmps_mask_notallzeros_bmask_mixed_5_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_5_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_5_logical_before masked_icmps_mask_notallzeros_bmask_mixed_5_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_6_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_6   : masked_icmps_mask_notallzeros_bmask_mixed_6_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_6_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_6_before masked_icmps_mask_notallzeros_bmask_mixed_6_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_6_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_6_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_6_logical   : masked_icmps_mask_notallzeros_bmask_mixed_6_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_6_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_6_logical_before masked_icmps_mask_notallzeros_bmask_mixed_6_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_7_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_7   : masked_icmps_mask_notallzeros_bmask_mixed_7_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_7_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_7_before masked_icmps_mask_notallzeros_bmask_mixed_7_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_7_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_7_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_7_logical   : masked_icmps_mask_notallzeros_bmask_mixed_7_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_7_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_7_logical_before masked_icmps_mask_notallzeros_bmask_mixed_7_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_7b_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_7b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_7b   : masked_icmps_mask_notallzeros_bmask_mixed_7b_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_7b_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_7b_before masked_icmps_mask_notallzeros_bmask_mixed_7b_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_7b_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_7b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_7b_logical   : masked_icmps_mask_notallzeros_bmask_mixed_7b_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_7b_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_7b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_7b_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_0_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_0   : masked_icmps_mask_notallzeros_bmask_mixed_negated_0_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_0_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_0_before masked_icmps_mask_notallzeros_bmask_mixed_negated_0_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_1_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_1   : masked_icmps_mask_notallzeros_bmask_mixed_negated_1_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_1_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_1_before masked_icmps_mask_notallzeros_bmask_mixed_negated_1_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_1b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_1b   : masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_before masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_2_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_2   : masked_icmps_mask_notallzeros_bmask_mixed_negated_2_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_2_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_2_before masked_icmps_mask_notallzeros_bmask_mixed_negated_2_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_3_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_3   : masked_icmps_mask_notallzeros_bmask_mixed_negated_3_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_3_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_3_before masked_icmps_mask_notallzeros_bmask_mixed_negated_3_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_3b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_3b   : masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_before masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_4_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_4   : masked_icmps_mask_notallzeros_bmask_mixed_negated_4_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_4_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_4_before masked_icmps_mask_notallzeros_bmask_mixed_negated_4_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_5_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_5   : masked_icmps_mask_notallzeros_bmask_mixed_negated_5_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_5_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_5_before masked_icmps_mask_notallzeros_bmask_mixed_negated_5_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_6_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_6   : masked_icmps_mask_notallzeros_bmask_mixed_negated_6_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_6_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_6_before masked_icmps_mask_notallzeros_bmask_mixed_negated_6_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_7_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_7   : masked_icmps_mask_notallzeros_bmask_mixed_negated_7_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_7_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_7_before masked_icmps_mask_notallzeros_bmask_mixed_negated_7_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_7b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_7b   : masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_before masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %7, %5  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_0   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %7, %5  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_1   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %7, %5  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %7, %5  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_2   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_3   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %6, %4  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %6, %4  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_4   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_5   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_6   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_7   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical   : masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %7, %5  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %7, %5  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %7, %5  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %7, %5  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.or %6, %4  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.or %6, %4  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_combined
  simp_alive_peephole
  sorry
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical_combined := [llvmfunc|
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical   : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical_before  ⊑  masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical_combined := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical_combined
  simp_alive_peephole
  sorry
def masked_icmps_bmask_notmixed_or_combined := [llvmfunc|
  llvm.func @masked_icmps_bmask_notmixed_or(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_bmask_notmixed_or   : masked_icmps_bmask_notmixed_or_before  ⊑  masked_icmps_bmask_notmixed_or_combined := by
  unfold masked_icmps_bmask_notmixed_or_before masked_icmps_bmask_notmixed_or_combined
  simp_alive_peephole
  sorry
def masked_icmps_bmask_notmixed_or_vec_combined := [llvmfunc|
  llvm.func @masked_icmps_bmask_notmixed_or_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_masked_icmps_bmask_notmixed_or_vec   : masked_icmps_bmask_notmixed_or_vec_before  ⊑  masked_icmps_bmask_notmixed_or_vec_combined := by
  unfold masked_icmps_bmask_notmixed_or_vec_before masked_icmps_bmask_notmixed_or_vec_combined
  simp_alive_peephole
  sorry
def masked_icmps_bmask_notmixed_or_vec_poison1_combined := [llvmfunc|
  llvm.func @masked_icmps_bmask_notmixed_or_vec_poison1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(dense<-13> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.and %arg0, %0  : vector<2xi8>
    %10 = llvm.icmp "eq" %9, %7 : vector<2xi8>
    %11 = llvm.icmp "eq" %arg0, %8 : vector<2xi8>
    %12 = llvm.or %10, %11  : vector<2xi1>
    llvm.return %12 : vector<2xi1>
  }]

theorem inst_combine_masked_icmps_bmask_notmixed_or_vec_poison1   : masked_icmps_bmask_notmixed_or_vec_poison1_before  ⊑  masked_icmps_bmask_notmixed_or_vec_poison1_combined := by
  unfold masked_icmps_bmask_notmixed_or_vec_poison1_before masked_icmps_bmask_notmixed_or_vec_poison1_combined
  simp_alive_peephole
  sorry
def masked_icmps_bmask_notmixed_or_vec_poison2_combined := [llvmfunc|
  llvm.func @masked_icmps_bmask_notmixed_or_vec_poison2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.constant(-13 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.and %arg0, %0  : vector<2xi8>
    %10 = llvm.icmp "eq" %9, %1 : vector<2xi8>
    %11 = llvm.icmp "eq" %arg0, %8 : vector<2xi8>
    %12 = llvm.or %10, %11  : vector<2xi1>
    llvm.return %12 : vector<2xi1>
  }]

theorem inst_combine_masked_icmps_bmask_notmixed_or_vec_poison2   : masked_icmps_bmask_notmixed_or_vec_poison2_before  ⊑  masked_icmps_bmask_notmixed_or_vec_poison2_combined := by
  unfold masked_icmps_bmask_notmixed_or_vec_poison2_before masked_icmps_bmask_notmixed_or_vec_poison2_combined
  simp_alive_peephole
  sorry
def masked_icmps_bmask_notmixed_or_contradict_notoptimized_combined := [llvmfunc|
  llvm.func @masked_icmps_bmask_notmixed_or_contradict_notoptimized(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.mlir.constant(242 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_masked_icmps_bmask_notmixed_or_contradict_notoptimized   : masked_icmps_bmask_notmixed_or_contradict_notoptimized_before  ⊑  masked_icmps_bmask_notmixed_or_contradict_notoptimized_combined := by
  unfold masked_icmps_bmask_notmixed_or_contradict_notoptimized_before masked_icmps_bmask_notmixed_or_contradict_notoptimized_combined
  simp_alive_peephole
  sorry
def masked_icmps_bmask_notmixed_and_combined := [llvmfunc|
  llvm.func @masked_icmps_bmask_notmixed_and(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_bmask_notmixed_and   : masked_icmps_bmask_notmixed_and_before  ⊑  masked_icmps_bmask_notmixed_and_combined := by
  unfold masked_icmps_bmask_notmixed_and_before masked_icmps_bmask_notmixed_and_combined
  simp_alive_peephole
  sorry
def masked_icmps_bmask_notmixed_and_contradict_notoptimized_combined := [llvmfunc|
  llvm.func @masked_icmps_bmask_notmixed_and_contradict_notoptimized(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.mlir.constant(242 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_masked_icmps_bmask_notmixed_and_contradict_notoptimized   : masked_icmps_bmask_notmixed_and_contradict_notoptimized_before  ⊑  masked_icmps_bmask_notmixed_and_contradict_notoptimized_combined := by
  unfold masked_icmps_bmask_notmixed_and_contradict_notoptimized_before masked_icmps_bmask_notmixed_and_contradict_notoptimized_combined
  simp_alive_peephole
  sorry
def masked_icmps_bmask_notmixed_and_expected_false_combined := [llvmfunc|
  llvm.func @masked_icmps_bmask_notmixed_and_expected_false(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(242 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_masked_icmps_bmask_notmixed_and_expected_false   : masked_icmps_bmask_notmixed_and_expected_false_before  ⊑  masked_icmps_bmask_notmixed_and_expected_false_combined := by
  unfold masked_icmps_bmask_notmixed_and_expected_false_before masked_icmps_bmask_notmixed_and_expected_false_combined
  simp_alive_peephole
  sorry
def masked_icmps_bmask_notmixed_not_subset_notoptimized_combined := [llvmfunc|
  llvm.func @masked_icmps_bmask_notmixed_not_subset_notoptimized(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(254 : i32) : i32
    %1 = llvm.mlir.constant(252 : i32) : i32
    %2 = llvm.mlir.constant(253 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_masked_icmps_bmask_notmixed_not_subset_notoptimized   : masked_icmps_bmask_notmixed_not_subset_notoptimized_before  ⊑  masked_icmps_bmask_notmixed_not_subset_notoptimized_combined := by
  unfold masked_icmps_bmask_notmixed_not_subset_notoptimized_before masked_icmps_bmask_notmixed_not_subset_notoptimized_combined
  simp_alive_peephole
  sorry
