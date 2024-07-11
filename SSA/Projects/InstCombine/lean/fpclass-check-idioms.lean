import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fpclass-check-idioms
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f32_fcnan_fcinf_before := [llvmfunc|
  llvm.func @f32_fcnan_fcinf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

def f32_fcnan_fcinf_strictfp_before := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

def f32_not_fcnan_fcinf_before := [llvmfunc|
  llvm.func @f32_not_fcnan_fcinf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }]

def f32_not_fcnan_fcinf_strictfp_before := [llvmfunc|
  llvm.func @f32_not_fcnan_fcinf_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }]

def f64_fcnan_fcinf_before := [llvmfunc|
  llvm.func @f64_fcnan_fcinf(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(9218868437227405312 : i64) : i64
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }]

def f64_fcnan_fcinf_strictfp_before := [llvmfunc|
  llvm.func @f64_fcnan_fcinf_strictfp(%arg0: f64) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(9218868437227405312 : i64) : i64
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }]

def f32_fcinf_before := [llvmfunc|
  llvm.func @f32_fcinf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(2139095040 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def f32_fcinf_strictfp_before := [llvmfunc|
  llvm.func @f32_fcinf_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(2139095040 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def f32_fcposinf_before := [llvmfunc|
  llvm.func @f32_fcposinf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def f32_fcposinf_strictfp_before := [llvmfunc|
  llvm.func @f32_fcposinf_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def f32_fcneginf_before := [llvmfunc|
  llvm.func @f32_fcneginf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-8388608 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def f32_fcneginf_strictfp_before := [llvmfunc|
  llvm.func @f32_fcneginf_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(-8388608 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def f32_fcposzero_before := [llvmfunc|
  llvm.func @f32_fcposzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def f32_fcposzero_strictfp_before := [llvmfunc|
  llvm.func @f32_fcposzero_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def f32_fcnegzero_before := [llvmfunc|
  llvm.func @f32_fcnegzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def f32_fcnegzero_strictfp_before := [llvmfunc|
  llvm.func @f32_fcnegzero_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def f32_fczero_before := [llvmfunc|
  llvm.func @f32_fczero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def f32_fczero_strictfp_before := [llvmfunc|
  llvm.func @f32_fczero_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def f32_fcnan_before := [llvmfunc|
  llvm.func @f32_fcnan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.mlir.constant(8388607 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.bitcast %arg0 : f32 to i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    %6 = llvm.and %3, %1  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def f32_fcnan_strictfp_before := [llvmfunc|
  llvm.func @f32_fcnan_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.mlir.constant(8388607 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.bitcast %arg0 : f32 to i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    %6 = llvm.and %3, %1  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def f32_fcnan_fcinf_vec_before := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2139095040> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %0 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def f32_fcnan_fcinf_vec_strictfp_before := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_vec_strictfp(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(dense<2139095040> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %0 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def f32_fcinf_vec_before := [llvmfunc|
  llvm.func @f32_fcinf_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2139095040> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %3 = llvm.and %2, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def f32_fcinf_vec_strictfp_before := [llvmfunc|
  llvm.func @f32_fcinf_vec_strictfp(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2139095040> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %3 = llvm.and %2, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def f32_fcnan_fcinf_wrong_mask1_before := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_mask1(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095041 : i32) : i32
    %1 = llvm.mlir.constant(2139095040 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def f32_fcnan_fcinf_wrong_mask1_strictfp_before := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_mask1_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095041 : i32) : i32
    %1 = llvm.mlir.constant(2139095040 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def f32_fcnan_fcinf_wrong_mask2_before := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_mask2(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.mlir.constant(2130706432 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def f32_fcnan_fcinf_wrong_mask2_strictfp_before := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_mask2_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.mlir.constant(2130706432 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def f64_fcnan_fcinf_wrong_mask3_before := [llvmfunc|
  llvm.func @f64_fcnan_fcinf_wrong_mask3(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i64) : i64
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }]

def f64_fcnan_fcinf_wrong_mask3_strictfp_before := [llvmfunc|
  llvm.func @f64_fcnan_fcinf_wrong_mask3_strictfp(%arg0: f64) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i64) : i64
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }]

def f32_fcnan_fcinf_wrong_pred_before := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_pred(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    llvm.return %3 : i1
  }]

def f32_fcnan_fcinf_wrong_pred_strictfp_before := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_pred_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    llvm.return %3 : i1
  }]

def f32_fcposzero_wrong_pred_before := [llvmfunc|
  llvm.func @f32_fcposzero_wrong_pred(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def f32_fcposzero_wrong_pred_strictfp_before := [llvmfunc|
  llvm.func @f32_fcposzero_wrong_pred_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def f32_fcnan_fcinf_wrong_type1_before := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_type1(%arg0: vector<2xf32>) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }]

def f32_fcnan_fcinf_wrong_type1_strictfp_before := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_type1_strictfp(%arg0: vector<2xf32>) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }]

def f32_fcposinf_wrong_type1_before := [llvmfunc|
  llvm.func @f32_fcposinf_wrong_type1(%arg0: vector<2xf32>) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    llvm.return %2 : i1
  }]

def f32_fcposinf_wrong_type1_strictfp_before := [llvmfunc|
  llvm.func @f32_fcposinf_wrong_type1_strictfp(%arg0: vector<2xf32>) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    llvm.return %2 : i1
  }]

def f32_fcnan_fcinf_wrong_type2_before := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_type2(%arg0: f80) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i80) : i80
    %1 = llvm.bitcast %arg0 : f80 to i80
    %2 = llvm.and %1, %0  : i80
    %3 = llvm.icmp "eq" %2, %0 : i80
    llvm.return %3 : i1
  }]

def f32_fcnan_fcinf_wrong_type2_strictfp_before := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_type2_strictfp(%arg0: f80) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i80) : i80
    %1 = llvm.bitcast %arg0 : f80 to i80
    %2 = llvm.and %1, %0  : i80
    %3 = llvm.icmp "eq" %2, %0 : i80
    llvm.return %3 : i1
  }]

def f32_fcposzero_wrong_type2_before := [llvmfunc|
  llvm.func @f32_fcposzero_wrong_type2(%arg0: f80) -> i1 {
    %0 = llvm.mlir.constant(0 : i80) : i80
    %1 = llvm.bitcast %arg0 : f80 to i80
    %2 = llvm.icmp "eq" %1, %0 : i80
    llvm.return %2 : i1
  }]

def f32_fcposzero_wrong_type2_strictfp_before := [llvmfunc|
  llvm.func @f32_fcposzero_wrong_type2_strictfp(%arg0: f80) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(0 : i80) : i80
    %1 = llvm.bitcast %arg0 : f80 to i80
    %2 = llvm.icmp "eq" %1, %0 : i80
    llvm.return %2 : i1
  }]

def f32_fcnan_fcinf_noimplicitfloat_before := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_noimplicitfloat(%arg0: f32) -> i1 attributes {passthrough = ["noimplicitfloat"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

def f32_fcnan_fcinf_noimplicitfloat_strictfp_before := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_noimplicitfloat_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["noimplicitfloat", "strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

def f32_fcposinf_noimplicitfloat_before := [llvmfunc|
  llvm.func @f32_fcposinf_noimplicitfloat(%arg0: f32) -> i1 attributes {passthrough = ["noimplicitfloat"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def f32_fcposinf_noimplicitfloat_strictfp_before := [llvmfunc|
  llvm.func @f32_fcposinf_noimplicitfloat_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["noimplicitfloat", "strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def f32_fcposnan_before := [llvmfunc|
  llvm.func @f32_fcposnan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095041 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def f32_fcposnan_strictfp_before := [llvmfunc|
  llvm.func @f32_fcposnan_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095041 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def f32_fcposinf_multiuse_before := [llvmfunc|
  llvm.func @f32_fcposinf_multiuse(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    llvm.call @usei32(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def f32_fcposinf_multiuse_strictfp_before := [llvmfunc|
  llvm.func @f32_fcposinf_multiuse_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    llvm.call @usei32(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def f32_fcnan_fcinf_combined := [llvmfunc|
  llvm.func @f32_fcnan_fcinf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_f32_fcnan_fcinf   : f32_fcnan_fcinf_before  ⊑  f32_fcnan_fcinf_combined := by
  unfold f32_fcnan_fcinf_before f32_fcnan_fcinf_combined
  simp_alive_peephole
  sorry
def f32_fcnan_fcinf_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_f32_fcnan_fcinf_strictfp   : f32_fcnan_fcinf_strictfp_before  ⊑  f32_fcnan_fcinf_strictfp_combined := by
  unfold f32_fcnan_fcinf_strictfp_before f32_fcnan_fcinf_strictfp_combined
  simp_alive_peephole
  sorry
def f32_not_fcnan_fcinf_combined := [llvmfunc|
  llvm.func @f32_not_fcnan_fcinf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_f32_not_fcnan_fcinf   : f32_not_fcnan_fcinf_before  ⊑  f32_not_fcnan_fcinf_combined := by
  unfold f32_not_fcnan_fcinf_before f32_not_fcnan_fcinf_combined
  simp_alive_peephole
  sorry
def f32_not_fcnan_fcinf_strictfp_combined := [llvmfunc|
  llvm.func @f32_not_fcnan_fcinf_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_f32_not_fcnan_fcinf_strictfp   : f32_not_fcnan_fcinf_strictfp_before  ⊑  f32_not_fcnan_fcinf_strictfp_combined := by
  unfold f32_not_fcnan_fcinf_strictfp_before f32_not_fcnan_fcinf_strictfp_combined
  simp_alive_peephole
  sorry
def f64_fcnan_fcinf_combined := [llvmfunc|
  llvm.func @f64_fcnan_fcinf(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(9218868437227405312 : i64) : i64
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_f64_fcnan_fcinf   : f64_fcnan_fcinf_before  ⊑  f64_fcnan_fcinf_combined := by
  unfold f64_fcnan_fcinf_before f64_fcnan_fcinf_combined
  simp_alive_peephole
  sorry
def f64_fcnan_fcinf_strictfp_combined := [llvmfunc|
  llvm.func @f64_fcnan_fcinf_strictfp(%arg0: f64) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(9218868437227405312 : i64) : i64
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_f64_fcnan_fcinf_strictfp   : f64_fcnan_fcinf_strictfp_before  ⊑  f64_fcnan_fcinf_strictfp_combined := by
  unfold f64_fcnan_fcinf_strictfp_before f64_fcnan_fcinf_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcinf_combined := [llvmfunc|
  llvm.func @f32_fcinf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_f32_fcinf   : f32_fcinf_before  ⊑  f32_fcinf_combined := by
  unfold f32_fcinf_before f32_fcinf_combined
  simp_alive_peephole
  sorry
def f32_fcinf_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcinf_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_f32_fcinf_strictfp   : f32_fcinf_strictfp_before  ⊑  f32_fcinf_strictfp_combined := by
  unfold f32_fcinf_strictfp_before f32_fcinf_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcposinf_combined := [llvmfunc|
  llvm.func @f32_fcposinf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcposinf   : f32_fcposinf_before  ⊑  f32_fcposinf_combined := by
  unfold f32_fcposinf_before f32_fcposinf_combined
  simp_alive_peephole
  sorry
def f32_fcposinf_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcposinf_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcposinf_strictfp   : f32_fcposinf_strictfp_before  ⊑  f32_fcposinf_strictfp_combined := by
  unfold f32_fcposinf_strictfp_before f32_fcposinf_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcneginf_combined := [llvmfunc|
  llvm.func @f32_fcneginf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-8388608 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcneginf   : f32_fcneginf_before  ⊑  f32_fcneginf_combined := by
  unfold f32_fcneginf_before f32_fcneginf_combined
  simp_alive_peephole
  sorry
def f32_fcneginf_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcneginf_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(-8388608 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcneginf_strictfp   : f32_fcneginf_strictfp_before  ⊑  f32_fcneginf_strictfp_combined := by
  unfold f32_fcneginf_strictfp_before f32_fcneginf_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcposzero_combined := [llvmfunc|
  llvm.func @f32_fcposzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcposzero   : f32_fcposzero_before  ⊑  f32_fcposzero_combined := by
  unfold f32_fcposzero_before f32_fcposzero_combined
  simp_alive_peephole
  sorry
def f32_fcposzero_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcposzero_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcposzero_strictfp   : f32_fcposzero_strictfp_before  ⊑  f32_fcposzero_strictfp_combined := by
  unfold f32_fcposzero_strictfp_before f32_fcposzero_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcnegzero_combined := [llvmfunc|
  llvm.func @f32_fcnegzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcnegzero   : f32_fcnegzero_before  ⊑  f32_fcnegzero_combined := by
  unfold f32_fcnegzero_before f32_fcnegzero_combined
  simp_alive_peephole
  sorry
def f32_fcnegzero_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcnegzero_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcnegzero_strictfp   : f32_fcnegzero_strictfp_before  ⊑  f32_fcnegzero_strictfp_combined := by
  unfold f32_fcnegzero_strictfp_before f32_fcnegzero_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fczero_combined := [llvmfunc|
  llvm.func @f32_fczero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_f32_fczero   : f32_fczero_before  ⊑  f32_fczero_combined := by
  unfold f32_fczero_before f32_fczero_combined
  simp_alive_peephole
  sorry
def f32_fczero_strictfp_combined := [llvmfunc|
  llvm.func @f32_fczero_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_f32_fczero_strictfp   : f32_fczero_strictfp_before  ⊑  f32_fczero_strictfp_combined := by
  unfold f32_fczero_strictfp_before f32_fczero_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcnan_combined := [llvmfunc|
  llvm.func @f32_fcnan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.mlir.constant(8388607 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.bitcast %arg0 : f32 to i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    %6 = llvm.and %3, %1  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_f32_fcnan   : f32_fcnan_before  ⊑  f32_fcnan_combined := by
  unfold f32_fcnan_before f32_fcnan_combined
  simp_alive_peephole
  sorry
def f32_fcnan_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcnan_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.mlir.constant(8388607 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.bitcast %arg0 : f32 to i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    %6 = llvm.and %3, %1  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_f32_fcnan_strictfp   : f32_fcnan_strictfp_before  ⊑  f32_fcnan_strictfp_combined := by
  unfold f32_fcnan_strictfp_before f32_fcnan_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcnan_fcinf_vec_combined := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2139095040> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %0 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_f32_fcnan_fcinf_vec   : f32_fcnan_fcinf_vec_before  ⊑  f32_fcnan_fcinf_vec_combined := by
  unfold f32_fcnan_fcinf_vec_before f32_fcnan_fcinf_vec_combined
  simp_alive_peephole
  sorry
def f32_fcnan_fcinf_vec_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_vec_strictfp(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(dense<2139095040> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %0 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_f32_fcnan_fcinf_vec_strictfp   : f32_fcnan_fcinf_vec_strictfp_before  ⊑  f32_fcnan_fcinf_vec_strictfp_combined := by
  unfold f32_fcnan_fcinf_vec_strictfp_before f32_fcnan_fcinf_vec_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcinf_vec_combined := [llvmfunc|
  llvm.func @f32_fcinf_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2139095040> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %2 = llvm.bitcast %1 : vector<2xf32> to vector<2xi32>
    %3 = llvm.icmp "eq" %2, %0 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_f32_fcinf_vec   : f32_fcinf_vec_before  ⊑  f32_fcinf_vec_combined := by
  unfold f32_fcinf_vec_before f32_fcinf_vec_combined
  simp_alive_peephole
  sorry
def f32_fcinf_vec_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcinf_vec_strictfp(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(dense<2139095040> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %2 = llvm.bitcast %1 : vector<2xf32> to vector<2xi32>
    %3 = llvm.icmp "eq" %2, %0 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_f32_fcinf_vec_strictfp   : f32_fcinf_vec_strictfp_before  ⊑  f32_fcinf_vec_strictfp_combined := by
  unfold f32_fcinf_vec_strictfp_before f32_fcinf_vec_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcnan_fcinf_wrong_mask1_combined := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_mask1(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095041 : i32) : i32
    %1 = llvm.mlir.constant(2139095040 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_f32_fcnan_fcinf_wrong_mask1   : f32_fcnan_fcinf_wrong_mask1_before  ⊑  f32_fcnan_fcinf_wrong_mask1_combined := by
  unfold f32_fcnan_fcinf_wrong_mask1_before f32_fcnan_fcinf_wrong_mask1_combined
  simp_alive_peephole
  sorry
def f32_fcnan_fcinf_wrong_mask1_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_mask1_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095041 : i32) : i32
    %1 = llvm.mlir.constant(2139095040 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_f32_fcnan_fcinf_wrong_mask1_strictfp   : f32_fcnan_fcinf_wrong_mask1_strictfp_before  ⊑  f32_fcnan_fcinf_wrong_mask1_strictfp_combined := by
  unfold f32_fcnan_fcinf_wrong_mask1_strictfp_before f32_fcnan_fcinf_wrong_mask1_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcnan_fcinf_wrong_mask2_combined := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_mask2(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.mlir.constant(2130706432 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_f32_fcnan_fcinf_wrong_mask2   : f32_fcnan_fcinf_wrong_mask2_before  ⊑  f32_fcnan_fcinf_wrong_mask2_combined := by
  unfold f32_fcnan_fcinf_wrong_mask2_before f32_fcnan_fcinf_wrong_mask2_combined
  simp_alive_peephole
  sorry
def f32_fcnan_fcinf_wrong_mask2_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_mask2_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.mlir.constant(2130706432 : i32) : i32
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_f32_fcnan_fcinf_wrong_mask2_strictfp   : f32_fcnan_fcinf_wrong_mask2_strictfp_before  ⊑  f32_fcnan_fcinf_wrong_mask2_strictfp_combined := by
  unfold f32_fcnan_fcinf_wrong_mask2_strictfp_before f32_fcnan_fcinf_wrong_mask2_strictfp_combined
  simp_alive_peephole
  sorry
def f64_fcnan_fcinf_wrong_mask3_combined := [llvmfunc|
  llvm.func @f64_fcnan_fcinf_wrong_mask3(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i64) : i64
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_f64_fcnan_fcinf_wrong_mask3   : f64_fcnan_fcinf_wrong_mask3_before  ⊑  f64_fcnan_fcinf_wrong_mask3_combined := by
  unfold f64_fcnan_fcinf_wrong_mask3_before f64_fcnan_fcinf_wrong_mask3_combined
  simp_alive_peephole
  sorry
def f64_fcnan_fcinf_wrong_mask3_strictfp_combined := [llvmfunc|
  llvm.func @f64_fcnan_fcinf_wrong_mask3_strictfp(%arg0: f64) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i64) : i64
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_f64_fcnan_fcinf_wrong_mask3_strictfp   : f64_fcnan_fcinf_wrong_mask3_strictfp_before  ⊑  f64_fcnan_fcinf_wrong_mask3_strictfp_combined := by
  unfold f64_fcnan_fcinf_wrong_mask3_strictfp_before f64_fcnan_fcinf_wrong_mask3_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcnan_fcinf_wrong_pred_combined := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_pred(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_f32_fcnan_fcinf_wrong_pred   : f32_fcnan_fcinf_wrong_pred_before  ⊑  f32_fcnan_fcinf_wrong_pred_combined := by
  unfold f32_fcnan_fcinf_wrong_pred_before f32_fcnan_fcinf_wrong_pred_combined
  simp_alive_peephole
  sorry
def f32_fcnan_fcinf_wrong_pred_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_pred_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_f32_fcnan_fcinf_wrong_pred_strictfp   : f32_fcnan_fcinf_wrong_pred_strictfp_before  ⊑  f32_fcnan_fcinf_wrong_pred_strictfp_combined := by
  unfold f32_fcnan_fcinf_wrong_pred_strictfp_before f32_fcnan_fcinf_wrong_pred_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcposzero_wrong_pred_combined := [llvmfunc|
  llvm.func @f32_fcposzero_wrong_pred(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcposzero_wrong_pred   : f32_fcposzero_wrong_pred_before  ⊑  f32_fcposzero_wrong_pred_combined := by
  unfold f32_fcposzero_wrong_pred_before f32_fcposzero_wrong_pred_combined
  simp_alive_peephole
  sorry
def f32_fcposzero_wrong_pred_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcposzero_wrong_pred_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcposzero_wrong_pred_strictfp   : f32_fcposzero_wrong_pred_strictfp_before  ⊑  f32_fcposzero_wrong_pred_strictfp_combined := by
  unfold f32_fcposzero_wrong_pred_strictfp_before f32_fcposzero_wrong_pred_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcnan_fcinf_wrong_type1_combined := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_type1(%arg0: vector<2xf32>) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_f32_fcnan_fcinf_wrong_type1   : f32_fcnan_fcinf_wrong_type1_before  ⊑  f32_fcnan_fcinf_wrong_type1_combined := by
  unfold f32_fcnan_fcinf_wrong_type1_before f32_fcnan_fcinf_wrong_type1_combined
  simp_alive_peephole
  sorry
def f32_fcnan_fcinf_wrong_type1_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_type1_strictfp(%arg0: vector<2xf32>) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_f32_fcnan_fcinf_wrong_type1_strictfp   : f32_fcnan_fcinf_wrong_type1_strictfp_before  ⊑  f32_fcnan_fcinf_wrong_type1_strictfp_combined := by
  unfold f32_fcnan_fcinf_wrong_type1_strictfp_before f32_fcnan_fcinf_wrong_type1_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcposinf_wrong_type1_combined := [llvmfunc|
  llvm.func @f32_fcposinf_wrong_type1(%arg0: vector<2xf32>) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcposinf_wrong_type1   : f32_fcposinf_wrong_type1_before  ⊑  f32_fcposinf_wrong_type1_combined := by
  unfold f32_fcposinf_wrong_type1_before f32_fcposinf_wrong_type1_combined
  simp_alive_peephole
  sorry
def f32_fcposinf_wrong_type1_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcposinf_wrong_type1_strictfp(%arg0: vector<2xf32>) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcposinf_wrong_type1_strictfp   : f32_fcposinf_wrong_type1_strictfp_before  ⊑  f32_fcposinf_wrong_type1_strictfp_combined := by
  unfold f32_fcposinf_wrong_type1_strictfp_before f32_fcposinf_wrong_type1_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcnan_fcinf_wrong_type2_combined := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_type2(%arg0: f80) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i80) : i80
    %1 = llvm.bitcast %arg0 : f80 to i80
    %2 = llvm.and %1, %0  : i80
    %3 = llvm.icmp "eq" %2, %0 : i80
    llvm.return %3 : i1
  }]

theorem inst_combine_f32_fcnan_fcinf_wrong_type2   : f32_fcnan_fcinf_wrong_type2_before  ⊑  f32_fcnan_fcinf_wrong_type2_combined := by
  unfold f32_fcnan_fcinf_wrong_type2_before f32_fcnan_fcinf_wrong_type2_combined
  simp_alive_peephole
  sorry
def f32_fcnan_fcinf_wrong_type2_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_wrong_type2_strictfp(%arg0: f80) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i80) : i80
    %1 = llvm.bitcast %arg0 : f80 to i80
    %2 = llvm.and %1, %0  : i80
    %3 = llvm.icmp "eq" %2, %0 : i80
    llvm.return %3 : i1
  }]

theorem inst_combine_f32_fcnan_fcinf_wrong_type2_strictfp   : f32_fcnan_fcinf_wrong_type2_strictfp_before  ⊑  f32_fcnan_fcinf_wrong_type2_strictfp_combined := by
  unfold f32_fcnan_fcinf_wrong_type2_strictfp_before f32_fcnan_fcinf_wrong_type2_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcposzero_wrong_type2_combined := [llvmfunc|
  llvm.func @f32_fcposzero_wrong_type2(%arg0: f80) -> i1 {
    %0 = llvm.mlir.constant(0 : i80) : i80
    %1 = llvm.bitcast %arg0 : f80 to i80
    %2 = llvm.icmp "eq" %1, %0 : i80
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcposzero_wrong_type2   : f32_fcposzero_wrong_type2_before  ⊑  f32_fcposzero_wrong_type2_combined := by
  unfold f32_fcposzero_wrong_type2_before f32_fcposzero_wrong_type2_combined
  simp_alive_peephole
  sorry
def f32_fcposzero_wrong_type2_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcposzero_wrong_type2_strictfp(%arg0: f80) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(0 : i80) : i80
    %1 = llvm.bitcast %arg0 : f80 to i80
    %2 = llvm.icmp "eq" %1, %0 : i80
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcposzero_wrong_type2_strictfp   : f32_fcposzero_wrong_type2_strictfp_before  ⊑  f32_fcposzero_wrong_type2_strictfp_combined := by
  unfold f32_fcposzero_wrong_type2_strictfp_before f32_fcposzero_wrong_type2_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcnan_fcinf_noimplicitfloat_combined := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_noimplicitfloat(%arg0: f32) -> i1 attributes {passthrough = ["noimplicitfloat"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_f32_fcnan_fcinf_noimplicitfloat   : f32_fcnan_fcinf_noimplicitfloat_before  ⊑  f32_fcnan_fcinf_noimplicitfloat_combined := by
  unfold f32_fcnan_fcinf_noimplicitfloat_before f32_fcnan_fcinf_noimplicitfloat_combined
  simp_alive_peephole
  sorry
def f32_fcnan_fcinf_noimplicitfloat_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcnan_fcinf_noimplicitfloat_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["noimplicitfloat", "strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_f32_fcnan_fcinf_noimplicitfloat_strictfp   : f32_fcnan_fcinf_noimplicitfloat_strictfp_before  ⊑  f32_fcnan_fcinf_noimplicitfloat_strictfp_combined := by
  unfold f32_fcnan_fcinf_noimplicitfloat_strictfp_before f32_fcnan_fcinf_noimplicitfloat_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcposinf_noimplicitfloat_combined := [llvmfunc|
  llvm.func @f32_fcposinf_noimplicitfloat(%arg0: f32) -> i1 attributes {passthrough = ["noimplicitfloat"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcposinf_noimplicitfloat   : f32_fcposinf_noimplicitfloat_before  ⊑  f32_fcposinf_noimplicitfloat_combined := by
  unfold f32_fcposinf_noimplicitfloat_before f32_fcposinf_noimplicitfloat_combined
  simp_alive_peephole
  sorry
def f32_fcposinf_noimplicitfloat_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcposinf_noimplicitfloat_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["noimplicitfloat", "strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcposinf_noimplicitfloat_strictfp   : f32_fcposinf_noimplicitfloat_strictfp_before  ⊑  f32_fcposinf_noimplicitfloat_strictfp_combined := by
  unfold f32_fcposinf_noimplicitfloat_strictfp_before f32_fcposinf_noimplicitfloat_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcposnan_combined := [llvmfunc|
  llvm.func @f32_fcposnan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095041 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcposnan   : f32_fcposnan_before  ⊑  f32_fcposnan_combined := by
  unfold f32_fcposnan_before f32_fcposnan_combined
  simp_alive_peephole
  sorry
def f32_fcposnan_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcposnan_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095041 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcposnan_strictfp   : f32_fcposnan_strictfp_before  ⊑  f32_fcposnan_strictfp_combined := by
  unfold f32_fcposnan_strictfp_before f32_fcposnan_strictfp_combined
  simp_alive_peephole
  sorry
def f32_fcposinf_multiuse_combined := [llvmfunc|
  llvm.func @f32_fcposinf_multiuse(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    llvm.call @usei32(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcposinf_multiuse   : f32_fcposinf_multiuse_before  ⊑  f32_fcposinf_multiuse_combined := by
  unfold f32_fcposinf_multiuse_before f32_fcposinf_multiuse_combined
  simp_alive_peephole
  sorry
def f32_fcposinf_multiuse_strictfp_combined := [llvmfunc|
  llvm.func @f32_fcposinf_multiuse_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(2139095040 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    llvm.call @usei32(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_f32_fcposinf_multiuse_strictfp   : f32_fcposinf_multiuse_strictfp_before  ⊑  f32_fcposinf_multiuse_strictfp_combined := by
  unfold f32_fcposinf_multiuse_strictfp_before f32_fcposinf_multiuse_strictfp_combined
  simp_alive_peephole
  sorry
