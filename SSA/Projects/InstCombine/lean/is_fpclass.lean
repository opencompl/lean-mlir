import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  is_fpclass
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_class_no_mask_f32_before := [llvmfunc|
  llvm.func @test_class_no_mask_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 0 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_full_mask_f32_before := [llvmfunc|
  llvm.func @test_class_full_mask_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1023 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_undef_no_mask_f32_before := [llvmfunc|
  llvm.func @test_class_undef_no_mask_f32() -> i1 {
    %0 = llvm.mlir.undef : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 0 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_undef_full_mask_f32_before := [llvmfunc|
  llvm.func @test_class_undef_full_mask_f32() -> i1 {
    %0 = llvm.mlir.undef : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1023 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_poison_no_mask_f32_before := [llvmfunc|
  llvm.func @test_class_poison_no_mask_f32() -> i1 {
    %0 = llvm.mlir.poison : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 0 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_poison_full_mask_f32_before := [llvmfunc|
  llvm.func @test_class_poison_full_mask_f32() -> i1 {
    %0 = llvm.mlir.poison : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1023 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_undef_val_f32_before := [llvmfunc|
  llvm.func @test_class_undef_val_f32() -> i1 {
    %0 = llvm.mlir.undef : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 4 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_poison_val_f32_before := [llvmfunc|
  llvm.func @test_class_poison_val_f32() -> i1 {
    %0 = llvm.mlir.poison : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 4 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_isnan_f32_before := [llvmfunc|
  llvm.func @test_class_isnan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_isnan_v2f32_before := [llvmfunc|
  llvm.func @test_class_isnan_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %0 : vector<2xi1>
  }]

def test_class_isnan_f32_strict_before := [llvmfunc|
  llvm.func @test_class_isnan_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_p0_n0_f32_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_p0_n0_v2f32_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %0 : vector<2xi1>
  }]

def test_class_is_p0_n0_v2f32_daz_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_v2f32_daz(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %0 : vector<2xi1>
  }]

def test_class_is_p0_n0_v2f32_dynamic_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_v2f32_dynamic(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math-f32", "ieee,dynamic"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %0 : vector<2xi1>
  }]

def test_class_is_p0_n0_or_nan_f32_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 99 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_p0_n0_or_nan_v2f32_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_nan_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 99 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %0 : vector<2xi1>
  }]

def test_class_is_p0_n0_or_nan_f32_daz_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_nan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 99 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_p0_n0_or_nan_v2f32_daz_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_nan_v2f32_daz(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 99 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %0 : vector<2xi1>
  }]

def test_class_is_p0_n0_or_sub_or_nan_f32_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_sub_or_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 243 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_p0_n0_or_sub_or_nan_v2f32_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_sub_or_nan_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 243 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %0 : vector<2xi1>
  }]

def test_class_is_p0_n0_or_sub_or_nan_f32_daz_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_sub_or_nan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 243 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_p0_n0_or_sub_or_nan_v2f32_daz_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_sub_or_nan_v2f32_daz(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 243 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %0 : vector<2xi1>
  }]

def test_class_is_p0_n0_or_sub_or_snan_f32_daz_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_sub_or_snan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 241 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_p0_n0_or_sub_or_qnan_f32_daz_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_sub_or_qnan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 242 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_p0_n0_or_nan_f32_before := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_or_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 924 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_p0_n0_or_qnan_f32_before := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_or_qnan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 926 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_p0_n0_or_snan_f32_before := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_or_snan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 925 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_p0_n0_or_nan_f32_daz_before := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_or_nan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 924 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_p0_n0_or_sub_or_nan_f32_before := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_or_sub_or_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_p0_n0_or_sub_or_nan_f32_daz_before := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_or_sub_or_nan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_p0_n0_or_sub_and_not_nan_f32_before := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_or_sub_and_not_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 780 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_p0_n0_or_sub_and_not_nan_f32_daz_before := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_or_sub_and_not_nan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 780 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_p0_n0_f32_before := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 927 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_p0_n0_v2f32_before := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 927 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %0 : vector<2xi1>
  }]

def test_class_is_not_p0_n0_f32_strict_before := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 927 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_p0_n0_f32_daz_before := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 927 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_p0_n0_f32_dynamic_before := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_f32_dynamic(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 927 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_p0_n0_psub_nsub_f32_daz_before := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_psub_nsub_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_p0_n0_psub_nsub_f32_dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_psub_nsub_f32_dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_p0_n0_psub_nsub_f32_dynamic_before := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_psub_nsub_f32_dynamic(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,dynamiz"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_p0_n0_f32_strict_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_p0_n0_f32_daz_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_p0_n0_f32_dapz_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_f32_dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_p0_n0_psub_nsub_f32_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_psub_nsub_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_p0_n0_psub_nsub_f32_daz_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_psub_nsub_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_p0_n0_psub_nsub_f32_dapz_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_psub_nsub_f32_dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_p0_n0_psub_nsub_f32_dynamic_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_psub_nsub_f32_dynamic(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_p0_n0_psub_nsub_v2f32_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_psub_nsub_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %0 : vector<2xi1>
  }]

def test_class_is_p0_n0_psub_nsub_v2f32_daz_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_psub_nsub_v2f32_daz(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %0 : vector<2xi1>
  }]

def test_class_is_p0_n0_psub_nsub_v2f32_dapz_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_psub_nsub_v2f32_dapz(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math", "ieee,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %0 : vector<2xi1>
  }]

def test_class_is_p0_n0_psub_nsub_v2f32_dynamic_before := [llvmfunc|
  llvm.func @test_class_is_p0_n0_psub_nsub_v2f32_dynamic(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %0 : vector<2xi1>
  }]

def test_class_is_pinf_f32_before := [llvmfunc|
  llvm.func @test_class_is_pinf_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pinf_or_nan_f32_before := [llvmfunc|
  llvm.func @test_class_is_pinf_or_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 515 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pinf_v2f32_before := [llvmfunc|
  llvm.func @test_class_is_pinf_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %0 : vector<2xi1>
  }]

def test_class_is_ninf_f32_before := [llvmfunc|
  llvm.func @test_class_is_ninf_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_ninf_or_nan_f32_before := [llvmfunc|
  llvm.func @test_class_is_ninf_or_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_ninf_v2f32_before := [llvmfunc|
  llvm.func @test_class_is_ninf_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %0 : vector<2xi1>
  }]

def test_class_is_inf_f32_before := [llvmfunc|
  llvm.func @test_class_is_inf_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 516 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_inf_v2f32_before := [llvmfunc|
  llvm.func @test_class_is_inf_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 516 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %0 : vector<2xi1>
  }]

def test_class_is_inf_or_nan_f32_before := [llvmfunc|
  llvm.func @test_class_is_inf_or_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 519 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pinf_f32_strict_before := [llvmfunc|
  llvm.func @test_class_is_pinf_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_ninf_f32_strict_before := [llvmfunc|
  llvm.func @test_class_is_ninf_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_inf_f32_strict_before := [llvmfunc|
  llvm.func @test_class_is_inf_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 516 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pinf_or_nan_f32_strict_before := [llvmfunc|
  llvm.func @test_class_is_pinf_or_nan_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 515 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_ninf_or_nan_f32_strict_before := [llvmfunc|
  llvm.func @test_class_is_ninf_or_nan_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_inf_or_nan_f32_strict_before := [llvmfunc|
  llvm.func @test_class_is_inf_or_nan_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 519 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_constant_class_snan_test_snan_f64_before := [llvmfunc|
  llvm.func @test_constant_class_snan_test_snan_f64() -> i1 {
    %0 = llvm.mlir.constant(0x7FF0000000000001 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_qnan_test_qnan_f64_before := [llvmfunc|
  llvm.func @test_constant_class_qnan_test_qnan_f64() -> i1 {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 2 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_qnan_test_snan_f64_before := [llvmfunc|
  llvm.func @test_constant_class_qnan_test_snan_f64() -> i1 {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_ninf_test_ninf_f64_before := [llvmfunc|
  llvm.func @test_constant_class_ninf_test_ninf_f64() -> i1 {
    %0 = llvm.mlir.constant(0xFFF0000000000000 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 4 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_pinf_test_ninf_f64_before := [llvmfunc|
  llvm.func @test_constant_class_pinf_test_ninf_f64() -> i1 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 4 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_qnan_test_ninf_f64_before := [llvmfunc|
  llvm.func @test_constant_class_qnan_test_ninf_f64() -> i1 {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 4 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_snan_test_ninf_f64_before := [llvmfunc|
  llvm.func @test_constant_class_snan_test_ninf_f64() -> i1 {
    %0 = llvm.mlir.constant(0x7FF0000000000001 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 4 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_nnormal_test_nnormal_f64_before := [llvmfunc|
  llvm.func @test_constant_class_nnormal_test_nnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 8 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_pnormal_test_nnormal_f64_before := [llvmfunc|
  llvm.func @test_constant_class_pnormal_test_nnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 8 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_nsubnormal_test_nsubnormal_f64_before := [llvmfunc|
  llvm.func @test_constant_class_nsubnormal_test_nsubnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(-2.2250738585072009E-308 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 16 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_psubnormal_test_nsubnormal_f64_before := [llvmfunc|
  llvm.func @test_constant_class_psubnormal_test_nsubnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(2.2250738585072009E-308 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 16 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_nzero_test_nzero_f64_before := [llvmfunc|
  llvm.func @test_constant_class_nzero_test_nzero_f64() -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 32 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_pzero_test_nzero_f64_before := [llvmfunc|
  llvm.func @test_constant_class_pzero_test_nzero_f64() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 32 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_pzero_test_pzero_f64_before := [llvmfunc|
  llvm.func @test_constant_class_pzero_test_pzero_f64() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 64 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_nzero_test_pzero_f64_before := [llvmfunc|
  llvm.func @test_constant_class_nzero_test_pzero_f64() -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 64 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_psubnormal_test_psubnormal_f64_before := [llvmfunc|
  llvm.func @test_constant_class_psubnormal_test_psubnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(2.2250738585072009E-308 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 128 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_nsubnormal_test_psubnormal_f64_before := [llvmfunc|
  llvm.func @test_constant_class_nsubnormal_test_psubnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(-2.2250738585072009E-308 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 128 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_pnormal_test_pnormal_f64_before := [llvmfunc|
  llvm.func @test_constant_class_pnormal_test_pnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 256 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_nnormal_test_pnormal_f64_before := [llvmfunc|
  llvm.func @test_constant_class_nnormal_test_pnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 256 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_pinf_test_pinf_f64_before := [llvmfunc|
  llvm.func @test_constant_class_pinf_test_pinf_f64() -> i1 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 512 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_ninf_test_pinf_f64_before := [llvmfunc|
  llvm.func @test_constant_class_ninf_test_pinf_f64() -> i1 {
    %0 = llvm.mlir.constant(0xFFF0000000000000 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 512 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_qnan_test_pinf_f64_before := [llvmfunc|
  llvm.func @test_constant_class_qnan_test_pinf_f64() -> i1 {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 512 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_constant_class_snan_test_pinf_f64_before := [llvmfunc|
  llvm.func @test_constant_class_snan_test_pinf_f64() -> i1 {
    %0 = llvm.mlir.constant(0x7FF0000000000001 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 512 : i32}> : (f64) -> i1]

    llvm.return %1 : i1
  }]

def test_class_is_snan_nnan_src_before := [llvmfunc|
  llvm.func @test_class_is_snan_nnan_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 1 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_is_qnan_nnan_src_before := [llvmfunc|
  llvm.func @test_class_is_qnan_nnan_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 2 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_is_nan_nnan_src_before := [llvmfunc|
  llvm.func @test_class_is_nan_nnan_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 3 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_is_nan_other_nnan_src_before := [llvmfunc|
  llvm.func @test_class_is_nan_other_nnan_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 267 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_is_not_nan_nnan_src_before := [llvmfunc|
  llvm.func @test_class_is_not_nan_nnan_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 1020 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_is_not_nan_nnan_src_strict_before := [llvmfunc|
  llvm.func @test_class_is_not_nan_nnan_src_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 1020 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_is_ninf_pinf_ninf_src_before := [llvmfunc|
  llvm.func @test_class_is_ninf_pinf_ninf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 516 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_is_ninf_ninf_src_before := [llvmfunc|
  llvm.func @test_class_is_ninf_ninf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 4 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_is_pinf_ninf_src_before := [llvmfunc|
  llvm.func @test_class_is_pinf_ninf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 512 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_is_ninf_pinf_pnormal_ninf_src_before := [llvmfunc|
  llvm.func @test_class_is_ninf_pinf_pnormal_ninf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 772 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_is_not_inf_ninf_src_before := [llvmfunc|
  llvm.func @test_class_is_not_inf_ninf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 507 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_is_not_inf_ninf_src_strict_before := [llvmfunc|
  llvm.func @test_class_is_not_inf_ninf_src_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 507 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_not_is_nan_before := [llvmfunc|
  llvm.func @test_class_not_is_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f32) -> i1]

    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

def test_class_not_is_nan_multi_use_before := [llvmfunc|
  llvm.func @test_class_not_is_nan_multi_use(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f32) -> i1]

    llvm.store %1, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

def test_class_not_is_inf_nan_before := [llvmfunc|
  llvm.func @test_class_not_is_inf_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 519 : i32}> : (f32) -> i1]

    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

def test_class_not_is_normal_before := [llvmfunc|
  llvm.func @test_class_not_is_normal(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1]

    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

def test_class_xor_false_before := [llvmfunc|
  llvm.func @test_class_xor_false(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 33 : i32}> : (f32) -> i1]

    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

def test_class_not_vector_before := [llvmfunc|
  llvm.func @test_class_not_vector(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 33 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    %3 = llvm.xor %2, %1  : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

def test_class_xor_vector_before := [llvmfunc|
  llvm.func @test_class_xor_vector(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 33 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    %4 = llvm.xor %3, %2  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def test_fold_or_class_f32_0_before := [llvmfunc|
  llvm.func @test_fold_or_class_f32_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1]

    %2 = llvm.fcmp "uno" %arg0, %0 : f32
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def test_fold_or3_class_f32_0_before := [llvmfunc|
  llvm.func @test_fold_or3_class_f32_0(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 2 : i32}> : (f32) -> i1]

    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

    %3 = llvm.or %0, %1  : i1
    %4 = llvm.or %3, %2  : i1
    llvm.return %4 : i1
  }]

def test_fold_or_all_tests_class_f32_0_before := [llvmfunc|
  llvm.func @test_fold_or_all_tests_class_f32_0(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 2 : i32}> : (f32) -> i1]

    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1]

    %4 = "llvm.intr.is.fpclass"(%arg0) <{bit = 16 : i32}> : (f32) -> i1]

    %5 = "llvm.intr.is.fpclass"(%arg0) <{bit = 32 : i32}> : (f32) -> i1]

    %6 = "llvm.intr.is.fpclass"(%arg0) <{bit = 64 : i32}> : (f32) -> i1]

    %7 = "llvm.intr.is.fpclass"(%arg0) <{bit = 128 : i32}> : (f32) -> i1]

    %8 = "llvm.intr.is.fpclass"(%arg0) <{bit = 256 : i32}> : (f32) -> i1]

    %9 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (f32) -> i1]

    %10 = llvm.or %0, %1  : i1
    %11 = llvm.or %10, %2  : i1
    %12 = llvm.or %11, %3  : i1
    %13 = llvm.or %12, %4  : i1
    %14 = llvm.or %13, %5  : i1
    %15 = llvm.or %14, %6  : i1
    %16 = llvm.or %15, %7  : i1
    %17 = llvm.or %16, %8  : i1
    %18 = llvm.or %17, %9  : i1
    llvm.return %18 : i1
  }]

def test_fold_or_class_f32_1_before := [llvmfunc|
  llvm.func @test_fold_or_class_f32_1(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1]

    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def test_no_fold_or_class_f32_multi_use0_before := [llvmfunc|
  llvm.func @test_no_fold_or_class_f32_multi_use0(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

    llvm.store %0, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1]

    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def test_no_fold_or_class_f32_multi_use1_before := [llvmfunc|
  llvm.func @test_no_fold_or_class_f32_multi_use1(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1]

    llvm.store %1, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def test_fold_or_class_f32_2_before := [llvmfunc|
  llvm.func @test_fold_or_class_f32_2(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1]

    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def test_no_fold_or_class_f32_0_before := [llvmfunc|
  llvm.func @test_no_fold_or_class_f32_0(%arg0: f32, %arg1: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg1) <{bit = 8 : i32}> : (f32) -> i1]

    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def test_fold_or_class_v2f32_before := [llvmfunc|
  llvm.func @test_fold_or_class_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    %2 = llvm.or %0, %1  : vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }]

def test_fold_and_class_f32_0_before := [llvmfunc|
  llvm.func @test_fold_and_class_f32_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1]

    %2 = llvm.fcmp "uno" %arg0, %0 : f32
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def test_fold_and3_class_f32_0_before := [llvmfunc|
  llvm.func @test_fold_and3_class_f32_0(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 2 : i32}> : (f32) -> i1]

    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1]

    %3 = llvm.and %0, %1  : i1
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }]

def test_fold_and_all_tests_class_f32_0_before := [llvmfunc|
  llvm.func @test_fold_and_all_tests_class_f32_0(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 2 : i32}> : (f32) -> i1]

    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1]

    %4 = "llvm.intr.is.fpclass"(%arg0) <{bit = 16 : i32}> : (f32) -> i1]

    %5 = "llvm.intr.is.fpclass"(%arg0) <{bit = 32 : i32}> : (f32) -> i1]

    %6 = "llvm.intr.is.fpclass"(%arg0) <{bit = 64 : i32}> : (f32) -> i1]

    %7 = "llvm.intr.is.fpclass"(%arg0) <{bit = 128 : i32}> : (f32) -> i1]

    %8 = "llvm.intr.is.fpclass"(%arg0) <{bit = 256 : i32}> : (f32) -> i1]

    %9 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (f32) -> i1]

    %10 = llvm.and %0, %1  : i1
    %11 = llvm.and %10, %2  : i1
    %12 = llvm.and %11, %3  : i1
    %13 = llvm.and %12, %4  : i1
    %14 = llvm.and %13, %5  : i1
    %15 = llvm.and %14, %6  : i1
    %16 = llvm.and %15, %7  : i1
    %17 = llvm.and %16, %8  : i1
    %18 = llvm.and %17, %9  : i1
    llvm.return %18 : i1
  }]

def test_fold_and_not_all_tests_class_f32_0_before := [llvmfunc|
  llvm.func @test_fold_and_not_all_tests_class_f32_0(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1022 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1021 : i32}> : (f32) -> i1]

    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1019 : i32}> : (f32) -> i1]

    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1015 : i32}> : (f32) -> i1]

    %4 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1007 : i32}> : (f32) -> i1]

    %5 = "llvm.intr.is.fpclass"(%arg0) <{bit = 991 : i32}> : (f32) -> i1]

    %6 = "llvm.intr.is.fpclass"(%arg0) <{bit = 959 : i32}> : (f32) -> i1]

    %7 = "llvm.intr.is.fpclass"(%arg0) <{bit = 895 : i32}> : (f32) -> i1]

    %8 = "llvm.intr.is.fpclass"(%arg0) <{bit = 767 : i32}> : (f32) -> i1]

    %9 = "llvm.intr.is.fpclass"(%arg0) <{bit = 511 : i32}> : (f32) -> i1]

    %10 = llvm.and %0, %1  : i1
    %11 = llvm.and %10, %2  : i1
    %12 = llvm.and %11, %3  : i1
    %13 = llvm.and %12, %4  : i1
    %14 = llvm.and %13, %5  : i1
    %15 = llvm.and %14, %6  : i1
    %16 = llvm.and %15, %7  : i1
    %17 = llvm.and %16, %8  : i1
    %18 = llvm.and %17, %9  : i1
    llvm.return %18 : i1
  }]

def test_fold_and_class_f32_1_before := [llvmfunc|
  llvm.func @test_fold_and_class_f32_1(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 48 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 11 : i32}> : (f32) -> i1]

    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }]

def test_no_fold_and_class_f32_multi_use0_before := [llvmfunc|
  llvm.func @test_no_fold_and_class_f32_multi_use0(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 15 : i32}> : (f32) -> i1]

    llvm.store %0, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1]

    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }]

def test_no_fold_and_class_f32_multi_use1_before := [llvmfunc|
  llvm.func @test_no_fold_and_class_f32_multi_use1(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 15 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1]

    llvm.store %1, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }]

def test_fold_and_class_f32_2_before := [llvmfunc|
  llvm.func @test_fold_and_class_f32_2(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1]

    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }]

def test_fold_and_class_f32_3_before := [llvmfunc|
  llvm.func @test_fold_and_class_f32_3(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 37 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 393 : i32}> : (f32) -> i1]

    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }]

def test_fold_and_class_f32_4_before := [llvmfunc|
  llvm.func @test_fold_and_class_f32_4(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 393 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 37 : i32}> : (f32) -> i1]

    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }]

def test_no_fold_and_class_f32_0_before := [llvmfunc|
  llvm.func @test_no_fold_and_class_f32_0(%arg0: f32, %arg1: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg1) <{bit = 15 : i32}> : (f32) -> i1]

    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }]

def test_fold_and_class_v2f32_before := [llvmfunc|
  llvm.func @test_fold_and_class_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 15 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    %2 = llvm.and %0, %1  : vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }]

def test_fold_xor_class_f32_0_before := [llvmfunc|
  llvm.func @test_fold_xor_class_f32_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1]

    %2 = llvm.fcmp "uno" %arg0, %0 : f32
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }]

def test_fold_xor3_class_f32_0_before := [llvmfunc|
  llvm.func @test_fold_xor3_class_f32_0(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 2 : i32}> : (f32) -> i1]

    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

    %3 = llvm.xor %0, %1  : i1
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }]

def test_fold_xor_all_tests_class_f32_0_before := [llvmfunc|
  llvm.func @test_fold_xor_all_tests_class_f32_0(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 2 : i32}> : (f32) -> i1]

    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1]

    %4 = "llvm.intr.is.fpclass"(%arg0) <{bit = 16 : i32}> : (f32) -> i1]

    %5 = "llvm.intr.is.fpclass"(%arg0) <{bit = 32 : i32}> : (f32) -> i1]

    %6 = "llvm.intr.is.fpclass"(%arg0) <{bit = 64 : i32}> : (f32) -> i1]

    %7 = "llvm.intr.is.fpclass"(%arg0) <{bit = 128 : i32}> : (f32) -> i1]

    %8 = "llvm.intr.is.fpclass"(%arg0) <{bit = 256 : i32}> : (f32) -> i1]

    %9 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (f32) -> i1]

    %10 = llvm.xor %0, %1  : i1
    %11 = llvm.xor %10, %2  : i1
    %12 = llvm.xor %11, %3  : i1
    %13 = llvm.xor %12, %4  : i1
    %14 = llvm.xor %13, %5  : i1
    %15 = llvm.xor %14, %6  : i1
    %16 = llvm.xor %15, %7  : i1
    %17 = llvm.xor %16, %8  : i1
    %18 = llvm.xor %17, %9  : i1
    llvm.return %18 : i1
  }]

def test_fold_xor_class_f32_1_before := [llvmfunc|
  llvm.func @test_fold_xor_class_f32_1(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1]

    %2 = llvm.xor %0, %1  : i1
    llvm.return %2 : i1
  }]

def test_no_fold_xor_class_f32_multi_use0_before := [llvmfunc|
  llvm.func @test_no_fold_xor_class_f32_multi_use0(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

    llvm.store %0, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1]

    %2 = llvm.xor %0, %1  : i1
    llvm.return %2 : i1
  }]

def test_no_fold_xor_class_f32_multi_use1_before := [llvmfunc|
  llvm.func @test_no_fold_xor_class_f32_multi_use1(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1]

    llvm.store %1, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %2 = llvm.xor %0, %1  : i1
    llvm.return %2 : i1
  }]

def test_fold_xor_class_f32_2_before := [llvmfunc|
  llvm.func @test_fold_xor_class_f32_2(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1]

    %2 = llvm.xor %0, %1  : i1
    llvm.return %2 : i1
  }]

def test_no_fold_xor_class_f32_0_before := [llvmfunc|
  llvm.func @test_no_fold_xor_class_f32_0(%arg0: f32, %arg1: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

    %1 = "llvm.intr.is.fpclass"(%arg1) <{bit = 8 : i32}> : (f32) -> i1]

    %2 = llvm.xor %0, %1  : i1
    llvm.return %2 : i1
  }]

def test_fold_xor_class_v2f32_before := [llvmfunc|
  llvm.func @test_fold_xor_class_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 13 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    %2 = llvm.xor %0, %1  : vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }]

def test_class_fneg_none_before := [llvmfunc|
  llvm.func @test_class_fneg_none(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 0 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_all_before := [llvmfunc|
  llvm.func @test_class_fneg_all(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1023 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_snan_before := [llvmfunc|
  llvm.func @test_class_fneg_snan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_qnan_before := [llvmfunc|
  llvm.func @test_class_fneg_qnan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 2 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_neginf_before := [llvmfunc|
  llvm.func @test_class_fneg_neginf(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 4 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_negnormal_before := [llvmfunc|
  llvm.func @test_class_fneg_negnormal(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 8 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_negsubnormal_before := [llvmfunc|
  llvm.func @test_class_fneg_negsubnormal(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 16 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_negzero_before := [llvmfunc|
  llvm.func @test_class_fneg_negzero(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 32 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_poszero_before := [llvmfunc|
  llvm.func @test_class_fneg_poszero(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 64 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_possubnormal_before := [llvmfunc|
  llvm.func @test_class_fneg_possubnormal(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 128 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_posnormal_before := [llvmfunc|
  llvm.func @test_class_fneg_posnormal(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 256 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_posinf_before := [llvmfunc|
  llvm.func @test_class_fneg_posinf(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 512 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_isnan_before := [llvmfunc|
  llvm.func @test_class_fneg_isnan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 3 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_nnan_before := [llvmfunc|
  llvm.func @test_class_fneg_nnan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1020 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_normal_before := [llvmfunc|
  llvm.func @test_class_fneg_normal(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 264 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_zero_before := [llvmfunc|
  llvm.func @test_class_fneg_zero(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 96 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_subnormal_before := [llvmfunc|
  llvm.func @test_class_fneg_subnormal(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 144 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_normal_neginf_before := [llvmfunc|
  llvm.func @test_class_fneg_normal_neginf(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 268 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_normal_pinf_before := [llvmfunc|
  llvm.func @test_class_fneg_normal_pinf(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 776 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_neginf_posnormal_negsubnormal_poszero_before := [llvmfunc|
  llvm.func @test_class_fneg_neginf_posnormal_negsubnormal_poszero(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 340 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_neginf_posnormal_negsubnormal_poszero_snan_before := [llvmfunc|
  llvm.func @test_class_fneg_neginf_posnormal_negsubnormal_poszero_snan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 341 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_neginf_posnormal_negsubnormal_poszero_qnan_before := [llvmfunc|
  llvm.func @test_class_fneg_neginf_posnormal_negsubnormal_poszero_qnan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 342 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_neginf_posnormal_negsubnormal_poszero_nan_before := [llvmfunc|
  llvm.func @test_class_fneg_neginf_posnormal_negsubnormal_poszero_nan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 343 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_posinf_negnormal_possubnormal_negzero_before := [llvmfunc|
  llvm.func @test_class_fneg_posinf_negnormal_possubnormal_negzero(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 680 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_before := [llvmfunc|
  llvm.func @test_class_fneg_posinf_negnormal_possubnormal_negzero_snan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 681 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_posinf_negnormal_possubnormal_negzero_qnan_before := [llvmfunc|
  llvm.func @test_class_fneg_posinf_negnormal_possubnormal_negzero_qnan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 682 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_before := [llvmfunc|
  llvm.func @test_class_fneg_posinf_negnormal_possubnormal_negzero_nan(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 683 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_strictfp_before := [llvmfunc|
  llvm.func @test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.fneg %arg0  : f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 681 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_multiple_use_fneg_before := [llvmfunc|
  llvm.func @test_class_fneg_multiple_use_fneg(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    llvm.store %0, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr]

    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 682 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_vector_before := [llvmfunc|
  llvm.func @test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_vector(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 683 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %1 : vector<2xi1>
  }]

def test_class_fabs_none_before := [llvmfunc|
  llvm.func @test_class_fabs_none(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 0 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_all_before := [llvmfunc|
  llvm.func @test_class_fabs_all(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1023 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_snan_before := [llvmfunc|
  llvm.func @test_class_fabs_snan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_qnan_before := [llvmfunc|
  llvm.func @test_class_fabs_qnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 2 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_neginf_before := [llvmfunc|
  llvm.func @test_class_fabs_neginf(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 4 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_negnormal_before := [llvmfunc|
  llvm.func @test_class_fabs_negnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 8 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_negsubnormal_before := [llvmfunc|
  llvm.func @test_class_fabs_negsubnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 16 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_negzero_before := [llvmfunc|
  llvm.func @test_class_fabs_negzero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 32 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_poszero_before := [llvmfunc|
  llvm.func @test_class_fabs_poszero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 64 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_possubnormal_before := [llvmfunc|
  llvm.func @test_class_fabs_possubnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 128 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_posnormal_before := [llvmfunc|
  llvm.func @test_class_fabs_posnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 256 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_posinf_before := [llvmfunc|
  llvm.func @test_class_fabs_posinf(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 512 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_isnan_before := [llvmfunc|
  llvm.func @test_class_fabs_isnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 3 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_nnan_before := [llvmfunc|
  llvm.func @test_class_fabs_nnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 1020 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_normal_before := [llvmfunc|
  llvm.func @test_class_fabs_normal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 264 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_zero_before := [llvmfunc|
  llvm.func @test_class_fabs_zero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 96 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_subnormal_before := [llvmfunc|
  llvm.func @test_class_fabs_subnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 144 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_normal_neginf_before := [llvmfunc|
  llvm.func @test_class_fabs_normal_neginf(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 268 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_normal_pinf_before := [llvmfunc|
  llvm.func @test_class_fabs_normal_pinf(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 776 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_neginf_posnormal_negsubnormal_poszero_before := [llvmfunc|
  llvm.func @test_class_fabs_neginf_posnormal_negsubnormal_poszero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 340 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_neginf_posnormal_negsubnormal_poszero_snan_before := [llvmfunc|
  llvm.func @test_class_fabs_neginf_posnormal_negsubnormal_poszero_snan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 341 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_neginf_posnormal_negsubnormal_poszero_qnan_before := [llvmfunc|
  llvm.func @test_class_fabs_neginf_posnormal_negsubnormal_poszero_qnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 342 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_neginf_posnormal_negsubnormal_poszero_nan_before := [llvmfunc|
  llvm.func @test_class_fabs_neginf_posnormal_negsubnormal_poszero_nan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 343 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_posinf_negnormal_possubnormal_negzero_before := [llvmfunc|
  llvm.func @test_class_fabs_posinf_negnormal_possubnormal_negzero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 680 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_before := [llvmfunc|
  llvm.func @test_class_fabs_posinf_negnormal_possubnormal_negzero_snan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 681 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_posinf_negnormal_possubnormal_negzero_qnan_before := [llvmfunc|
  llvm.func @test_class_fabs_posinf_negnormal_possubnormal_negzero_qnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 682 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_before := [llvmfunc|
  llvm.func @test_class_fabs_posinf_negnormal_possubnormal_negzero_nan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 683 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_before := [llvmfunc|
  llvm.func @test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 681 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_multiple_use_fabs_before := [llvmfunc|
  llvm.func @test_class_fabs_multiple_use_fabs(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    llvm.store %0, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr]

    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 682 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_before := [llvmfunc|
  llvm.func @test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_vector(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 683 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %1 : vector<2xi1>
  }]

def test_class_fneg_fabs_none_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_none(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 0 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_all_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_all(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 1023 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_snan_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_snan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 1 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_qnan_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_qnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 2 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_neginf_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_neginf(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 4 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_negnormal_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_negnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 8 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_negsubnormal_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_negsubnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 16 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_negzero_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_negzero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 32 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_poszero_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_poszero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 64 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_possubnormal_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_possubnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 128 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_posnormal_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_posnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 256 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_posinf_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_posinf(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 512 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_isnan_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_isnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 3 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_nnan_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_nnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 1020 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_normal_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_normal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 264 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_zero_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_zero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 96 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_subnormal_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_subnormal(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 144 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_normal_neginf_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_normal_neginf(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 268 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_normal_pinf_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_normal_pinf(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 776 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 340 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_snan_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_snan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 341 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_qnan_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_qnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 342 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_nan_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_nan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 343 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 680 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 681 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_qnan_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_qnan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 682 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan(%arg0: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 683 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 681 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_multiple_use_fabs_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_multiple_use_fabs(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    llvm.store %1, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr]

    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 682 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_before := [llvmfunc|
  llvm.func @test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_vector(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %1 = llvm.fneg %0  : vector<2xf32>
    %2 = "llvm.intr.is.fpclass"(%0) <{bit = 683 : i32}> : (vector<2xf32>) -> vector<2xi1>]

    llvm.return %2 : vector<2xi1>
  }]

def test_class_is_zero_nozero_src_before := [llvmfunc|
  llvm.func @test_class_is_zero_nozero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_zero_noposzero_src_before := [llvmfunc|
  llvm.func @test_class_is_zero_noposzero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_zero_nonegzero_src_before := [llvmfunc|
  llvm.func @test_class_is_zero_nonegzero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_nozero_src_before := [llvmfunc|
  llvm.func @test_class_is_pzero_nozero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 64 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_nopzero_src_before := [llvmfunc|
  llvm.func @test_class_is_pzero_nopzero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 64 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_nonzero_src_before := [llvmfunc|
  llvm.func @test_class_is_pzero_nonzero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 64 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_nozero_src_before := [llvmfunc|
  llvm.func @test_class_is_nzero_nozero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 32 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_nopzero_src_before := [llvmfunc|
  llvm.func @test_class_is_nzero_nopzero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 32 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_nonzero_src_before := [llvmfunc|
  llvm.func @test_class_is_nzero_nonzero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 32 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_normal_or_zero_nozero_src_before := [llvmfunc|
  llvm.func @test_class_is_normal_or_zero_nozero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 360 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_inf_or_nan_nozero_src_before := [llvmfunc|
  llvm.func @test_class_is_inf_or_nan_nozero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 519 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_inf_or_nan_noinf_src_before := [llvmfunc|
  llvm.func @test_class_is_inf_or_nan_noinf_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 519 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_inf_or_nan_nonan_src_before := [llvmfunc|
  llvm.func @test_class_is_inf_or_nan_nonan_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 519 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_normal_or_subnormal_noinf_src_before := [llvmfunc|
  llvm.func @test_class_is_normal_or_subnormal_noinf_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 408 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_neginf_or_nopinf_src_before := [llvmfunc|
  llvm.func @test_class_is_neginf_or_nopinf_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_neginf_noninf_src_before := [llvmfunc|
  llvm.func @test_class_is_neginf_noninf_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_neginf_noinf_src_before := [llvmfunc|
  llvm.func @test_class_is_neginf_noinf_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_posinf_noninf_src_before := [llvmfunc|
  llvm.func @test_class_is_posinf_noninf_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_posinf_nopinf_src_before := [llvmfunc|
  llvm.func @test_class_is_posinf_nopinf_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_posinf_noinf_src_before := [llvmfunc|
  llvm.func @test_class_is_posinf_noinf_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_subnormal_nosub_src_before := [llvmfunc|
  llvm.func @test_class_is_subnormal_nosub_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 144 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_subnormal_nonsub_src_before := [llvmfunc|
  llvm.func @test_class_is_subnormal_nonsub_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 144 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_subnormal_nosub_src_before := [llvmfunc|
  llvm.func @test_class_is_not_subnormal_nosub_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 879 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_negsubnormal_nosub_src_before := [llvmfunc|
  llvm.func @test_class_is_not_negsubnormal_nosub_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1007 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_negsubnormal_nonegsub_src_before := [llvmfunc|
  llvm.func @test_class_is_not_negsubnormal_nonegsub_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1007 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nnormal_nonorm_src_before := [llvmfunc|
  llvm.func @test_class_is_nnormal_nonorm_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nnormal_nonorm_src_before := [llvmfunc|
  llvm.func @test_class_is_not_nnormal_nonorm_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 759 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nnormal_onlynorm_src_before := [llvmfunc|
  llvm.func @test_class_is_not_nnormal_onlynorm_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 759 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nnormal_onlynorm_src_before := [llvmfunc|
  llvm.func @test_class_is_nnormal_onlynorm_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_normal_assume_normal_before := [llvmfunc|
  llvm.func @test_class_is_normal_assume_normal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1]

    "llvm.intr.assume"(%0) : (i1) -> ()
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_is_normal_assume_not_normal_before := [llvmfunc|
  llvm.func @test_class_is_normal_assume_not_normal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1]

    "llvm.intr.assume"(%0) : (i1) -> ()
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 759 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  }]

def test_class_is_nan_assume_ord_before := [llvmfunc|
  llvm.func @test_class_is_nan_assume_ord(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ord" %arg0, %0 : f32
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_is_nan_assume_uno_before := [llvmfunc|
  llvm.func @test_class_is_nan_assume_uno(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "uno" %arg0, %0 : f32
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_is_nan_assume_not_eq_pinf_before := [llvmfunc|
  llvm.func @test_class_is_nan_assume_not_eq_pinf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test_class_is_pzero_psub_pnorm_pinf__ieee_before := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 960 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_psub_pnorm_pinf_snan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 961 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_psub_pnorm_pinf_qnan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 962 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_psub_pnorm_pinf_nan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 963 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_psub_pnorm_pinf__ieee_before := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 896 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_psub_pnorm_pinf_snan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 897 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_psub_pnorm_pinf_qnan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 898 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_psub_pnorm_pinf_nan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 899 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pnorm_pinf__ieee_before := [llvmfunc|
  llvm.func @test_class_is_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 768 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_pnorm_pinf__ieee_before := [llvmfunc|
  llvm.func @test_class_is_pzero_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 704 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_pnorm_pinf_nan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_pzero_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 707 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_pzero_psub_pnorm_pinf__ieee_before := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 992 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_pzero_psub_pnorm_pinf_snan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 993 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 994 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_pzero_psub_pnorm_pinf_nan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 995 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__ieee_before := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1017 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1009 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1010 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1011 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_psub_pnorm_pinf__ieee_before := [llvmfunc|
  llvm.func @test_class_is_nzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 928 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_nsub_pnorm_pinf__ieee_before := [llvmfunc|
  llvm.func @test_class_is_nzero_nsub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 816 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pzero_psub_pnorm_pinf__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 63 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pzero_psub_pnorm_pinf_snan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 62 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pzero_psub_pnorm_pinf_qnan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 61 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pzero_psub_pnorm_pinf_nan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 960 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_psub_pnorm_pinf__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 127 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_psub_pnorm_pinf_snan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 126 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_psub_pnorm_pinf_qnan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 125 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_psub_pnorm_pinf_nan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 124 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pnorm_pinf__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 255 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pzero_pnorm_pinf__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_pzero_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 319 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pzero_pnorm_pinf_nan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_pzero_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 316 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nzero_pzero_psub_pnorm_pinf__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 22 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 30 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 29 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 28 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 6 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 14 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 13 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 12 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nzero_psub_pnorm_pinf__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_nzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 95 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nzero_nsub_pnorm_pinf__ieee_before := [llvmfunc|
  llvm.func @test_class_is_not_nzero_nsub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 207 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_psub_pnorm_pinf__daz_before := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 960 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_psub_pnorm_pinf_snan__daz_before := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 961 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_psub_pnorm_pinf_qnan__daz_before := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 962 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_psub_pnorm_pinf_nan__daz_before := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 963 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_psub_pnorm_pinf__daz_before := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 896 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_psub_pnorm_pinf_snan__daz_before := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 897 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_psub_pnorm_pinf_qnan__daz_before := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 898 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_psub_pnorm_pinf_nan__daz_before := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 899 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pnorm_pinf__daz_before := [llvmfunc|
  llvm.func @test_class_is_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 768 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_pnorm_pinf__daz_before := [llvmfunc|
  llvm.func @test_class_is_pzero_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 704 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_pnorm_pinf_nan__daz_before := [llvmfunc|
  llvm.func @test_class_is_pzero_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 707 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_pzero_psub_pnorm_pinf__daz_before := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 992 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_pzero_psub_pnorm_pinf_snan__daz_before := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 993 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__daz_before := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 994 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_pzero_psub_pnorm_pinf_nan__daz_before := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 995 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__daz_before := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1017 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_before := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1009 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_before := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1010 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz_before := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1011 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_psub_pnorm_pinf__daz_before := [llvmfunc|
  llvm.func @test_class_is_nzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 928 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_nsub_pnorm_pinf__daz_before := [llvmfunc|
  llvm.func @test_class_is_nzero_nsub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 816 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pzero_psub_pnorm_pinf__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 63 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pzero_psub_pnorm_pinf_snan__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 62 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pzero_psub_pnorm_pinf_qnan__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 61 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pzero_psub_pnorm_pinf_nan__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 960 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_psub_pnorm_pinf__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 127 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_psub_pnorm_pinf_snan__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 126 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_psub_pnorm_pinf_qnan__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 125 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_psub_pnorm_pinf_nan__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 124 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pnorm_pinf__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 255 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pzero_pnorm_pinf__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_pzero_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 319 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pzero_pnorm_pinf_nan__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_pzero_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 316 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nzero_pzero_psub_pnorm_pinf__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 22 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 30 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 29 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 28 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 6 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 14 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 13 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 12 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nzero_psub_pnorm_pinf__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_nzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 95 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nzero_nsub_pnorm_pinf__daz_before := [llvmfunc|
  llvm.func @test_class_is_not_nzero_nsub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 207 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_psub_pnorm_pinf__dapz_before := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 960 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_psub_pnorm_pinf_snan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 961 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_psub_pnorm_pinf_qnan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 962 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_psub_pnorm_pinf_nan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 963 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_psub_pnorm_pinf__dapz_before := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 896 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_psub_pnorm_pinf_snan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 897 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_psub_pnorm_pinf_qnan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 898 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_psub_pnorm_pinf_nan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 899 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pnorm_pinf__dapz_before := [llvmfunc|
  llvm.func @test_class_is_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 768 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_pnorm_pinf__dapz_before := [llvmfunc|
  llvm.func @test_class_is_pzero_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 704 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_pzero_pnorm_pinf_nan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_pzero_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 707 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_pzero_psub_pnorm_pinf__dapz_before := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 992 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_pzero_psub_pnorm_pinf_snan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 993 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 994 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_pzero_psub_pnorm_pinf_nan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 995 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__dapz_before := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1017 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1009 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1010 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1011 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_psub_pnorm_pinf__dapz_before := [llvmfunc|
  llvm.func @test_class_is_nzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 928 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_nzero_nsub_pnorm_pinf__dapz_before := [llvmfunc|
  llvm.func @test_class_is_nzero_nsub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 816 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pzero_psub_pnorm_pinf__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 63 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pzero_psub_pnorm_pinf_snan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 62 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pzero_psub_pnorm_pinf_qnan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 61 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pzero_psub_pnorm_pinf_nan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 960 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_psub_pnorm_pinf__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 127 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_psub_pnorm_pinf_snan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 126 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_psub_pnorm_pinf_qnan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 125 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_psub_pnorm_pinf_nan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 124 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pnorm_pinf__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 255 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pzero_pnorm_pinf__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_pzero_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 319 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_pzero_pnorm_pinf_nan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_pzero_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 316 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nzero_pzero_psub_pnorm_pinf__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 22 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 30 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 29 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 28 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 6 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 14 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 13 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 12 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nzero_psub_pnorm_pinf__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_nzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 95 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_nzero_nsub_pnorm_pinf__dapz_before := [llvmfunc|
  llvm.func @test_class_is_not_nzero_nsub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 207 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_psub_pnorm_pinf__dynamic_before := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf__dynamic(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,dynamic"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 896 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_is_not_psub_pnorm_pinf__dynamic_before := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf__dynamic(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,dynamic"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 127 : i32}> : (f32) -> i1]

    llvm.return %0 : i1
  }]

def test_class_no_mask_f32_combined := [llvmfunc|
  llvm.func @test_class_no_mask_f32(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_no_mask_f32   : test_class_no_mask_f32_before  ⊑  test_class_no_mask_f32_combined := by
  unfold test_class_no_mask_f32_before test_class_no_mask_f32_combined
  simp_alive_peephole
  sorry
def test_class_full_mask_f32_combined := [llvmfunc|
  llvm.func @test_class_full_mask_f32(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_full_mask_f32   : test_class_full_mask_f32_before  ⊑  test_class_full_mask_f32_combined := by
  unfold test_class_full_mask_f32_before test_class_full_mask_f32_combined
  simp_alive_peephole
  sorry
def test_class_undef_no_mask_f32_combined := [llvmfunc|
  llvm.func @test_class_undef_no_mask_f32() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_undef_no_mask_f32   : test_class_undef_no_mask_f32_before  ⊑  test_class_undef_no_mask_f32_combined := by
  unfold test_class_undef_no_mask_f32_before test_class_undef_no_mask_f32_combined
  simp_alive_peephole
  sorry
def test_class_undef_full_mask_f32_combined := [llvmfunc|
  llvm.func @test_class_undef_full_mask_f32() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_undef_full_mask_f32   : test_class_undef_full_mask_f32_before  ⊑  test_class_undef_full_mask_f32_combined := by
  unfold test_class_undef_full_mask_f32_before test_class_undef_full_mask_f32_combined
  simp_alive_peephole
  sorry
def test_class_poison_no_mask_f32_combined := [llvmfunc|
  llvm.func @test_class_poison_no_mask_f32() -> i1 {
    %0 = llvm.mlir.poison : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_poison_no_mask_f32   : test_class_poison_no_mask_f32_before  ⊑  test_class_poison_no_mask_f32_combined := by
  unfold test_class_poison_no_mask_f32_before test_class_poison_no_mask_f32_combined
  simp_alive_peephole
  sorry
def test_class_poison_full_mask_f32_combined := [llvmfunc|
  llvm.func @test_class_poison_full_mask_f32() -> i1 {
    %0 = llvm.mlir.poison : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_poison_full_mask_f32   : test_class_poison_full_mask_f32_before  ⊑  test_class_poison_full_mask_f32_combined := by
  unfold test_class_poison_full_mask_f32_before test_class_poison_full_mask_f32_combined
  simp_alive_peephole
  sorry
def test_class_undef_val_f32_combined := [llvmfunc|
  llvm.func @test_class_undef_val_f32() -> i1 {
    %0 = llvm.mlir.undef : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_undef_val_f32   : test_class_undef_val_f32_before  ⊑  test_class_undef_val_f32_combined := by
  unfold test_class_undef_val_f32_before test_class_undef_val_f32_combined
  simp_alive_peephole
  sorry
def test_class_poison_val_f32_combined := [llvmfunc|
  llvm.func @test_class_poison_val_f32() -> i1 {
    %0 = llvm.mlir.poison : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_poison_val_f32   : test_class_poison_val_f32_before  ⊑  test_class_poison_val_f32_combined := by
  unfold test_class_poison_val_f32_before test_class_poison_val_f32_combined
  simp_alive_peephole
  sorry
def test_class_isnan_f32_combined := [llvmfunc|
  llvm.func @test_class_isnan_f32(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "uno" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_isnan_f32   : test_class_isnan_f32_before  ⊑  test_class_isnan_f32_combined := by
  unfold test_class_isnan_f32_before test_class_isnan_f32_combined
  simp_alive_peephole
  sorry
def test_class_isnan_v2f32_combined := [llvmfunc|
  llvm.func @test_class_isnan_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "uno" %arg0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_test_class_isnan_v2f32   : test_class_isnan_v2f32_before  ⊑  test_class_isnan_v2f32_combined := by
  unfold test_class_isnan_v2f32_before test_class_isnan_v2f32_combined
  simp_alive_peephole
  sorry
def test_class_isnan_f32_strict_combined := [llvmfunc|
  llvm.func @test_class_isnan_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_isnan_f32_strict   : test_class_isnan_f32_strict_before  ⊑  test_class_isnan_f32_strict_combined := by
  unfold test_class_isnan_f32_strict_before test_class_isnan_f32_strict_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_isnan_f32_strict   : test_class_isnan_f32_strict_before  ⊑  test_class_isnan_f32_strict_combined := by
  unfold test_class_isnan_f32_strict_before test_class_isnan_f32_strict_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_f32_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_f32(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_p0_n0_f32   : test_class_is_p0_n0_f32_before  ⊑  test_class_is_p0_n0_f32_combined := by
  unfold test_class_is_p0_n0_f32_before test_class_is_p0_n0_f32_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_v2f32_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "oeq" %arg0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_test_class_is_p0_n0_v2f32   : test_class_is_p0_n0_v2f32_before  ⊑  test_class_is_p0_n0_v2f32_combined := by
  unfold test_class_is_p0_n0_v2f32_before test_class_is_p0_n0_v2f32_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_v2f32_daz_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_v2f32_daz(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (vector<2xf32>) -> vector<2xi1>]

theorem inst_combine_test_class_is_p0_n0_v2f32_daz   : test_class_is_p0_n0_v2f32_daz_before  ⊑  test_class_is_p0_n0_v2f32_daz_combined := by
  unfold test_class_is_p0_n0_v2f32_daz_before test_class_is_p0_n0_v2f32_daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_test_class_is_p0_n0_v2f32_daz   : test_class_is_p0_n0_v2f32_daz_before  ⊑  test_class_is_p0_n0_v2f32_daz_combined := by
  unfold test_class_is_p0_n0_v2f32_daz_before test_class_is_p0_n0_v2f32_daz_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_v2f32_dynamic_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_v2f32_dynamic(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math-f32", "ieee,dynamic"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (vector<2xf32>) -> vector<2xi1>]

theorem inst_combine_test_class_is_p0_n0_v2f32_dynamic   : test_class_is_p0_n0_v2f32_dynamic_before  ⊑  test_class_is_p0_n0_v2f32_dynamic_combined := by
  unfold test_class_is_p0_n0_v2f32_dynamic_before test_class_is_p0_n0_v2f32_dynamic_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_test_class_is_p0_n0_v2f32_dynamic   : test_class_is_p0_n0_v2f32_dynamic_before  ⊑  test_class_is_p0_n0_v2f32_dynamic_combined := by
  unfold test_class_is_p0_n0_v2f32_dynamic_before test_class_is_p0_n0_v2f32_dynamic_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_or_nan_f32_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_nan_f32(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ueq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_p0_n0_or_nan_f32   : test_class_is_p0_n0_or_nan_f32_before  ⊑  test_class_is_p0_n0_or_nan_f32_combined := by
  unfold test_class_is_p0_n0_or_nan_f32_before test_class_is_p0_n0_or_nan_f32_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_or_nan_v2f32_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_nan_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "ueq" %arg0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_test_class_is_p0_n0_or_nan_v2f32   : test_class_is_p0_n0_or_nan_v2f32_before  ⊑  test_class_is_p0_n0_or_nan_v2f32_combined := by
  unfold test_class_is_p0_n0_or_nan_v2f32_before test_class_is_p0_n0_or_nan_v2f32_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_or_nan_f32_daz_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_nan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 99 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_p0_n0_or_nan_f32_daz   : test_class_is_p0_n0_or_nan_f32_daz_before  ⊑  test_class_is_p0_n0_or_nan_f32_daz_combined := by
  unfold test_class_is_p0_n0_or_nan_f32_daz_before test_class_is_p0_n0_or_nan_f32_daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_p0_n0_or_nan_f32_daz   : test_class_is_p0_n0_or_nan_f32_daz_before  ⊑  test_class_is_p0_n0_or_nan_f32_daz_combined := by
  unfold test_class_is_p0_n0_or_nan_f32_daz_before test_class_is_p0_n0_or_nan_f32_daz_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_or_nan_v2f32_daz_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_nan_v2f32_daz(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 99 : i32}> : (vector<2xf32>) -> vector<2xi1>]

theorem inst_combine_test_class_is_p0_n0_or_nan_v2f32_daz   : test_class_is_p0_n0_or_nan_v2f32_daz_before  ⊑  test_class_is_p0_n0_or_nan_v2f32_daz_combined := by
  unfold test_class_is_p0_n0_or_nan_v2f32_daz_before test_class_is_p0_n0_or_nan_v2f32_daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_test_class_is_p0_n0_or_nan_v2f32_daz   : test_class_is_p0_n0_or_nan_v2f32_daz_before  ⊑  test_class_is_p0_n0_or_nan_v2f32_daz_combined := by
  unfold test_class_is_p0_n0_or_nan_v2f32_daz_before test_class_is_p0_n0_or_nan_v2f32_daz_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_or_sub_or_nan_f32_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_sub_or_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 243 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_p0_n0_or_sub_or_nan_f32   : test_class_is_p0_n0_or_sub_or_nan_f32_before  ⊑  test_class_is_p0_n0_or_sub_or_nan_f32_combined := by
  unfold test_class_is_p0_n0_or_sub_or_nan_f32_before test_class_is_p0_n0_or_sub_or_nan_f32_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_p0_n0_or_sub_or_nan_f32   : test_class_is_p0_n0_or_sub_or_nan_f32_before  ⊑  test_class_is_p0_n0_or_sub_or_nan_f32_combined := by
  unfold test_class_is_p0_n0_or_sub_or_nan_f32_before test_class_is_p0_n0_or_sub_or_nan_f32_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_or_sub_or_nan_v2f32_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_sub_or_nan_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 243 : i32}> : (vector<2xf32>) -> vector<2xi1>]

theorem inst_combine_test_class_is_p0_n0_or_sub_or_nan_v2f32   : test_class_is_p0_n0_or_sub_or_nan_v2f32_before  ⊑  test_class_is_p0_n0_or_sub_or_nan_v2f32_combined := by
  unfold test_class_is_p0_n0_or_sub_or_nan_v2f32_before test_class_is_p0_n0_or_sub_or_nan_v2f32_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_test_class_is_p0_n0_or_sub_or_nan_v2f32   : test_class_is_p0_n0_or_sub_or_nan_v2f32_before  ⊑  test_class_is_p0_n0_or_sub_or_nan_v2f32_combined := by
  unfold test_class_is_p0_n0_or_sub_or_nan_v2f32_before test_class_is_p0_n0_or_sub_or_nan_v2f32_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_or_sub_or_nan_f32_daz_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_sub_or_nan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ueq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_p0_n0_or_sub_or_nan_f32_daz   : test_class_is_p0_n0_or_sub_or_nan_f32_daz_before  ⊑  test_class_is_p0_n0_or_sub_or_nan_f32_daz_combined := by
  unfold test_class_is_p0_n0_or_sub_or_nan_f32_daz_before test_class_is_p0_n0_or_sub_or_nan_f32_daz_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_or_sub_or_nan_v2f32_daz_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_sub_or_nan_v2f32_daz(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "ueq" %arg0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_test_class_is_p0_n0_or_sub_or_nan_v2f32_daz   : test_class_is_p0_n0_or_sub_or_nan_v2f32_daz_before  ⊑  test_class_is_p0_n0_or_sub_or_nan_v2f32_daz_combined := by
  unfold test_class_is_p0_n0_or_sub_or_nan_v2f32_daz_before test_class_is_p0_n0_or_sub_or_nan_v2f32_daz_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_or_sub_or_snan_f32_daz_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_sub_or_snan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 241 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_p0_n0_or_sub_or_snan_f32_daz   : test_class_is_p0_n0_or_sub_or_snan_f32_daz_before  ⊑  test_class_is_p0_n0_or_sub_or_snan_f32_daz_combined := by
  unfold test_class_is_p0_n0_or_sub_or_snan_f32_daz_before test_class_is_p0_n0_or_sub_or_snan_f32_daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_p0_n0_or_sub_or_snan_f32_daz   : test_class_is_p0_n0_or_sub_or_snan_f32_daz_before  ⊑  test_class_is_p0_n0_or_sub_or_snan_f32_daz_combined := by
  unfold test_class_is_p0_n0_or_sub_or_snan_f32_daz_before test_class_is_p0_n0_or_sub_or_snan_f32_daz_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_or_sub_or_qnan_f32_daz_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_or_sub_or_qnan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 242 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_p0_n0_or_sub_or_qnan_f32_daz   : test_class_is_p0_n0_or_sub_or_qnan_f32_daz_before  ⊑  test_class_is_p0_n0_or_sub_or_qnan_f32_daz_combined := by
  unfold test_class_is_p0_n0_or_sub_or_qnan_f32_daz_before test_class_is_p0_n0_or_sub_or_qnan_f32_daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_p0_n0_or_sub_or_qnan_f32_daz   : test_class_is_p0_n0_or_sub_or_qnan_f32_daz_before  ⊑  test_class_is_p0_n0_or_sub_or_qnan_f32_daz_combined := by
  unfold test_class_is_p0_n0_or_sub_or_qnan_f32_daz_before test_class_is_p0_n0_or_sub_or_qnan_f32_daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_p0_n0_or_nan_f32_combined := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_or_nan_f32(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "one" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_not_p0_n0_or_nan_f32   : test_class_is_not_p0_n0_or_nan_f32_before  ⊑  test_class_is_not_p0_n0_or_nan_f32_combined := by
  unfold test_class_is_not_p0_n0_or_nan_f32_before test_class_is_not_p0_n0_or_nan_f32_combined
  simp_alive_peephole
  sorry
def test_class_is_not_p0_n0_or_qnan_f32_combined := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_or_qnan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 926 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_p0_n0_or_qnan_f32   : test_class_is_not_p0_n0_or_qnan_f32_before  ⊑  test_class_is_not_p0_n0_or_qnan_f32_combined := by
  unfold test_class_is_not_p0_n0_or_qnan_f32_before test_class_is_not_p0_n0_or_qnan_f32_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_p0_n0_or_qnan_f32   : test_class_is_not_p0_n0_or_qnan_f32_before  ⊑  test_class_is_not_p0_n0_or_qnan_f32_combined := by
  unfold test_class_is_not_p0_n0_or_qnan_f32_before test_class_is_not_p0_n0_or_qnan_f32_combined
  simp_alive_peephole
  sorry
def test_class_is_not_p0_n0_or_snan_f32_combined := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_or_snan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 925 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_p0_n0_or_snan_f32   : test_class_is_not_p0_n0_or_snan_f32_before  ⊑  test_class_is_not_p0_n0_or_snan_f32_combined := by
  unfold test_class_is_not_p0_n0_or_snan_f32_before test_class_is_not_p0_n0_or_snan_f32_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_p0_n0_or_snan_f32   : test_class_is_not_p0_n0_or_snan_f32_before  ⊑  test_class_is_not_p0_n0_or_snan_f32_combined := by
  unfold test_class_is_not_p0_n0_or_snan_f32_before test_class_is_not_p0_n0_or_snan_f32_combined
  simp_alive_peephole
  sorry
def test_class_is_not_p0_n0_or_nan_f32_daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_or_nan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 924 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_p0_n0_or_nan_f32_daz   : test_class_is_not_p0_n0_or_nan_f32_daz_before  ⊑  test_class_is_not_p0_n0_or_nan_f32_daz_combined := by
  unfold test_class_is_not_p0_n0_or_nan_f32_daz_before test_class_is_not_p0_n0_or_nan_f32_daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_p0_n0_or_nan_f32_daz   : test_class_is_not_p0_n0_or_nan_f32_daz_before  ⊑  test_class_is_not_p0_n0_or_nan_f32_daz_combined := by
  unfold test_class_is_not_p0_n0_or_nan_f32_daz_before test_class_is_not_p0_n0_or_nan_f32_daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_p0_n0_or_sub_or_nan_f32_combined := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_or_sub_or_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_p0_n0_or_sub_or_nan_f32   : test_class_is_not_p0_n0_or_sub_or_nan_f32_before  ⊑  test_class_is_not_p0_n0_or_sub_or_nan_f32_combined := by
  unfold test_class_is_not_p0_n0_or_sub_or_nan_f32_before test_class_is_not_p0_n0_or_sub_or_nan_f32_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_p0_n0_or_sub_or_nan_f32   : test_class_is_not_p0_n0_or_sub_or_nan_f32_before  ⊑  test_class_is_not_p0_n0_or_sub_or_nan_f32_combined := by
  unfold test_class_is_not_p0_n0_or_sub_or_nan_f32_before test_class_is_not_p0_n0_or_sub_or_nan_f32_combined
  simp_alive_peephole
  sorry
def test_class_is_not_p0_n0_or_sub_or_nan_f32_daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_or_sub_or_nan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_not_p0_n0_or_sub_or_nan_f32_daz   : test_class_is_not_p0_n0_or_sub_or_nan_f32_daz_before  ⊑  test_class_is_not_p0_n0_or_sub_or_nan_f32_daz_combined := by
  unfold test_class_is_not_p0_n0_or_sub_or_nan_f32_daz_before test_class_is_not_p0_n0_or_sub_or_nan_f32_daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_p0_n0_or_sub_and_not_nan_f32_combined := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_or_sub_and_not_nan_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 780 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_p0_n0_or_sub_and_not_nan_f32   : test_class_is_not_p0_n0_or_sub_and_not_nan_f32_before  ⊑  test_class_is_not_p0_n0_or_sub_and_not_nan_f32_combined := by
  unfold test_class_is_not_p0_n0_or_sub_and_not_nan_f32_before test_class_is_not_p0_n0_or_sub_and_not_nan_f32_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_p0_n0_or_sub_and_not_nan_f32   : test_class_is_not_p0_n0_or_sub_and_not_nan_f32_before  ⊑  test_class_is_not_p0_n0_or_sub_and_not_nan_f32_combined := by
  unfold test_class_is_not_p0_n0_or_sub_and_not_nan_f32_before test_class_is_not_p0_n0_or_sub_and_not_nan_f32_combined
  simp_alive_peephole
  sorry
def test_class_is_not_p0_n0_or_sub_and_not_nan_f32_daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_or_sub_and_not_nan_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "one" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_not_p0_n0_or_sub_and_not_nan_f32_daz   : test_class_is_not_p0_n0_or_sub_and_not_nan_f32_daz_before  ⊑  test_class_is_not_p0_n0_or_sub_and_not_nan_f32_daz_combined := by
  unfold test_class_is_not_p0_n0_or_sub_and_not_nan_f32_daz_before test_class_is_not_p0_n0_or_sub_and_not_nan_f32_daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_p0_n0_f32_combined := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_f32(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_not_p0_n0_f32   : test_class_is_not_p0_n0_f32_before  ⊑  test_class_is_not_p0_n0_f32_combined := by
  unfold test_class_is_not_p0_n0_f32_before test_class_is_not_p0_n0_f32_combined
  simp_alive_peephole
  sorry
def test_class_is_not_p0_n0_v2f32_combined := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "une" %arg0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_test_class_is_not_p0_n0_v2f32   : test_class_is_not_p0_n0_v2f32_before  ⊑  test_class_is_not_p0_n0_v2f32_combined := by
  unfold test_class_is_not_p0_n0_v2f32_before test_class_is_not_p0_n0_v2f32_combined
  simp_alive_peephole
  sorry
def test_class_is_not_p0_n0_f32_strict_combined := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 927 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_p0_n0_f32_strict   : test_class_is_not_p0_n0_f32_strict_before  ⊑  test_class_is_not_p0_n0_f32_strict_combined := by
  unfold test_class_is_not_p0_n0_f32_strict_before test_class_is_not_p0_n0_f32_strict_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_p0_n0_f32_strict   : test_class_is_not_p0_n0_f32_strict_before  ⊑  test_class_is_not_p0_n0_f32_strict_combined := by
  unfold test_class_is_not_p0_n0_f32_strict_before test_class_is_not_p0_n0_f32_strict_combined
  simp_alive_peephole
  sorry
def test_class_is_not_p0_n0_f32_daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 927 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_p0_n0_f32_daz   : test_class_is_not_p0_n0_f32_daz_before  ⊑  test_class_is_not_p0_n0_f32_daz_combined := by
  unfold test_class_is_not_p0_n0_f32_daz_before test_class_is_not_p0_n0_f32_daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_p0_n0_f32_daz   : test_class_is_not_p0_n0_f32_daz_before  ⊑  test_class_is_not_p0_n0_f32_daz_combined := by
  unfold test_class_is_not_p0_n0_f32_daz_before test_class_is_not_p0_n0_f32_daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_p0_n0_f32_dynamic_combined := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_f32_dynamic(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 927 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_p0_n0_f32_dynamic   : test_class_is_not_p0_n0_f32_dynamic_before  ⊑  test_class_is_not_p0_n0_f32_dynamic_combined := by
  unfold test_class_is_not_p0_n0_f32_dynamic_before test_class_is_not_p0_n0_f32_dynamic_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_p0_n0_f32_dynamic   : test_class_is_not_p0_n0_f32_dynamic_before  ⊑  test_class_is_not_p0_n0_f32_dynamic_combined := by
  unfold test_class_is_not_p0_n0_f32_dynamic_before test_class_is_not_p0_n0_f32_dynamic_combined
  simp_alive_peephole
  sorry
def test_class_is_not_p0_n0_psub_nsub_f32_daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_psub_nsub_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_not_p0_n0_psub_nsub_f32_daz   : test_class_is_not_p0_n0_psub_nsub_f32_daz_before  ⊑  test_class_is_not_p0_n0_psub_nsub_f32_daz_combined := by
  unfold test_class_is_not_p0_n0_psub_nsub_f32_daz_before test_class_is_not_p0_n0_psub_nsub_f32_daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_p0_n0_psub_nsub_f32_dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_psub_nsub_f32_dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,positive-zero"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_not_p0_n0_psub_nsub_f32_dapz   : test_class_is_not_p0_n0_psub_nsub_f32_dapz_before  ⊑  test_class_is_not_p0_n0_psub_nsub_f32_dapz_combined := by
  unfold test_class_is_not_p0_n0_psub_nsub_f32_dapz_before test_class_is_not_p0_n0_psub_nsub_f32_dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_p0_n0_psub_nsub_f32_dynamic_combined := [llvmfunc|
  llvm.func @test_class_is_not_p0_n0_psub_nsub_f32_dynamic(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,dynamiz"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_p0_n0_psub_nsub_f32_dynamic   : test_class_is_not_p0_n0_psub_nsub_f32_dynamic_before  ⊑  test_class_is_not_p0_n0_psub_nsub_f32_dynamic_combined := by
  unfold test_class_is_not_p0_n0_psub_nsub_f32_dynamic_before test_class_is_not_p0_n0_psub_nsub_f32_dynamic_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_p0_n0_psub_nsub_f32_dynamic   : test_class_is_not_p0_n0_psub_nsub_f32_dynamic_before  ⊑  test_class_is_not_p0_n0_psub_nsub_f32_dynamic_combined := by
  unfold test_class_is_not_p0_n0_psub_nsub_f32_dynamic_before test_class_is_not_p0_n0_psub_nsub_f32_dynamic_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_f32_strict_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_p0_n0_f32_strict   : test_class_is_p0_n0_f32_strict_before  ⊑  test_class_is_p0_n0_f32_strict_combined := by
  unfold test_class_is_p0_n0_f32_strict_before test_class_is_p0_n0_f32_strict_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_p0_n0_f32_strict   : test_class_is_p0_n0_f32_strict_before  ⊑  test_class_is_p0_n0_f32_strict_combined := by
  unfold test_class_is_p0_n0_f32_strict_before test_class_is_p0_n0_f32_strict_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_f32_daz_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_p0_n0_f32_daz   : test_class_is_p0_n0_f32_daz_before  ⊑  test_class_is_p0_n0_f32_daz_combined := by
  unfold test_class_is_p0_n0_f32_daz_before test_class_is_p0_n0_f32_daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_p0_n0_f32_daz   : test_class_is_p0_n0_f32_daz_before  ⊑  test_class_is_p0_n0_f32_daz_combined := by
  unfold test_class_is_p0_n0_f32_daz_before test_class_is_p0_n0_f32_daz_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_f32_dapz_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_f32_dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 96 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_p0_n0_f32_dapz   : test_class_is_p0_n0_f32_dapz_before  ⊑  test_class_is_p0_n0_f32_dapz_combined := by
  unfold test_class_is_p0_n0_f32_dapz_before test_class_is_p0_n0_f32_dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_p0_n0_f32_dapz   : test_class_is_p0_n0_f32_dapz_before  ⊑  test_class_is_p0_n0_f32_dapz_combined := by
  unfold test_class_is_p0_n0_f32_dapz_before test_class_is_p0_n0_f32_dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_psub_nsub_f32_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_psub_nsub_f32(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_p0_n0_psub_nsub_f32   : test_class_is_p0_n0_psub_nsub_f32_before  ⊑  test_class_is_p0_n0_psub_nsub_f32_combined := by
  unfold test_class_is_p0_n0_psub_nsub_f32_before test_class_is_p0_n0_psub_nsub_f32_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_p0_n0_psub_nsub_f32   : test_class_is_p0_n0_psub_nsub_f32_before  ⊑  test_class_is_p0_n0_psub_nsub_f32_combined := by
  unfold test_class_is_p0_n0_psub_nsub_f32_before test_class_is_p0_n0_psub_nsub_f32_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_psub_nsub_f32_daz_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_psub_nsub_f32_daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_p0_n0_psub_nsub_f32_daz   : test_class_is_p0_n0_psub_nsub_f32_daz_before  ⊑  test_class_is_p0_n0_psub_nsub_f32_daz_combined := by
  unfold test_class_is_p0_n0_psub_nsub_f32_daz_before test_class_is_p0_n0_psub_nsub_f32_daz_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_psub_nsub_f32_dapz_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_psub_nsub_f32_dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,positive-zero"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_p0_n0_psub_nsub_f32_dapz   : test_class_is_p0_n0_psub_nsub_f32_dapz_before  ⊑  test_class_is_p0_n0_psub_nsub_f32_dapz_combined := by
  unfold test_class_is_p0_n0_psub_nsub_f32_dapz_before test_class_is_p0_n0_psub_nsub_f32_dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_psub_nsub_f32_dynamic_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_psub_nsub_f32_dynamic(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_p0_n0_psub_nsub_f32_dynamic   : test_class_is_p0_n0_psub_nsub_f32_dynamic_before  ⊑  test_class_is_p0_n0_psub_nsub_f32_dynamic_combined := by
  unfold test_class_is_p0_n0_psub_nsub_f32_dynamic_before test_class_is_p0_n0_psub_nsub_f32_dynamic_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_p0_n0_psub_nsub_f32_dynamic   : test_class_is_p0_n0_psub_nsub_f32_dynamic_before  ⊑  test_class_is_p0_n0_psub_nsub_f32_dynamic_combined := by
  unfold test_class_is_p0_n0_psub_nsub_f32_dynamic_before test_class_is_p0_n0_psub_nsub_f32_dynamic_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_psub_nsub_v2f32_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_psub_nsub_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (vector<2xf32>) -> vector<2xi1>]

theorem inst_combine_test_class_is_p0_n0_psub_nsub_v2f32   : test_class_is_p0_n0_psub_nsub_v2f32_before  ⊑  test_class_is_p0_n0_psub_nsub_v2f32_combined := by
  unfold test_class_is_p0_n0_psub_nsub_v2f32_before test_class_is_p0_n0_psub_nsub_v2f32_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_test_class_is_p0_n0_psub_nsub_v2f32   : test_class_is_p0_n0_psub_nsub_v2f32_before  ⊑  test_class_is_p0_n0_psub_nsub_v2f32_combined := by
  unfold test_class_is_p0_n0_psub_nsub_v2f32_before test_class_is_p0_n0_psub_nsub_v2f32_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_psub_nsub_v2f32_daz_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_psub_nsub_v2f32_daz(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "oeq" %arg0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_test_class_is_p0_n0_psub_nsub_v2f32_daz   : test_class_is_p0_n0_psub_nsub_v2f32_daz_before  ⊑  test_class_is_p0_n0_psub_nsub_v2f32_daz_combined := by
  unfold test_class_is_p0_n0_psub_nsub_v2f32_daz_before test_class_is_p0_n0_psub_nsub_v2f32_daz_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_psub_nsub_v2f32_dapz_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_psub_nsub_v2f32_dapz(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math", "ieee,positive-zero"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "oeq" %arg0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_test_class_is_p0_n0_psub_nsub_v2f32_dapz   : test_class_is_p0_n0_psub_nsub_v2f32_dapz_before  ⊑  test_class_is_p0_n0_psub_nsub_v2f32_dapz_combined := by
  unfold test_class_is_p0_n0_psub_nsub_v2f32_dapz_before test_class_is_p0_n0_psub_nsub_v2f32_dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_p0_n0_psub_nsub_v2f32_dynamic_combined := [llvmfunc|
  llvm.func @test_class_is_p0_n0_psub_nsub_v2f32_dynamic(%arg0: vector<2xf32>) -> vector<2xi1> attributes {passthrough = [["denormal-fp-math", "ieee,dynamic"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 240 : i32}> : (vector<2xf32>) -> vector<2xi1>]

theorem inst_combine_test_class_is_p0_n0_psub_nsub_v2f32_dynamic   : test_class_is_p0_n0_psub_nsub_v2f32_dynamic_before  ⊑  test_class_is_p0_n0_psub_nsub_v2f32_dynamic_combined := by
  unfold test_class_is_p0_n0_psub_nsub_v2f32_dynamic_before test_class_is_p0_n0_psub_nsub_v2f32_dynamic_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_test_class_is_p0_n0_psub_nsub_v2f32_dynamic   : test_class_is_p0_n0_psub_nsub_v2f32_dynamic_before  ⊑  test_class_is_p0_n0_psub_nsub_v2f32_dynamic_combined := by
  unfold test_class_is_p0_n0_psub_nsub_v2f32_dynamic_before test_class_is_p0_n0_psub_nsub_v2f32_dynamic_combined
  simp_alive_peephole
  sorry
def test_class_is_pinf_f32_combined := [llvmfunc|
  llvm.func @test_class_is_pinf_f32(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_pinf_f32   : test_class_is_pinf_f32_before  ⊑  test_class_is_pinf_f32_combined := by
  unfold test_class_is_pinf_f32_before test_class_is_pinf_f32_combined
  simp_alive_peephole
  sorry
def test_class_is_pinf_or_nan_f32_combined := [llvmfunc|
  llvm.func @test_class_is_pinf_or_nan_f32(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.fcmp "ueq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_pinf_or_nan_f32   : test_class_is_pinf_or_nan_f32_before  ⊑  test_class_is_pinf_or_nan_f32_combined := by
  unfold test_class_is_pinf_or_nan_f32_before test_class_is_pinf_or_nan_f32_combined
  simp_alive_peephole
  sorry
def test_class_is_pinf_v2f32_combined := [llvmfunc|
  llvm.func @test_class_is_pinf_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<0x7F800000> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fcmp "oeq" %arg0, %0 : vector<2xf32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test_class_is_pinf_v2f32   : test_class_is_pinf_v2f32_before  ⊑  test_class_is_pinf_v2f32_combined := by
  unfold test_class_is_pinf_v2f32_before test_class_is_pinf_v2f32_combined
  simp_alive_peephole
  sorry
def test_class_is_ninf_f32_combined := [llvmfunc|
  llvm.func @test_class_is_ninf_f32(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_ninf_f32   : test_class_is_ninf_f32_before  ⊑  test_class_is_ninf_f32_combined := by
  unfold test_class_is_ninf_f32_before test_class_is_ninf_f32_combined
  simp_alive_peephole
  sorry
def test_class_is_ninf_or_nan_f32_combined := [llvmfunc|
  llvm.func @test_class_is_ninf_or_nan_f32(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.fcmp "ueq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_ninf_or_nan_f32   : test_class_is_ninf_or_nan_f32_before  ⊑  test_class_is_ninf_or_nan_f32_combined := by
  unfold test_class_is_ninf_or_nan_f32_before test_class_is_ninf_or_nan_f32_combined
  simp_alive_peephole
  sorry
def test_class_is_ninf_v2f32_combined := [llvmfunc|
  llvm.func @test_class_is_ninf_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<0xFF800000> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fcmp "oeq" %arg0, %0 : vector<2xf32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test_class_is_ninf_v2f32   : test_class_is_ninf_v2f32_before  ⊑  test_class_is_ninf_v2f32_combined := by
  unfold test_class_is_ninf_v2f32_before test_class_is_ninf_v2f32_combined
  simp_alive_peephole
  sorry
def test_class_is_inf_f32_combined := [llvmfunc|
  llvm.func @test_class_is_inf_f32(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_class_is_inf_f32   : test_class_is_inf_f32_before  ⊑  test_class_is_inf_f32_combined := by
  unfold test_class_is_inf_f32_before test_class_is_inf_f32_combined
  simp_alive_peephole
  sorry
def test_class_is_inf_v2f32_combined := [llvmfunc|
  llvm.func @test_class_is_inf_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<0x7F800000> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %2 = llvm.fcmp "oeq" %1, %0 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_test_class_is_inf_v2f32   : test_class_is_inf_v2f32_before  ⊑  test_class_is_inf_v2f32_combined := by
  unfold test_class_is_inf_v2f32_before test_class_is_inf_v2f32_combined
  simp_alive_peephole
  sorry
def test_class_is_inf_or_nan_f32_combined := [llvmfunc|
  llvm.func @test_class_is_inf_or_nan_f32(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_class_is_inf_or_nan_f32   : test_class_is_inf_or_nan_f32_before  ⊑  test_class_is_inf_or_nan_f32_combined := by
  unfold test_class_is_inf_or_nan_f32_before test_class_is_inf_or_nan_f32_combined
  simp_alive_peephole
  sorry
def test_class_is_pinf_f32_strict_combined := [llvmfunc|
  llvm.func @test_class_is_pinf_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 512 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pinf_f32_strict   : test_class_is_pinf_f32_strict_before  ⊑  test_class_is_pinf_f32_strict_combined := by
  unfold test_class_is_pinf_f32_strict_before test_class_is_pinf_f32_strict_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pinf_f32_strict   : test_class_is_pinf_f32_strict_before  ⊑  test_class_is_pinf_f32_strict_combined := by
  unfold test_class_is_pinf_f32_strict_before test_class_is_pinf_f32_strict_combined
  simp_alive_peephole
  sorry
def test_class_is_ninf_f32_strict_combined := [llvmfunc|
  llvm.func @test_class_is_ninf_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 4 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_ninf_f32_strict   : test_class_is_ninf_f32_strict_before  ⊑  test_class_is_ninf_f32_strict_combined := by
  unfold test_class_is_ninf_f32_strict_before test_class_is_ninf_f32_strict_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_ninf_f32_strict   : test_class_is_ninf_f32_strict_before  ⊑  test_class_is_ninf_f32_strict_combined := by
  unfold test_class_is_ninf_f32_strict_before test_class_is_ninf_f32_strict_combined
  simp_alive_peephole
  sorry
def test_class_is_inf_f32_strict_combined := [llvmfunc|
  llvm.func @test_class_is_inf_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 516 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_inf_f32_strict   : test_class_is_inf_f32_strict_before  ⊑  test_class_is_inf_f32_strict_combined := by
  unfold test_class_is_inf_f32_strict_before test_class_is_inf_f32_strict_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_inf_f32_strict   : test_class_is_inf_f32_strict_before  ⊑  test_class_is_inf_f32_strict_combined := by
  unfold test_class_is_inf_f32_strict_before test_class_is_inf_f32_strict_combined
  simp_alive_peephole
  sorry
def test_class_is_pinf_or_nan_f32_strict_combined := [llvmfunc|
  llvm.func @test_class_is_pinf_or_nan_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 515 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pinf_or_nan_f32_strict   : test_class_is_pinf_or_nan_f32_strict_before  ⊑  test_class_is_pinf_or_nan_f32_strict_combined := by
  unfold test_class_is_pinf_or_nan_f32_strict_before test_class_is_pinf_or_nan_f32_strict_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pinf_or_nan_f32_strict   : test_class_is_pinf_or_nan_f32_strict_before  ⊑  test_class_is_pinf_or_nan_f32_strict_combined := by
  unfold test_class_is_pinf_or_nan_f32_strict_before test_class_is_pinf_or_nan_f32_strict_combined
  simp_alive_peephole
  sorry
def test_class_is_ninf_or_nan_f32_strict_combined := [llvmfunc|
  llvm.func @test_class_is_ninf_or_nan_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 7 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_ninf_or_nan_f32_strict   : test_class_is_ninf_or_nan_f32_strict_before  ⊑  test_class_is_ninf_or_nan_f32_strict_combined := by
  unfold test_class_is_ninf_or_nan_f32_strict_before test_class_is_ninf_or_nan_f32_strict_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_ninf_or_nan_f32_strict   : test_class_is_ninf_or_nan_f32_strict_before  ⊑  test_class_is_ninf_or_nan_f32_strict_combined := by
  unfold test_class_is_ninf_or_nan_f32_strict_before test_class_is_ninf_or_nan_f32_strict_combined
  simp_alive_peephole
  sorry
def test_class_is_inf_or_nan_f32_strict_combined := [llvmfunc|
  llvm.func @test_class_is_inf_or_nan_f32_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 519 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_inf_or_nan_f32_strict   : test_class_is_inf_or_nan_f32_strict_before  ⊑  test_class_is_inf_or_nan_f32_strict_combined := by
  unfold test_class_is_inf_or_nan_f32_strict_before test_class_is_inf_or_nan_f32_strict_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_inf_or_nan_f32_strict   : test_class_is_inf_or_nan_f32_strict_before  ⊑  test_class_is_inf_or_nan_f32_strict_combined := by
  unfold test_class_is_inf_or_nan_f32_strict_before test_class_is_inf_or_nan_f32_strict_combined
  simp_alive_peephole
  sorry
def test_constant_class_snan_test_snan_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_snan_test_snan_f64() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_snan_test_snan_f64   : test_constant_class_snan_test_snan_f64_before  ⊑  test_constant_class_snan_test_snan_f64_combined := by
  unfold test_constant_class_snan_test_snan_f64_before test_constant_class_snan_test_snan_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_qnan_test_qnan_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_qnan_test_qnan_f64() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_qnan_test_qnan_f64   : test_constant_class_qnan_test_qnan_f64_before  ⊑  test_constant_class_qnan_test_qnan_f64_combined := by
  unfold test_constant_class_qnan_test_qnan_f64_before test_constant_class_qnan_test_qnan_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_qnan_test_snan_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_qnan_test_snan_f64() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_qnan_test_snan_f64   : test_constant_class_qnan_test_snan_f64_before  ⊑  test_constant_class_qnan_test_snan_f64_combined := by
  unfold test_constant_class_qnan_test_snan_f64_before test_constant_class_qnan_test_snan_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_ninf_test_ninf_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_ninf_test_ninf_f64() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_ninf_test_ninf_f64   : test_constant_class_ninf_test_ninf_f64_before  ⊑  test_constant_class_ninf_test_ninf_f64_combined := by
  unfold test_constant_class_ninf_test_ninf_f64_before test_constant_class_ninf_test_ninf_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_pinf_test_ninf_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_pinf_test_ninf_f64() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_pinf_test_ninf_f64   : test_constant_class_pinf_test_ninf_f64_before  ⊑  test_constant_class_pinf_test_ninf_f64_combined := by
  unfold test_constant_class_pinf_test_ninf_f64_before test_constant_class_pinf_test_ninf_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_qnan_test_ninf_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_qnan_test_ninf_f64() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_qnan_test_ninf_f64   : test_constant_class_qnan_test_ninf_f64_before  ⊑  test_constant_class_qnan_test_ninf_f64_combined := by
  unfold test_constant_class_qnan_test_ninf_f64_before test_constant_class_qnan_test_ninf_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_snan_test_ninf_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_snan_test_ninf_f64() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_snan_test_ninf_f64   : test_constant_class_snan_test_ninf_f64_before  ⊑  test_constant_class_snan_test_ninf_f64_combined := by
  unfold test_constant_class_snan_test_ninf_f64_before test_constant_class_snan_test_ninf_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_nnormal_test_nnormal_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_nnormal_test_nnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_nnormal_test_nnormal_f64   : test_constant_class_nnormal_test_nnormal_f64_before  ⊑  test_constant_class_nnormal_test_nnormal_f64_combined := by
  unfold test_constant_class_nnormal_test_nnormal_f64_before test_constant_class_nnormal_test_nnormal_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_pnormal_test_nnormal_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_pnormal_test_nnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_pnormal_test_nnormal_f64   : test_constant_class_pnormal_test_nnormal_f64_before  ⊑  test_constant_class_pnormal_test_nnormal_f64_combined := by
  unfold test_constant_class_pnormal_test_nnormal_f64_before test_constant_class_pnormal_test_nnormal_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_nsubnormal_test_nsubnormal_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_nsubnormal_test_nsubnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_nsubnormal_test_nsubnormal_f64   : test_constant_class_nsubnormal_test_nsubnormal_f64_before  ⊑  test_constant_class_nsubnormal_test_nsubnormal_f64_combined := by
  unfold test_constant_class_nsubnormal_test_nsubnormal_f64_before test_constant_class_nsubnormal_test_nsubnormal_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_psubnormal_test_nsubnormal_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_psubnormal_test_nsubnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_psubnormal_test_nsubnormal_f64   : test_constant_class_psubnormal_test_nsubnormal_f64_before  ⊑  test_constant_class_psubnormal_test_nsubnormal_f64_combined := by
  unfold test_constant_class_psubnormal_test_nsubnormal_f64_before test_constant_class_psubnormal_test_nsubnormal_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_nzero_test_nzero_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_nzero_test_nzero_f64() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_nzero_test_nzero_f64   : test_constant_class_nzero_test_nzero_f64_before  ⊑  test_constant_class_nzero_test_nzero_f64_combined := by
  unfold test_constant_class_nzero_test_nzero_f64_before test_constant_class_nzero_test_nzero_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_pzero_test_nzero_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_pzero_test_nzero_f64() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_pzero_test_nzero_f64   : test_constant_class_pzero_test_nzero_f64_before  ⊑  test_constant_class_pzero_test_nzero_f64_combined := by
  unfold test_constant_class_pzero_test_nzero_f64_before test_constant_class_pzero_test_nzero_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_pzero_test_pzero_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_pzero_test_pzero_f64() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_pzero_test_pzero_f64   : test_constant_class_pzero_test_pzero_f64_before  ⊑  test_constant_class_pzero_test_pzero_f64_combined := by
  unfold test_constant_class_pzero_test_pzero_f64_before test_constant_class_pzero_test_pzero_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_nzero_test_pzero_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_nzero_test_pzero_f64() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_nzero_test_pzero_f64   : test_constant_class_nzero_test_pzero_f64_before  ⊑  test_constant_class_nzero_test_pzero_f64_combined := by
  unfold test_constant_class_nzero_test_pzero_f64_before test_constant_class_nzero_test_pzero_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_psubnormal_test_psubnormal_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_psubnormal_test_psubnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_psubnormal_test_psubnormal_f64   : test_constant_class_psubnormal_test_psubnormal_f64_before  ⊑  test_constant_class_psubnormal_test_psubnormal_f64_combined := by
  unfold test_constant_class_psubnormal_test_psubnormal_f64_before test_constant_class_psubnormal_test_psubnormal_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_nsubnormal_test_psubnormal_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_nsubnormal_test_psubnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_nsubnormal_test_psubnormal_f64   : test_constant_class_nsubnormal_test_psubnormal_f64_before  ⊑  test_constant_class_nsubnormal_test_psubnormal_f64_combined := by
  unfold test_constant_class_nsubnormal_test_psubnormal_f64_before test_constant_class_nsubnormal_test_psubnormal_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_pnormal_test_pnormal_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_pnormal_test_pnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_pnormal_test_pnormal_f64   : test_constant_class_pnormal_test_pnormal_f64_before  ⊑  test_constant_class_pnormal_test_pnormal_f64_combined := by
  unfold test_constant_class_pnormal_test_pnormal_f64_before test_constant_class_pnormal_test_pnormal_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_nnormal_test_pnormal_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_nnormal_test_pnormal_f64() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_nnormal_test_pnormal_f64   : test_constant_class_nnormal_test_pnormal_f64_before  ⊑  test_constant_class_nnormal_test_pnormal_f64_combined := by
  unfold test_constant_class_nnormal_test_pnormal_f64_before test_constant_class_nnormal_test_pnormal_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_pinf_test_pinf_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_pinf_test_pinf_f64() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_pinf_test_pinf_f64   : test_constant_class_pinf_test_pinf_f64_before  ⊑  test_constant_class_pinf_test_pinf_f64_combined := by
  unfold test_constant_class_pinf_test_pinf_f64_before test_constant_class_pinf_test_pinf_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_ninf_test_pinf_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_ninf_test_pinf_f64() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_ninf_test_pinf_f64   : test_constant_class_ninf_test_pinf_f64_before  ⊑  test_constant_class_ninf_test_pinf_f64_combined := by
  unfold test_constant_class_ninf_test_pinf_f64_before test_constant_class_ninf_test_pinf_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_qnan_test_pinf_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_qnan_test_pinf_f64() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_qnan_test_pinf_f64   : test_constant_class_qnan_test_pinf_f64_before  ⊑  test_constant_class_qnan_test_pinf_f64_combined := by
  unfold test_constant_class_qnan_test_pinf_f64_before test_constant_class_qnan_test_pinf_f64_combined
  simp_alive_peephole
  sorry
def test_constant_class_snan_test_pinf_f64_combined := [llvmfunc|
  llvm.func @test_constant_class_snan_test_pinf_f64() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_constant_class_snan_test_pinf_f64   : test_constant_class_snan_test_pinf_f64_before  ⊑  test_constant_class_snan_test_pinf_f64_combined := by
  unfold test_constant_class_snan_test_pinf_f64_before test_constant_class_snan_test_pinf_f64_combined
  simp_alive_peephole
  sorry
def test_class_is_snan_nnan_src_combined := [llvmfunc|
  llvm.func @test_class_is_snan_nnan_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_snan_nnan_src   : test_class_is_snan_nnan_src_before  ⊑  test_class_is_snan_nnan_src_combined := by
  unfold test_class_is_snan_nnan_src_before test_class_is_snan_nnan_src_combined
  simp_alive_peephole
  sorry
def test_class_is_qnan_nnan_src_combined := [llvmfunc|
  llvm.func @test_class_is_qnan_nnan_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_qnan_nnan_src   : test_class_is_qnan_nnan_src_before  ⊑  test_class_is_qnan_nnan_src_combined := by
  unfold test_class_is_qnan_nnan_src_before test_class_is_qnan_nnan_src_combined
  simp_alive_peephole
  sorry
def test_class_is_nan_nnan_src_combined := [llvmfunc|
  llvm.func @test_class_is_nan_nnan_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nan_nnan_src   : test_class_is_nan_nnan_src_before  ⊑  test_class_is_nan_nnan_src_combined := by
  unfold test_class_is_nan_nnan_src_before test_class_is_nan_nnan_src_combined
  simp_alive_peephole
  sorry
def test_class_is_nan_other_nnan_src_combined := [llvmfunc|
  llvm.func @test_class_is_nan_other_nnan_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

theorem inst_combine_test_class_is_nan_other_nnan_src   : test_class_is_nan_other_nnan_src_before  ⊑  test_class_is_nan_other_nnan_src_combined := by
  unfold test_class_is_nan_other_nnan_src_before test_class_is_nan_other_nnan_src_combined
  simp_alive_peephole
  sorry
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 264 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nan_other_nnan_src   : test_class_is_nan_other_nnan_src_before  ⊑  test_class_is_nan_other_nnan_src_combined := by
  unfold test_class_is_nan_other_nnan_src_before test_class_is_nan_other_nnan_src_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i1
  }]

theorem inst_combine_test_class_is_nan_other_nnan_src   : test_class_is_nan_other_nnan_src_before  ⊑  test_class_is_nan_other_nnan_src_combined := by
  unfold test_class_is_nan_other_nnan_src_before test_class_is_nan_other_nnan_src_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nan_nnan_src_combined := [llvmfunc|
  llvm.func @test_class_is_not_nan_nnan_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nan_nnan_src   : test_class_is_not_nan_nnan_src_before  ⊑  test_class_is_not_nan_nnan_src_combined := by
  unfold test_class_is_not_nan_nnan_src_before test_class_is_not_nan_nnan_src_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nan_nnan_src_strict_combined := [llvmfunc|
  llvm.func @test_class_is_not_nan_nnan_src_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nan_nnan_src_strict   : test_class_is_not_nan_nnan_src_strict_before  ⊑  test_class_is_not_nan_nnan_src_strict_combined := by
  unfold test_class_is_not_nan_nnan_src_strict_before test_class_is_not_nan_nnan_src_strict_combined
  simp_alive_peephole
  sorry
def test_class_is_ninf_pinf_ninf_src_combined := [llvmfunc|
  llvm.func @test_class_is_ninf_pinf_ninf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_ninf_pinf_ninf_src   : test_class_is_ninf_pinf_ninf_src_before  ⊑  test_class_is_ninf_pinf_ninf_src_combined := by
  unfold test_class_is_ninf_pinf_ninf_src_before test_class_is_ninf_pinf_ninf_src_combined
  simp_alive_peephole
  sorry
def test_class_is_ninf_ninf_src_combined := [llvmfunc|
  llvm.func @test_class_is_ninf_ninf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_ninf_ninf_src   : test_class_is_ninf_ninf_src_before  ⊑  test_class_is_ninf_ninf_src_combined := by
  unfold test_class_is_ninf_ninf_src_before test_class_is_ninf_ninf_src_combined
  simp_alive_peephole
  sorry
def test_class_is_pinf_ninf_src_combined := [llvmfunc|
  llvm.func @test_class_is_pinf_ninf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pinf_ninf_src   : test_class_is_pinf_ninf_src_before  ⊑  test_class_is_pinf_ninf_src_combined := by
  unfold test_class_is_pinf_ninf_src_before test_class_is_pinf_ninf_src_combined
  simp_alive_peephole
  sorry
def test_class_is_ninf_pinf_pnormal_ninf_src_combined := [llvmfunc|
  llvm.func @test_class_is_ninf_pinf_pnormal_ninf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

theorem inst_combine_test_class_is_ninf_pinf_pnormal_ninf_src   : test_class_is_ninf_pinf_pnormal_ninf_src_before  ⊑  test_class_is_ninf_pinf_pnormal_ninf_src_combined := by
  unfold test_class_is_ninf_pinf_pnormal_ninf_src_before test_class_is_ninf_pinf_pnormal_ninf_src_combined
  simp_alive_peephole
  sorry
    %2 = "llvm.intr.is.fpclass"(%1) <{bit = 256 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_ninf_pinf_pnormal_ninf_src   : test_class_is_ninf_pinf_pnormal_ninf_src_before  ⊑  test_class_is_ninf_pinf_pnormal_ninf_src_combined := by
  unfold test_class_is_ninf_pinf_pnormal_ninf_src_before test_class_is_ninf_pinf_pnormal_ninf_src_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i1
  }]

theorem inst_combine_test_class_is_ninf_pinf_pnormal_ninf_src   : test_class_is_ninf_pinf_pnormal_ninf_src_before  ⊑  test_class_is_ninf_pinf_pnormal_ninf_src_combined := by
  unfold test_class_is_ninf_pinf_pnormal_ninf_src_before test_class_is_ninf_pinf_pnormal_ninf_src_combined
  simp_alive_peephole
  sorry
def test_class_is_not_inf_ninf_src_combined := [llvmfunc|
  llvm.func @test_class_is_not_inf_ninf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_inf_ninf_src   : test_class_is_not_inf_ninf_src_before  ⊑  test_class_is_not_inf_ninf_src_combined := by
  unfold test_class_is_not_inf_ninf_src_before test_class_is_not_inf_ninf_src_combined
  simp_alive_peephole
  sorry
def test_class_is_not_inf_ninf_src_strict_combined := [llvmfunc|
  llvm.func @test_class_is_not_inf_ninf_src_strict(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_inf_ninf_src_strict   : test_class_is_not_inf_ninf_src_strict_before  ⊑  test_class_is_not_inf_ninf_src_strict_combined := by
  unfold test_class_is_not_inf_ninf_src_strict_before test_class_is_not_inf_ninf_src_strict_combined
  simp_alive_peephole
  sorry
def test_class_not_is_nan_combined := [llvmfunc|
  llvm.func @test_class_not_is_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ord" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_not_is_nan   : test_class_not_is_nan_before  ⊑  test_class_not_is_nan_combined := by
  unfold test_class_not_is_nan_before test_class_not_is_nan_combined
  simp_alive_peephole
  sorry
def test_class_not_is_nan_multi_use_combined := [llvmfunc|
  llvm.func @test_class_not_is_nan_multi_use(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.fcmp "uno" %arg0, %0 : f32
    llvm.store %2, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_test_class_not_is_nan_multi_use   : test_class_not_is_nan_multi_use_before  ⊑  test_class_not_is_nan_multi_use_combined := by
  unfold test_class_not_is_nan_multi_use_before test_class_not_is_nan_multi_use_combined
  simp_alive_peephole
  sorry
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_test_class_not_is_nan_multi_use   : test_class_not_is_nan_multi_use_before  ⊑  test_class_not_is_nan_multi_use_combined := by
  unfold test_class_not_is_nan_multi_use_before test_class_not_is_nan_multi_use_combined
  simp_alive_peephole
  sorry
def test_class_not_is_inf_nan_combined := [llvmfunc|
  llvm.func @test_class_not_is_inf_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.fcmp "one" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_class_not_is_inf_nan   : test_class_not_is_inf_nan_before  ⊑  test_class_not_is_inf_nan_combined := by
  unfold test_class_not_is_inf_nan_before test_class_not_is_inf_nan_combined
  simp_alive_peephole
  sorry
def test_class_not_is_normal_combined := [llvmfunc|
  llvm.func @test_class_not_is_normal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 759 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_not_is_normal   : test_class_not_is_normal_before  ⊑  test_class_not_is_normal_combined := by
  unfold test_class_not_is_normal_before test_class_not_is_normal_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_not_is_normal   : test_class_not_is_normal_before  ⊑  test_class_not_is_normal_combined := by
  unfold test_class_not_is_normal_before test_class_not_is_normal_combined
  simp_alive_peephole
  sorry
def test_class_xor_false_combined := [llvmfunc|
  llvm.func @test_class_xor_false(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 33 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_xor_false   : test_class_xor_false_before  ⊑  test_class_xor_false_combined := by
  unfold test_class_xor_false_before test_class_xor_false_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_xor_false   : test_class_xor_false_before  ⊑  test_class_xor_false_combined := by
  unfold test_class_xor_false_before test_class_xor_false_combined
  simp_alive_peephole
  sorry
def test_class_not_vector_combined := [llvmfunc|
  llvm.func @test_class_not_vector(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 990 : i32}> : (vector<2xf32>) -> vector<2xi1>]

theorem inst_combine_test_class_not_vector   : test_class_not_vector_before  ⊑  test_class_not_vector_combined := by
  unfold test_class_not_vector_before test_class_not_vector_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_test_class_not_vector   : test_class_not_vector_before  ⊑  test_class_not_vector_combined := by
  unfold test_class_not_vector_before test_class_not_vector_combined
  simp_alive_peephole
  sorry
def test_class_xor_vector_combined := [llvmfunc|
  llvm.func @test_class_xor_vector(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 33 : i32}> : (vector<2xf32>) -> vector<2xi1>]

theorem inst_combine_test_class_xor_vector   : test_class_xor_vector_before  ⊑  test_class_xor_vector_combined := by
  unfold test_class_xor_vector_before test_class_xor_vector_combined
  simp_alive_peephole
  sorry
    %4 = llvm.xor %3, %2  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_test_class_xor_vector   : test_class_xor_vector_before  ⊑  test_class_xor_vector_combined := by
  unfold test_class_xor_vector_before test_class_xor_vector_combined
  simp_alive_peephole
  sorry
def test_fold_or_class_f32_0_combined := [llvmfunc|
  llvm.func @test_fold_or_class_f32_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "uno" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_fold_or_class_f32_0   : test_fold_or_class_f32_0_before  ⊑  test_fold_or_class_f32_0_combined := by
  unfold test_fold_or_class_f32_0_before test_fold_or_class_f32_0_combined
  simp_alive_peephole
  sorry
def test_fold_or3_class_f32_0_combined := [llvmfunc|
  llvm.func @test_fold_or3_class_f32_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.fcmp "ueq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_fold_or3_class_f32_0   : test_fold_or3_class_f32_0_before  ⊑  test_fold_or3_class_f32_0_combined := by
  unfold test_fold_or3_class_f32_0_before test_fold_or3_class_f32_0_combined
  simp_alive_peephole
  sorry
def test_fold_or_all_tests_class_f32_0_combined := [llvmfunc|
  llvm.func @test_fold_or_all_tests_class_f32_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_fold_or_all_tests_class_f32_0   : test_fold_or_all_tests_class_f32_0_before  ⊑  test_fold_or_all_tests_class_f32_0_combined := by
  unfold test_fold_or_all_tests_class_f32_0_before test_fold_or_all_tests_class_f32_0_combined
  simp_alive_peephole
  sorry
def test_fold_or_class_f32_1_combined := [llvmfunc|
  llvm.func @test_fold_or_class_f32_1(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 12 : i32}> : (f32) -> i1]

theorem inst_combine_test_fold_or_class_f32_1   : test_fold_or_class_f32_1_before  ⊑  test_fold_or_class_f32_1_combined := by
  unfold test_fold_or_class_f32_1_before test_fold_or_class_f32_1_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_fold_or_class_f32_1   : test_fold_or_class_f32_1_before  ⊑  test_fold_or_class_f32_1_combined := by
  unfold test_fold_or_class_f32_1_before test_fold_or_class_f32_1_combined
  simp_alive_peephole
  sorry
def test_no_fold_or_class_f32_multi_use0_combined := [llvmfunc|
  llvm.func @test_no_fold_or_class_f32_multi_use0(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.store %1, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_test_no_fold_or_class_f32_multi_use0   : test_no_fold_or_class_f32_multi_use0_before  ⊑  test_no_fold_or_class_f32_multi_use0_combined := by
  unfold test_no_fold_or_class_f32_multi_use0_before test_no_fold_or_class_f32_multi_use0_combined
  simp_alive_peephole
  sorry
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1]

theorem inst_combine_test_no_fold_or_class_f32_multi_use0   : test_no_fold_or_class_f32_multi_use0_before  ⊑  test_no_fold_or_class_f32_multi_use0_combined := by
  unfold test_no_fold_or_class_f32_multi_use0_before test_no_fold_or_class_f32_multi_use0_combined
  simp_alive_peephole
  sorry
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_test_no_fold_or_class_f32_multi_use0   : test_no_fold_or_class_f32_multi_use0_before  ⊑  test_no_fold_or_class_f32_multi_use0_combined := by
  unfold test_no_fold_or_class_f32_multi_use0_before test_no_fold_or_class_f32_multi_use0_combined
  simp_alive_peephole
  sorry
def test_no_fold_or_class_f32_multi_use1_combined := [llvmfunc|
  llvm.func @test_no_fold_or_class_f32_multi_use1(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1]

theorem inst_combine_test_no_fold_or_class_f32_multi_use1   : test_no_fold_or_class_f32_multi_use1_before  ⊑  test_no_fold_or_class_f32_multi_use1_combined := by
  unfold test_no_fold_or_class_f32_multi_use1_before test_no_fold_or_class_f32_multi_use1_combined
  simp_alive_peephole
  sorry
    llvm.store %2, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_test_no_fold_or_class_f32_multi_use1   : test_no_fold_or_class_f32_multi_use1_before  ⊑  test_no_fold_or_class_f32_multi_use1_combined := by
  unfold test_no_fold_or_class_f32_multi_use1_before test_no_fold_or_class_f32_multi_use1_combined
  simp_alive_peephole
  sorry
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_test_no_fold_or_class_f32_multi_use1   : test_no_fold_or_class_f32_multi_use1_before  ⊑  test_no_fold_or_class_f32_multi_use1_combined := by
  unfold test_no_fold_or_class_f32_multi_use1_before test_no_fold_or_class_f32_multi_use1_combined
  simp_alive_peephole
  sorry
def test_fold_or_class_f32_2_combined := [llvmfunc|
  llvm.func @test_fold_or_class_f32_2(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.fcmp "ueq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_fold_or_class_f32_2   : test_fold_or_class_f32_2_before  ⊑  test_fold_or_class_f32_2_combined := by
  unfold test_fold_or_class_f32_2_before test_fold_or_class_f32_2_combined
  simp_alive_peephole
  sorry
def test_no_fold_or_class_f32_0_combined := [llvmfunc|
  llvm.func @test_no_fold_or_class_f32_0(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = "llvm.intr.is.fpclass"(%arg1) <{bit = 8 : i32}> : (f32) -> i1]

theorem inst_combine_test_no_fold_or_class_f32_0   : test_no_fold_or_class_f32_0_before  ⊑  test_no_fold_or_class_f32_0_combined := by
  unfold test_no_fold_or_class_f32_0_before test_no_fold_or_class_f32_0_combined
  simp_alive_peephole
  sorry
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_test_no_fold_or_class_f32_0   : test_no_fold_or_class_f32_0_before  ⊑  test_no_fold_or_class_f32_0_combined := by
  unfold test_no_fold_or_class_f32_0_before test_no_fold_or_class_f32_0_combined
  simp_alive_peephole
  sorry
def test_fold_or_class_v2f32_combined := [llvmfunc|
  llvm.func @test_fold_or_class_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 12 : i32}> : (vector<2xf32>) -> vector<2xi1>]

theorem inst_combine_test_fold_or_class_v2f32   : test_fold_or_class_v2f32_before  ⊑  test_fold_or_class_v2f32_combined := by
  unfold test_fold_or_class_v2f32_before test_fold_or_class_v2f32_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_test_fold_or_class_v2f32   : test_fold_or_class_v2f32_before  ⊑  test_fold_or_class_v2f32_combined := by
  unfold test_fold_or_class_v2f32_before test_fold_or_class_v2f32_combined
  simp_alive_peephole
  sorry
def test_fold_and_class_f32_0_combined := [llvmfunc|
  llvm.func @test_fold_and_class_f32_0(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1]

theorem inst_combine_test_fold_and_class_f32_0   : test_fold_and_class_f32_0_before  ⊑  test_fold_and_class_f32_0_combined := by
  unfold test_fold_and_class_f32_0_before test_fold_and_class_f32_0_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_fold_and_class_f32_0   : test_fold_and_class_f32_0_before  ⊑  test_fold_and_class_f32_0_combined := by
  unfold test_fold_and_class_f32_0_before test_fold_and_class_f32_0_combined
  simp_alive_peephole
  sorry
def test_fold_and3_class_f32_0_combined := [llvmfunc|
  llvm.func @test_fold_and3_class_f32_0(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 2 : i32}> : (f32) -> i1]

theorem inst_combine_test_fold_and3_class_f32_0   : test_fold_and3_class_f32_0_before  ⊑  test_fold_and3_class_f32_0_combined := by
  unfold test_fold_and3_class_f32_0_before test_fold_and3_class_f32_0_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_fold_and3_class_f32_0   : test_fold_and3_class_f32_0_before  ⊑  test_fold_and3_class_f32_0_combined := by
  unfold test_fold_and3_class_f32_0_before test_fold_and3_class_f32_0_combined
  simp_alive_peephole
  sorry
def test_fold_and_all_tests_class_f32_0_combined := [llvmfunc|
  llvm.func @test_fold_and_all_tests_class_f32_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_fold_and_all_tests_class_f32_0   : test_fold_and_all_tests_class_f32_0_before  ⊑  test_fold_and_all_tests_class_f32_0_combined := by
  unfold test_fold_and_all_tests_class_f32_0_before test_fold_and_all_tests_class_f32_0_combined
  simp_alive_peephole
  sorry
def test_fold_and_not_all_tests_class_f32_0_combined := [llvmfunc|
  llvm.func @test_fold_and_not_all_tests_class_f32_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_fold_and_not_all_tests_class_f32_0   : test_fold_and_not_all_tests_class_f32_0_before  ⊑  test_fold_and_not_all_tests_class_f32_0_combined := by
  unfold test_fold_and_not_all_tests_class_f32_0_before test_fold_and_not_all_tests_class_f32_0_combined
  simp_alive_peephole
  sorry
def test_fold_and_class_f32_1_combined := [llvmfunc|
  llvm.func @test_fold_and_class_f32_1(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_fold_and_class_f32_1   : test_fold_and_class_f32_1_before  ⊑  test_fold_and_class_f32_1_combined := by
  unfold test_fold_and_class_f32_1_before test_fold_and_class_f32_1_combined
  simp_alive_peephole
  sorry
def test_no_fold_and_class_f32_multi_use0_combined := [llvmfunc|
  llvm.func @test_no_fold_and_class_f32_multi_use0(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 15 : i32}> : (f32) -> i1]

theorem inst_combine_test_no_fold_and_class_f32_multi_use0   : test_no_fold_and_class_f32_multi_use0_before  ⊑  test_no_fold_and_class_f32_multi_use0_combined := by
  unfold test_no_fold_and_class_f32_multi_use0_before test_no_fold_and_class_f32_multi_use0_combined
  simp_alive_peephole
  sorry
    llvm.store %0, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_test_no_fold_and_class_f32_multi_use0   : test_no_fold_and_class_f32_multi_use0_before  ⊑  test_no_fold_and_class_f32_multi_use0_combined := by
  unfold test_no_fold_and_class_f32_multi_use0_before test_no_fold_and_class_f32_multi_use0_combined
  simp_alive_peephole
  sorry
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1]

theorem inst_combine_test_no_fold_and_class_f32_multi_use0   : test_no_fold_and_class_f32_multi_use0_before  ⊑  test_no_fold_and_class_f32_multi_use0_combined := by
  unfold test_no_fold_and_class_f32_multi_use0_before test_no_fold_and_class_f32_multi_use0_combined
  simp_alive_peephole
  sorry
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_no_fold_and_class_f32_multi_use0   : test_no_fold_and_class_f32_multi_use0_before  ⊑  test_no_fold_and_class_f32_multi_use0_combined := by
  unfold test_no_fold_and_class_f32_multi_use0_before test_no_fold_and_class_f32_multi_use0_combined
  simp_alive_peephole
  sorry
def test_no_fold_and_class_f32_multi_use1_combined := [llvmfunc|
  llvm.func @test_no_fold_and_class_f32_multi_use1(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 15 : i32}> : (f32) -> i1]

theorem inst_combine_test_no_fold_and_class_f32_multi_use1   : test_no_fold_and_class_f32_multi_use1_before  ⊑  test_no_fold_and_class_f32_multi_use1_combined := by
  unfold test_no_fold_and_class_f32_multi_use1_before test_no_fold_and_class_f32_multi_use1_combined
  simp_alive_peephole
  sorry
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1]

theorem inst_combine_test_no_fold_and_class_f32_multi_use1   : test_no_fold_and_class_f32_multi_use1_before  ⊑  test_no_fold_and_class_f32_multi_use1_combined := by
  unfold test_no_fold_and_class_f32_multi_use1_before test_no_fold_and_class_f32_multi_use1_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_test_no_fold_and_class_f32_multi_use1   : test_no_fold_and_class_f32_multi_use1_before  ⊑  test_no_fold_and_class_f32_multi_use1_combined := by
  unfold test_no_fold_and_class_f32_multi_use1_before test_no_fold_and_class_f32_multi_use1_combined
  simp_alive_peephole
  sorry
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_no_fold_and_class_f32_multi_use1   : test_no_fold_and_class_f32_multi_use1_before  ⊑  test_no_fold_and_class_f32_multi_use1_combined := by
  unfold test_no_fold_and_class_f32_multi_use1_before test_no_fold_and_class_f32_multi_use1_combined
  simp_alive_peephole
  sorry
def test_fold_and_class_f32_2_combined := [llvmfunc|
  llvm.func @test_fold_and_class_f32_2(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.fcmp "ueq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_fold_and_class_f32_2   : test_fold_and_class_f32_2_before  ⊑  test_fold_and_class_f32_2_combined := by
  unfold test_fold_and_class_f32_2_before test_fold_and_class_f32_2_combined
  simp_alive_peephole
  sorry
def test_fold_and_class_f32_3_combined := [llvmfunc|
  llvm.func @test_fold_and_class_f32_3(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1]

theorem inst_combine_test_fold_and_class_f32_3   : test_fold_and_class_f32_3_before  ⊑  test_fold_and_class_f32_3_combined := by
  unfold test_fold_and_class_f32_3_before test_fold_and_class_f32_3_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_fold_and_class_f32_3   : test_fold_and_class_f32_3_before  ⊑  test_fold_and_class_f32_3_combined := by
  unfold test_fold_and_class_f32_3_before test_fold_and_class_f32_3_combined
  simp_alive_peephole
  sorry
def test_fold_and_class_f32_4_combined := [llvmfunc|
  llvm.func @test_fold_and_class_f32_4(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1]

theorem inst_combine_test_fold_and_class_f32_4   : test_fold_and_class_f32_4_before  ⊑  test_fold_and_class_f32_4_combined := by
  unfold test_fold_and_class_f32_4_before test_fold_and_class_f32_4_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_fold_and_class_f32_4   : test_fold_and_class_f32_4_before  ⊑  test_fold_and_class_f32_4_combined := by
  unfold test_fold_and_class_f32_4_before test_fold_and_class_f32_4_combined
  simp_alive_peephole
  sorry
def test_no_fold_and_class_f32_0_combined := [llvmfunc|
  llvm.func @test_no_fold_and_class_f32_0(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.fcmp "ueq" %arg0, %0 : f32
    %2 = "llvm.intr.is.fpclass"(%arg1) <{bit = 15 : i32}> : (f32) -> i1]

theorem inst_combine_test_no_fold_and_class_f32_0   : test_no_fold_and_class_f32_0_before  ⊑  test_no_fold_and_class_f32_0_combined := by
  unfold test_no_fold_and_class_f32_0_before test_no_fold_and_class_f32_0_combined
  simp_alive_peephole
  sorry
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_test_no_fold_and_class_f32_0   : test_no_fold_and_class_f32_0_before  ⊑  test_no_fold_and_class_f32_0_combined := by
  unfold test_no_fold_and_class_f32_0_before test_no_fold_and_class_f32_0_combined
  simp_alive_peephole
  sorry
def test_fold_and_class_v2f32_combined := [llvmfunc|
  llvm.func @test_fold_and_class_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<0xFF800000> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fcmp "ueq" %arg0, %0 : vector<2xf32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test_fold_and_class_v2f32   : test_fold_and_class_v2f32_before  ⊑  test_fold_and_class_v2f32_combined := by
  unfold test_fold_and_class_v2f32_before test_fold_and_class_v2f32_combined
  simp_alive_peephole
  sorry
def test_fold_xor_class_f32_0_combined := [llvmfunc|
  llvm.func @test_fold_xor_class_f32_0(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 2 : i32}> : (f32) -> i1]

theorem inst_combine_test_fold_xor_class_f32_0   : test_fold_xor_class_f32_0_before  ⊑  test_fold_xor_class_f32_0_combined := by
  unfold test_fold_xor_class_f32_0_before test_fold_xor_class_f32_0_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_fold_xor_class_f32_0   : test_fold_xor_class_f32_0_before  ⊑  test_fold_xor_class_f32_0_combined := by
  unfold test_fold_xor_class_f32_0_before test_fold_xor_class_f32_0_combined
  simp_alive_peephole
  sorry
def test_fold_xor3_class_f32_0_combined := [llvmfunc|
  llvm.func @test_fold_xor3_class_f32_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.fcmp "ueq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_fold_xor3_class_f32_0   : test_fold_xor3_class_f32_0_before  ⊑  test_fold_xor3_class_f32_0_combined := by
  unfold test_fold_xor3_class_f32_0_before test_fold_xor3_class_f32_0_combined
  simp_alive_peephole
  sorry
def test_fold_xor_all_tests_class_f32_0_combined := [llvmfunc|
  llvm.func @test_fold_xor_all_tests_class_f32_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_fold_xor_all_tests_class_f32_0   : test_fold_xor_all_tests_class_f32_0_before  ⊑  test_fold_xor_all_tests_class_f32_0_combined := by
  unfold test_fold_xor_all_tests_class_f32_0_before test_fold_xor_all_tests_class_f32_0_combined
  simp_alive_peephole
  sorry
def test_fold_xor_class_f32_1_combined := [llvmfunc|
  llvm.func @test_fold_xor_class_f32_1(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 12 : i32}> : (f32) -> i1]

theorem inst_combine_test_fold_xor_class_f32_1   : test_fold_xor_class_f32_1_before  ⊑  test_fold_xor_class_f32_1_combined := by
  unfold test_fold_xor_class_f32_1_before test_fold_xor_class_f32_1_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_fold_xor_class_f32_1   : test_fold_xor_class_f32_1_before  ⊑  test_fold_xor_class_f32_1_combined := by
  unfold test_fold_xor_class_f32_1_before test_fold_xor_class_f32_1_combined
  simp_alive_peephole
  sorry
def test_no_fold_xor_class_f32_multi_use0_combined := [llvmfunc|
  llvm.func @test_no_fold_xor_class_f32_multi_use0(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.store %1, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_test_no_fold_xor_class_f32_multi_use0   : test_no_fold_xor_class_f32_multi_use0_before  ⊑  test_no_fold_xor_class_f32_multi_use0_combined := by
  unfold test_no_fold_xor_class_f32_multi_use0_before test_no_fold_xor_class_f32_multi_use0_combined
  simp_alive_peephole
  sorry
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1]

theorem inst_combine_test_no_fold_xor_class_f32_multi_use0   : test_no_fold_xor_class_f32_multi_use0_before  ⊑  test_no_fold_xor_class_f32_multi_use0_combined := by
  unfold test_no_fold_xor_class_f32_multi_use0_before test_no_fold_xor_class_f32_multi_use0_combined
  simp_alive_peephole
  sorry
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_test_no_fold_xor_class_f32_multi_use0   : test_no_fold_xor_class_f32_multi_use0_before  ⊑  test_no_fold_xor_class_f32_multi_use0_combined := by
  unfold test_no_fold_xor_class_f32_multi_use0_before test_no_fold_xor_class_f32_multi_use0_combined
  simp_alive_peephole
  sorry
def test_no_fold_xor_class_f32_multi_use1_combined := [llvmfunc|
  llvm.func @test_no_fold_xor_class_f32_multi_use1(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1]

theorem inst_combine_test_no_fold_xor_class_f32_multi_use1   : test_no_fold_xor_class_f32_multi_use1_before  ⊑  test_no_fold_xor_class_f32_multi_use1_combined := by
  unfold test_no_fold_xor_class_f32_multi_use1_before test_no_fold_xor_class_f32_multi_use1_combined
  simp_alive_peephole
  sorry
    llvm.store %2, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_test_no_fold_xor_class_f32_multi_use1   : test_no_fold_xor_class_f32_multi_use1_before  ⊑  test_no_fold_xor_class_f32_multi_use1_combined := by
  unfold test_no_fold_xor_class_f32_multi_use1_before test_no_fold_xor_class_f32_multi_use1_combined
  simp_alive_peephole
  sorry
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_test_no_fold_xor_class_f32_multi_use1   : test_no_fold_xor_class_f32_multi_use1_before  ⊑  test_no_fold_xor_class_f32_multi_use1_combined := by
  unfold test_no_fold_xor_class_f32_multi_use1_before test_no_fold_xor_class_f32_multi_use1_combined
  simp_alive_peephole
  sorry
def test_fold_xor_class_f32_2_combined := [llvmfunc|
  llvm.func @test_fold_xor_class_f32_2(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_fold_xor_class_f32_2   : test_fold_xor_class_f32_2_before  ⊑  test_fold_xor_class_f32_2_combined := by
  unfold test_fold_xor_class_f32_2_before test_fold_xor_class_f32_2_combined
  simp_alive_peephole
  sorry
def test_no_fold_xor_class_f32_0_combined := [llvmfunc|
  llvm.func @test_no_fold_xor_class_f32_0(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = "llvm.intr.is.fpclass"(%arg1) <{bit = 8 : i32}> : (f32) -> i1]

theorem inst_combine_test_no_fold_xor_class_f32_0   : test_no_fold_xor_class_f32_0_before  ⊑  test_no_fold_xor_class_f32_0_combined := by
  unfold test_no_fold_xor_class_f32_0_before test_no_fold_xor_class_f32_0_combined
  simp_alive_peephole
  sorry
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_test_no_fold_xor_class_f32_0   : test_no_fold_xor_class_f32_0_before  ⊑  test_no_fold_xor_class_f32_0_combined := by
  unfold test_no_fold_xor_class_f32_0_before test_no_fold_xor_class_f32_0_combined
  simp_alive_peephole
  sorry
def test_fold_xor_class_v2f32_combined := [llvmfunc|
  llvm.func @test_fold_xor_class_v2f32(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 9 : i32}> : (vector<2xf32>) -> vector<2xi1>]

theorem inst_combine_test_fold_xor_class_v2f32   : test_fold_xor_class_v2f32_before  ⊑  test_fold_xor_class_v2f32_combined := by
  unfold test_fold_xor_class_v2f32_before test_fold_xor_class_v2f32_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_test_fold_xor_class_v2f32   : test_fold_xor_class_v2f32_before  ⊑  test_fold_xor_class_v2f32_combined := by
  unfold test_fold_xor_class_v2f32_before test_fold_xor_class_v2f32_combined
  simp_alive_peephole
  sorry
def test_class_fneg_none_combined := [llvmfunc|
  llvm.func @test_class_fneg_none(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_none   : test_class_fneg_none_before  ⊑  test_class_fneg_none_combined := by
  unfold test_class_fneg_none_before test_class_fneg_none_combined
  simp_alive_peephole
  sorry
def test_class_fneg_all_combined := [llvmfunc|
  llvm.func @test_class_fneg_all(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_all   : test_class_fneg_all_before  ⊑  test_class_fneg_all_combined := by
  unfold test_class_fneg_all_before test_class_fneg_all_combined
  simp_alive_peephole
  sorry
def test_class_fneg_snan_combined := [llvmfunc|
  llvm.func @test_class_fneg_snan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_snan   : test_class_fneg_snan_before  ⊑  test_class_fneg_snan_combined := by
  unfold test_class_fneg_snan_before test_class_fneg_snan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_snan   : test_class_fneg_snan_before  ⊑  test_class_fneg_snan_combined := by
  unfold test_class_fneg_snan_before test_class_fneg_snan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_qnan_combined := [llvmfunc|
  llvm.func @test_class_fneg_qnan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 2 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_qnan   : test_class_fneg_qnan_before  ⊑  test_class_fneg_qnan_combined := by
  unfold test_class_fneg_qnan_before test_class_fneg_qnan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_qnan   : test_class_fneg_qnan_before  ⊑  test_class_fneg_qnan_combined := by
  unfold test_class_fneg_qnan_before test_class_fneg_qnan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_neginf_combined := [llvmfunc|
  llvm.func @test_class_fneg_neginf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_fneg_neginf   : test_class_fneg_neginf_before  ⊑  test_class_fneg_neginf_combined := by
  unfold test_class_fneg_neginf_before test_class_fneg_neginf_combined
  simp_alive_peephole
  sorry
def test_class_fneg_negnormal_combined := [llvmfunc|
  llvm.func @test_class_fneg_negnormal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 256 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_negnormal   : test_class_fneg_negnormal_before  ⊑  test_class_fneg_negnormal_combined := by
  unfold test_class_fneg_negnormal_before test_class_fneg_negnormal_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_negnormal   : test_class_fneg_negnormal_before  ⊑  test_class_fneg_negnormal_combined := by
  unfold test_class_fneg_negnormal_before test_class_fneg_negnormal_combined
  simp_alive_peephole
  sorry
def test_class_fneg_negsubnormal_combined := [llvmfunc|
  llvm.func @test_class_fneg_negsubnormal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 128 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_negsubnormal   : test_class_fneg_negsubnormal_before  ⊑  test_class_fneg_negsubnormal_combined := by
  unfold test_class_fneg_negsubnormal_before test_class_fneg_negsubnormal_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_negsubnormal   : test_class_fneg_negsubnormal_before  ⊑  test_class_fneg_negsubnormal_combined := by
  unfold test_class_fneg_negsubnormal_before test_class_fneg_negsubnormal_combined
  simp_alive_peephole
  sorry
def test_class_fneg_negzero_combined := [llvmfunc|
  llvm.func @test_class_fneg_negzero(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 64 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_negzero   : test_class_fneg_negzero_before  ⊑  test_class_fneg_negzero_combined := by
  unfold test_class_fneg_negzero_before test_class_fneg_negzero_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_negzero   : test_class_fneg_negzero_before  ⊑  test_class_fneg_negzero_combined := by
  unfold test_class_fneg_negzero_before test_class_fneg_negzero_combined
  simp_alive_peephole
  sorry
def test_class_fneg_poszero_combined := [llvmfunc|
  llvm.func @test_class_fneg_poszero(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 32 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_poszero   : test_class_fneg_poszero_before  ⊑  test_class_fneg_poszero_combined := by
  unfold test_class_fneg_poszero_before test_class_fneg_poszero_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_poszero   : test_class_fneg_poszero_before  ⊑  test_class_fneg_poszero_combined := by
  unfold test_class_fneg_poszero_before test_class_fneg_poszero_combined
  simp_alive_peephole
  sorry
def test_class_fneg_possubnormal_combined := [llvmfunc|
  llvm.func @test_class_fneg_possubnormal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 16 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_possubnormal   : test_class_fneg_possubnormal_before  ⊑  test_class_fneg_possubnormal_combined := by
  unfold test_class_fneg_possubnormal_before test_class_fneg_possubnormal_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_possubnormal   : test_class_fneg_possubnormal_before  ⊑  test_class_fneg_possubnormal_combined := by
  unfold test_class_fneg_possubnormal_before test_class_fneg_possubnormal_combined
  simp_alive_peephole
  sorry
def test_class_fneg_posnormal_combined := [llvmfunc|
  llvm.func @test_class_fneg_posnormal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 8 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_posnormal   : test_class_fneg_posnormal_before  ⊑  test_class_fneg_posnormal_combined := by
  unfold test_class_fneg_posnormal_before test_class_fneg_posnormal_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_posnormal   : test_class_fneg_posnormal_before  ⊑  test_class_fneg_posnormal_combined := by
  unfold test_class_fneg_posnormal_before test_class_fneg_posnormal_combined
  simp_alive_peephole
  sorry
def test_class_fneg_posinf_combined := [llvmfunc|
  llvm.func @test_class_fneg_posinf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_fneg_posinf   : test_class_fneg_posinf_before  ⊑  test_class_fneg_posinf_combined := by
  unfold test_class_fneg_posinf_before test_class_fneg_posinf_combined
  simp_alive_peephole
  sorry
def test_class_fneg_isnan_combined := [llvmfunc|
  llvm.func @test_class_fneg_isnan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "uno" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_fneg_isnan   : test_class_fneg_isnan_before  ⊑  test_class_fneg_isnan_combined := by
  unfold test_class_fneg_isnan_before test_class_fneg_isnan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_nnan_combined := [llvmfunc|
  llvm.func @test_class_fneg_nnan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ord" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_fneg_nnan   : test_class_fneg_nnan_before  ⊑  test_class_fneg_nnan_combined := by
  unfold test_class_fneg_nnan_before test_class_fneg_nnan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_normal_combined := [llvmfunc|
  llvm.func @test_class_fneg_normal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_normal   : test_class_fneg_normal_before  ⊑  test_class_fneg_normal_combined := by
  unfold test_class_fneg_normal_before test_class_fneg_normal_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_normal   : test_class_fneg_normal_before  ⊑  test_class_fneg_normal_combined := by
  unfold test_class_fneg_normal_before test_class_fneg_normal_combined
  simp_alive_peephole
  sorry
def test_class_fneg_zero_combined := [llvmfunc|
  llvm.func @test_class_fneg_zero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_fneg_zero   : test_class_fneg_zero_before  ⊑  test_class_fneg_zero_combined := by
  unfold test_class_fneg_zero_before test_class_fneg_zero_combined
  simp_alive_peephole
  sorry
def test_class_fneg_subnormal_combined := [llvmfunc|
  llvm.func @test_class_fneg_subnormal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 144 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_subnormal   : test_class_fneg_subnormal_before  ⊑  test_class_fneg_subnormal_combined := by
  unfold test_class_fneg_subnormal_before test_class_fneg_subnormal_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_subnormal   : test_class_fneg_subnormal_before  ⊑  test_class_fneg_subnormal_combined := by
  unfold test_class_fneg_subnormal_before test_class_fneg_subnormal_combined
  simp_alive_peephole
  sorry
def test_class_fneg_normal_neginf_combined := [llvmfunc|
  llvm.func @test_class_fneg_normal_neginf(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 776 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_normal_neginf   : test_class_fneg_normal_neginf_before  ⊑  test_class_fneg_normal_neginf_combined := by
  unfold test_class_fneg_normal_neginf_before test_class_fneg_normal_neginf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_normal_neginf   : test_class_fneg_normal_neginf_before  ⊑  test_class_fneg_normal_neginf_combined := by
  unfold test_class_fneg_normal_neginf_before test_class_fneg_normal_neginf_combined
  simp_alive_peephole
  sorry
def test_class_fneg_normal_pinf_combined := [llvmfunc|
  llvm.func @test_class_fneg_normal_pinf(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 268 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_normal_pinf   : test_class_fneg_normal_pinf_before  ⊑  test_class_fneg_normal_pinf_combined := by
  unfold test_class_fneg_normal_pinf_before test_class_fneg_normal_pinf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_normal_pinf   : test_class_fneg_normal_pinf_before  ⊑  test_class_fneg_normal_pinf_combined := by
  unfold test_class_fneg_normal_pinf_before test_class_fneg_normal_pinf_combined
  simp_alive_peephole
  sorry
def test_class_fneg_neginf_posnormal_negsubnormal_poszero_combined := [llvmfunc|
  llvm.func @test_class_fneg_neginf_posnormal_negsubnormal_poszero(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 680 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_neginf_posnormal_negsubnormal_poszero   : test_class_fneg_neginf_posnormal_negsubnormal_poszero_before  ⊑  test_class_fneg_neginf_posnormal_negsubnormal_poszero_combined := by
  unfold test_class_fneg_neginf_posnormal_negsubnormal_poszero_before test_class_fneg_neginf_posnormal_negsubnormal_poszero_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_neginf_posnormal_negsubnormal_poszero   : test_class_fneg_neginf_posnormal_negsubnormal_poszero_before  ⊑  test_class_fneg_neginf_posnormal_negsubnormal_poszero_combined := by
  unfold test_class_fneg_neginf_posnormal_negsubnormal_poszero_before test_class_fneg_neginf_posnormal_negsubnormal_poszero_combined
  simp_alive_peephole
  sorry
def test_class_fneg_neginf_posnormal_negsubnormal_poszero_snan_combined := [llvmfunc|
  llvm.func @test_class_fneg_neginf_posnormal_negsubnormal_poszero_snan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 681 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_neginf_posnormal_negsubnormal_poszero_snan   : test_class_fneg_neginf_posnormal_negsubnormal_poszero_snan_before  ⊑  test_class_fneg_neginf_posnormal_negsubnormal_poszero_snan_combined := by
  unfold test_class_fneg_neginf_posnormal_negsubnormal_poszero_snan_before test_class_fneg_neginf_posnormal_negsubnormal_poszero_snan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_neginf_posnormal_negsubnormal_poszero_snan   : test_class_fneg_neginf_posnormal_negsubnormal_poszero_snan_before  ⊑  test_class_fneg_neginf_posnormal_negsubnormal_poszero_snan_combined := by
  unfold test_class_fneg_neginf_posnormal_negsubnormal_poszero_snan_before test_class_fneg_neginf_posnormal_negsubnormal_poszero_snan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_neginf_posnormal_negsubnormal_poszero_qnan_combined := [llvmfunc|
  llvm.func @test_class_fneg_neginf_posnormal_negsubnormal_poszero_qnan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 682 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_neginf_posnormal_negsubnormal_poszero_qnan   : test_class_fneg_neginf_posnormal_negsubnormal_poszero_qnan_before  ⊑  test_class_fneg_neginf_posnormal_negsubnormal_poszero_qnan_combined := by
  unfold test_class_fneg_neginf_posnormal_negsubnormal_poszero_qnan_before test_class_fneg_neginf_posnormal_negsubnormal_poszero_qnan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_neginf_posnormal_negsubnormal_poszero_qnan   : test_class_fneg_neginf_posnormal_negsubnormal_poszero_qnan_before  ⊑  test_class_fneg_neginf_posnormal_negsubnormal_poszero_qnan_combined := by
  unfold test_class_fneg_neginf_posnormal_negsubnormal_poszero_qnan_before test_class_fneg_neginf_posnormal_negsubnormal_poszero_qnan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_neginf_posnormal_negsubnormal_poszero_nan_combined := [llvmfunc|
  llvm.func @test_class_fneg_neginf_posnormal_negsubnormal_poszero_nan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 683 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_neginf_posnormal_negsubnormal_poszero_nan   : test_class_fneg_neginf_posnormal_negsubnormal_poszero_nan_before  ⊑  test_class_fneg_neginf_posnormal_negsubnormal_poszero_nan_combined := by
  unfold test_class_fneg_neginf_posnormal_negsubnormal_poszero_nan_before test_class_fneg_neginf_posnormal_negsubnormal_poszero_nan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_neginf_posnormal_negsubnormal_poszero_nan   : test_class_fneg_neginf_posnormal_negsubnormal_poszero_nan_before  ⊑  test_class_fneg_neginf_posnormal_negsubnormal_poszero_nan_combined := by
  unfold test_class_fneg_neginf_posnormal_negsubnormal_poszero_nan_before test_class_fneg_neginf_posnormal_negsubnormal_poszero_nan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_posinf_negnormal_possubnormal_negzero_combined := [llvmfunc|
  llvm.func @test_class_fneg_posinf_negnormal_possubnormal_negzero(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 340 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_posinf_negnormal_possubnormal_negzero   : test_class_fneg_posinf_negnormal_possubnormal_negzero_before  ⊑  test_class_fneg_posinf_negnormal_possubnormal_negzero_combined := by
  unfold test_class_fneg_posinf_negnormal_possubnormal_negzero_before test_class_fneg_posinf_negnormal_possubnormal_negzero_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_posinf_negnormal_possubnormal_negzero   : test_class_fneg_posinf_negnormal_possubnormal_negzero_before  ⊑  test_class_fneg_posinf_negnormal_possubnormal_negzero_combined := by
  unfold test_class_fneg_posinf_negnormal_possubnormal_negzero_before test_class_fneg_posinf_negnormal_possubnormal_negzero_combined
  simp_alive_peephole
  sorry
def test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_combined := [llvmfunc|
  llvm.func @test_class_fneg_posinf_negnormal_possubnormal_negzero_snan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 341 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_posinf_negnormal_possubnormal_negzero_snan   : test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_before  ⊑  test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_combined := by
  unfold test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_before test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_posinf_negnormal_possubnormal_negzero_snan   : test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_before  ⊑  test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_combined := by
  unfold test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_before test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_posinf_negnormal_possubnormal_negzero_qnan_combined := [llvmfunc|
  llvm.func @test_class_fneg_posinf_negnormal_possubnormal_negzero_qnan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 342 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_posinf_negnormal_possubnormal_negzero_qnan   : test_class_fneg_posinf_negnormal_possubnormal_negzero_qnan_before  ⊑  test_class_fneg_posinf_negnormal_possubnormal_negzero_qnan_combined := by
  unfold test_class_fneg_posinf_negnormal_possubnormal_negzero_qnan_before test_class_fneg_posinf_negnormal_possubnormal_negzero_qnan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_posinf_negnormal_possubnormal_negzero_qnan   : test_class_fneg_posinf_negnormal_possubnormal_negzero_qnan_before  ⊑  test_class_fneg_posinf_negnormal_possubnormal_negzero_qnan_combined := by
  unfold test_class_fneg_posinf_negnormal_possubnormal_negzero_qnan_before test_class_fneg_posinf_negnormal_possubnormal_negzero_qnan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_combined := [llvmfunc|
  llvm.func @test_class_fneg_posinf_negnormal_possubnormal_negzero_nan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 343 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_posinf_negnormal_possubnormal_negzero_nan   : test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_before  ⊑  test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_combined := by
  unfold test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_before test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_posinf_negnormal_possubnormal_negzero_nan   : test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_before  ⊑  test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_combined := by
  unfold test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_before test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_strictfp_combined := [llvmfunc|
  llvm.func @test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 341 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_strictfp   : test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_strictfp_before  ⊑  test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_strictfp_combined := by
  unfold test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_strictfp_before test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_strictfp_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_strictfp   : test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_strictfp_before  ⊑  test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_strictfp_combined := by
  unfold test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_strictfp_before test_class_fneg_posinf_negnormal_possubnormal_negzero_snan_strictfp_combined
  simp_alive_peephole
  sorry
def test_class_fneg_multiple_use_fneg_combined := [llvmfunc|
  llvm.func @test_class_fneg_multiple_use_fneg(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    llvm.store %0, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr]

theorem inst_combine_test_class_fneg_multiple_use_fneg   : test_class_fneg_multiple_use_fneg_before  ⊑  test_class_fneg_multiple_use_fneg_combined := by
  unfold test_class_fneg_multiple_use_fneg_before test_class_fneg_multiple_use_fneg_combined
  simp_alive_peephole
  sorry
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 342 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_multiple_use_fneg   : test_class_fneg_multiple_use_fneg_before  ⊑  test_class_fneg_multiple_use_fneg_combined := by
  unfold test_class_fneg_multiple_use_fneg_before test_class_fneg_multiple_use_fneg_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_fneg_multiple_use_fneg   : test_class_fneg_multiple_use_fneg_before  ⊑  test_class_fneg_multiple_use_fneg_combined := by
  unfold test_class_fneg_multiple_use_fneg_before test_class_fneg_multiple_use_fneg_combined
  simp_alive_peephole
  sorry
def test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_vector_combined := [llvmfunc|
  llvm.func @test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_vector(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 343 : i32}> : (vector<2xf32>) -> vector<2xi1>]

theorem inst_combine_test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_vector   : test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_vector_before  ⊑  test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_vector_combined := by
  unfold test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_vector_before test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_vector_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_vector   : test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_vector_before  ⊑  test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_vector_combined := by
  unfold test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_vector_before test_class_fneg_posinf_negnormal_possubnormal_negzero_nan_vector_combined
  simp_alive_peephole
  sorry
def test_class_fabs_none_combined := [llvmfunc|
  llvm.func @test_class_fabs_none(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_none   : test_class_fabs_none_before  ⊑  test_class_fabs_none_combined := by
  unfold test_class_fabs_none_before test_class_fabs_none_combined
  simp_alive_peephole
  sorry
def test_class_fabs_all_combined := [llvmfunc|
  llvm.func @test_class_fabs_all(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_all   : test_class_fabs_all_before  ⊑  test_class_fabs_all_combined := by
  unfold test_class_fabs_all_before test_class_fabs_all_combined
  simp_alive_peephole
  sorry
def test_class_fabs_snan_combined := [llvmfunc|
  llvm.func @test_class_fabs_snan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fabs_snan   : test_class_fabs_snan_before  ⊑  test_class_fabs_snan_combined := by
  unfold test_class_fabs_snan_before test_class_fabs_snan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_snan   : test_class_fabs_snan_before  ⊑  test_class_fabs_snan_combined := by
  unfold test_class_fabs_snan_before test_class_fabs_snan_combined
  simp_alive_peephole
  sorry
def test_class_fabs_qnan_combined := [llvmfunc|
  llvm.func @test_class_fabs_qnan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 2 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fabs_qnan   : test_class_fabs_qnan_before  ⊑  test_class_fabs_qnan_combined := by
  unfold test_class_fabs_qnan_before test_class_fabs_qnan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_qnan   : test_class_fabs_qnan_before  ⊑  test_class_fabs_qnan_combined := by
  unfold test_class_fabs_qnan_before test_class_fabs_qnan_combined
  simp_alive_peephole
  sorry
def test_class_fabs_neginf_combined := [llvmfunc|
  llvm.func @test_class_fabs_neginf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_neginf   : test_class_fabs_neginf_before  ⊑  test_class_fabs_neginf_combined := by
  unfold test_class_fabs_neginf_before test_class_fabs_neginf_combined
  simp_alive_peephole
  sorry
def test_class_fabs_negnormal_combined := [llvmfunc|
  llvm.func @test_class_fabs_negnormal(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_negnormal   : test_class_fabs_negnormal_before  ⊑  test_class_fabs_negnormal_combined := by
  unfold test_class_fabs_negnormal_before test_class_fabs_negnormal_combined
  simp_alive_peephole
  sorry
def test_class_fabs_negsubnormal_combined := [llvmfunc|
  llvm.func @test_class_fabs_negsubnormal(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_negsubnormal   : test_class_fabs_negsubnormal_before  ⊑  test_class_fabs_negsubnormal_combined := by
  unfold test_class_fabs_negsubnormal_before test_class_fabs_negsubnormal_combined
  simp_alive_peephole
  sorry
def test_class_fabs_negzero_combined := [llvmfunc|
  llvm.func @test_class_fabs_negzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_negzero   : test_class_fabs_negzero_before  ⊑  test_class_fabs_negzero_combined := by
  unfold test_class_fabs_negzero_before test_class_fabs_negzero_combined
  simp_alive_peephole
  sorry
def test_class_fabs_poszero_combined := [llvmfunc|
  llvm.func @test_class_fabs_poszero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_fabs_poszero   : test_class_fabs_poszero_before  ⊑  test_class_fabs_poszero_combined := by
  unfold test_class_fabs_poszero_before test_class_fabs_poszero_combined
  simp_alive_peephole
  sorry
def test_class_fabs_possubnormal_combined := [llvmfunc|
  llvm.func @test_class_fabs_possubnormal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 144 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fabs_possubnormal   : test_class_fabs_possubnormal_before  ⊑  test_class_fabs_possubnormal_combined := by
  unfold test_class_fabs_possubnormal_before test_class_fabs_possubnormal_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_possubnormal   : test_class_fabs_possubnormal_before  ⊑  test_class_fabs_possubnormal_combined := by
  unfold test_class_fabs_possubnormal_before test_class_fabs_possubnormal_combined
  simp_alive_peephole
  sorry
def test_class_fabs_posnormal_combined := [llvmfunc|
  llvm.func @test_class_fabs_posnormal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fabs_posnormal   : test_class_fabs_posnormal_before  ⊑  test_class_fabs_posnormal_combined := by
  unfold test_class_fabs_posnormal_before test_class_fabs_posnormal_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_posnormal   : test_class_fabs_posnormal_before  ⊑  test_class_fabs_posnormal_combined := by
  unfold test_class_fabs_posnormal_before test_class_fabs_posnormal_combined
  simp_alive_peephole
  sorry
def test_class_fabs_posinf_combined := [llvmfunc|
  llvm.func @test_class_fabs_posinf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_class_fabs_posinf   : test_class_fabs_posinf_before  ⊑  test_class_fabs_posinf_combined := by
  unfold test_class_fabs_posinf_before test_class_fabs_posinf_combined
  simp_alive_peephole
  sorry
def test_class_fabs_isnan_combined := [llvmfunc|
  llvm.func @test_class_fabs_isnan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "uno" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_fabs_isnan   : test_class_fabs_isnan_before  ⊑  test_class_fabs_isnan_combined := by
  unfold test_class_fabs_isnan_before test_class_fabs_isnan_combined
  simp_alive_peephole
  sorry
def test_class_fabs_nnan_combined := [llvmfunc|
  llvm.func @test_class_fabs_nnan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ord" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_fabs_nnan   : test_class_fabs_nnan_before  ⊑  test_class_fabs_nnan_combined := by
  unfold test_class_fabs_nnan_before test_class_fabs_nnan_combined
  simp_alive_peephole
  sorry
def test_class_fabs_normal_combined := [llvmfunc|
  llvm.func @test_class_fabs_normal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fabs_normal   : test_class_fabs_normal_before  ⊑  test_class_fabs_normal_combined := by
  unfold test_class_fabs_normal_before test_class_fabs_normal_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_normal   : test_class_fabs_normal_before  ⊑  test_class_fabs_normal_combined := by
  unfold test_class_fabs_normal_before test_class_fabs_normal_combined
  simp_alive_peephole
  sorry
def test_class_fabs_zero_combined := [llvmfunc|
  llvm.func @test_class_fabs_zero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_fabs_zero   : test_class_fabs_zero_before  ⊑  test_class_fabs_zero_combined := by
  unfold test_class_fabs_zero_before test_class_fabs_zero_combined
  simp_alive_peephole
  sorry
def test_class_fabs_subnormal_combined := [llvmfunc|
  llvm.func @test_class_fabs_subnormal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 144 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fabs_subnormal   : test_class_fabs_subnormal_before  ⊑  test_class_fabs_subnormal_combined := by
  unfold test_class_fabs_subnormal_before test_class_fabs_subnormal_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_subnormal   : test_class_fabs_subnormal_before  ⊑  test_class_fabs_subnormal_combined := by
  unfold test_class_fabs_subnormal_before test_class_fabs_subnormal_combined
  simp_alive_peephole
  sorry
def test_class_fabs_normal_neginf_combined := [llvmfunc|
  llvm.func @test_class_fabs_normal_neginf(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fabs_normal_neginf   : test_class_fabs_normal_neginf_before  ⊑  test_class_fabs_normal_neginf_combined := by
  unfold test_class_fabs_normal_neginf_before test_class_fabs_normal_neginf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_normal_neginf   : test_class_fabs_normal_neginf_before  ⊑  test_class_fabs_normal_neginf_combined := by
  unfold test_class_fabs_normal_neginf_before test_class_fabs_normal_neginf_combined
  simp_alive_peephole
  sorry
def test_class_fabs_normal_pinf_combined := [llvmfunc|
  llvm.func @test_class_fabs_normal_pinf(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 780 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fabs_normal_pinf   : test_class_fabs_normal_pinf_before  ⊑  test_class_fabs_normal_pinf_combined := by
  unfold test_class_fabs_normal_pinf_before test_class_fabs_normal_pinf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_normal_pinf   : test_class_fabs_normal_pinf_before  ⊑  test_class_fabs_normal_pinf_combined := by
  unfold test_class_fabs_normal_pinf_before test_class_fabs_normal_pinf_combined
  simp_alive_peephole
  sorry
def test_class_fabs_neginf_posnormal_negsubnormal_poszero_combined := [llvmfunc|
  llvm.func @test_class_fabs_neginf_posnormal_negsubnormal_poszero(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 360 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fabs_neginf_posnormal_negsubnormal_poszero   : test_class_fabs_neginf_posnormal_negsubnormal_poszero_before  ⊑  test_class_fabs_neginf_posnormal_negsubnormal_poszero_combined := by
  unfold test_class_fabs_neginf_posnormal_negsubnormal_poszero_before test_class_fabs_neginf_posnormal_negsubnormal_poszero_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_neginf_posnormal_negsubnormal_poszero   : test_class_fabs_neginf_posnormal_negsubnormal_poszero_before  ⊑  test_class_fabs_neginf_posnormal_negsubnormal_poszero_combined := by
  unfold test_class_fabs_neginf_posnormal_negsubnormal_poszero_before test_class_fabs_neginf_posnormal_negsubnormal_poszero_combined
  simp_alive_peephole
  sorry
def test_class_fabs_neginf_posnormal_negsubnormal_poszero_snan_combined := [llvmfunc|
  llvm.func @test_class_fabs_neginf_posnormal_negsubnormal_poszero_snan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 361 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fabs_neginf_posnormal_negsubnormal_poszero_snan   : test_class_fabs_neginf_posnormal_negsubnormal_poszero_snan_before  ⊑  test_class_fabs_neginf_posnormal_negsubnormal_poszero_snan_combined := by
  unfold test_class_fabs_neginf_posnormal_negsubnormal_poszero_snan_before test_class_fabs_neginf_posnormal_negsubnormal_poszero_snan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_neginf_posnormal_negsubnormal_poszero_snan   : test_class_fabs_neginf_posnormal_negsubnormal_poszero_snan_before  ⊑  test_class_fabs_neginf_posnormal_negsubnormal_poszero_snan_combined := by
  unfold test_class_fabs_neginf_posnormal_negsubnormal_poszero_snan_before test_class_fabs_neginf_posnormal_negsubnormal_poszero_snan_combined
  simp_alive_peephole
  sorry
def test_class_fabs_neginf_posnormal_negsubnormal_poszero_qnan_combined := [llvmfunc|
  llvm.func @test_class_fabs_neginf_posnormal_negsubnormal_poszero_qnan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 362 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fabs_neginf_posnormal_negsubnormal_poszero_qnan   : test_class_fabs_neginf_posnormal_negsubnormal_poszero_qnan_before  ⊑  test_class_fabs_neginf_posnormal_negsubnormal_poszero_qnan_combined := by
  unfold test_class_fabs_neginf_posnormal_negsubnormal_poszero_qnan_before test_class_fabs_neginf_posnormal_negsubnormal_poszero_qnan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_neginf_posnormal_negsubnormal_poszero_qnan   : test_class_fabs_neginf_posnormal_negsubnormal_poszero_qnan_before  ⊑  test_class_fabs_neginf_posnormal_negsubnormal_poszero_qnan_combined := by
  unfold test_class_fabs_neginf_posnormal_negsubnormal_poszero_qnan_before test_class_fabs_neginf_posnormal_negsubnormal_poszero_qnan_combined
  simp_alive_peephole
  sorry
def test_class_fabs_neginf_posnormal_negsubnormal_poszero_nan_combined := [llvmfunc|
  llvm.func @test_class_fabs_neginf_posnormal_negsubnormal_poszero_nan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 363 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fabs_neginf_posnormal_negsubnormal_poszero_nan   : test_class_fabs_neginf_posnormal_negsubnormal_poszero_nan_before  ⊑  test_class_fabs_neginf_posnormal_negsubnormal_poszero_nan_combined := by
  unfold test_class_fabs_neginf_posnormal_negsubnormal_poszero_nan_before test_class_fabs_neginf_posnormal_negsubnormal_poszero_nan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_neginf_posnormal_negsubnormal_poszero_nan   : test_class_fabs_neginf_posnormal_negsubnormal_poszero_nan_before  ⊑  test_class_fabs_neginf_posnormal_negsubnormal_poszero_nan_combined := by
  unfold test_class_fabs_neginf_posnormal_negsubnormal_poszero_nan_before test_class_fabs_neginf_posnormal_negsubnormal_poszero_nan_combined
  simp_alive_peephole
  sorry
def test_class_fabs_posinf_negnormal_possubnormal_negzero_combined := [llvmfunc|
  llvm.func @test_class_fabs_posinf_negnormal_possubnormal_negzero(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 660 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fabs_posinf_negnormal_possubnormal_negzero   : test_class_fabs_posinf_negnormal_possubnormal_negzero_before  ⊑  test_class_fabs_posinf_negnormal_possubnormal_negzero_combined := by
  unfold test_class_fabs_posinf_negnormal_possubnormal_negzero_before test_class_fabs_posinf_negnormal_possubnormal_negzero_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_posinf_negnormal_possubnormal_negzero   : test_class_fabs_posinf_negnormal_possubnormal_negzero_before  ⊑  test_class_fabs_posinf_negnormal_possubnormal_negzero_combined := by
  unfold test_class_fabs_posinf_negnormal_possubnormal_negzero_before test_class_fabs_posinf_negnormal_possubnormal_negzero_combined
  simp_alive_peephole
  sorry
def test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_combined := [llvmfunc|
  llvm.func @test_class_fabs_posinf_negnormal_possubnormal_negzero_snan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 661 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fabs_posinf_negnormal_possubnormal_negzero_snan   : test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_before  ⊑  test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_combined := by
  unfold test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_before test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_posinf_negnormal_possubnormal_negzero_snan   : test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_before  ⊑  test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_combined := by
  unfold test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_before test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_combined
  simp_alive_peephole
  sorry
def test_class_fabs_posinf_negnormal_possubnormal_negzero_qnan_combined := [llvmfunc|
  llvm.func @test_class_fabs_posinf_negnormal_possubnormal_negzero_qnan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 662 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fabs_posinf_negnormal_possubnormal_negzero_qnan   : test_class_fabs_posinf_negnormal_possubnormal_negzero_qnan_before  ⊑  test_class_fabs_posinf_negnormal_possubnormal_negzero_qnan_combined := by
  unfold test_class_fabs_posinf_negnormal_possubnormal_negzero_qnan_before test_class_fabs_posinf_negnormal_possubnormal_negzero_qnan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_posinf_negnormal_possubnormal_negzero_qnan   : test_class_fabs_posinf_negnormal_possubnormal_negzero_qnan_before  ⊑  test_class_fabs_posinf_negnormal_possubnormal_negzero_qnan_combined := by
  unfold test_class_fabs_posinf_negnormal_possubnormal_negzero_qnan_before test_class_fabs_posinf_negnormal_possubnormal_negzero_qnan_combined
  simp_alive_peephole
  sorry
def test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_combined := [llvmfunc|
  llvm.func @test_class_fabs_posinf_negnormal_possubnormal_negzero_nan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 663 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fabs_posinf_negnormal_possubnormal_negzero_nan   : test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_before  ⊑  test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_combined := by
  unfold test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_before test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_posinf_negnormal_possubnormal_negzero_nan   : test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_before  ⊑  test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_combined := by
  unfold test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_before test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_combined
  simp_alive_peephole
  sorry
def test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_combined := [llvmfunc|
  llvm.func @test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 661 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp   : test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_before  ⊑  test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_combined := by
  unfold test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_before test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp   : test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_before  ⊑  test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_combined := by
  unfold test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_before test_class_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_combined
  simp_alive_peephole
  sorry
def test_class_fabs_multiple_use_fabs_combined := [llvmfunc|
  llvm.func @test_class_fabs_multiple_use_fabs(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    llvm.store %0, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr]

theorem inst_combine_test_class_fabs_multiple_use_fabs   : test_class_fabs_multiple_use_fabs_before  ⊑  test_class_fabs_multiple_use_fabs_combined := by
  unfold test_class_fabs_multiple_use_fabs_before test_class_fabs_multiple_use_fabs_combined
  simp_alive_peephole
  sorry
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 662 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fabs_multiple_use_fabs   : test_class_fabs_multiple_use_fabs_before  ⊑  test_class_fabs_multiple_use_fabs_combined := by
  unfold test_class_fabs_multiple_use_fabs_before test_class_fabs_multiple_use_fabs_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_fabs_multiple_use_fabs   : test_class_fabs_multiple_use_fabs_before  ⊑  test_class_fabs_multiple_use_fabs_combined := by
  unfold test_class_fabs_multiple_use_fabs_before test_class_fabs_multiple_use_fabs_combined
  simp_alive_peephole
  sorry
def test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_combined := [llvmfunc|
  llvm.func @test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_vector(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 663 : i32}> : (vector<2xf32>) -> vector<2xi1>]

theorem inst_combine_test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_vector   : test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_before  ⊑  test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_combined := by
  unfold test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_before test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_vector   : test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_before  ⊑  test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_combined := by
  unfold test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_before test_class_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_none_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_none(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_none   : test_class_fneg_fabs_none_before  ⊑  test_class_fneg_fabs_none_combined := by
  unfold test_class_fneg_fabs_none_before test_class_fneg_fabs_none_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_all_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_all(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_all   : test_class_fneg_fabs_all_before  ⊑  test_class_fneg_fabs_all_combined := by
  unfold test_class_fneg_fabs_all_before test_class_fneg_fabs_all_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_snan_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_snan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_fabs_snan   : test_class_fneg_fabs_snan_before  ⊑  test_class_fneg_fabs_snan_combined := by
  unfold test_class_fneg_fabs_snan_before test_class_fneg_fabs_snan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_snan   : test_class_fneg_fabs_snan_before  ⊑  test_class_fneg_fabs_snan_combined := by
  unfold test_class_fneg_fabs_snan_before test_class_fneg_fabs_snan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_qnan_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_qnan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 2 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_fabs_qnan   : test_class_fneg_fabs_qnan_before  ⊑  test_class_fneg_fabs_qnan_combined := by
  unfold test_class_fneg_fabs_qnan_before test_class_fneg_fabs_qnan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_qnan   : test_class_fneg_fabs_qnan_before  ⊑  test_class_fneg_fabs_qnan_combined := by
  unfold test_class_fneg_fabs_qnan_before test_class_fneg_fabs_qnan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_neginf_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_neginf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_neginf   : test_class_fneg_fabs_neginf_before  ⊑  test_class_fneg_fabs_neginf_combined := by
  unfold test_class_fneg_fabs_neginf_before test_class_fneg_fabs_neginf_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_negnormal_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_negnormal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_fabs_negnormal   : test_class_fneg_fabs_negnormal_before  ⊑  test_class_fneg_fabs_negnormal_combined := by
  unfold test_class_fneg_fabs_negnormal_before test_class_fneg_fabs_negnormal_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_negnormal   : test_class_fneg_fabs_negnormal_before  ⊑  test_class_fneg_fabs_negnormal_combined := by
  unfold test_class_fneg_fabs_negnormal_before test_class_fneg_fabs_negnormal_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_negsubnormal_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_negsubnormal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 144 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_fabs_negsubnormal   : test_class_fneg_fabs_negsubnormal_before  ⊑  test_class_fneg_fabs_negsubnormal_combined := by
  unfold test_class_fneg_fabs_negsubnormal_before test_class_fneg_fabs_negsubnormal_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_negsubnormal   : test_class_fneg_fabs_negsubnormal_before  ⊑  test_class_fneg_fabs_negsubnormal_combined := by
  unfold test_class_fneg_fabs_negsubnormal_before test_class_fneg_fabs_negsubnormal_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_negzero_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_negzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_negzero   : test_class_fneg_fabs_negzero_before  ⊑  test_class_fneg_fabs_negzero_combined := by
  unfold test_class_fneg_fabs_negzero_before test_class_fneg_fabs_negzero_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_poszero_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_poszero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_poszero   : test_class_fneg_fabs_poszero_before  ⊑  test_class_fneg_fabs_poszero_combined := by
  unfold test_class_fneg_fabs_poszero_before test_class_fneg_fabs_poszero_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_possubnormal_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_possubnormal(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_possubnormal   : test_class_fneg_fabs_possubnormal_before  ⊑  test_class_fneg_fabs_possubnormal_combined := by
  unfold test_class_fneg_fabs_possubnormal_before test_class_fneg_fabs_possubnormal_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_posnormal_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_posnormal(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_posnormal   : test_class_fneg_fabs_posnormal_before  ⊑  test_class_fneg_fabs_posnormal_combined := by
  unfold test_class_fneg_fabs_posnormal_before test_class_fneg_fabs_posnormal_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_posinf_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_posinf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_posinf   : test_class_fneg_fabs_posinf_before  ⊑  test_class_fneg_fabs_posinf_combined := by
  unfold test_class_fneg_fabs_posinf_before test_class_fneg_fabs_posinf_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_isnan_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_isnan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "uno" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_isnan   : test_class_fneg_fabs_isnan_before  ⊑  test_class_fneg_fabs_isnan_combined := by
  unfold test_class_fneg_fabs_isnan_before test_class_fneg_fabs_isnan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_nnan_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_nnan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ord" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_nnan   : test_class_fneg_fabs_nnan_before  ⊑  test_class_fneg_fabs_nnan_combined := by
  unfold test_class_fneg_fabs_nnan_before test_class_fneg_fabs_nnan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_normal_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_normal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_fabs_normal   : test_class_fneg_fabs_normal_before  ⊑  test_class_fneg_fabs_normal_combined := by
  unfold test_class_fneg_fabs_normal_before test_class_fneg_fabs_normal_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_normal   : test_class_fneg_fabs_normal_before  ⊑  test_class_fneg_fabs_normal_combined := by
  unfold test_class_fneg_fabs_normal_before test_class_fneg_fabs_normal_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_zero_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_zero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_zero   : test_class_fneg_fabs_zero_before  ⊑  test_class_fneg_fabs_zero_combined := by
  unfold test_class_fneg_fabs_zero_before test_class_fneg_fabs_zero_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_subnormal_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_subnormal(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 144 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_fabs_subnormal   : test_class_fneg_fabs_subnormal_before  ⊑  test_class_fneg_fabs_subnormal_combined := by
  unfold test_class_fneg_fabs_subnormal_before test_class_fneg_fabs_subnormal_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_subnormal   : test_class_fneg_fabs_subnormal_before  ⊑  test_class_fneg_fabs_subnormal_combined := by
  unfold test_class_fneg_fabs_subnormal_before test_class_fneg_fabs_subnormal_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_normal_neginf_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_normal_neginf(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 780 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_fabs_normal_neginf   : test_class_fneg_fabs_normal_neginf_before  ⊑  test_class_fneg_fabs_normal_neginf_combined := by
  unfold test_class_fneg_fabs_normal_neginf_before test_class_fneg_fabs_normal_neginf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_normal_neginf   : test_class_fneg_fabs_normal_neginf_before  ⊑  test_class_fneg_fabs_normal_neginf_combined := by
  unfold test_class_fneg_fabs_normal_neginf_before test_class_fneg_fabs_normal_neginf_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_normal_pinf_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_normal_pinf(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_fabs_normal_pinf   : test_class_fneg_fabs_normal_pinf_before  ⊑  test_class_fneg_fabs_normal_pinf_combined := by
  unfold test_class_fneg_fabs_normal_pinf_before test_class_fneg_fabs_normal_pinf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_normal_pinf   : test_class_fneg_fabs_normal_pinf_before  ⊑  test_class_fneg_fabs_normal_pinf_combined := by
  unfold test_class_fneg_fabs_normal_pinf_before test_class_fneg_fabs_normal_pinf_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 660 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero   : test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_before  ⊑  test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_combined := by
  unfold test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_before test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero   : test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_before  ⊑  test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_combined := by
  unfold test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_before test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_snan_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_snan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 661 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_snan   : test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_snan_before  ⊑  test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_snan_combined := by
  unfold test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_snan_before test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_snan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_snan   : test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_snan_before  ⊑  test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_snan_combined := by
  unfold test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_snan_before test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_snan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_qnan_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_qnan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 662 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_qnan   : test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_qnan_before  ⊑  test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_qnan_combined := by
  unfold test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_qnan_before test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_qnan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_qnan   : test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_qnan_before  ⊑  test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_qnan_combined := by
  unfold test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_qnan_before test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_qnan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_nan_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_nan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 663 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_nan   : test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_nan_before  ⊑  test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_nan_combined := by
  unfold test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_nan_before test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_nan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_nan   : test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_nan_before  ⊑  test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_nan_combined := by
  unfold test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_nan_before test_class_fneg_fabs_neginf_posnormal_negsubnormal_poszero_nan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 360 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero   : test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_before  ⊑  test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_combined := by
  unfold test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_before test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero   : test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_before  ⊑  test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_combined := by
  unfold test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_before test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 361 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan   : test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_before  ⊑  test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_combined := by
  unfold test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_before test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan   : test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_before  ⊑  test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_combined := by
  unfold test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_before test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_qnan_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_qnan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 362 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_qnan   : test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_qnan_before  ⊑  test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_qnan_combined := by
  unfold test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_qnan_before test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_qnan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_qnan   : test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_qnan_before  ⊑  test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_qnan_combined := by
  unfold test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_qnan_before test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_qnan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 363 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan   : test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_before  ⊑  test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_combined := by
  unfold test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_before test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan   : test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_before  ⊑  test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_combined := by
  unfold test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_before test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp(%arg0: f32) -> i1 attributes {passthrough = ["strictfp"]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 361 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp   : test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_before  ⊑  test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_combined := by
  unfold test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_before test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp   : test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_before  ⊑  test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_combined := by
  unfold test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_before test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_snan_strictfp_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_multiple_use_fabs_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_multiple_use_fabs(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    llvm.store %1, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr]

theorem inst_combine_test_class_fneg_fabs_multiple_use_fabs   : test_class_fneg_fabs_multiple_use_fabs_before  ⊑  test_class_fneg_fabs_multiple_use_fabs_combined := by
  unfold test_class_fneg_fabs_multiple_use_fabs_before test_class_fneg_fabs_multiple_use_fabs_combined
  simp_alive_peephole
  sorry
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 362 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_fneg_fabs_multiple_use_fabs   : test_class_fneg_fabs_multiple_use_fabs_before  ⊑  test_class_fneg_fabs_multiple_use_fabs_combined := by
  unfold test_class_fneg_fabs_multiple_use_fabs_before test_class_fneg_fabs_multiple_use_fabs_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i1
  }]

theorem inst_combine_test_class_fneg_fabs_multiple_use_fabs   : test_class_fneg_fabs_multiple_use_fabs_before  ⊑  test_class_fneg_fabs_multiple_use_fabs_combined := by
  unfold test_class_fneg_fabs_multiple_use_fabs_before test_class_fneg_fabs_multiple_use_fabs_combined
  simp_alive_peephole
  sorry
def test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_combined := [llvmfunc|
  llvm.func @test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_vector(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 663 : i32}> : (vector<2xf32>) -> vector<2xi1>]

theorem inst_combine_test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_vector   : test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_before  ⊑  test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_combined := by
  unfold test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_before test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_vector   : test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_before  ⊑  test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_combined := by
  unfold test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_before test_class_fneg_fabs_posinf_negnormal_possubnormal_negzero_nan_vector_combined
  simp_alive_peephole
  sorry
def test_class_is_zero_nozero_src_combined := [llvmfunc|
  llvm.func @test_class_is_zero_nozero_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_zero_nozero_src   : test_class_is_zero_nozero_src_before  ⊑  test_class_is_zero_nozero_src_combined := by
  unfold test_class_is_zero_nozero_src_before test_class_is_zero_nozero_src_combined
  simp_alive_peephole
  sorry
def test_class_is_zero_noposzero_src_combined := [llvmfunc|
  llvm.func @test_class_is_zero_noposzero_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_zero_noposzero_src   : test_class_is_zero_noposzero_src_before  ⊑  test_class_is_zero_noposzero_src_combined := by
  unfold test_class_is_zero_noposzero_src_before test_class_is_zero_noposzero_src_combined
  simp_alive_peephole
  sorry
def test_class_is_zero_nonegzero_src_combined := [llvmfunc|
  llvm.func @test_class_is_zero_nonegzero_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_zero_nonegzero_src   : test_class_is_zero_nonegzero_src_before  ⊑  test_class_is_zero_nonegzero_src_combined := by
  unfold test_class_is_zero_nonegzero_src_before test_class_is_zero_nonegzero_src_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_nozero_src_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_nozero_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_nozero_src   : test_class_is_pzero_nozero_src_before  ⊑  test_class_is_pzero_nozero_src_combined := by
  unfold test_class_is_pzero_nozero_src_before test_class_is_pzero_nozero_src_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_nopzero_src_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_nopzero_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_nopzero_src   : test_class_is_pzero_nopzero_src_before  ⊑  test_class_is_pzero_nopzero_src_combined := by
  unfold test_class_is_pzero_nopzero_src_before test_class_is_pzero_nopzero_src_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_nonzero_src_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_nonzero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 64 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_nonzero_src   : test_class_is_pzero_nonzero_src_before  ⊑  test_class_is_pzero_nonzero_src_combined := by
  unfold test_class_is_pzero_nonzero_src_before test_class_is_pzero_nonzero_src_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_nonzero_src   : test_class_is_pzero_nonzero_src_before  ⊑  test_class_is_pzero_nonzero_src_combined := by
  unfold test_class_is_pzero_nonzero_src_before test_class_is_pzero_nonzero_src_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_nozero_src_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_nozero_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_nozero_src   : test_class_is_nzero_nozero_src_before  ⊑  test_class_is_nzero_nozero_src_combined := by
  unfold test_class_is_nzero_nozero_src_before test_class_is_nzero_nozero_src_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_nopzero_src_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_nopzero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 32 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nzero_nopzero_src   : test_class_is_nzero_nopzero_src_before  ⊑  test_class_is_nzero_nopzero_src_combined := by
  unfold test_class_is_nzero_nopzero_src_before test_class_is_nzero_nopzero_src_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_nopzero_src   : test_class_is_nzero_nopzero_src_before  ⊑  test_class_is_nzero_nopzero_src_combined := by
  unfold test_class_is_nzero_nopzero_src_before test_class_is_nzero_nopzero_src_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_nonzero_src_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_nonzero_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_nonzero_src   : test_class_is_nzero_nonzero_src_before  ⊑  test_class_is_nzero_nonzero_src_combined := by
  unfold test_class_is_nzero_nonzero_src_before test_class_is_nzero_nonzero_src_combined
  simp_alive_peephole
  sorry
def test_class_is_normal_or_zero_nozero_src_combined := [llvmfunc|
  llvm.func @test_class_is_normal_or_zero_nozero_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_normal_or_zero_nozero_src   : test_class_is_normal_or_zero_nozero_src_before  ⊑  test_class_is_normal_or_zero_nozero_src_combined := by
  unfold test_class_is_normal_or_zero_nozero_src_before test_class_is_normal_or_zero_nozero_src_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_normal_or_zero_nozero_src   : test_class_is_normal_or_zero_nozero_src_before  ⊑  test_class_is_normal_or_zero_nozero_src_combined := by
  unfold test_class_is_normal_or_zero_nozero_src_before test_class_is_normal_or_zero_nozero_src_combined
  simp_alive_peephole
  sorry
def test_class_is_inf_or_nan_nozero_src_combined := [llvmfunc|
  llvm.func @test_class_is_inf_or_nan_nozero_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_class_is_inf_or_nan_nozero_src   : test_class_is_inf_or_nan_nozero_src_before  ⊑  test_class_is_inf_or_nan_nozero_src_combined := by
  unfold test_class_is_inf_or_nan_nozero_src_before test_class_is_inf_or_nan_nozero_src_combined
  simp_alive_peephole
  sorry
def test_class_is_inf_or_nan_noinf_src_combined := [llvmfunc|
  llvm.func @test_class_is_inf_or_nan_noinf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_class_is_inf_or_nan_noinf_src   : test_class_is_inf_or_nan_noinf_src_before  ⊑  test_class_is_inf_or_nan_noinf_src_combined := by
  unfold test_class_is_inf_or_nan_noinf_src_before test_class_is_inf_or_nan_noinf_src_combined
  simp_alive_peephole
  sorry
def test_class_is_inf_or_nan_nonan_src_combined := [llvmfunc|
  llvm.func @test_class_is_inf_or_nan_nonan_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_class_is_inf_or_nan_nonan_src   : test_class_is_inf_or_nan_nonan_src_before  ⊑  test_class_is_inf_or_nan_nonan_src_combined := by
  unfold test_class_is_inf_or_nan_nonan_src_before test_class_is_inf_or_nan_nonan_src_combined
  simp_alive_peephole
  sorry
def test_class_is_normal_or_subnormal_noinf_src_combined := [llvmfunc|
  llvm.func @test_class_is_normal_or_subnormal_noinf_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 408 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_normal_or_subnormal_noinf_src   : test_class_is_normal_or_subnormal_noinf_src_before  ⊑  test_class_is_normal_or_subnormal_noinf_src_combined := by
  unfold test_class_is_normal_or_subnormal_noinf_src_before test_class_is_normal_or_subnormal_noinf_src_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_normal_or_subnormal_noinf_src   : test_class_is_normal_or_subnormal_noinf_src_before  ⊑  test_class_is_normal_or_subnormal_noinf_src_combined := by
  unfold test_class_is_normal_or_subnormal_noinf_src_before test_class_is_normal_or_subnormal_noinf_src_combined
  simp_alive_peephole
  sorry
def test_class_is_neginf_or_nopinf_src_combined := [llvmfunc|
  llvm.func @test_class_is_neginf_or_nopinf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_neginf_or_nopinf_src   : test_class_is_neginf_or_nopinf_src_before  ⊑  test_class_is_neginf_or_nopinf_src_combined := by
  unfold test_class_is_neginf_or_nopinf_src_before test_class_is_neginf_or_nopinf_src_combined
  simp_alive_peephole
  sorry
def test_class_is_neginf_noninf_src_combined := [llvmfunc|
  llvm.func @test_class_is_neginf_noninf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_neginf_noninf_src   : test_class_is_neginf_noninf_src_before  ⊑  test_class_is_neginf_noninf_src_combined := by
  unfold test_class_is_neginf_noninf_src_before test_class_is_neginf_noninf_src_combined
  simp_alive_peephole
  sorry
def test_class_is_neginf_noinf_src_combined := [llvmfunc|
  llvm.func @test_class_is_neginf_noinf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_neginf_noinf_src   : test_class_is_neginf_noinf_src_before  ⊑  test_class_is_neginf_noinf_src_combined := by
  unfold test_class_is_neginf_noinf_src_before test_class_is_neginf_noinf_src_combined
  simp_alive_peephole
  sorry
def test_class_is_posinf_noninf_src_combined := [llvmfunc|
  llvm.func @test_class_is_posinf_noninf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_posinf_noninf_src   : test_class_is_posinf_noninf_src_before  ⊑  test_class_is_posinf_noninf_src_combined := by
  unfold test_class_is_posinf_noninf_src_before test_class_is_posinf_noninf_src_combined
  simp_alive_peephole
  sorry
def test_class_is_posinf_nopinf_src_combined := [llvmfunc|
  llvm.func @test_class_is_posinf_nopinf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_posinf_nopinf_src   : test_class_is_posinf_nopinf_src_before  ⊑  test_class_is_posinf_nopinf_src_combined := by
  unfold test_class_is_posinf_nopinf_src_before test_class_is_posinf_nopinf_src_combined
  simp_alive_peephole
  sorry
def test_class_is_posinf_noinf_src_combined := [llvmfunc|
  llvm.func @test_class_is_posinf_noinf_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_posinf_noinf_src   : test_class_is_posinf_noinf_src_before  ⊑  test_class_is_posinf_noinf_src_combined := by
  unfold test_class_is_posinf_noinf_src_before test_class_is_posinf_noinf_src_combined
  simp_alive_peephole
  sorry
def test_class_is_subnormal_nosub_src_combined := [llvmfunc|
  llvm.func @test_class_is_subnormal_nosub_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_subnormal_nosub_src   : test_class_is_subnormal_nosub_src_before  ⊑  test_class_is_subnormal_nosub_src_combined := by
  unfold test_class_is_subnormal_nosub_src_before test_class_is_subnormal_nosub_src_combined
  simp_alive_peephole
  sorry
def test_class_is_subnormal_nonsub_src_combined := [llvmfunc|
  llvm.func @test_class_is_subnormal_nonsub_src(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 128 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_subnormal_nonsub_src   : test_class_is_subnormal_nonsub_src_before  ⊑  test_class_is_subnormal_nonsub_src_combined := by
  unfold test_class_is_subnormal_nonsub_src_before test_class_is_subnormal_nonsub_src_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_subnormal_nonsub_src   : test_class_is_subnormal_nonsub_src_before  ⊑  test_class_is_subnormal_nonsub_src_combined := by
  unfold test_class_is_subnormal_nonsub_src_before test_class_is_subnormal_nonsub_src_combined
  simp_alive_peephole
  sorry
def test_class_is_not_subnormal_nosub_src_combined := [llvmfunc|
  llvm.func @test_class_is_not_subnormal_nosub_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_subnormal_nosub_src   : test_class_is_not_subnormal_nosub_src_before  ⊑  test_class_is_not_subnormal_nosub_src_combined := by
  unfold test_class_is_not_subnormal_nosub_src_before test_class_is_not_subnormal_nosub_src_combined
  simp_alive_peephole
  sorry
def test_class_is_not_negsubnormal_nosub_src_combined := [llvmfunc|
  llvm.func @test_class_is_not_negsubnormal_nosub_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_negsubnormal_nosub_src   : test_class_is_not_negsubnormal_nosub_src_before  ⊑  test_class_is_not_negsubnormal_nosub_src_combined := by
  unfold test_class_is_not_negsubnormal_nosub_src_before test_class_is_not_negsubnormal_nosub_src_combined
  simp_alive_peephole
  sorry
def test_class_is_not_negsubnormal_nonegsub_src_combined := [llvmfunc|
  llvm.func @test_class_is_not_negsubnormal_nonegsub_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_negsubnormal_nonegsub_src   : test_class_is_not_negsubnormal_nonegsub_src_before  ⊑  test_class_is_not_negsubnormal_nonegsub_src_combined := by
  unfold test_class_is_not_negsubnormal_nonegsub_src_before test_class_is_not_negsubnormal_nonegsub_src_combined
  simp_alive_peephole
  sorry
def test_class_is_nnormal_nonorm_src_combined := [llvmfunc|
  llvm.func @test_class_is_nnormal_nonorm_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nnormal_nonorm_src   : test_class_is_nnormal_nonorm_src_before  ⊑  test_class_is_nnormal_nonorm_src_combined := by
  unfold test_class_is_nnormal_nonorm_src_before test_class_is_nnormal_nonorm_src_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nnormal_nonorm_src_combined := [llvmfunc|
  llvm.func @test_class_is_not_nnormal_nonorm_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nnormal_nonorm_src   : test_class_is_not_nnormal_nonorm_src_before  ⊑  test_class_is_not_nnormal_nonorm_src_combined := by
  unfold test_class_is_not_nnormal_nonorm_src_before test_class_is_not_nnormal_nonorm_src_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nnormal_onlynorm_src_combined := [llvmfunc|
  llvm.func @test_class_is_not_nnormal_onlynorm_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nnormal_onlynorm_src   : test_class_is_not_nnormal_onlynorm_src_before  ⊑  test_class_is_not_nnormal_onlynorm_src_combined := by
  unfold test_class_is_not_nnormal_onlynorm_src_before test_class_is_not_nnormal_onlynorm_src_combined
  simp_alive_peephole
  sorry
def test_class_is_nnormal_onlynorm_src_combined := [llvmfunc|
  llvm.func @test_class_is_nnormal_onlynorm_src(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nnormal_onlynorm_src   : test_class_is_nnormal_onlynorm_src_before  ⊑  test_class_is_nnormal_onlynorm_src_combined := by
  unfold test_class_is_nnormal_onlynorm_src_before test_class_is_nnormal_onlynorm_src_combined
  simp_alive_peephole
  sorry
def test_class_is_normal_assume_normal_combined := [llvmfunc|
  llvm.func @test_class_is_normal_assume_normal(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_normal_assume_normal   : test_class_is_normal_assume_normal_before  ⊑  test_class_is_normal_assume_normal_combined := by
  unfold test_class_is_normal_assume_normal_before test_class_is_normal_assume_normal_combined
  simp_alive_peephole
  sorry
    "llvm.intr.assume"(%1) : (i1) -> ()
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_normal_assume_normal   : test_class_is_normal_assume_normal_before  ⊑  test_class_is_normal_assume_normal_combined := by
  unfold test_class_is_normal_assume_normal_before test_class_is_normal_assume_normal_combined
  simp_alive_peephole
  sorry
def test_class_is_normal_assume_not_normal_combined := [llvmfunc|
  llvm.func @test_class_is_normal_assume_not_normal(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 264 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_normal_assume_not_normal   : test_class_is_normal_assume_not_normal_before  ⊑  test_class_is_normal_assume_not_normal_combined := by
  unfold test_class_is_normal_assume_not_normal_before test_class_is_normal_assume_not_normal_combined
  simp_alive_peephole
  sorry
    "llvm.intr.assume"(%1) : (i1) -> ()
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_normal_assume_not_normal   : test_class_is_normal_assume_not_normal_before  ⊑  test_class_is_normal_assume_not_normal_combined := by
  unfold test_class_is_normal_assume_not_normal_before test_class_is_normal_assume_not_normal_combined
  simp_alive_peephole
  sorry
def test_class_is_nan_assume_ord_combined := [llvmfunc|
  llvm.func @test_class_is_nan_assume_ord(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.fcmp "ord" %arg0, %0 : f32
    "llvm.intr.assume"(%2) : (i1) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_nan_assume_ord   : test_class_is_nan_assume_ord_before  ⊑  test_class_is_nan_assume_ord_combined := by
  unfold test_class_is_nan_assume_ord_before test_class_is_nan_assume_ord_combined
  simp_alive_peephole
  sorry
def test_class_is_nan_assume_uno_combined := [llvmfunc|
  llvm.func @test_class_is_nan_assume_uno(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.fcmp "uno" %arg0, %0 : f32
    "llvm.intr.assume"(%2) : (i1) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_nan_assume_uno   : test_class_is_nan_assume_uno_before  ⊑  test_class_is_nan_assume_uno_combined := by
  unfold test_class_is_nan_assume_uno_before test_class_is_nan_assume_uno_combined
  simp_alive_peephole
  sorry
def test_class_is_nan_assume_not_eq_pinf_combined := [llvmfunc|
  llvm.func @test_class_is_nan_assume_not_eq_pinf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.fcmp "oeq" %arg0, %0 : f32
    "llvm.intr.assume"(%2) : (i1) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_nan_assume_not_eq_pinf   : test_class_is_nan_assume_not_eq_pinf_before  ⊑  test_class_is_nan_assume_not_eq_pinf_combined := by
  unfold test_class_is_nan_assume_not_eq_pinf_before test_class_is_nan_assume_not_eq_pinf_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_psub_pnorm_pinf__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 960 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf__ieee   : test_class_is_pzero_psub_pnorm_pinf__ieee_before  ⊑  test_class_is_pzero_psub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf__ieee_before test_class_is_pzero_psub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf__ieee   : test_class_is_pzero_psub_pnorm_pinf__ieee_before  ⊑  test_class_is_pzero_psub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf__ieee_before test_class_is_pzero_psub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_psub_pnorm_pinf_snan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 961 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf_snan__ieee   : test_class_is_pzero_psub_pnorm_pinf_snan__ieee_before  ⊑  test_class_is_pzero_psub_pnorm_pinf_snan__ieee_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf_snan__ieee_before test_class_is_pzero_psub_pnorm_pinf_snan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf_snan__ieee   : test_class_is_pzero_psub_pnorm_pinf_snan__ieee_before  ⊑  test_class_is_pzero_psub_pnorm_pinf_snan__ieee_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf_snan__ieee_before test_class_is_pzero_psub_pnorm_pinf_snan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_psub_pnorm_pinf_qnan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 962 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf_qnan__ieee   : test_class_is_pzero_psub_pnorm_pinf_qnan__ieee_before  ⊑  test_class_is_pzero_psub_pnorm_pinf_qnan__ieee_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf_qnan__ieee_before test_class_is_pzero_psub_pnorm_pinf_qnan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf_qnan__ieee   : test_class_is_pzero_psub_pnorm_pinf_qnan__ieee_before  ⊑  test_class_is_pzero_psub_pnorm_pinf_qnan__ieee_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf_qnan__ieee_before test_class_is_pzero_psub_pnorm_pinf_qnan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_psub_pnorm_pinf_nan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 963 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf_nan__ieee   : test_class_is_pzero_psub_pnorm_pinf_nan__ieee_before  ⊑  test_class_is_pzero_psub_pnorm_pinf_nan__ieee_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf_nan__ieee_before test_class_is_pzero_psub_pnorm_pinf_nan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf_nan__ieee   : test_class_is_pzero_psub_pnorm_pinf_nan__ieee_before  ⊑  test_class_is_pzero_psub_pnorm_pinf_nan__ieee_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf_nan__ieee_before test_class_is_pzero_psub_pnorm_pinf_nan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_psub_pnorm_pinf__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ogt" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_psub_pnorm_pinf__ieee   : test_class_is_psub_pnorm_pinf__ieee_before  ⊑  test_class_is_psub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_psub_pnorm_pinf__ieee_before test_class_is_psub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_psub_pnorm_pinf_snan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 897 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_psub_pnorm_pinf_snan__ieee   : test_class_is_psub_pnorm_pinf_snan__ieee_before  ⊑  test_class_is_psub_pnorm_pinf_snan__ieee_combined := by
  unfold test_class_is_psub_pnorm_pinf_snan__ieee_before test_class_is_psub_pnorm_pinf_snan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_psub_pnorm_pinf_snan__ieee   : test_class_is_psub_pnorm_pinf_snan__ieee_before  ⊑  test_class_is_psub_pnorm_pinf_snan__ieee_combined := by
  unfold test_class_is_psub_pnorm_pinf_snan__ieee_before test_class_is_psub_pnorm_pinf_snan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_psub_pnorm_pinf_qnan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 898 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_psub_pnorm_pinf_qnan__ieee   : test_class_is_psub_pnorm_pinf_qnan__ieee_before  ⊑  test_class_is_psub_pnorm_pinf_qnan__ieee_combined := by
  unfold test_class_is_psub_pnorm_pinf_qnan__ieee_before test_class_is_psub_pnorm_pinf_qnan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_psub_pnorm_pinf_qnan__ieee   : test_class_is_psub_pnorm_pinf_qnan__ieee_before  ⊑  test_class_is_psub_pnorm_pinf_qnan__ieee_combined := by
  unfold test_class_is_psub_pnorm_pinf_qnan__ieee_before test_class_is_psub_pnorm_pinf_qnan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_psub_pnorm_pinf_nan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ugt" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_psub_pnorm_pinf_nan__ieee   : test_class_is_psub_pnorm_pinf_nan__ieee_before  ⊑  test_class_is_psub_pnorm_pinf_nan__ieee_combined := by
  unfold test_class_is_psub_pnorm_pinf_nan__ieee_before test_class_is_psub_pnorm_pinf_nan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_pnorm_pinf__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 768 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pnorm_pinf__ieee   : test_class_is_pnorm_pinf__ieee_before  ⊑  test_class_is_pnorm_pinf__ieee_combined := by
  unfold test_class_is_pnorm_pinf__ieee_before test_class_is_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pnorm_pinf__ieee   : test_class_is_pnorm_pinf__ieee_before  ⊑  test_class_is_pnorm_pinf__ieee_combined := by
  unfold test_class_is_pnorm_pinf__ieee_before test_class_is_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_pnorm_pinf__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 704 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_pnorm_pinf__ieee   : test_class_is_pzero_pnorm_pinf__ieee_before  ⊑  test_class_is_pzero_pnorm_pinf__ieee_combined := by
  unfold test_class_is_pzero_pnorm_pinf__ieee_before test_class_is_pzero_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_pnorm_pinf__ieee   : test_class_is_pzero_pnorm_pinf__ieee_before  ⊑  test_class_is_pzero_pnorm_pinf__ieee_combined := by
  unfold test_class_is_pzero_pnorm_pinf__ieee_before test_class_is_pzero_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_pnorm_pinf_nan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 707 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_pnorm_pinf_nan__ieee   : test_class_is_pzero_pnorm_pinf_nan__ieee_before  ⊑  test_class_is_pzero_pnorm_pinf_nan__ieee_combined := by
  unfold test_class_is_pzero_pnorm_pinf_nan__ieee_before test_class_is_pzero_pnorm_pinf_nan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_pnorm_pinf_nan__ieee   : test_class_is_pzero_pnorm_pinf_nan__ieee_before  ⊑  test_class_is_pzero_pnorm_pinf_nan__ieee_combined := by
  unfold test_class_is_pzero_pnorm_pinf_nan__ieee_before test_class_is_pzero_pnorm_pinf_nan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_pzero_psub_pnorm_pinf__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oge" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf__ieee   : test_class_is_nzero_pzero_psub_pnorm_pinf__ieee_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf__ieee_before test_class_is_nzero_pzero_psub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 993 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf_snan__ieee   : test_class_is_nzero_pzero_psub_pnorm_pinf_snan__ieee_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf_snan__ieee_before test_class_is_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf_snan__ieee   : test_class_is_nzero_pzero_psub_pnorm_pinf_snan__ieee_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf_snan__ieee_before test_class_is_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 994 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__ieee   : test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__ieee   : test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_pzero_psub_pnorm_pinf_nan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "uge" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf_nan__ieee   : test_class_is_nzero_pzero_psub_pnorm_pinf_nan__ieee_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf_nan__ieee_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf_nan__ieee_before test_class_is_nzero_pzero_psub_pnorm_pinf_nan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1017 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__ieee   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__ieee_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__ieee_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__ieee   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__ieee_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__ieee_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1009 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1010 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1011 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_psub_pnorm_pinf__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 928 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nzero_psub_pnorm_pinf__ieee   : test_class_is_nzero_psub_pnorm_pinf__ieee_before  ⊑  test_class_is_nzero_psub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_nzero_psub_pnorm_pinf__ieee_before test_class_is_nzero_psub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_psub_pnorm_pinf__ieee   : test_class_is_nzero_psub_pnorm_pinf__ieee_before  ⊑  test_class_is_nzero_psub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_nzero_psub_pnorm_pinf__ieee_before test_class_is_nzero_psub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_nsub_pnorm_pinf__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_nsub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 816 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nzero_nsub_pnorm_pinf__ieee   : test_class_is_nzero_nsub_pnorm_pinf__ieee_before  ⊑  test_class_is_nzero_nsub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_nzero_nsub_pnorm_pinf__ieee_before test_class_is_nzero_nsub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_nsub_pnorm_pinf__ieee   : test_class_is_nzero_nsub_pnorm_pinf__ieee_before  ⊑  test_class_is_nzero_nsub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_nzero_nsub_pnorm_pinf__ieee_before test_class_is_nzero_nsub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pzero_psub_pnorm_pinf__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 63 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf__ieee   : test_class_is_not_pzero_psub_pnorm_pinf__ieee_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf__ieee_before test_class_is_not_pzero_psub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf__ieee   : test_class_is_not_pzero_psub_pnorm_pinf__ieee_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf__ieee_before test_class_is_not_pzero_psub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pzero_psub_pnorm_pinf_snan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 62 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf_snan__ieee   : test_class_is_not_pzero_psub_pnorm_pinf_snan__ieee_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf_snan__ieee_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf_snan__ieee_before test_class_is_not_pzero_psub_pnorm_pinf_snan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf_snan__ieee   : test_class_is_not_pzero_psub_pnorm_pinf_snan__ieee_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf_snan__ieee_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf_snan__ieee_before test_class_is_not_pzero_psub_pnorm_pinf_snan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pzero_psub_pnorm_pinf_qnan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 61 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf_qnan__ieee   : test_class_is_not_pzero_psub_pnorm_pinf_qnan__ieee_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf_qnan__ieee_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf_qnan__ieee_before test_class_is_not_pzero_psub_pnorm_pinf_qnan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf_qnan__ieee   : test_class_is_not_pzero_psub_pnorm_pinf_qnan__ieee_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf_qnan__ieee_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf_qnan__ieee_before test_class_is_not_pzero_psub_pnorm_pinf_qnan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pzero_psub_pnorm_pinf_nan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 960 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf_nan__ieee   : test_class_is_not_pzero_psub_pnorm_pinf_nan__ieee_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf_nan__ieee_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf_nan__ieee_before test_class_is_not_pzero_psub_pnorm_pinf_nan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf_nan__ieee   : test_class_is_not_pzero_psub_pnorm_pinf_nan__ieee_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf_nan__ieee_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf_nan__ieee_before test_class_is_not_pzero_psub_pnorm_pinf_nan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_psub_pnorm_pinf__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ule" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf__ieee   : test_class_is_not_psub_pnorm_pinf__ieee_before  ⊑  test_class_is_not_psub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_not_psub_pnorm_pinf__ieee_before test_class_is_not_psub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_psub_pnorm_pinf_snan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 126 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf_snan__ieee   : test_class_is_not_psub_pnorm_pinf_snan__ieee_before  ⊑  test_class_is_not_psub_pnorm_pinf_snan__ieee_combined := by
  unfold test_class_is_not_psub_pnorm_pinf_snan__ieee_before test_class_is_not_psub_pnorm_pinf_snan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf_snan__ieee   : test_class_is_not_psub_pnorm_pinf_snan__ieee_before  ⊑  test_class_is_not_psub_pnorm_pinf_snan__ieee_combined := by
  unfold test_class_is_not_psub_pnorm_pinf_snan__ieee_before test_class_is_not_psub_pnorm_pinf_snan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_psub_pnorm_pinf_qnan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 125 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf_qnan__ieee   : test_class_is_not_psub_pnorm_pinf_qnan__ieee_before  ⊑  test_class_is_not_psub_pnorm_pinf_qnan__ieee_combined := by
  unfold test_class_is_not_psub_pnorm_pinf_qnan__ieee_before test_class_is_not_psub_pnorm_pinf_qnan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf_qnan__ieee   : test_class_is_not_psub_pnorm_pinf_qnan__ieee_before  ⊑  test_class_is_not_psub_pnorm_pinf_qnan__ieee_combined := by
  unfold test_class_is_not_psub_pnorm_pinf_qnan__ieee_before test_class_is_not_psub_pnorm_pinf_qnan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_psub_pnorm_pinf_nan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ole" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf_nan__ieee   : test_class_is_not_psub_pnorm_pinf_nan__ieee_before  ⊑  test_class_is_not_psub_pnorm_pinf_nan__ieee_combined := by
  unfold test_class_is_not_psub_pnorm_pinf_nan__ieee_before test_class_is_not_psub_pnorm_pinf_nan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pnorm_pinf__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 255 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pnorm_pinf__ieee   : test_class_is_not_pnorm_pinf__ieee_before  ⊑  test_class_is_not_pnorm_pinf__ieee_combined := by
  unfold test_class_is_not_pnorm_pinf__ieee_before test_class_is_not_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pnorm_pinf__ieee   : test_class_is_not_pnorm_pinf__ieee_before  ⊑  test_class_is_not_pnorm_pinf__ieee_combined := by
  unfold test_class_is_not_pnorm_pinf__ieee_before test_class_is_not_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pzero_pnorm_pinf__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_pzero_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 319 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pzero_pnorm_pinf__ieee   : test_class_is_not_pzero_pnorm_pinf__ieee_before  ⊑  test_class_is_not_pzero_pnorm_pinf__ieee_combined := by
  unfold test_class_is_not_pzero_pnorm_pinf__ieee_before test_class_is_not_pzero_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pzero_pnorm_pinf__ieee   : test_class_is_not_pzero_pnorm_pinf__ieee_before  ⊑  test_class_is_not_pzero_pnorm_pinf__ieee_combined := by
  unfold test_class_is_not_pzero_pnorm_pinf__ieee_before test_class_is_not_pzero_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pzero_pnorm_pinf_nan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_pzero_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 316 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pzero_pnorm_pinf_nan__ieee   : test_class_is_not_pzero_pnorm_pinf_nan__ieee_before  ⊑  test_class_is_not_pzero_pnorm_pinf_nan__ieee_combined := by
  unfold test_class_is_not_pzero_pnorm_pinf_nan__ieee_before test_class_is_not_pzero_pnorm_pinf_nan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pzero_pnorm_pinf_nan__ieee   : test_class_is_not_pzero_pnorm_pinf_nan__ieee_before  ⊑  test_class_is_not_pzero_pnorm_pinf_nan__ieee_combined := by
  unfold test_class_is_not_pzero_pnorm_pinf_nan__ieee_before test_class_is_not_pzero_pnorm_pinf_nan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nzero_pzero_psub_pnorm_pinf__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 22 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf__ieee   : test_class_is_not_nzero_pzero_psub_pnorm_pinf__ieee_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf__ieee_before test_class_is_not_nzero_pzero_psub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf__ieee   : test_class_is_not_nzero_pzero_psub_pnorm_pinf__ieee_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf__ieee_before test_class_is_not_nzero_pzero_psub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 30 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__ieee   : test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__ieee_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__ieee_before test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__ieee   : test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__ieee_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__ieee_before test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 29 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__ieee   : test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__ieee   : test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "olt" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__ieee   : test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__ieee_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__ieee_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__ieee_before test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 6 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__ieee   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__ieee_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__ieee_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__ieee   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__ieee_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__ieee_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 14 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 13 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 12 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nzero_psub_pnorm_pinf__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_nzero_psub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 95 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nzero_psub_pnorm_pinf__ieee   : test_class_is_not_nzero_psub_pnorm_pinf__ieee_before  ⊑  test_class_is_not_nzero_psub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_not_nzero_psub_pnorm_pinf__ieee_before test_class_is_not_nzero_psub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nzero_psub_pnorm_pinf__ieee   : test_class_is_not_nzero_psub_pnorm_pinf__ieee_before  ⊑  test_class_is_not_nzero_psub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_not_nzero_psub_pnorm_pinf__ieee_before test_class_is_not_nzero_psub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nzero_nsub_pnorm_pinf__ieee_combined := [llvmfunc|
  llvm.func @test_class_is_not_nzero_nsub_pnorm_pinf__ieee(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,ieee"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 207 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nzero_nsub_pnorm_pinf__ieee   : test_class_is_not_nzero_nsub_pnorm_pinf__ieee_before  ⊑  test_class_is_not_nzero_nsub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_not_nzero_nsub_pnorm_pinf__ieee_before test_class_is_not_nzero_nsub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nzero_nsub_pnorm_pinf__ieee   : test_class_is_not_nzero_nsub_pnorm_pinf__ieee_before  ⊑  test_class_is_not_nzero_nsub_pnorm_pinf__ieee_combined := by
  unfold test_class_is_not_nzero_nsub_pnorm_pinf__ieee_before test_class_is_not_nzero_nsub_pnorm_pinf__ieee_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_psub_pnorm_pinf__daz_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 960 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf__daz   : test_class_is_pzero_psub_pnorm_pinf__daz_before  ⊑  test_class_is_pzero_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf__daz_before test_class_is_pzero_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf__daz   : test_class_is_pzero_psub_pnorm_pinf__daz_before  ⊑  test_class_is_pzero_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf__daz_before test_class_is_pzero_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_psub_pnorm_pinf_snan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 961 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf_snan__daz   : test_class_is_pzero_psub_pnorm_pinf_snan__daz_before  ⊑  test_class_is_pzero_psub_pnorm_pinf_snan__daz_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf_snan__daz_before test_class_is_pzero_psub_pnorm_pinf_snan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf_snan__daz   : test_class_is_pzero_psub_pnorm_pinf_snan__daz_before  ⊑  test_class_is_pzero_psub_pnorm_pinf_snan__daz_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf_snan__daz_before test_class_is_pzero_psub_pnorm_pinf_snan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_psub_pnorm_pinf_qnan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 962 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf_qnan__daz   : test_class_is_pzero_psub_pnorm_pinf_qnan__daz_before  ⊑  test_class_is_pzero_psub_pnorm_pinf_qnan__daz_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf_qnan__daz_before test_class_is_pzero_psub_pnorm_pinf_qnan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf_qnan__daz   : test_class_is_pzero_psub_pnorm_pinf_qnan__daz_before  ⊑  test_class_is_pzero_psub_pnorm_pinf_qnan__daz_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf_qnan__daz_before test_class_is_pzero_psub_pnorm_pinf_qnan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_psub_pnorm_pinf_nan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 963 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf_nan__daz   : test_class_is_pzero_psub_pnorm_pinf_nan__daz_before  ⊑  test_class_is_pzero_psub_pnorm_pinf_nan__daz_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf_nan__daz_before test_class_is_pzero_psub_pnorm_pinf_nan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf_nan__daz   : test_class_is_pzero_psub_pnorm_pinf_nan__daz_before  ⊑  test_class_is_pzero_psub_pnorm_pinf_nan__daz_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf_nan__daz_before test_class_is_pzero_psub_pnorm_pinf_nan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_psub_pnorm_pinf__daz_combined := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 896 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_psub_pnorm_pinf__daz   : test_class_is_psub_pnorm_pinf__daz_before  ⊑  test_class_is_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_psub_pnorm_pinf__daz_before test_class_is_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_psub_pnorm_pinf__daz   : test_class_is_psub_pnorm_pinf__daz_before  ⊑  test_class_is_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_psub_pnorm_pinf__daz_before test_class_is_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_psub_pnorm_pinf_snan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 897 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_psub_pnorm_pinf_snan__daz   : test_class_is_psub_pnorm_pinf_snan__daz_before  ⊑  test_class_is_psub_pnorm_pinf_snan__daz_combined := by
  unfold test_class_is_psub_pnorm_pinf_snan__daz_before test_class_is_psub_pnorm_pinf_snan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_psub_pnorm_pinf_snan__daz   : test_class_is_psub_pnorm_pinf_snan__daz_before  ⊑  test_class_is_psub_pnorm_pinf_snan__daz_combined := by
  unfold test_class_is_psub_pnorm_pinf_snan__daz_before test_class_is_psub_pnorm_pinf_snan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_psub_pnorm_pinf_qnan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 898 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_psub_pnorm_pinf_qnan__daz   : test_class_is_psub_pnorm_pinf_qnan__daz_before  ⊑  test_class_is_psub_pnorm_pinf_qnan__daz_combined := by
  unfold test_class_is_psub_pnorm_pinf_qnan__daz_before test_class_is_psub_pnorm_pinf_qnan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_psub_pnorm_pinf_qnan__daz   : test_class_is_psub_pnorm_pinf_qnan__daz_before  ⊑  test_class_is_psub_pnorm_pinf_qnan__daz_combined := by
  unfold test_class_is_psub_pnorm_pinf_qnan__daz_before test_class_is_psub_pnorm_pinf_qnan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_psub_pnorm_pinf_nan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 899 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_psub_pnorm_pinf_nan__daz   : test_class_is_psub_pnorm_pinf_nan__daz_before  ⊑  test_class_is_psub_pnorm_pinf_nan__daz_combined := by
  unfold test_class_is_psub_pnorm_pinf_nan__daz_before test_class_is_psub_pnorm_pinf_nan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_psub_pnorm_pinf_nan__daz   : test_class_is_psub_pnorm_pinf_nan__daz_before  ⊑  test_class_is_psub_pnorm_pinf_nan__daz_combined := by
  unfold test_class_is_psub_pnorm_pinf_nan__daz_before test_class_is_psub_pnorm_pinf_nan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_pnorm_pinf__daz_combined := [llvmfunc|
  llvm.func @test_class_is_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ogt" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_pnorm_pinf__daz   : test_class_is_pnorm_pinf__daz_before  ⊑  test_class_is_pnorm_pinf__daz_combined := by
  unfold test_class_is_pnorm_pinf__daz_before test_class_is_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_pnorm_pinf__daz_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 704 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_pnorm_pinf__daz   : test_class_is_pzero_pnorm_pinf__daz_before  ⊑  test_class_is_pzero_pnorm_pinf__daz_combined := by
  unfold test_class_is_pzero_pnorm_pinf__daz_before test_class_is_pzero_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_pnorm_pinf__daz   : test_class_is_pzero_pnorm_pinf__daz_before  ⊑  test_class_is_pzero_pnorm_pinf__daz_combined := by
  unfold test_class_is_pzero_pnorm_pinf__daz_before test_class_is_pzero_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_pnorm_pinf_nan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 707 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_pnorm_pinf_nan__daz   : test_class_is_pzero_pnorm_pinf_nan__daz_before  ⊑  test_class_is_pzero_pnorm_pinf_nan__daz_combined := by
  unfold test_class_is_pzero_pnorm_pinf_nan__daz_before test_class_is_pzero_pnorm_pinf_nan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_pnorm_pinf_nan__daz   : test_class_is_pzero_pnorm_pinf_nan__daz_before  ⊑  test_class_is_pzero_pnorm_pinf_nan__daz_combined := by
  unfold test_class_is_pzero_pnorm_pinf_nan__daz_before test_class_is_pzero_pnorm_pinf_nan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_pzero_psub_pnorm_pinf__daz_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 992 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf__daz   : test_class_is_nzero_pzero_psub_pnorm_pinf__daz_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf__daz_before test_class_is_nzero_pzero_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf__daz   : test_class_is_nzero_pzero_psub_pnorm_pinf__daz_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf__daz_before test_class_is_nzero_pzero_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_pzero_psub_pnorm_pinf_snan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 993 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf_snan__daz   : test_class_is_nzero_pzero_psub_pnorm_pinf_snan__daz_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf_snan__daz_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf_snan__daz_before test_class_is_nzero_pzero_psub_pnorm_pinf_snan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf_snan__daz   : test_class_is_nzero_pzero_psub_pnorm_pinf_snan__daz_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf_snan__daz_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf_snan__daz_before test_class_is_nzero_pzero_psub_pnorm_pinf_snan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 994 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__daz   : test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__daz_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__daz_before test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__daz   : test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__daz_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__daz_before test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_pzero_psub_pnorm_pinf_nan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 995 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf_nan__daz   : test_class_is_nzero_pzero_psub_pnorm_pinf_nan__daz_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf_nan__daz_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf_nan__daz_before test_class_is_nzero_pzero_psub_pnorm_pinf_nan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf_nan__daz   : test_class_is_nzero_pzero_psub_pnorm_pinf_nan__daz_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf_nan__daz_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf_nan__daz_before test_class_is_nzero_pzero_psub_pnorm_pinf_nan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__daz_combined := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1017 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__daz   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__daz_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__daz_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__daz   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__daz_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__daz_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1009 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1010 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "uge" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_psub_pnorm_pinf__daz_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 928 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nzero_psub_pnorm_pinf__daz   : test_class_is_nzero_psub_pnorm_pinf__daz_before  ⊑  test_class_is_nzero_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_nzero_psub_pnorm_pinf__daz_before test_class_is_nzero_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_psub_pnorm_pinf__daz   : test_class_is_nzero_psub_pnorm_pinf__daz_before  ⊑  test_class_is_nzero_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_nzero_psub_pnorm_pinf__daz_before test_class_is_nzero_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_nsub_pnorm_pinf__daz_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_nsub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 816 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nzero_nsub_pnorm_pinf__daz   : test_class_is_nzero_nsub_pnorm_pinf__daz_before  ⊑  test_class_is_nzero_nsub_pnorm_pinf__daz_combined := by
  unfold test_class_is_nzero_nsub_pnorm_pinf__daz_before test_class_is_nzero_nsub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_nsub_pnorm_pinf__daz   : test_class_is_nzero_nsub_pnorm_pinf__daz_before  ⊑  test_class_is_nzero_nsub_pnorm_pinf__daz_combined := by
  unfold test_class_is_nzero_nsub_pnorm_pinf__daz_before test_class_is_nzero_nsub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pzero_psub_pnorm_pinf__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 63 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf__daz   : test_class_is_not_pzero_psub_pnorm_pinf__daz_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf__daz_before test_class_is_not_pzero_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf__daz   : test_class_is_not_pzero_psub_pnorm_pinf__daz_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf__daz_before test_class_is_not_pzero_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pzero_psub_pnorm_pinf_snan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 62 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf_snan__daz   : test_class_is_not_pzero_psub_pnorm_pinf_snan__daz_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf_snan__daz_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf_snan__daz_before test_class_is_not_pzero_psub_pnorm_pinf_snan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf_snan__daz   : test_class_is_not_pzero_psub_pnorm_pinf_snan__daz_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf_snan__daz_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf_snan__daz_before test_class_is_not_pzero_psub_pnorm_pinf_snan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pzero_psub_pnorm_pinf_qnan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 61 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf_qnan__daz   : test_class_is_not_pzero_psub_pnorm_pinf_qnan__daz_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf_qnan__daz_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf_qnan__daz_before test_class_is_not_pzero_psub_pnorm_pinf_qnan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf_qnan__daz   : test_class_is_not_pzero_psub_pnorm_pinf_qnan__daz_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf_qnan__daz_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf_qnan__daz_before test_class_is_not_pzero_psub_pnorm_pinf_qnan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pzero_psub_pnorm_pinf_nan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 960 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf_nan__daz   : test_class_is_not_pzero_psub_pnorm_pinf_nan__daz_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf_nan__daz_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf_nan__daz_before test_class_is_not_pzero_psub_pnorm_pinf_nan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf_nan__daz   : test_class_is_not_pzero_psub_pnorm_pinf_nan__daz_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf_nan__daz_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf_nan__daz_before test_class_is_not_pzero_psub_pnorm_pinf_nan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_psub_pnorm_pinf__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 127 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf__daz   : test_class_is_not_psub_pnorm_pinf__daz_before  ⊑  test_class_is_not_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_not_psub_pnorm_pinf__daz_before test_class_is_not_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf__daz   : test_class_is_not_psub_pnorm_pinf__daz_before  ⊑  test_class_is_not_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_not_psub_pnorm_pinf__daz_before test_class_is_not_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_psub_pnorm_pinf_snan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 126 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf_snan__daz   : test_class_is_not_psub_pnorm_pinf_snan__daz_before  ⊑  test_class_is_not_psub_pnorm_pinf_snan__daz_combined := by
  unfold test_class_is_not_psub_pnorm_pinf_snan__daz_before test_class_is_not_psub_pnorm_pinf_snan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf_snan__daz   : test_class_is_not_psub_pnorm_pinf_snan__daz_before  ⊑  test_class_is_not_psub_pnorm_pinf_snan__daz_combined := by
  unfold test_class_is_not_psub_pnorm_pinf_snan__daz_before test_class_is_not_psub_pnorm_pinf_snan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_psub_pnorm_pinf_qnan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 125 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf_qnan__daz   : test_class_is_not_psub_pnorm_pinf_qnan__daz_before  ⊑  test_class_is_not_psub_pnorm_pinf_qnan__daz_combined := by
  unfold test_class_is_not_psub_pnorm_pinf_qnan__daz_before test_class_is_not_psub_pnorm_pinf_qnan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf_qnan__daz   : test_class_is_not_psub_pnorm_pinf_qnan__daz_before  ⊑  test_class_is_not_psub_pnorm_pinf_qnan__daz_combined := by
  unfold test_class_is_not_psub_pnorm_pinf_qnan__daz_before test_class_is_not_psub_pnorm_pinf_qnan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_psub_pnorm_pinf_nan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 124 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf_nan__daz   : test_class_is_not_psub_pnorm_pinf_nan__daz_before  ⊑  test_class_is_not_psub_pnorm_pinf_nan__daz_combined := by
  unfold test_class_is_not_psub_pnorm_pinf_nan__daz_before test_class_is_not_psub_pnorm_pinf_nan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf_nan__daz   : test_class_is_not_psub_pnorm_pinf_nan__daz_before  ⊑  test_class_is_not_psub_pnorm_pinf_nan__daz_combined := by
  unfold test_class_is_not_psub_pnorm_pinf_nan__daz_before test_class_is_not_psub_pnorm_pinf_nan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pnorm_pinf__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ule" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_not_pnorm_pinf__daz   : test_class_is_not_pnorm_pinf__daz_before  ⊑  test_class_is_not_pnorm_pinf__daz_combined := by
  unfold test_class_is_not_pnorm_pinf__daz_before test_class_is_not_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pzero_pnorm_pinf__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_pzero_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 319 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pzero_pnorm_pinf__daz   : test_class_is_not_pzero_pnorm_pinf__daz_before  ⊑  test_class_is_not_pzero_pnorm_pinf__daz_combined := by
  unfold test_class_is_not_pzero_pnorm_pinf__daz_before test_class_is_not_pzero_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pzero_pnorm_pinf__daz   : test_class_is_not_pzero_pnorm_pinf__daz_before  ⊑  test_class_is_not_pzero_pnorm_pinf__daz_combined := by
  unfold test_class_is_not_pzero_pnorm_pinf__daz_before test_class_is_not_pzero_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pzero_pnorm_pinf_nan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_pzero_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 316 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pzero_pnorm_pinf_nan__daz   : test_class_is_not_pzero_pnorm_pinf_nan__daz_before  ⊑  test_class_is_not_pzero_pnorm_pinf_nan__daz_combined := by
  unfold test_class_is_not_pzero_pnorm_pinf_nan__daz_before test_class_is_not_pzero_pnorm_pinf_nan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pzero_pnorm_pinf_nan__daz   : test_class_is_not_pzero_pnorm_pinf_nan__daz_before  ⊑  test_class_is_not_pzero_pnorm_pinf_nan__daz_combined := by
  unfold test_class_is_not_pzero_pnorm_pinf_nan__daz_before test_class_is_not_pzero_pnorm_pinf_nan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nzero_pzero_psub_pnorm_pinf__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 22 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf__daz   : test_class_is_not_nzero_pzero_psub_pnorm_pinf__daz_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf__daz_before test_class_is_not_nzero_pzero_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf__daz   : test_class_is_not_nzero_pzero_psub_pnorm_pinf__daz_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf__daz_before test_class_is_not_nzero_pzero_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 30 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__daz   : test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__daz_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__daz_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__daz_before test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__daz   : test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__daz_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__daz_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__daz_before test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 29 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__daz   : test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__daz_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__daz_before test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__daz   : test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__daz_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__daz_before test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 28 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__daz   : test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__daz_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__daz_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__daz_before test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__daz   : test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__daz_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__daz_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__daz_before test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 6 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__daz   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__daz_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__daz_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__daz   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__daz_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__daz_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 14 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 13 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "olt" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nzero_psub_pnorm_pinf__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nzero_psub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 95 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nzero_psub_pnorm_pinf__daz   : test_class_is_not_nzero_psub_pnorm_pinf__daz_before  ⊑  test_class_is_not_nzero_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_not_nzero_psub_pnorm_pinf__daz_before test_class_is_not_nzero_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nzero_psub_pnorm_pinf__daz   : test_class_is_not_nzero_psub_pnorm_pinf__daz_before  ⊑  test_class_is_not_nzero_psub_pnorm_pinf__daz_combined := by
  unfold test_class_is_not_nzero_psub_pnorm_pinf__daz_before test_class_is_not_nzero_psub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nzero_nsub_pnorm_pinf__daz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nzero_nsub_pnorm_pinf__daz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,preserve-sign"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 207 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nzero_nsub_pnorm_pinf__daz   : test_class_is_not_nzero_nsub_pnorm_pinf__daz_before  ⊑  test_class_is_not_nzero_nsub_pnorm_pinf__daz_combined := by
  unfold test_class_is_not_nzero_nsub_pnorm_pinf__daz_before test_class_is_not_nzero_nsub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nzero_nsub_pnorm_pinf__daz   : test_class_is_not_nzero_nsub_pnorm_pinf__daz_before  ⊑  test_class_is_not_nzero_nsub_pnorm_pinf__daz_combined := by
  unfold test_class_is_not_nzero_nsub_pnorm_pinf__daz_before test_class_is_not_nzero_nsub_pnorm_pinf__daz_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_psub_pnorm_pinf__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 960 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf__dapz   : test_class_is_pzero_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_pzero_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf__dapz_before test_class_is_pzero_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf__dapz   : test_class_is_pzero_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_pzero_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf__dapz_before test_class_is_pzero_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_psub_pnorm_pinf_snan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 961 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf_snan__dapz   : test_class_is_pzero_psub_pnorm_pinf_snan__dapz_before  ⊑  test_class_is_pzero_psub_pnorm_pinf_snan__dapz_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf_snan__dapz_before test_class_is_pzero_psub_pnorm_pinf_snan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf_snan__dapz   : test_class_is_pzero_psub_pnorm_pinf_snan__dapz_before  ⊑  test_class_is_pzero_psub_pnorm_pinf_snan__dapz_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf_snan__dapz_before test_class_is_pzero_psub_pnorm_pinf_snan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_psub_pnorm_pinf_qnan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 962 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf_qnan__dapz   : test_class_is_pzero_psub_pnorm_pinf_qnan__dapz_before  ⊑  test_class_is_pzero_psub_pnorm_pinf_qnan__dapz_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf_qnan__dapz_before test_class_is_pzero_psub_pnorm_pinf_qnan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf_qnan__dapz   : test_class_is_pzero_psub_pnorm_pinf_qnan__dapz_before  ⊑  test_class_is_pzero_psub_pnorm_pinf_qnan__dapz_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf_qnan__dapz_before test_class_is_pzero_psub_pnorm_pinf_qnan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_psub_pnorm_pinf_nan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 963 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf_nan__dapz   : test_class_is_pzero_psub_pnorm_pinf_nan__dapz_before  ⊑  test_class_is_pzero_psub_pnorm_pinf_nan__dapz_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf_nan__dapz_before test_class_is_pzero_psub_pnorm_pinf_nan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_psub_pnorm_pinf_nan__dapz   : test_class_is_pzero_psub_pnorm_pinf_nan__dapz_before  ⊑  test_class_is_pzero_psub_pnorm_pinf_nan__dapz_combined := by
  unfold test_class_is_pzero_psub_pnorm_pinf_nan__dapz_before test_class_is_pzero_psub_pnorm_pinf_nan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_psub_pnorm_pinf__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 896 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_psub_pnorm_pinf__dapz   : test_class_is_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_psub_pnorm_pinf__dapz_before test_class_is_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_psub_pnorm_pinf__dapz   : test_class_is_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_psub_pnorm_pinf__dapz_before test_class_is_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_psub_pnorm_pinf_snan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 897 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_psub_pnorm_pinf_snan__dapz   : test_class_is_psub_pnorm_pinf_snan__dapz_before  ⊑  test_class_is_psub_pnorm_pinf_snan__dapz_combined := by
  unfold test_class_is_psub_pnorm_pinf_snan__dapz_before test_class_is_psub_pnorm_pinf_snan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_psub_pnorm_pinf_snan__dapz   : test_class_is_psub_pnorm_pinf_snan__dapz_before  ⊑  test_class_is_psub_pnorm_pinf_snan__dapz_combined := by
  unfold test_class_is_psub_pnorm_pinf_snan__dapz_before test_class_is_psub_pnorm_pinf_snan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_psub_pnorm_pinf_qnan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 898 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_psub_pnorm_pinf_qnan__dapz   : test_class_is_psub_pnorm_pinf_qnan__dapz_before  ⊑  test_class_is_psub_pnorm_pinf_qnan__dapz_combined := by
  unfold test_class_is_psub_pnorm_pinf_qnan__dapz_before test_class_is_psub_pnorm_pinf_qnan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_psub_pnorm_pinf_qnan__dapz   : test_class_is_psub_pnorm_pinf_qnan__dapz_before  ⊑  test_class_is_psub_pnorm_pinf_qnan__dapz_combined := by
  unfold test_class_is_psub_pnorm_pinf_qnan__dapz_before test_class_is_psub_pnorm_pinf_qnan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_psub_pnorm_pinf_nan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 899 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_psub_pnorm_pinf_nan__dapz   : test_class_is_psub_pnorm_pinf_nan__dapz_before  ⊑  test_class_is_psub_pnorm_pinf_nan__dapz_combined := by
  unfold test_class_is_psub_pnorm_pinf_nan__dapz_before test_class_is_psub_pnorm_pinf_nan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_psub_pnorm_pinf_nan__dapz   : test_class_is_psub_pnorm_pinf_nan__dapz_before  ⊑  test_class_is_psub_pnorm_pinf_nan__dapz_combined := by
  unfold test_class_is_psub_pnorm_pinf_nan__dapz_before test_class_is_psub_pnorm_pinf_nan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_pnorm_pinf__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ogt" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_pnorm_pinf__dapz   : test_class_is_pnorm_pinf__dapz_before  ⊑  test_class_is_pnorm_pinf__dapz_combined := by
  unfold test_class_is_pnorm_pinf__dapz_before test_class_is_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_pnorm_pinf__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 704 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_pnorm_pinf__dapz   : test_class_is_pzero_pnorm_pinf__dapz_before  ⊑  test_class_is_pzero_pnorm_pinf__dapz_combined := by
  unfold test_class_is_pzero_pnorm_pinf__dapz_before test_class_is_pzero_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_pnorm_pinf__dapz   : test_class_is_pzero_pnorm_pinf__dapz_before  ⊑  test_class_is_pzero_pnorm_pinf__dapz_combined := by
  unfold test_class_is_pzero_pnorm_pinf__dapz_before test_class_is_pzero_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_pzero_pnorm_pinf_nan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_pzero_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 707 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_pzero_pnorm_pinf_nan__dapz   : test_class_is_pzero_pnorm_pinf_nan__dapz_before  ⊑  test_class_is_pzero_pnorm_pinf_nan__dapz_combined := by
  unfold test_class_is_pzero_pnorm_pinf_nan__dapz_before test_class_is_pzero_pnorm_pinf_nan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_pzero_pnorm_pinf_nan__dapz   : test_class_is_pzero_pnorm_pinf_nan__dapz_before  ⊑  test_class_is_pzero_pnorm_pinf_nan__dapz_combined := by
  unfold test_class_is_pzero_pnorm_pinf_nan__dapz_before test_class_is_pzero_pnorm_pinf_nan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_pzero_psub_pnorm_pinf__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 992 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf__dapz   : test_class_is_nzero_pzero_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf__dapz_before test_class_is_nzero_pzero_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf__dapz   : test_class_is_nzero_pzero_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf__dapz_before test_class_is_nzero_pzero_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 993 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf_snan__dapz   : test_class_is_nzero_pzero_psub_pnorm_pinf_snan__dapz_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf_snan__dapz_before test_class_is_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf_snan__dapz   : test_class_is_nzero_pzero_psub_pnorm_pinf_snan__dapz_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf_snan__dapz_before test_class_is_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 994 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__dapz   : test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__dapz   : test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before test_class_is_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_pzero_psub_pnorm_pinf_nan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_pzero_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 995 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf_nan__dapz   : test_class_is_nzero_pzero_psub_pnorm_pinf_nan__dapz_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf_nan__dapz_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf_nan__dapz_before test_class_is_nzero_pzero_psub_pnorm_pinf_nan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_pzero_psub_pnorm_pinf_nan__dapz   : test_class_is_nzero_pzero_psub_pnorm_pinf_nan__dapz_before  ⊑  test_class_is_nzero_pzero_psub_pnorm_pinf_nan__dapz_combined := by
  unfold test_class_is_nzero_pzero_psub_pnorm_pinf_nan__dapz_before test_class_is_nzero_pzero_psub_pnorm_pinf_nan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1017 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__dapz   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__dapz_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__dapz   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__dapz_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1009 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 1010 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "uge" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz   : test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz_before  ⊑  test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz_combined := by
  unfold test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz_before test_class_is_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_psub_pnorm_pinf__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 928 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nzero_psub_pnorm_pinf__dapz   : test_class_is_nzero_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_nzero_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_nzero_psub_pnorm_pinf__dapz_before test_class_is_nzero_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_psub_pnorm_pinf__dapz   : test_class_is_nzero_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_nzero_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_nzero_psub_pnorm_pinf__dapz_before test_class_is_nzero_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_nzero_nsub_pnorm_pinf__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_nzero_nsub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 816 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_nzero_nsub_pnorm_pinf__dapz   : test_class_is_nzero_nsub_pnorm_pinf__dapz_before  ⊑  test_class_is_nzero_nsub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_nzero_nsub_pnorm_pinf__dapz_before test_class_is_nzero_nsub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_nzero_nsub_pnorm_pinf__dapz   : test_class_is_nzero_nsub_pnorm_pinf__dapz_before  ⊑  test_class_is_nzero_nsub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_nzero_nsub_pnorm_pinf__dapz_before test_class_is_nzero_nsub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pzero_psub_pnorm_pinf__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 63 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf__dapz   : test_class_is_not_pzero_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf__dapz_before test_class_is_not_pzero_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf__dapz   : test_class_is_not_pzero_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf__dapz_before test_class_is_not_pzero_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pzero_psub_pnorm_pinf_snan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 62 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf_snan__dapz   : test_class_is_not_pzero_psub_pnorm_pinf_snan__dapz_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf_snan__dapz_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf_snan__dapz_before test_class_is_not_pzero_psub_pnorm_pinf_snan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf_snan__dapz   : test_class_is_not_pzero_psub_pnorm_pinf_snan__dapz_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf_snan__dapz_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf_snan__dapz_before test_class_is_not_pzero_psub_pnorm_pinf_snan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pzero_psub_pnorm_pinf_qnan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 61 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf_qnan__dapz   : test_class_is_not_pzero_psub_pnorm_pinf_qnan__dapz_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf_qnan__dapz_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf_qnan__dapz_before test_class_is_not_pzero_psub_pnorm_pinf_qnan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf_qnan__dapz   : test_class_is_not_pzero_psub_pnorm_pinf_qnan__dapz_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf_qnan__dapz_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf_qnan__dapz_before test_class_is_not_pzero_psub_pnorm_pinf_qnan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pzero_psub_pnorm_pinf_nan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_pzero_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 960 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf_nan__dapz   : test_class_is_not_pzero_psub_pnorm_pinf_nan__dapz_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf_nan__dapz_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf_nan__dapz_before test_class_is_not_pzero_psub_pnorm_pinf_nan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pzero_psub_pnorm_pinf_nan__dapz   : test_class_is_not_pzero_psub_pnorm_pinf_nan__dapz_before  ⊑  test_class_is_not_pzero_psub_pnorm_pinf_nan__dapz_combined := by
  unfold test_class_is_not_pzero_psub_pnorm_pinf_nan__dapz_before test_class_is_not_pzero_psub_pnorm_pinf_nan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_psub_pnorm_pinf__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 127 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf__dapz   : test_class_is_not_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_not_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_not_psub_pnorm_pinf__dapz_before test_class_is_not_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf__dapz   : test_class_is_not_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_not_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_not_psub_pnorm_pinf__dapz_before test_class_is_not_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_psub_pnorm_pinf_snan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 126 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf_snan__dapz   : test_class_is_not_psub_pnorm_pinf_snan__dapz_before  ⊑  test_class_is_not_psub_pnorm_pinf_snan__dapz_combined := by
  unfold test_class_is_not_psub_pnorm_pinf_snan__dapz_before test_class_is_not_psub_pnorm_pinf_snan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf_snan__dapz   : test_class_is_not_psub_pnorm_pinf_snan__dapz_before  ⊑  test_class_is_not_psub_pnorm_pinf_snan__dapz_combined := by
  unfold test_class_is_not_psub_pnorm_pinf_snan__dapz_before test_class_is_not_psub_pnorm_pinf_snan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_psub_pnorm_pinf_qnan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 125 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf_qnan__dapz   : test_class_is_not_psub_pnorm_pinf_qnan__dapz_before  ⊑  test_class_is_not_psub_pnorm_pinf_qnan__dapz_combined := by
  unfold test_class_is_not_psub_pnorm_pinf_qnan__dapz_before test_class_is_not_psub_pnorm_pinf_qnan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf_qnan__dapz   : test_class_is_not_psub_pnorm_pinf_qnan__dapz_before  ⊑  test_class_is_not_psub_pnorm_pinf_qnan__dapz_combined := by
  unfold test_class_is_not_psub_pnorm_pinf_qnan__dapz_before test_class_is_not_psub_pnorm_pinf_qnan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_psub_pnorm_pinf_nan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 124 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf_nan__dapz   : test_class_is_not_psub_pnorm_pinf_nan__dapz_before  ⊑  test_class_is_not_psub_pnorm_pinf_nan__dapz_combined := by
  unfold test_class_is_not_psub_pnorm_pinf_nan__dapz_before test_class_is_not_psub_pnorm_pinf_nan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf_nan__dapz   : test_class_is_not_psub_pnorm_pinf_nan__dapz_before  ⊑  test_class_is_not_psub_pnorm_pinf_nan__dapz_combined := by
  unfold test_class_is_not_psub_pnorm_pinf_nan__dapz_before test_class_is_not_psub_pnorm_pinf_nan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pnorm_pinf__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ule" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_not_pnorm_pinf__dapz   : test_class_is_not_pnorm_pinf__dapz_before  ⊑  test_class_is_not_pnorm_pinf__dapz_combined := by
  unfold test_class_is_not_pnorm_pinf__dapz_before test_class_is_not_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pzero_pnorm_pinf__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_pzero_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 319 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pzero_pnorm_pinf__dapz   : test_class_is_not_pzero_pnorm_pinf__dapz_before  ⊑  test_class_is_not_pzero_pnorm_pinf__dapz_combined := by
  unfold test_class_is_not_pzero_pnorm_pinf__dapz_before test_class_is_not_pzero_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pzero_pnorm_pinf__dapz   : test_class_is_not_pzero_pnorm_pinf__dapz_before  ⊑  test_class_is_not_pzero_pnorm_pinf__dapz_combined := by
  unfold test_class_is_not_pzero_pnorm_pinf__dapz_before test_class_is_not_pzero_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_pzero_pnorm_pinf_nan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_pzero_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 316 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_pzero_pnorm_pinf_nan__dapz   : test_class_is_not_pzero_pnorm_pinf_nan__dapz_before  ⊑  test_class_is_not_pzero_pnorm_pinf_nan__dapz_combined := by
  unfold test_class_is_not_pzero_pnorm_pinf_nan__dapz_before test_class_is_not_pzero_pnorm_pinf_nan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_pzero_pnorm_pinf_nan__dapz   : test_class_is_not_pzero_pnorm_pinf_nan__dapz_before  ⊑  test_class_is_not_pzero_pnorm_pinf_nan__dapz_combined := by
  unfold test_class_is_not_pzero_pnorm_pinf_nan__dapz_before test_class_is_not_pzero_pnorm_pinf_nan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nzero_pzero_psub_pnorm_pinf__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 22 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf__dapz   : test_class_is_not_nzero_pzero_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf__dapz_before test_class_is_not_nzero_pzero_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf__dapz   : test_class_is_not_nzero_pzero_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf__dapz_before test_class_is_not_nzero_pzero_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 30 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__dapz   : test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__dapz_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__dapz_before test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__dapz   : test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__dapz_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__dapz_before test_class_is_not_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 29 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__dapz   : test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__dapz   : test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before test_class_is_not_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 28 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__dapz   : test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__dapz_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__dapz_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__dapz_before test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__dapz   : test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__dapz_before  ⊑  test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__dapz_combined := by
  unfold test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__dapz_before test_class_is_not_nzero_pzero_psub_pnorm_pinf_nan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 6 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__dapz   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__dapz_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__dapz   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__dapz_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 14 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_snan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 13 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_qnan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "olt" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz   : test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz_before  ⊑  test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz_combined := by
  unfold test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz_before test_class_is_not_nsub_nzero_pzero_psub_pnorm_pinf_nan__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nzero_psub_pnorm_pinf__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nzero_psub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 95 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nzero_psub_pnorm_pinf__dapz   : test_class_is_not_nzero_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_not_nzero_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_not_nzero_psub_pnorm_pinf__dapz_before test_class_is_not_nzero_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nzero_psub_pnorm_pinf__dapz   : test_class_is_not_nzero_psub_pnorm_pinf__dapz_before  ⊑  test_class_is_not_nzero_psub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_not_nzero_psub_pnorm_pinf__dapz_before test_class_is_not_nzero_psub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_not_nzero_nsub_pnorm_pinf__dapz_combined := [llvmfunc|
  llvm.func @test_class_is_not_nzero_nsub_pnorm_pinf__dapz(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,positive-zero"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 207 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_nzero_nsub_pnorm_pinf__dapz   : test_class_is_not_nzero_nsub_pnorm_pinf__dapz_before  ⊑  test_class_is_not_nzero_nsub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_not_nzero_nsub_pnorm_pinf__dapz_before test_class_is_not_nzero_nsub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_nzero_nsub_pnorm_pinf__dapz   : test_class_is_not_nzero_nsub_pnorm_pinf__dapz_before  ⊑  test_class_is_not_nzero_nsub_pnorm_pinf__dapz_combined := by
  unfold test_class_is_not_nzero_nsub_pnorm_pinf__dapz_before test_class_is_not_nzero_nsub_pnorm_pinf__dapz_combined
  simp_alive_peephole
  sorry
def test_class_is_psub_pnorm_pinf__dynamic_combined := [llvmfunc|
  llvm.func @test_class_is_psub_pnorm_pinf__dynamic(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,dynamic"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 896 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_psub_pnorm_pinf__dynamic   : test_class_is_psub_pnorm_pinf__dynamic_before  ⊑  test_class_is_psub_pnorm_pinf__dynamic_combined := by
  unfold test_class_is_psub_pnorm_pinf__dynamic_before test_class_is_psub_pnorm_pinf__dynamic_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_psub_pnorm_pinf__dynamic   : test_class_is_psub_pnorm_pinf__dynamic_before  ⊑  test_class_is_psub_pnorm_pinf__dynamic_combined := by
  unfold test_class_is_psub_pnorm_pinf__dynamic_before test_class_is_psub_pnorm_pinf__dynamic_combined
  simp_alive_peephole
  sorry
def test_class_is_not_psub_pnorm_pinf__dynamic_combined := [llvmfunc|
  llvm.func @test_class_is_not_psub_pnorm_pinf__dynamic(%arg0: f32) -> i1 attributes {passthrough = [["denormal-fp-math", "dynamic,dynamic"]]} {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 127 : i32}> : (f32) -> i1]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf__dynamic   : test_class_is_not_psub_pnorm_pinf__dynamic_before  ⊑  test_class_is_not_psub_pnorm_pinf__dynamic_combined := by
  unfold test_class_is_not_psub_pnorm_pinf__dynamic_before test_class_is_not_psub_pnorm_pinf__dynamic_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_class_is_not_psub_pnorm_pinf__dynamic   : test_class_is_not_psub_pnorm_pinf__dynamic_before  ⊑  test_class_is_not_psub_pnorm_pinf__dynamic_combined := by
  unfold test_class_is_not_psub_pnorm_pinf__dynamic_before test_class_is_not_psub_pnorm_pinf__dynamic_combined
  simp_alive_peephole
  sorry
