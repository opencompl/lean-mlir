import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  combine-is.fpclass-and-fcmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fcmp_oeq_inf_or_class_normal_before := [llvmfunc|
  llvm.func @fcmp_oeq_inf_or_class_normal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def class_normal_or_fcmp_oeq_inf_before := [llvmfunc|
  llvm.func @class_normal_or_fcmp_oeq_inf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def fcmp_oeq_inf_or_class_normal_vector_before := [llvmfunc|
  llvm.func @fcmp_oeq_inf_or_class_normal_vector(%arg0: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<0x7C00> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.fcmp "oeq" %arg0, %0 : vector<2xf16>
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (vector<2xf16>) -> vector<2xi1>]

    %3 = llvm.or %1, %2  : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

def fcmp_oeq_inf_multi_use_or_class_normal_before := [llvmfunc|
  llvm.func @fcmp_oeq_inf_multi_use_or_class_normal(%arg0: f16, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    llvm.store %1, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_oeq_inf_or_class_normal_multi_use_before := [llvmfunc|
  llvm.func @fcmp_oeq_inf_or_class_normal_multi_use(%arg0: f16, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    llvm.store %2, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_or_class_isnan_before := [llvmfunc|
  llvm.func @fcmp_ord_or_class_isnan(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f16) -> i1]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_or_class_isnan_wrong_operand_before := [llvmfunc|
  llvm.func @fcmp_ord_or_class_isnan_wrong_operand(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg1) <{bit = 3 : i32}> : (f16) -> i1]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_and_class_isnan_before := [llvmfunc|
  llvm.func @fcmp_ord_and_class_isnan(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f16) -> i1]

    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_or_class_isnan_commute_before := [llvmfunc|
  llvm.func @fcmp_ord_or_class_isnan_commute(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f16) -> i1]

    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ord_and_class_isnan_commute_before := [llvmfunc|
  llvm.func @fcmp_ord_and_class_isnan_commute(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f16) -> i1]

    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_isfinite_and_class_subnormal_before := [llvmfunc|
  llvm.func @fcmp_isfinite_and_class_subnormal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "olt" %1, %0 : f16
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 144 : i32}> : (f16) -> i1]

    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def fcmp_isfinite_or_class_subnormal_before := [llvmfunc|
  llvm.func @fcmp_isfinite_or_class_subnormal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "olt" %1, %0 : f16
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 144 : i32}> : (f16) -> i1]

    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def fcmp_issubnormal_or_class_finite_before := [llvmfunc|
  llvm.func @fcmp_issubnormal_or_class_finite(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "olt" %1, %0 : f16
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 504 : i32}> : (f16) -> i1]

    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def class_finite_or_fcmp_issubnormal_before := [llvmfunc|
  llvm.func @class_finite_or_fcmp_issubnormal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "olt" %1, %0 : f16
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 504 : i32}> : (f16) -> i1]

    %4 = llvm.or %3, %2  : i1
    llvm.return %4 : i1
  }]

def fcmp_issubnormal_and_class_finite_before := [llvmfunc|
  llvm.func @fcmp_issubnormal_and_class_finite(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "olt" %1, %0 : f16
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 504 : i32}> : (f16) -> i1]

    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def class_inf_or_fcmp_issubnormal_before := [llvmfunc|
  llvm.func @class_inf_or_fcmp_issubnormal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "olt" %1, %0 : f16
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 516 : i32}> : (f16) -> i1]

    %4 = llvm.or %3, %2  : i1
    llvm.return %4 : i1
  }]

def class_finite_or_fcmp_issubnormal_vector_before := [llvmfunc|
  llvm.func @class_finite_or_fcmp_issubnormal_vector(%arg0: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<6.103520e-05> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.intr.fabs(%arg0)  : (vector<2xf16>) -> vector<2xf16>
    %2 = llvm.fcmp "olt" %1, %0 : vector<2xf16>
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 504 : i32}> : (vector<2xf16>) -> vector<2xi1>]

    %4 = llvm.or %3, %2  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def fcmp_oeq_zero_or_class_normal_before := [llvmfunc|
  llvm.func @fcmp_oeq_zero_or_class_normal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_oeq_zero_or_class_normal_daz_before := [llvmfunc|
  llvm.func @fcmp_oeq_zero_or_class_normal_daz(%arg0: f16) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_oeq_zero_or_class_normal_daz_v2f16_before := [llvmfunc|
  llvm.func @fcmp_oeq_zero_or_class_normal_daz_v2f16(%arg0: vector<2xf16>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %2 = llvm.fcmp "oeq" %arg0, %1 : vector<2xf16>
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (vector<2xf16>) -> vector<2xi1>]

    %4 = llvm.or %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def fcmp_oeq_zero_or_class_normal_dynamic_before := [llvmfunc|
  llvm.func @fcmp_oeq_zero_or_class_normal_dynamic(%arg0: f16) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_oeq_zero_or_class_normal_dynamic_v2f16_before := [llvmfunc|
  llvm.func @fcmp_oeq_zero_or_class_normal_dynamic_v2f16(%arg0: vector<2xf16>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %2 = llvm.fcmp "oeq" %arg0, %1 : vector<2xf16>
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (vector<2xf16>) -> vector<2xi1>]

    %4 = llvm.or %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def class_normal_or_fcmp_oeq_zero_before := [llvmfunc|
  llvm.func @class_normal_or_fcmp_oeq_zero(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_ueq_zero_or_class_normal_before := [llvmfunc|
  llvm.func @fcmp_ueq_zero_or_class_normal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ueq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def class_normal_or_fcmp_ueq_zero_before := [llvmfunc|
  llvm.func @class_normal_or_fcmp_ueq_zero(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ueq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_one_zero_or_class_normal_before := [llvmfunc|
  llvm.func @fcmp_one_zero_or_class_normal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "one" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_one_zero_or_class_normal_daz_before := [llvmfunc|
  llvm.func @fcmp_one_zero_or_class_normal_daz(%arg0: f16) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "one" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_one_zero_or_class_normal_dynamic_before := [llvmfunc|
  llvm.func @fcmp_one_zero_or_class_normal_dynamic(%arg0: f16) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "one" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def class_normal_or_fcmp_one_zero_before := [llvmfunc|
  llvm.func @class_normal_or_fcmp_one_zero(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "one" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_une_zero_or_class_normal_before := [llvmfunc|
  llvm.func @fcmp_une_zero_or_class_normal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "une" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def class_normal_or_fcmp_une_zero_before := [llvmfunc|
  llvm.func @class_normal_or_fcmp_une_zero(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "une" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def class_normal_or_fcmp_une_zero_daz_before := [llvmfunc|
  llvm.func @class_normal_or_fcmp_une_zero_daz(%arg0: f16) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "une" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def class_normal_or_fcmp_une_zero_dynamic_before := [llvmfunc|
  llvm.func @class_normal_or_fcmp_une_zero_dynamic(%arg0: f16) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "une" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def fcmp_oeq_inf_xor_class_normal_before := [llvmfunc|
  llvm.func @fcmp_oeq_inf_xor_class_normal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }]

def class_normal_xor_fcmp_oeq_inf_before := [llvmfunc|
  llvm.func @class_normal_xor_fcmp_oeq_inf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1]

    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }]

def fcmp_oeq_inf_or_class_normal_combined := [llvmfunc|
  llvm.func @fcmp_oeq_inf_or_class_normal(%arg0: f16) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 776 : i32}> : (f16) -> i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fcmp_oeq_inf_or_class_normal   : fcmp_oeq_inf_or_class_normal_before  ⊑  fcmp_oeq_inf_or_class_normal_combined := by
  unfold fcmp_oeq_inf_or_class_normal_before fcmp_oeq_inf_or_class_normal_combined
  simp_alive_peephole
  sorry
def class_normal_or_fcmp_oeq_inf_combined := [llvmfunc|
  llvm.func @class_normal_or_fcmp_oeq_inf(%arg0: f16) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 776 : i32}> : (f16) -> i1
    llvm.return %0 : i1
  }]

theorem inst_combine_class_normal_or_fcmp_oeq_inf   : class_normal_or_fcmp_oeq_inf_before  ⊑  class_normal_or_fcmp_oeq_inf_combined := by
  unfold class_normal_or_fcmp_oeq_inf_before class_normal_or_fcmp_oeq_inf_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_inf_or_class_normal_vector_combined := [llvmfunc|
  llvm.func @fcmp_oeq_inf_or_class_normal_vector(%arg0: vector<2xf16>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 776 : i32}> : (vector<2xf16>) -> vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_fcmp_oeq_inf_or_class_normal_vector   : fcmp_oeq_inf_or_class_normal_vector_before  ⊑  fcmp_oeq_inf_or_class_normal_vector_combined := by
  unfold fcmp_oeq_inf_or_class_normal_vector_before fcmp_oeq_inf_or_class_normal_vector_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_inf_multi_use_or_class_normal_combined := [llvmfunc|
  llvm.func @fcmp_oeq_inf_multi_use_or_class_normal(%arg0: f16, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    llvm.store %1, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_oeq_inf_multi_use_or_class_normal   : fcmp_oeq_inf_multi_use_or_class_normal_before  ⊑  fcmp_oeq_inf_multi_use_or_class_normal_combined := by
  unfold fcmp_oeq_inf_multi_use_or_class_normal_before fcmp_oeq_inf_multi_use_or_class_normal_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_inf_or_class_normal_multi_use_combined := [llvmfunc|
  llvm.func @fcmp_oeq_inf_or_class_normal_multi_use(%arg0: f16, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    llvm.store %2, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_oeq_inf_or_class_normal_multi_use   : fcmp_oeq_inf_or_class_normal_multi_use_before  ⊑  fcmp_oeq_inf_or_class_normal_multi_use_combined := by
  unfold fcmp_oeq_inf_or_class_normal_multi_use_before fcmp_oeq_inf_or_class_normal_multi_use_combined
  simp_alive_peephole
  sorry
def fcmp_ord_or_class_isnan_combined := [llvmfunc|
  llvm.func @fcmp_ord_or_class_isnan(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fcmp_ord_or_class_isnan   : fcmp_ord_or_class_isnan_before  ⊑  fcmp_ord_or_class_isnan_combined := by
  unfold fcmp_ord_or_class_isnan_before fcmp_ord_or_class_isnan_combined
  simp_alive_peephole
  sorry
def fcmp_ord_or_class_isnan_wrong_operand_combined := [llvmfunc|
  llvm.func @fcmp_ord_or_class_isnan_wrong_operand(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "uno" %arg1, %0 : f16
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_ord_or_class_isnan_wrong_operand   : fcmp_ord_or_class_isnan_wrong_operand_before  ⊑  fcmp_ord_or_class_isnan_wrong_operand_combined := by
  unfold fcmp_ord_or_class_isnan_wrong_operand_before fcmp_ord_or_class_isnan_wrong_operand_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_class_isnan_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_class_isnan(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fcmp_ord_and_class_isnan   : fcmp_ord_and_class_isnan_before  ⊑  fcmp_ord_and_class_isnan_combined := by
  unfold fcmp_ord_and_class_isnan_before fcmp_ord_and_class_isnan_combined
  simp_alive_peephole
  sorry
def fcmp_ord_or_class_isnan_commute_combined := [llvmfunc|
  llvm.func @fcmp_ord_or_class_isnan_commute(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fcmp_ord_or_class_isnan_commute   : fcmp_ord_or_class_isnan_commute_before  ⊑  fcmp_ord_or_class_isnan_commute_combined := by
  unfold fcmp_ord_or_class_isnan_commute_before fcmp_ord_or_class_isnan_commute_combined
  simp_alive_peephole
  sorry
def fcmp_ord_and_class_isnan_commute_combined := [llvmfunc|
  llvm.func @fcmp_ord_and_class_isnan_commute(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fcmp_ord_and_class_isnan_commute   : fcmp_ord_and_class_isnan_commute_before  ⊑  fcmp_ord_and_class_isnan_commute_combined := by
  unfold fcmp_ord_and_class_isnan_commute_before fcmp_ord_and_class_isnan_commute_combined
  simp_alive_peephole
  sorry
def fcmp_isfinite_and_class_subnormal_combined := [llvmfunc|
  llvm.func @fcmp_isfinite_and_class_subnormal(%arg0: f16) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 144 : i32}> : (f16) -> i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fcmp_isfinite_and_class_subnormal   : fcmp_isfinite_and_class_subnormal_before  ⊑  fcmp_isfinite_and_class_subnormal_combined := by
  unfold fcmp_isfinite_and_class_subnormal_before fcmp_isfinite_and_class_subnormal_combined
  simp_alive_peephole
  sorry
def fcmp_isfinite_or_class_subnormal_combined := [llvmfunc|
  llvm.func @fcmp_isfinite_or_class_subnormal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "one" %1, %0 : f16
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_isfinite_or_class_subnormal   : fcmp_isfinite_or_class_subnormal_before  ⊑  fcmp_isfinite_or_class_subnormal_combined := by
  unfold fcmp_isfinite_or_class_subnormal_before fcmp_isfinite_or_class_subnormal_combined
  simp_alive_peephole
  sorry
def fcmp_issubnormal_or_class_finite_combined := [llvmfunc|
  llvm.func @fcmp_issubnormal_or_class_finite(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "one" %1, %0 : f16
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_issubnormal_or_class_finite   : fcmp_issubnormal_or_class_finite_before  ⊑  fcmp_issubnormal_or_class_finite_combined := by
  unfold fcmp_issubnormal_or_class_finite_before fcmp_issubnormal_or_class_finite_combined
  simp_alive_peephole
  sorry
def class_finite_or_fcmp_issubnormal_combined := [llvmfunc|
  llvm.func @class_finite_or_fcmp_issubnormal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "one" %1, %0 : f16
    llvm.return %2 : i1
  }]

theorem inst_combine_class_finite_or_fcmp_issubnormal   : class_finite_or_fcmp_issubnormal_before  ⊑  class_finite_or_fcmp_issubnormal_combined := by
  unfold class_finite_or_fcmp_issubnormal_before class_finite_or_fcmp_issubnormal_combined
  simp_alive_peephole
  sorry
def fcmp_issubnormal_and_class_finite_combined := [llvmfunc|
  llvm.func @fcmp_issubnormal_and_class_finite(%arg0: f16) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (f16) -> i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fcmp_issubnormal_and_class_finite   : fcmp_issubnormal_and_class_finite_before  ⊑  fcmp_issubnormal_and_class_finite_combined := by
  unfold fcmp_issubnormal_and_class_finite_before fcmp_issubnormal_and_class_finite_combined
  simp_alive_peephole
  sorry
def class_inf_or_fcmp_issubnormal_combined := [llvmfunc|
  llvm.func @class_inf_or_fcmp_issubnormal(%arg0: f16) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 756 : i32}> : (f16) -> i1
    llvm.return %0 : i1
  }]

theorem inst_combine_class_inf_or_fcmp_issubnormal   : class_inf_or_fcmp_issubnormal_before  ⊑  class_inf_or_fcmp_issubnormal_combined := by
  unfold class_inf_or_fcmp_issubnormal_before class_inf_or_fcmp_issubnormal_combined
  simp_alive_peephole
  sorry
def class_finite_or_fcmp_issubnormal_vector_combined := [llvmfunc|
  llvm.func @class_finite_or_fcmp_issubnormal_vector(%arg0: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<0x7C00> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.intr.fabs(%arg0)  : (vector<2xf16>) -> vector<2xf16>
    %2 = llvm.fcmp "one" %1, %0 : vector<2xf16>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_class_finite_or_fcmp_issubnormal_vector   : class_finite_or_fcmp_issubnormal_vector_before  ⊑  class_finite_or_fcmp_issubnormal_vector_combined := by
  unfold class_finite_or_fcmp_issubnormal_vector_before class_finite_or_fcmp_issubnormal_vector_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_zero_or_class_normal_combined := [llvmfunc|
  llvm.func @fcmp_oeq_zero_or_class_normal(%arg0: f16) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 360 : i32}> : (f16) -> i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fcmp_oeq_zero_or_class_normal   : fcmp_oeq_zero_or_class_normal_before  ⊑  fcmp_oeq_zero_or_class_normal_combined := by
  unfold fcmp_oeq_zero_or_class_normal_before fcmp_oeq_zero_or_class_normal_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_zero_or_class_normal_daz_combined := [llvmfunc|
  llvm.func @fcmp_oeq_zero_or_class_normal_daz(%arg0: f16) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_oeq_zero_or_class_normal_daz   : fcmp_oeq_zero_or_class_normal_daz_before  ⊑  fcmp_oeq_zero_or_class_normal_daz_combined := by
  unfold fcmp_oeq_zero_or_class_normal_daz_before fcmp_oeq_zero_or_class_normal_daz_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_zero_or_class_normal_daz_v2f16_combined := [llvmfunc|
  llvm.func @fcmp_oeq_zero_or_class_normal_daz_v2f16(%arg0: vector<2xf16>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %2 = llvm.fcmp "oeq" %arg0, %1 : vector<2xf16>
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (vector<2xf16>) -> vector<2xi1>
    %4 = llvm.or %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_fcmp_oeq_zero_or_class_normal_daz_v2f16   : fcmp_oeq_zero_or_class_normal_daz_v2f16_before  ⊑  fcmp_oeq_zero_or_class_normal_daz_v2f16_combined := by
  unfold fcmp_oeq_zero_or_class_normal_daz_v2f16_before fcmp_oeq_zero_or_class_normal_daz_v2f16_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_zero_or_class_normal_dynamic_combined := [llvmfunc|
  llvm.func @fcmp_oeq_zero_or_class_normal_dynamic(%arg0: f16) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "oeq" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_oeq_zero_or_class_normal_dynamic   : fcmp_oeq_zero_or_class_normal_dynamic_before  ⊑  fcmp_oeq_zero_or_class_normal_dynamic_combined := by
  unfold fcmp_oeq_zero_or_class_normal_dynamic_before fcmp_oeq_zero_or_class_normal_dynamic_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_zero_or_class_normal_dynamic_v2f16_combined := [llvmfunc|
  llvm.func @fcmp_oeq_zero_or_class_normal_dynamic_v2f16(%arg0: vector<2xf16>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %2 = llvm.fcmp "oeq" %arg0, %1 : vector<2xf16>
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (vector<2xf16>) -> vector<2xi1>
    %4 = llvm.or %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_fcmp_oeq_zero_or_class_normal_dynamic_v2f16   : fcmp_oeq_zero_or_class_normal_dynamic_v2f16_before  ⊑  fcmp_oeq_zero_or_class_normal_dynamic_v2f16_combined := by
  unfold fcmp_oeq_zero_or_class_normal_dynamic_v2f16_before fcmp_oeq_zero_or_class_normal_dynamic_v2f16_combined
  simp_alive_peephole
  sorry
def class_normal_or_fcmp_oeq_zero_combined := [llvmfunc|
  llvm.func @class_normal_or_fcmp_oeq_zero(%arg0: f16) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 360 : i32}> : (f16) -> i1
    llvm.return %0 : i1
  }]

theorem inst_combine_class_normal_or_fcmp_oeq_zero   : class_normal_or_fcmp_oeq_zero_before  ⊑  class_normal_or_fcmp_oeq_zero_combined := by
  unfold class_normal_or_fcmp_oeq_zero_before class_normal_or_fcmp_oeq_zero_combined
  simp_alive_peephole
  sorry
def fcmp_ueq_zero_or_class_normal_combined := [llvmfunc|
  llvm.func @fcmp_ueq_zero_or_class_normal(%arg0: f16) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 363 : i32}> : (f16) -> i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fcmp_ueq_zero_or_class_normal   : fcmp_ueq_zero_or_class_normal_before  ⊑  fcmp_ueq_zero_or_class_normal_combined := by
  unfold fcmp_ueq_zero_or_class_normal_before fcmp_ueq_zero_or_class_normal_combined
  simp_alive_peephole
  sorry
def class_normal_or_fcmp_ueq_zero_combined := [llvmfunc|
  llvm.func @class_normal_or_fcmp_ueq_zero(%arg0: f16) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 363 : i32}> : (f16) -> i1
    llvm.return %0 : i1
  }]

theorem inst_combine_class_normal_or_fcmp_ueq_zero   : class_normal_or_fcmp_ueq_zero_before  ⊑  class_normal_or_fcmp_ueq_zero_combined := by
  unfold class_normal_or_fcmp_ueq_zero_before class_normal_or_fcmp_ueq_zero_combined
  simp_alive_peephole
  sorry
def fcmp_one_zero_or_class_normal_combined := [llvmfunc|
  llvm.func @fcmp_one_zero_or_class_normal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "one" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_fcmp_one_zero_or_class_normal   : fcmp_one_zero_or_class_normal_before  ⊑  fcmp_one_zero_or_class_normal_combined := by
  unfold fcmp_one_zero_or_class_normal_before fcmp_one_zero_or_class_normal_combined
  simp_alive_peephole
  sorry
def fcmp_one_zero_or_class_normal_daz_combined := [llvmfunc|
  llvm.func @fcmp_one_zero_or_class_normal_daz(%arg0: f16) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "one" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_one_zero_or_class_normal_daz   : fcmp_one_zero_or_class_normal_daz_before  ⊑  fcmp_one_zero_or_class_normal_daz_combined := by
  unfold fcmp_one_zero_or_class_normal_daz_before fcmp_one_zero_or_class_normal_daz_combined
  simp_alive_peephole
  sorry
def fcmp_one_zero_or_class_normal_dynamic_combined := [llvmfunc|
  llvm.func @fcmp_one_zero_or_class_normal_dynamic(%arg0: f16) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "one" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_fcmp_one_zero_or_class_normal_dynamic   : fcmp_one_zero_or_class_normal_dynamic_before  ⊑  fcmp_one_zero_or_class_normal_dynamic_combined := by
  unfold fcmp_one_zero_or_class_normal_dynamic_before fcmp_one_zero_or_class_normal_dynamic_combined
  simp_alive_peephole
  sorry
def class_normal_or_fcmp_one_zero_combined := [llvmfunc|
  llvm.func @class_normal_or_fcmp_one_zero(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "one" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_class_normal_or_fcmp_one_zero   : class_normal_or_fcmp_one_zero_before  ⊑  class_normal_or_fcmp_one_zero_combined := by
  unfold class_normal_or_fcmp_one_zero_before class_normal_or_fcmp_one_zero_combined
  simp_alive_peephole
  sorry
def fcmp_une_zero_or_class_normal_combined := [llvmfunc|
  llvm.func @fcmp_une_zero_or_class_normal(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "une" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_fcmp_une_zero_or_class_normal   : fcmp_une_zero_or_class_normal_before  ⊑  fcmp_une_zero_or_class_normal_combined := by
  unfold fcmp_une_zero_or_class_normal_before fcmp_une_zero_or_class_normal_combined
  simp_alive_peephole
  sorry
def class_normal_or_fcmp_une_zero_combined := [llvmfunc|
  llvm.func @class_normal_or_fcmp_une_zero(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "une" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_class_normal_or_fcmp_une_zero   : class_normal_or_fcmp_une_zero_before  ⊑  class_normal_or_fcmp_une_zero_combined := by
  unfold class_normal_or_fcmp_une_zero_before class_normal_or_fcmp_une_zero_combined
  simp_alive_peephole
  sorry
def class_normal_or_fcmp_une_zero_daz_combined := [llvmfunc|
  llvm.func @class_normal_or_fcmp_une_zero_daz(%arg0: f16) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "une" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_class_normal_or_fcmp_une_zero_daz   : class_normal_or_fcmp_une_zero_daz_before  ⊑  class_normal_or_fcmp_une_zero_daz_combined := by
  unfold class_normal_or_fcmp_une_zero_daz_before class_normal_or_fcmp_une_zero_daz_combined
  simp_alive_peephole
  sorry
def class_normal_or_fcmp_une_zero_dynamic_combined := [llvmfunc|
  llvm.func @class_normal_or_fcmp_une_zero_dynamic(%arg0: f16) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "une" %arg0, %0 : f16
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f16) -> i1
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_class_normal_or_fcmp_une_zero_dynamic   : class_normal_or_fcmp_une_zero_dynamic_before  ⊑  class_normal_or_fcmp_une_zero_dynamic_combined := by
  unfold class_normal_or_fcmp_une_zero_dynamic_before class_normal_or_fcmp_une_zero_dynamic_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_inf_xor_class_normal_combined := [llvmfunc|
  llvm.func @fcmp_oeq_inf_xor_class_normal(%arg0: f16) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 776 : i32}> : (f16) -> i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fcmp_oeq_inf_xor_class_normal   : fcmp_oeq_inf_xor_class_normal_before  ⊑  fcmp_oeq_inf_xor_class_normal_combined := by
  unfold fcmp_oeq_inf_xor_class_normal_before fcmp_oeq_inf_xor_class_normal_combined
  simp_alive_peephole
  sorry
def class_normal_xor_fcmp_oeq_inf_combined := [llvmfunc|
  llvm.func @class_normal_xor_fcmp_oeq_inf(%arg0: f16) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 776 : i32}> : (f16) -> i1
    llvm.return %0 : i1
  }]

theorem inst_combine_class_normal_xor_fcmp_oeq_inf   : class_normal_xor_fcmp_oeq_inf_before  ⊑  class_normal_xor_fcmp_oeq_inf_combined := by
  unfold class_normal_xor_fcmp_oeq_inf_before class_normal_xor_fcmp_oeq_inf_combined
  simp_alive_peephole
  sorry
