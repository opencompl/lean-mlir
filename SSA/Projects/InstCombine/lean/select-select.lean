import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo1_before := [llvmfunc|
  llvm.func @foo1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "olt" %3, %1 : f32
    %5 = llvm.select %4, %3, %1 : i1, f32
    llvm.return %5 : f32
  }]

def foo2_before := [llvmfunc|
  llvm.func @foo2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "olt" %3, %1 : f32
    %5 = llvm.select %2, %arg0, %0 : i1, f32
    %6 = llvm.select %4, %5, %1 : i1, f32
    llvm.return %6 : f32
  }]

def foo3_before := [llvmfunc|
  llvm.func @foo3(%arg0: vector<2xi1>, %arg1: i1, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %1, %arg2 : vector<2xi1>, vector<2xi32>
    %3 = llvm.select %arg1, %2, %arg2 : i1, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def sel_shuf_commute0_before := [llvmfunc|
  llvm.func @sel_shuf_commute0(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 5, 2, 7] : vector<4xi8> 
    %1 = llvm.select %arg2, %0, %arg0 : vector<4xi1>, vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

def sel_shuf_commute1_before := [llvmfunc|
  llvm.func @sel_shuf_commute1(%arg0: vector<5xi9>, %arg1: vector<5xi9>, %arg2: vector<5xi1>) -> vector<5xi9> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 6, 2, 8, 9] : vector<5xi9> 
    %1 = llvm.select %arg2, %0, %arg1 : vector<5xi1>, vector<5xi9>
    llvm.return %1 : vector<5xi9>
  }]

def sel_shuf_commute2_before := [llvmfunc|
  llvm.func @sel_shuf_commute2(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xi1>) -> vector<4xf32> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 7] : vector<4xf32> 
    %1 = llvm.select %arg2, %arg0, %0 : vector<4xi1>, vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }]

def sel_shuf_commute3_before := [llvmfunc|
  llvm.func @sel_shuf_commute3(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: i1) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 5, 2, 3] : vector<4xi8> 
    %1 = llvm.select %arg2, %arg1, %0 : i1, vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

def sel_shuf_use_before := [llvmfunc|
  llvm.func @sel_shuf_use(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 5, 2, 7] : vector<4xi8> 
    llvm.call @use(%0) : (vector<4xi8>) -> ()
    %1 = llvm.select %arg2, %0, %arg0 : vector<4xi1>, vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

def sel_shuf_undef_before := [llvmfunc|
  llvm.func @sel_shuf_undef(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 5, 2, -1] : vector<4xi8> 
    %1 = llvm.select %arg2, %0, %arg1 : vector<4xi1>, vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

def sel_shuf_not_before := [llvmfunc|
  llvm.func @sel_shuf_not(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 5, 2, 6] : vector<4xi8> 
    %1 = llvm.select %arg2, %0, %arg1 : vector<4xi1>, vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

def sel_shuf_no_common_operand_before := [llvmfunc|
  llvm.func @sel_shuf_no_common_operand(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>, %arg3: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 5, 2, 3] : vector<4xi8> 
    %1 = llvm.select %arg2, %arg3, %0 : vector<4xi1>, vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

def sel_shuf_narrowing_commute1_before := [llvmfunc|
  llvm.func @sel_shuf_narrowing_commute1(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 5] : vector<4xi8> 
    %1 = llvm.select %arg3, %0, %arg2 : vector<2xi1>, vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def sel_shuf_narrowing_commute2_before := [llvmfunc|
  llvm.func @sel_shuf_narrowing_commute2(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 5] : vector<4xi8> 
    %1 = llvm.select %arg3, %arg2, %0 : vector<2xi1>, vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def strong_order_cmp_slt_eq_before := [llvmfunc|
  llvm.func @strong_order_cmp_slt_eq(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "slt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "eq" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

def strong_order_cmp_ult_eq_before := [llvmfunc|
  llvm.func @strong_order_cmp_ult_eq(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "ult" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "eq" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

def strong_order_cmp_slt_eq_wrong_const_before := [llvmfunc|
  llvm.func @strong_order_cmp_slt_eq_wrong_const(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "slt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "eq" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

def strong_order_cmp_ult_eq_wrong_const_before := [llvmfunc|
  llvm.func @strong_order_cmp_ult_eq_wrong_const(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "ult" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "eq" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

def strong_order_cmp_slt_ult_wrong_pred_before := [llvmfunc|
  llvm.func @strong_order_cmp_slt_ult_wrong_pred(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "slt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "ult" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

def strong_order_cmp_sgt_eq_before := [llvmfunc|
  llvm.func @strong_order_cmp_sgt_eq(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "eq" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

def strong_order_cmp_ugt_eq_before := [llvmfunc|
  llvm.func @strong_order_cmp_ugt_eq(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "eq" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

def strong_order_cmp_eq_slt_before := [llvmfunc|
  llvm.func @strong_order_cmp_eq_slt(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.icmp "eq" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "slt" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

def strong_order_cmp_eq_sgt_before := [llvmfunc|
  llvm.func @strong_order_cmp_eq_sgt(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.icmp "eq" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

def strong_order_cmp_eq_ult_before := [llvmfunc|
  llvm.func @strong_order_cmp_eq_ult(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.icmp "eq" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "ult" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

def strong_order_cmp_eq_ugt_before := [llvmfunc|
  llvm.func @strong_order_cmp_eq_ugt(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.icmp "eq" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

def strong_order_cmp_slt_sgt_before := [llvmfunc|
  llvm.func @strong_order_cmp_slt_sgt(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    %2 = llvm.sext %1 : i1 to i8
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

def strong_order_cmp_ult_ugt_before := [llvmfunc|
  llvm.func @strong_order_cmp_ult_ugt(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i32
    %2 = llvm.sext %1 : i1 to i8
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

def strong_order_cmp_sgt_slt_before := [llvmfunc|
  llvm.func @strong_order_cmp_sgt_slt(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %2 = llvm.zext %1 : i1 to i8
    %3 = llvm.icmp "slt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

def strong_order_cmp_ugt_ult_before := [llvmfunc|
  llvm.func @strong_order_cmp_ugt_ult(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.zext %1 : i1 to i8
    %3 = llvm.icmp "ult" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

def strong_order_cmp_ne_ugt_ne_not_one_use_before := [llvmfunc|
  llvm.func @strong_order_cmp_ne_ugt_ne_not_one_use(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.sext %1 : i1 to i8
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

def strong_order_cmp_slt_eq_slt_not_oneuse_before := [llvmfunc|
  llvm.func @strong_order_cmp_slt_eq_slt_not_oneuse(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "eq" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

def strong_order_cmp_sgt_eq_eq_not_oneuse_before := [llvmfunc|
  llvm.func @strong_order_cmp_sgt_eq_eq_not_oneuse(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

def strong_order_cmp_eq_ugt_eq_not_oneuse_before := [llvmfunc|
  llvm.func @strong_order_cmp_eq_ugt_eq_not_oneuse(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

def strong_order_cmp_ugt_ult_zext_not_oneuse_before := [llvmfunc|
  llvm.func @strong_order_cmp_ugt_ult_zext_not_oneuse(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.zext %1 : i1 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

def strong_order_cmp_slt_sgt_sext_not_oneuse_before := [llvmfunc|
  llvm.func @strong_order_cmp_slt_sgt_sext_not_oneuse(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    %2 = llvm.sext %1 : i1 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

def strong_order_cmp_ugt_ult_vector_before := [llvmfunc|
  llvm.func @strong_order_cmp_ugt_ult_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi8>
    %3 = llvm.icmp "ult" %arg0, %arg1 : vector<2xi32>
    %4 = llvm.select %3, %0, %2 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def strong_order_cmp_ugt_ult_vector_poison_before := [llvmfunc|
  llvm.func @strong_order_cmp_ugt_ult_vector_poison(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %8 = llvm.zext %7 : vector<2xi1> to vector<2xi8>
    %9 = llvm.icmp "ult" %arg0, %arg1 : vector<2xi32>
    %10 = llvm.select %9, %6, %8 : vector<2xi1>, vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def strong_order_cmp_eq_ugt_vector_before := [llvmfunc|
  llvm.func @strong_order_cmp_eq_ugt_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.icmp "eq" %arg0, %arg1 : vector<2xi32>
    %5 = llvm.select %4, %1, %2 : vector<2xi1>, vector<2xi8>
    %6 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %7 = llvm.select %6, %3, %5 : vector<2xi1>, vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }]

def strong_order_cmp_eq_ugt_vector_poison1_before := [llvmfunc|
  llvm.func @strong_order_cmp_eq_ugt_vector_poison1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.icmp "eq" %arg0, %arg1 : vector<2xi32>
    %10 = llvm.select %9, %6, %7 : vector<2xi1>, vector<2xi8>
    %11 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %12 = llvm.select %11, %8, %10 : vector<2xi1>, vector<2xi8>
    llvm.return %12 : vector<2xi8>
  }]

def strong_order_cmp_eq_ugt_vector_poison2_before := [llvmfunc|
  llvm.func @strong_order_cmp_eq_ugt_vector_poison2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.mlir.poison : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %10 = llvm.icmp "eq" %arg0, %arg1 : vector<2xi32>
    %11 = llvm.select %10, %1, %8 : vector<2xi1>, vector<2xi8>
    %12 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %13 = llvm.select %12, %9, %11 : vector<2xi1>, vector<2xi8>
    llvm.return %13 : vector<2xi8>
  }]

def strong_order_cmp_eq_ugt_vector_poison3_before := [llvmfunc|
  llvm.func @strong_order_cmp_eq_ugt_vector_poison3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.poison : i8
    %4 = llvm.mlir.constant(1 : i8) : i8
    %5 = llvm.mlir.undef : vector<2xi8>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<2xi8>
    %10 = llvm.icmp "eq" %arg0, %arg1 : vector<2xi32>
    %11 = llvm.select %10, %1, %2 : vector<2xi1>, vector<2xi8>
    %12 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %13 = llvm.select %12, %9, %11 : vector<2xi1>, vector<2xi8>
    llvm.return %13 : vector<2xi8>
  }]

def foo1_combined := [llvmfunc|
  llvm.func @foo1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "olt" %3, %1 : f32
    %5 = llvm.select %4, %3, %1 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_foo1   : foo1_before  ⊑  foo1_combined := by
  unfold foo1_before foo1_combined
  simp_alive_peephole
  sorry
def foo2_combined := [llvmfunc|
  llvm.func @foo2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "olt" %3, %1 : f32
    %5 = llvm.select %2, %arg0, %0 : i1, f32
    %6 = llvm.select %4, %5, %1 : i1, f32
    llvm.return %6 : f32
  }]

theorem inst_combine_foo2   : foo2_before  ⊑  foo2_combined := by
  unfold foo2_before foo2_combined
  simp_alive_peephole
  sorry
def foo3_combined := [llvmfunc|
  llvm.func @foo3(%arg0: vector<2xi1>, %arg1: i1, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %1, %arg2 : vector<2xi1>, vector<2xi32>
    %3 = llvm.select %arg1, %2, %arg2 : i1, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_foo3   : foo3_before  ⊑  foo3_combined := by
  unfold foo3_before foo3_combined
  simp_alive_peephole
  sorry
def sel_shuf_commute0_combined := [llvmfunc|
  llvm.func @sel_shuf_commute0(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>) -> vector<4xi8> {
    %0 = llvm.select %arg2, %arg1, %arg0 : vector<4xi1>, vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 5, 2, 7] : vector<4xi8> 
    llvm.return %1 : vector<4xi8>
  }]

theorem inst_combine_sel_shuf_commute0   : sel_shuf_commute0_before  ⊑  sel_shuf_commute0_combined := by
  unfold sel_shuf_commute0_before sel_shuf_commute0_combined
  simp_alive_peephole
  sorry
def sel_shuf_commute1_combined := [llvmfunc|
  llvm.func @sel_shuf_commute1(%arg0: vector<5xi9>, %arg1: vector<5xi9>, %arg2: vector<5xi1>) -> vector<5xi9> {
    %0 = llvm.select %arg2, %arg0, %arg1 : vector<5xi1>, vector<5xi9>
    %1 = llvm.shufflevector %0, %arg1 [0, 6, 2, 8, 9] : vector<5xi9> 
    llvm.return %1 : vector<5xi9>
  }]

theorem inst_combine_sel_shuf_commute1   : sel_shuf_commute1_before  ⊑  sel_shuf_commute1_combined := by
  unfold sel_shuf_commute1_before sel_shuf_commute1_combined
  simp_alive_peephole
  sorry
def sel_shuf_commute2_combined := [llvmfunc|
  llvm.func @sel_shuf_commute2(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xi1>) -> vector<4xf32> {
    %0 = llvm.select %arg2, %arg0, %arg1 : vector<4xi1>, vector<4xf32>
    %1 = llvm.shufflevector %arg0, %0 [0, 1, 2, 7] : vector<4xf32> 
    llvm.return %1 : vector<4xf32>
  }]

theorem inst_combine_sel_shuf_commute2   : sel_shuf_commute2_before  ⊑  sel_shuf_commute2_combined := by
  unfold sel_shuf_commute2_before sel_shuf_commute2_combined
  simp_alive_peephole
  sorry
def sel_shuf_commute3_combined := [llvmfunc|
  llvm.func @sel_shuf_commute3(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: i1) -> vector<4xi8> {
    %0 = llvm.select %arg2, %arg1, %arg0 : i1, vector<4xi8>
    %1 = llvm.shufflevector %0, %arg1 [0, 5, 2, 3] : vector<4xi8> 
    llvm.return %1 : vector<4xi8>
  }]

theorem inst_combine_sel_shuf_commute3   : sel_shuf_commute3_before  ⊑  sel_shuf_commute3_combined := by
  unfold sel_shuf_commute3_before sel_shuf_commute3_combined
  simp_alive_peephole
  sorry
def sel_shuf_use_combined := [llvmfunc|
  llvm.func @sel_shuf_use(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 5, 2, 7] : vector<4xi8> 
    llvm.call @use(%0) : (vector<4xi8>) -> ()
    %1 = llvm.select %arg2, %0, %arg0 : vector<4xi1>, vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

theorem inst_combine_sel_shuf_use   : sel_shuf_use_before  ⊑  sel_shuf_use_combined := by
  unfold sel_shuf_use_before sel_shuf_use_combined
  simp_alive_peephole
  sorry
def sel_shuf_undef_combined := [llvmfunc|
  llvm.func @sel_shuf_undef(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 5, 2, -1] : vector<4xi8> 
    %1 = llvm.select %arg2, %0, %arg1 : vector<4xi1>, vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

theorem inst_combine_sel_shuf_undef   : sel_shuf_undef_before  ⊑  sel_shuf_undef_combined := by
  unfold sel_shuf_undef_before sel_shuf_undef_combined
  simp_alive_peephole
  sorry
def sel_shuf_not_combined := [llvmfunc|
  llvm.func @sel_shuf_not(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 5, 2, 6] : vector<4xi8> 
    %1 = llvm.select %arg2, %0, %arg1 : vector<4xi1>, vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

theorem inst_combine_sel_shuf_not   : sel_shuf_not_before  ⊑  sel_shuf_not_combined := by
  unfold sel_shuf_not_before sel_shuf_not_combined
  simp_alive_peephole
  sorry
def sel_shuf_no_common_operand_combined := [llvmfunc|
  llvm.func @sel_shuf_no_common_operand(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>, %arg3: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 5, 2, 3] : vector<4xi8> 
    %1 = llvm.select %arg2, %arg3, %0 : vector<4xi1>, vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

theorem inst_combine_sel_shuf_no_common_operand   : sel_shuf_no_common_operand_before  ⊑  sel_shuf_no_common_operand_combined := by
  unfold sel_shuf_no_common_operand_before sel_shuf_no_common_operand_combined
  simp_alive_peephole
  sorry
def sel_shuf_narrowing_commute1_combined := [llvmfunc|
  llvm.func @sel_shuf_narrowing_commute1(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 5] : vector<4xi8> 
    %1 = llvm.select %arg3, %0, %arg2 : vector<2xi1>, vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_sel_shuf_narrowing_commute1   : sel_shuf_narrowing_commute1_before  ⊑  sel_shuf_narrowing_commute1_combined := by
  unfold sel_shuf_narrowing_commute1_before sel_shuf_narrowing_commute1_combined
  simp_alive_peephole
  sorry
def sel_shuf_narrowing_commute2_combined := [llvmfunc|
  llvm.func @sel_shuf_narrowing_commute2(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 5] : vector<4xi8> 
    %1 = llvm.select %arg3, %arg2, %0 : vector<2xi1>, vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_sel_shuf_narrowing_commute2   : sel_shuf_narrowing_commute2_before  ⊑  sel_shuf_narrowing_commute2_combined := by
  unfold sel_shuf_narrowing_commute2_before sel_shuf_narrowing_commute2_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_slt_eq_combined := [llvmfunc|
  llvm.func @strong_order_cmp_slt_eq(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "slt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "eq" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

theorem inst_combine_strong_order_cmp_slt_eq   : strong_order_cmp_slt_eq_before  ⊑  strong_order_cmp_slt_eq_combined := by
  unfold strong_order_cmp_slt_eq_before strong_order_cmp_slt_eq_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_ult_eq_combined := [llvmfunc|
  llvm.func @strong_order_cmp_ult_eq(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "ult" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "eq" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

theorem inst_combine_strong_order_cmp_ult_eq   : strong_order_cmp_ult_eq_before  ⊑  strong_order_cmp_ult_eq_combined := by
  unfold strong_order_cmp_ult_eq_before strong_order_cmp_ult_eq_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_slt_eq_wrong_const_combined := [llvmfunc|
  llvm.func @strong_order_cmp_slt_eq_wrong_const(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "slt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "eq" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

theorem inst_combine_strong_order_cmp_slt_eq_wrong_const   : strong_order_cmp_slt_eq_wrong_const_before  ⊑  strong_order_cmp_slt_eq_wrong_const_combined := by
  unfold strong_order_cmp_slt_eq_wrong_const_before strong_order_cmp_slt_eq_wrong_const_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_ult_eq_wrong_const_combined := [llvmfunc|
  llvm.func @strong_order_cmp_ult_eq_wrong_const(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "ult" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "eq" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

theorem inst_combine_strong_order_cmp_ult_eq_wrong_const   : strong_order_cmp_ult_eq_wrong_const_before  ⊑  strong_order_cmp_ult_eq_wrong_const_combined := by
  unfold strong_order_cmp_ult_eq_wrong_const_before strong_order_cmp_ult_eq_wrong_const_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_slt_ult_wrong_pred_combined := [llvmfunc|
  llvm.func @strong_order_cmp_slt_ult_wrong_pred(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "slt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "ult" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

theorem inst_combine_strong_order_cmp_slt_ult_wrong_pred   : strong_order_cmp_slt_ult_wrong_pred_before  ⊑  strong_order_cmp_slt_ult_wrong_pred_combined := by
  unfold strong_order_cmp_slt_ult_wrong_pred_before strong_order_cmp_slt_ult_wrong_pred_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_sgt_eq_combined := [llvmfunc|
  llvm.func @strong_order_cmp_sgt_eq(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "eq" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

theorem inst_combine_strong_order_cmp_sgt_eq   : strong_order_cmp_sgt_eq_before  ⊑  strong_order_cmp_sgt_eq_combined := by
  unfold strong_order_cmp_sgt_eq_before strong_order_cmp_sgt_eq_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_ugt_eq_combined := [llvmfunc|
  llvm.func @strong_order_cmp_ugt_eq(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "eq" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

theorem inst_combine_strong_order_cmp_ugt_eq   : strong_order_cmp_ugt_eq_before  ⊑  strong_order_cmp_ugt_eq_combined := by
  unfold strong_order_cmp_ugt_eq_before strong_order_cmp_ugt_eq_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_eq_slt_combined := [llvmfunc|
  llvm.func @strong_order_cmp_eq_slt(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    %2 = llvm.zext %1 : i1 to i8
    %3 = llvm.icmp "slt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_strong_order_cmp_eq_slt   : strong_order_cmp_eq_slt_before  ⊑  strong_order_cmp_eq_slt_combined := by
  unfold strong_order_cmp_eq_slt_before strong_order_cmp_eq_slt_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_eq_sgt_combined := [llvmfunc|
  llvm.func @strong_order_cmp_eq_sgt(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    %2 = llvm.sext %1 : i1 to i8
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_strong_order_cmp_eq_sgt   : strong_order_cmp_eq_sgt_before  ⊑  strong_order_cmp_eq_sgt_combined := by
  unfold strong_order_cmp_eq_sgt_before strong_order_cmp_eq_sgt_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_eq_ult_combined := [llvmfunc|
  llvm.func @strong_order_cmp_eq_ult(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    %2 = llvm.zext %1 : i1 to i8
    %3 = llvm.icmp "ult" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_strong_order_cmp_eq_ult   : strong_order_cmp_eq_ult_before  ⊑  strong_order_cmp_eq_ult_combined := by
  unfold strong_order_cmp_eq_ult_before strong_order_cmp_eq_ult_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_eq_ugt_combined := [llvmfunc|
  llvm.func @strong_order_cmp_eq_ugt(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    %2 = llvm.sext %1 : i1 to i8
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_strong_order_cmp_eq_ugt   : strong_order_cmp_eq_ugt_before  ⊑  strong_order_cmp_eq_ugt_combined := by
  unfold strong_order_cmp_eq_ugt_before strong_order_cmp_eq_ugt_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_slt_sgt_combined := [llvmfunc|
  llvm.func @strong_order_cmp_slt_sgt(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    %2 = llvm.sext %1 : i1 to i8
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_strong_order_cmp_slt_sgt   : strong_order_cmp_slt_sgt_before  ⊑  strong_order_cmp_slt_sgt_combined := by
  unfold strong_order_cmp_slt_sgt_before strong_order_cmp_slt_sgt_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_ult_ugt_combined := [llvmfunc|
  llvm.func @strong_order_cmp_ult_ugt(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i32
    %2 = llvm.sext %1 : i1 to i8
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_strong_order_cmp_ult_ugt   : strong_order_cmp_ult_ugt_before  ⊑  strong_order_cmp_ult_ugt_combined := by
  unfold strong_order_cmp_ult_ugt_before strong_order_cmp_ult_ugt_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_sgt_slt_combined := [llvmfunc|
  llvm.func @strong_order_cmp_sgt_slt(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %2 = llvm.zext %1 : i1 to i8
    %3 = llvm.icmp "slt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_strong_order_cmp_sgt_slt   : strong_order_cmp_sgt_slt_before  ⊑  strong_order_cmp_sgt_slt_combined := by
  unfold strong_order_cmp_sgt_slt_before strong_order_cmp_sgt_slt_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_ugt_ult_combined := [llvmfunc|
  llvm.func @strong_order_cmp_ugt_ult(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.zext %1 : i1 to i8
    %3 = llvm.icmp "ult" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_strong_order_cmp_ugt_ult   : strong_order_cmp_ugt_ult_before  ⊑  strong_order_cmp_ugt_ult_combined := by
  unfold strong_order_cmp_ugt_ult_before strong_order_cmp_ugt_ult_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_ne_ugt_ne_not_one_use_combined := [llvmfunc|
  llvm.func @strong_order_cmp_ne_ugt_ne_not_one_use(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.sext %1 : i1 to i8
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_strong_order_cmp_ne_ugt_ne_not_one_use   : strong_order_cmp_ne_ugt_ne_not_one_use_before  ⊑  strong_order_cmp_ne_ugt_ne_not_one_use_combined := by
  unfold strong_order_cmp_ne_ugt_ne_not_one_use_before strong_order_cmp_ne_ugt_ne_not_one_use_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_slt_eq_slt_not_oneuse_combined := [llvmfunc|
  llvm.func @strong_order_cmp_slt_eq_slt_not_oneuse(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "eq" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

theorem inst_combine_strong_order_cmp_slt_eq_slt_not_oneuse   : strong_order_cmp_slt_eq_slt_not_oneuse_before  ⊑  strong_order_cmp_slt_eq_slt_not_oneuse_combined := by
  unfold strong_order_cmp_slt_eq_slt_not_oneuse_before strong_order_cmp_slt_eq_slt_not_oneuse_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_sgt_eq_eq_not_oneuse_combined := [llvmfunc|
  llvm.func @strong_order_cmp_sgt_eq_eq_not_oneuse(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i8
    %5 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.select %5, %2, %4 : i1, i8
    llvm.return %6 : i8
  }]

theorem inst_combine_strong_order_cmp_sgt_eq_eq_not_oneuse   : strong_order_cmp_sgt_eq_eq_not_oneuse_before  ⊑  strong_order_cmp_sgt_eq_eq_not_oneuse_combined := by
  unfold strong_order_cmp_sgt_eq_eq_not_oneuse_before strong_order_cmp_sgt_eq_eq_not_oneuse_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_eq_ugt_eq_not_oneuse_combined := [llvmfunc|
  llvm.func @strong_order_cmp_eq_ugt_eq_not_oneuse(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.xor %2, %0  : i1
    %4 = llvm.sext %3 : i1 to i8
    %5 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %6 = llvm.select %5, %1, %4 : i1, i8
    llvm.return %6 : i8
  }]

theorem inst_combine_strong_order_cmp_eq_ugt_eq_not_oneuse   : strong_order_cmp_eq_ugt_eq_not_oneuse_before  ⊑  strong_order_cmp_eq_ugt_eq_not_oneuse_combined := by
  unfold strong_order_cmp_eq_ugt_eq_not_oneuse_before strong_order_cmp_eq_ugt_eq_not_oneuse_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_ugt_ult_zext_not_oneuse_combined := [llvmfunc|
  llvm.func @strong_order_cmp_ugt_ult_zext_not_oneuse(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.zext %1 : i1 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_strong_order_cmp_ugt_ult_zext_not_oneuse   : strong_order_cmp_ugt_ult_zext_not_oneuse_before  ⊑  strong_order_cmp_ugt_ult_zext_not_oneuse_combined := by
  unfold strong_order_cmp_ugt_ult_zext_not_oneuse_before strong_order_cmp_ugt_ult_zext_not_oneuse_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_slt_sgt_sext_not_oneuse_combined := [llvmfunc|
  llvm.func @strong_order_cmp_slt_sgt_sext_not_oneuse(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    %2 = llvm.sext %1 : i1 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_strong_order_cmp_slt_sgt_sext_not_oneuse   : strong_order_cmp_slt_sgt_sext_not_oneuse_before  ⊑  strong_order_cmp_slt_sgt_sext_not_oneuse_combined := by
  unfold strong_order_cmp_slt_sgt_sext_not_oneuse_before strong_order_cmp_slt_sgt_sext_not_oneuse_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_ugt_ult_vector_combined := [llvmfunc|
  llvm.func @strong_order_cmp_ugt_ult_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi8>
    %3 = llvm.icmp "ult" %arg0, %arg1 : vector<2xi32>
    %4 = llvm.select %3, %0, %2 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_strong_order_cmp_ugt_ult_vector   : strong_order_cmp_ugt_ult_vector_before  ⊑  strong_order_cmp_ugt_ult_vector_combined := by
  unfold strong_order_cmp_ugt_ult_vector_before strong_order_cmp_ugt_ult_vector_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_ugt_ult_vector_poison_combined := [llvmfunc|
  llvm.func @strong_order_cmp_ugt_ult_vector_poison(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %8 = llvm.zext %7 : vector<2xi1> to vector<2xi8>
    %9 = llvm.icmp "ult" %arg0, %arg1 : vector<2xi32>
    %10 = llvm.select %9, %6, %8 : vector<2xi1>, vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_strong_order_cmp_ugt_ult_vector_poison   : strong_order_cmp_ugt_ult_vector_poison_before  ⊑  strong_order_cmp_ugt_ult_vector_poison_combined := by
  unfold strong_order_cmp_ugt_ult_vector_poison_before strong_order_cmp_ugt_ult_vector_poison_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_eq_ugt_vector_combined := [llvmfunc|
  llvm.func @strong_order_cmp_eq_ugt_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ne" %arg0, %arg1 : vector<2xi32>
    %2 = llvm.sext %1 : vector<2xi1> to vector<2xi8>
    %3 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %4 = llvm.select %3, %0, %2 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_strong_order_cmp_eq_ugt_vector   : strong_order_cmp_eq_ugt_vector_before  ⊑  strong_order_cmp_eq_ugt_vector_combined := by
  unfold strong_order_cmp_eq_ugt_vector_before strong_order_cmp_eq_ugt_vector_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_eq_ugt_vector_poison1_combined := [llvmfunc|
  llvm.func @strong_order_cmp_eq_ugt_vector_poison1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ne" %arg0, %arg1 : vector<2xi32>
    %2 = llvm.sext %1 : vector<2xi1> to vector<2xi8>
    %3 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %4 = llvm.select %3, %0, %2 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_strong_order_cmp_eq_ugt_vector_poison1   : strong_order_cmp_eq_ugt_vector_poison1_before  ⊑  strong_order_cmp_eq_ugt_vector_poison1_combined := by
  unfold strong_order_cmp_eq_ugt_vector_poison1_before strong_order_cmp_eq_ugt_vector_poison1_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_eq_ugt_vector_poison2_combined := [llvmfunc|
  llvm.func @strong_order_cmp_eq_ugt_vector_poison2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ne" %arg0, %arg1 : vector<2xi32>
    %2 = llvm.sext %1 : vector<2xi1> to vector<2xi8>
    %3 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %4 = llvm.select %3, %0, %2 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_strong_order_cmp_eq_ugt_vector_poison2   : strong_order_cmp_eq_ugt_vector_poison2_before  ⊑  strong_order_cmp_eq_ugt_vector_poison2_combined := by
  unfold strong_order_cmp_eq_ugt_vector_poison2_before strong_order_cmp_eq_ugt_vector_poison2_combined
  simp_alive_peephole
  sorry
def strong_order_cmp_eq_ugt_vector_poison3_combined := [llvmfunc|
  llvm.func @strong_order_cmp_eq_ugt_vector_poison3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "ne" %arg0, %arg1 : vector<2xi32>
    %8 = llvm.sext %7 : vector<2xi1> to vector<2xi8>
    %9 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %10 = llvm.select %9, %6, %8 : vector<2xi1>, vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_strong_order_cmp_eq_ugt_vector_poison3   : strong_order_cmp_eq_ugt_vector_poison3_before  ⊑  strong_order_cmp_eq_ugt_vector_poison3_combined := by
  unfold strong_order_cmp_eq_ugt_vector_poison3_before strong_order_cmp_eq_ugt_vector_poison3_combined
  simp_alive_peephole
  sorry
