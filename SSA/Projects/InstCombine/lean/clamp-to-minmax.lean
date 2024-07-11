import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  clamp-to-minmax
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def clamp_float_fast_ordered_strict_maxmin_before := [llvmfunc|
  llvm.func @clamp_float_fast_ordered_strict_maxmin(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "olt" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_fast_ordered_nonstrict_maxmin_before := [llvmfunc|
  llvm.func @clamp_float_fast_ordered_nonstrict_maxmin(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ole" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_fast_ordered_strict_minmax_before := [llvmfunc|
  llvm.func @clamp_float_fast_ordered_strict_minmax(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ogt" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_fast_ordered_nonstrict_minmax_before := [llvmfunc|
  llvm.func @clamp_float_fast_ordered_nonstrict_minmax(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "oge" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_fast_unordered_strict_maxmin_before := [llvmfunc|
  llvm.func @clamp_float_fast_unordered_strict_maxmin(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ult" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_fast_unordered_nonstrict_maxmin_before := [llvmfunc|
  llvm.func @clamp_float_fast_unordered_nonstrict_maxmin(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ule" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_fast_unordered_strict_minmax_before := [llvmfunc|
  llvm.func @clamp_float_fast_unordered_strict_minmax(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ugt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ugt" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_fast_unordered_nonstrict_minmax_before := [llvmfunc|
  llvm.func @clamp_float_fast_unordered_nonstrict_minmax(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ugt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "uge" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_test_1_before := [llvmfunc|
  llvm.func @clamp_test_1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ugt" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %5 = llvm.select %4, %3, %1 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_negative_wrong_const_before := [llvmfunc|
  llvm.func @clamp_negative_wrong_const(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(5.120000e+02 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ugt" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %5 = llvm.select %4, %3, %1 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_negative_same_op_before := [llvmfunc|
  llvm.func @clamp_negative_same_op(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ult" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %5 = llvm.select %4, %3, %1 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_with_zero1_before := [llvmfunc|
  llvm.func @clamp_float_with_zero1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ole" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_with_zero2_before := [llvmfunc|
  llvm.func @clamp_float_with_zero2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "olt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_ordered_strict_maxmin1_before := [llvmfunc|
  llvm.func @clamp_float_ordered_strict_maxmin1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "olt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_ordered_strict_maxmin2_before := [llvmfunc|
  llvm.func @clamp_float_ordered_strict_maxmin2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "olt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_ordered_nonstrict_maxmin1_before := [llvmfunc|
  llvm.func @clamp_float_ordered_nonstrict_maxmin1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ole" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_ordered_nonstrict_maxmin2_before := [llvmfunc|
  llvm.func @clamp_float_ordered_nonstrict_maxmin2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ole" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_ordered_strict_minmax1_before := [llvmfunc|
  llvm.func @clamp_float_ordered_strict_minmax1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ogt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_ordered_strict_minmax2_before := [llvmfunc|
  llvm.func @clamp_float_ordered_strict_minmax2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ugt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ogt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_ordered_nonstrict_minmax1_before := [llvmfunc|
  llvm.func @clamp_float_ordered_nonstrict_minmax1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "oge" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_ordered_nonstrict_minmax2_before := [llvmfunc|
  llvm.func @clamp_float_ordered_nonstrict_minmax2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ugt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "oge" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_unordered_strict_maxmin1_before := [llvmfunc|
  llvm.func @clamp_float_unordered_strict_maxmin1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ult" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_unordered_strict_maxmin2_before := [llvmfunc|
  llvm.func @clamp_float_unordered_strict_maxmin2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ult" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_unordered_nonstrict_maxmin1_before := [llvmfunc|
  llvm.func @clamp_float_unordered_nonstrict_maxmin1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ule" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_unordered_nonstrict_maxmin2_before := [llvmfunc|
  llvm.func @clamp_float_unordered_nonstrict_maxmin2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ule" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_unordered_strict_minmax1_before := [llvmfunc|
  llvm.func @clamp_float_unordered_strict_minmax1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ugt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_unordered_strict_minmax2_before := [llvmfunc|
  llvm.func @clamp_float_unordered_strict_minmax2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ugt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ugt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_unordered_nonstrict_minmax1_before := [llvmfunc|
  llvm.func @clamp_float_unordered_nonstrict_minmax1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "uge" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def clamp_float_unordered_nonstrict_minmax2_before := [llvmfunc|
  llvm.func @clamp_float_unordered_nonstrict_minmax2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ugt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "uge" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

def ui32_clamp_and_cast_to_float_before := [llvmfunc|
  llvm.func @ui32_clamp_and_cast_to_float(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %3 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %4 = llvm.uitofp %arg0 : i32 to f32
    %5 = llvm.icmp "ugt" %arg0, %0 : i32
    %6 = llvm.icmp "ult" %arg0, %1 : i32
    %7 = llvm.select %5, %2, %4 : i1, f32
    %8 = llvm.select %6, %3, %7 : i1, f32
    llvm.return %8 : f32
  }]

def ui64_clamp_and_cast_to_float_before := [llvmfunc|
  llvm.func @ui64_clamp_and_cast_to_float(%arg0: i64) -> f32 {
    %0 = llvm.mlir.constant(255 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %3 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %4 = llvm.uitofp %arg0 : i64 to f32
    %5 = llvm.icmp "ugt" %arg0, %0 : i64
    %6 = llvm.icmp "ult" %arg0, %1 : i64
    %7 = llvm.select %5, %2, %4 : i1, f32
    %8 = llvm.select %6, %3, %7 : i1, f32
    llvm.return %8 : f32
  }]

def mixed_clamp_to_float_1_before := [llvmfunc|
  llvm.func @mixed_clamp_to_float_1(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.sitofp %3 : i32 to f32
    %5 = llvm.sitofp %arg0 : i32 to f32
    %6 = llvm.fcmp "ult" %5, %1 : f32
    %7 = llvm.select %6, %1, %4 : i1, f32
    llvm.return %7 : f32
  }]

def mixed_clamp_to_i32_1_before := [llvmfunc|
  llvm.func @mixed_clamp_to_i32_1(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %0, %arg0 : i1, f32
    %4 = llvm.fptosi %3 : f32 to i32
    %5 = llvm.fptosi %arg0 : f32 to i32
    %6 = llvm.icmp "ult" %5, %1 : i32
    %7 = llvm.select %6, %1, %4 : i1, i32
    llvm.return %7 : i32
  }]

def mixed_clamp_to_float_2_before := [llvmfunc|
  llvm.func @mixed_clamp_to_float_2(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %0, %arg0 : i1, i32
    %5 = llvm.sitofp %4 : i32 to f32
    %6 = llvm.icmp "slt" %arg0, %1 : i32
    %7 = llvm.select %6, %2, %5 : i1, f32
    llvm.return %7 : f32
  }]

def mixed_clamp_to_i32_2_before := [llvmfunc|
  llvm.func @mixed_clamp_to_i32_2(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.fcmp "ogt" %arg0, %0 : f32
    %4 = llvm.select %3, %0, %arg0 : i1, f32
    %5 = llvm.fptosi %4 : f32 to i32
    %6 = llvm.fcmp "olt" %arg0, %1 : f32
    %7 = llvm.select %6, %2, %5 : i1, i32
    llvm.return %7 : i32
  }]

def mixed_clamp_to_float_vec_before := [llvmfunc|
  llvm.func @mixed_clamp_to_float_vec(%arg0: vector<2xi32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<255> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %0, %arg0 : vector<2xi1>, vector<2xi32>
    %4 = llvm.sitofp %3 : vector<2xi32> to vector<2xf32>
    %5 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %6 = llvm.fcmp "ult" %5, %1 : vector<2xf32>
    %7 = llvm.select %6, %1, %4 : vector<2xi1>, vector<2xf32>
    llvm.return %7 : vector<2xf32>
  }]

def clamp_float_fast_ordered_strict_maxmin_combined := [llvmfunc|
  llvm.func @clamp_float_fast_ordered_strict_maxmin(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_clamp_float_fast_ordered_strict_maxmin   : clamp_float_fast_ordered_strict_maxmin_before  ⊑  clamp_float_fast_ordered_strict_maxmin_combined := by
  unfold clamp_float_fast_ordered_strict_maxmin_before clamp_float_fast_ordered_strict_maxmin_combined
  simp_alive_peephole
  sorry
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.intr.maxnum(%3, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

theorem inst_combine_clamp_float_fast_ordered_strict_maxmin   : clamp_float_fast_ordered_strict_maxmin_before  ⊑  clamp_float_fast_ordered_strict_maxmin_combined := by
  unfold clamp_float_fast_ordered_strict_maxmin_before clamp_float_fast_ordered_strict_maxmin_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_clamp_float_fast_ordered_strict_maxmin   : clamp_float_fast_ordered_strict_maxmin_before  ⊑  clamp_float_fast_ordered_strict_maxmin_combined := by
  unfold clamp_float_fast_ordered_strict_maxmin_before clamp_float_fast_ordered_strict_maxmin_combined
  simp_alive_peephole
  sorry
def clamp_float_fast_ordered_nonstrict_maxmin_combined := [llvmfunc|
  llvm.func @clamp_float_fast_ordered_nonstrict_maxmin(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_clamp_float_fast_ordered_nonstrict_maxmin   : clamp_float_fast_ordered_nonstrict_maxmin_before  ⊑  clamp_float_fast_ordered_nonstrict_maxmin_combined := by
  unfold clamp_float_fast_ordered_nonstrict_maxmin_before clamp_float_fast_ordered_nonstrict_maxmin_combined
  simp_alive_peephole
  sorry
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.intr.maxnum(%3, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

theorem inst_combine_clamp_float_fast_ordered_nonstrict_maxmin   : clamp_float_fast_ordered_nonstrict_maxmin_before  ⊑  clamp_float_fast_ordered_nonstrict_maxmin_combined := by
  unfold clamp_float_fast_ordered_nonstrict_maxmin_before clamp_float_fast_ordered_nonstrict_maxmin_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_clamp_float_fast_ordered_nonstrict_maxmin   : clamp_float_fast_ordered_nonstrict_maxmin_before  ⊑  clamp_float_fast_ordered_nonstrict_maxmin_combined := by
  unfold clamp_float_fast_ordered_nonstrict_maxmin_before clamp_float_fast_ordered_nonstrict_maxmin_combined
  simp_alive_peephole
  sorry
def clamp_float_fast_ordered_strict_minmax_combined := [llvmfunc|
  llvm.func @clamp_float_fast_ordered_strict_minmax(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_clamp_float_fast_ordered_strict_minmax   : clamp_float_fast_ordered_strict_minmax_before  ⊑  clamp_float_fast_ordered_strict_minmax_combined := by
  unfold clamp_float_fast_ordered_strict_minmax_before clamp_float_fast_ordered_strict_minmax_combined
  simp_alive_peephole
  sorry
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.intr.minnum(%3, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

theorem inst_combine_clamp_float_fast_ordered_strict_minmax   : clamp_float_fast_ordered_strict_minmax_before  ⊑  clamp_float_fast_ordered_strict_minmax_combined := by
  unfold clamp_float_fast_ordered_strict_minmax_before clamp_float_fast_ordered_strict_minmax_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_clamp_float_fast_ordered_strict_minmax   : clamp_float_fast_ordered_strict_minmax_before  ⊑  clamp_float_fast_ordered_strict_minmax_combined := by
  unfold clamp_float_fast_ordered_strict_minmax_before clamp_float_fast_ordered_strict_minmax_combined
  simp_alive_peephole
  sorry
def clamp_float_fast_ordered_nonstrict_minmax_combined := [llvmfunc|
  llvm.func @clamp_float_fast_ordered_nonstrict_minmax(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_clamp_float_fast_ordered_nonstrict_minmax   : clamp_float_fast_ordered_nonstrict_minmax_before  ⊑  clamp_float_fast_ordered_nonstrict_minmax_combined := by
  unfold clamp_float_fast_ordered_nonstrict_minmax_before clamp_float_fast_ordered_nonstrict_minmax_combined
  simp_alive_peephole
  sorry
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.intr.minnum(%3, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

theorem inst_combine_clamp_float_fast_ordered_nonstrict_minmax   : clamp_float_fast_ordered_nonstrict_minmax_before  ⊑  clamp_float_fast_ordered_nonstrict_minmax_combined := by
  unfold clamp_float_fast_ordered_nonstrict_minmax_before clamp_float_fast_ordered_nonstrict_minmax_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_clamp_float_fast_ordered_nonstrict_minmax   : clamp_float_fast_ordered_nonstrict_minmax_before  ⊑  clamp_float_fast_ordered_nonstrict_minmax_combined := by
  unfold clamp_float_fast_ordered_nonstrict_minmax_before clamp_float_fast_ordered_nonstrict_minmax_combined
  simp_alive_peephole
  sorry
def clamp_float_fast_unordered_strict_maxmin_combined := [llvmfunc|
  llvm.func @clamp_float_fast_unordered_strict_maxmin(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "oge" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_clamp_float_fast_unordered_strict_maxmin   : clamp_float_fast_unordered_strict_maxmin_before  ⊑  clamp_float_fast_unordered_strict_maxmin_combined := by
  unfold clamp_float_fast_unordered_strict_maxmin_before clamp_float_fast_unordered_strict_maxmin_combined
  simp_alive_peephole
  sorry
    %3 = llvm.select %2, %0, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : i1, f32]

theorem inst_combine_clamp_float_fast_unordered_strict_maxmin   : clamp_float_fast_unordered_strict_maxmin_before  ⊑  clamp_float_fast_unordered_strict_maxmin_combined := by
  unfold clamp_float_fast_unordered_strict_maxmin_before clamp_float_fast_unordered_strict_maxmin_combined
  simp_alive_peephole
  sorry
    %4 = llvm.intr.maxnum(%3, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

theorem inst_combine_clamp_float_fast_unordered_strict_maxmin   : clamp_float_fast_unordered_strict_maxmin_before  ⊑  clamp_float_fast_unordered_strict_maxmin_combined := by
  unfold clamp_float_fast_unordered_strict_maxmin_before clamp_float_fast_unordered_strict_maxmin_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_clamp_float_fast_unordered_strict_maxmin   : clamp_float_fast_unordered_strict_maxmin_before  ⊑  clamp_float_fast_unordered_strict_maxmin_combined := by
  unfold clamp_float_fast_unordered_strict_maxmin_before clamp_float_fast_unordered_strict_maxmin_combined
  simp_alive_peephole
  sorry
def clamp_float_fast_unordered_nonstrict_maxmin_combined := [llvmfunc|
  llvm.func @clamp_float_fast_unordered_nonstrict_maxmin(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "oge" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_clamp_float_fast_unordered_nonstrict_maxmin   : clamp_float_fast_unordered_nonstrict_maxmin_before  ⊑  clamp_float_fast_unordered_nonstrict_maxmin_combined := by
  unfold clamp_float_fast_unordered_nonstrict_maxmin_before clamp_float_fast_unordered_nonstrict_maxmin_combined
  simp_alive_peephole
  sorry
    %3 = llvm.select %2, %0, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : i1, f32]

theorem inst_combine_clamp_float_fast_unordered_nonstrict_maxmin   : clamp_float_fast_unordered_nonstrict_maxmin_before  ⊑  clamp_float_fast_unordered_nonstrict_maxmin_combined := by
  unfold clamp_float_fast_unordered_nonstrict_maxmin_before clamp_float_fast_unordered_nonstrict_maxmin_combined
  simp_alive_peephole
  sorry
    %4 = llvm.intr.maxnum(%3, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

theorem inst_combine_clamp_float_fast_unordered_nonstrict_maxmin   : clamp_float_fast_unordered_nonstrict_maxmin_before  ⊑  clamp_float_fast_unordered_nonstrict_maxmin_combined := by
  unfold clamp_float_fast_unordered_nonstrict_maxmin_before clamp_float_fast_unordered_nonstrict_maxmin_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_clamp_float_fast_unordered_nonstrict_maxmin   : clamp_float_fast_unordered_nonstrict_maxmin_before  ⊑  clamp_float_fast_unordered_nonstrict_maxmin_combined := by
  unfold clamp_float_fast_unordered_nonstrict_maxmin_before clamp_float_fast_unordered_nonstrict_maxmin_combined
  simp_alive_peephole
  sorry
def clamp_float_fast_unordered_strict_minmax_combined := [llvmfunc|
  llvm.func @clamp_float_fast_unordered_strict_minmax(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ole" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_clamp_float_fast_unordered_strict_minmax   : clamp_float_fast_unordered_strict_minmax_before  ⊑  clamp_float_fast_unordered_strict_minmax_combined := by
  unfold clamp_float_fast_unordered_strict_minmax_before clamp_float_fast_unordered_strict_minmax_combined
  simp_alive_peephole
  sorry
    %3 = llvm.select %2, %0, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : i1, f32]

theorem inst_combine_clamp_float_fast_unordered_strict_minmax   : clamp_float_fast_unordered_strict_minmax_before  ⊑  clamp_float_fast_unordered_strict_minmax_combined := by
  unfold clamp_float_fast_unordered_strict_minmax_before clamp_float_fast_unordered_strict_minmax_combined
  simp_alive_peephole
  sorry
    %4 = llvm.intr.minnum(%3, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

theorem inst_combine_clamp_float_fast_unordered_strict_minmax   : clamp_float_fast_unordered_strict_minmax_before  ⊑  clamp_float_fast_unordered_strict_minmax_combined := by
  unfold clamp_float_fast_unordered_strict_minmax_before clamp_float_fast_unordered_strict_minmax_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_clamp_float_fast_unordered_strict_minmax   : clamp_float_fast_unordered_strict_minmax_before  ⊑  clamp_float_fast_unordered_strict_minmax_combined := by
  unfold clamp_float_fast_unordered_strict_minmax_before clamp_float_fast_unordered_strict_minmax_combined
  simp_alive_peephole
  sorry
def clamp_float_fast_unordered_nonstrict_minmax_combined := [llvmfunc|
  llvm.func @clamp_float_fast_unordered_nonstrict_minmax(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ole" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_clamp_float_fast_unordered_nonstrict_minmax   : clamp_float_fast_unordered_nonstrict_minmax_before  ⊑  clamp_float_fast_unordered_nonstrict_minmax_combined := by
  unfold clamp_float_fast_unordered_nonstrict_minmax_before clamp_float_fast_unordered_nonstrict_minmax_combined
  simp_alive_peephole
  sorry
    %3 = llvm.select %2, %0, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : i1, f32]

theorem inst_combine_clamp_float_fast_unordered_nonstrict_minmax   : clamp_float_fast_unordered_nonstrict_minmax_before  ⊑  clamp_float_fast_unordered_nonstrict_minmax_combined := by
  unfold clamp_float_fast_unordered_nonstrict_minmax_before clamp_float_fast_unordered_nonstrict_minmax_combined
  simp_alive_peephole
  sorry
    %4 = llvm.intr.minnum(%3, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

theorem inst_combine_clamp_float_fast_unordered_nonstrict_minmax   : clamp_float_fast_unordered_nonstrict_minmax_before  ⊑  clamp_float_fast_unordered_nonstrict_minmax_combined := by
  unfold clamp_float_fast_unordered_nonstrict_minmax_before clamp_float_fast_unordered_nonstrict_minmax_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_clamp_float_fast_unordered_nonstrict_minmax   : clamp_float_fast_unordered_nonstrict_minmax_before  ⊑  clamp_float_fast_unordered_nonstrict_minmax_combined := by
  unfold clamp_float_fast_unordered_nonstrict_minmax_before clamp_float_fast_unordered_nonstrict_minmax_combined
  simp_alive_peephole
  sorry
def clamp_test_1_combined := [llvmfunc|
  llvm.func @clamp_test_1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "oge" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_clamp_test_1   : clamp_test_1_before  ⊑  clamp_test_1_combined := by
  unfold clamp_test_1_before clamp_test_1_combined
  simp_alive_peephole
  sorry
    %3 = llvm.select %2, %0, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : i1, f32]

theorem inst_combine_clamp_test_1   : clamp_test_1_before  ⊑  clamp_test_1_combined := by
  unfold clamp_test_1_before clamp_test_1_combined
  simp_alive_peephole
  sorry
    %4 = llvm.intr.maxnum(%3, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

theorem inst_combine_clamp_test_1   : clamp_test_1_before  ⊑  clamp_test_1_combined := by
  unfold clamp_test_1_before clamp_test_1_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_clamp_test_1   : clamp_test_1_before  ⊑  clamp_test_1_combined := by
  unfold clamp_test_1_before clamp_test_1_combined
  simp_alive_peephole
  sorry
def clamp_negative_wrong_const_combined := [llvmfunc|
  llvm.func @clamp_negative_wrong_const(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(5.120000e+02 : f32) : f32
    %2 = llvm.fcmp "oge" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_clamp_negative_wrong_const   : clamp_negative_wrong_const_before  ⊑  clamp_negative_wrong_const_combined := by
  unfold clamp_negative_wrong_const_before clamp_negative_wrong_const_combined
  simp_alive_peephole
  sorry
    %3 = llvm.select %2, %0, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : i1, f32]

theorem inst_combine_clamp_negative_wrong_const   : clamp_negative_wrong_const_before  ⊑  clamp_negative_wrong_const_combined := by
  unfold clamp_negative_wrong_const_before clamp_negative_wrong_const_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fcmp "ugt" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_clamp_negative_wrong_const   : clamp_negative_wrong_const_before  ⊑  clamp_negative_wrong_const_combined := by
  unfold clamp_negative_wrong_const_before clamp_negative_wrong_const_combined
  simp_alive_peephole
  sorry
    %5 = llvm.select %4, %3, %1 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_negative_wrong_const   : clamp_negative_wrong_const_before  ⊑  clamp_negative_wrong_const_combined := by
  unfold clamp_negative_wrong_const_before clamp_negative_wrong_const_combined
  simp_alive_peephole
  sorry
def clamp_negative_same_op_combined := [llvmfunc|
  llvm.func @clamp_negative_same_op(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "oge" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_clamp_negative_same_op   : clamp_negative_same_op_before  ⊑  clamp_negative_same_op_combined := by
  unfold clamp_negative_same_op_before clamp_negative_same_op_combined
  simp_alive_peephole
  sorry
    %3 = llvm.select %2, %0, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : i1, f32]

theorem inst_combine_clamp_negative_same_op   : clamp_negative_same_op_before  ⊑  clamp_negative_same_op_combined := by
  unfold clamp_negative_same_op_before clamp_negative_same_op_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fcmp "ult" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_clamp_negative_same_op   : clamp_negative_same_op_before  ⊑  clamp_negative_same_op_combined := by
  unfold clamp_negative_same_op_before clamp_negative_same_op_combined
  simp_alive_peephole
  sorry
    %5 = llvm.select %4, %3, %1 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_negative_same_op   : clamp_negative_same_op_before  ⊑  clamp_negative_same_op_combined := by
  unfold clamp_negative_same_op_before clamp_negative_same_op_combined
  simp_alive_peephole
  sorry
def clamp_float_with_zero1_combined := [llvmfunc|
  llvm.func @clamp_float_with_zero1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_clamp_float_with_zero1   : clamp_float_with_zero1_before  ⊑  clamp_float_with_zero1_combined := by
  unfold clamp_float_with_zero1_before clamp_float_with_zero1_combined
  simp_alive_peephole
  sorry
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ole" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_float_with_zero1   : clamp_float_with_zero1_before  ⊑  clamp_float_with_zero1_combined := by
  unfold clamp_float_with_zero1_before clamp_float_with_zero1_combined
  simp_alive_peephole
  sorry
def clamp_float_with_zero2_combined := [llvmfunc|
  llvm.func @clamp_float_with_zero2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_clamp_float_with_zero2   : clamp_float_with_zero2_before  ⊑  clamp_float_with_zero2_combined := by
  unfold clamp_float_with_zero2_before clamp_float_with_zero2_combined
  simp_alive_peephole
  sorry
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "olt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_float_with_zero2   : clamp_float_with_zero2_before  ⊑  clamp_float_with_zero2_combined := by
  unfold clamp_float_with_zero2_before clamp_float_with_zero2_combined
  simp_alive_peephole
  sorry
def clamp_float_ordered_strict_maxmin1_combined := [llvmfunc|
  llvm.func @clamp_float_ordered_strict_maxmin1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "olt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_float_ordered_strict_maxmin1   : clamp_float_ordered_strict_maxmin1_before  ⊑  clamp_float_ordered_strict_maxmin1_combined := by
  unfold clamp_float_ordered_strict_maxmin1_before clamp_float_ordered_strict_maxmin1_combined
  simp_alive_peephole
  sorry
def clamp_float_ordered_strict_maxmin2_combined := [llvmfunc|
  llvm.func @clamp_float_ordered_strict_maxmin2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "oge" %arg0, %0 : f32
    %3 = llvm.select %2, %0, %arg0 : i1, f32
    %4 = llvm.fcmp "olt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_float_ordered_strict_maxmin2   : clamp_float_ordered_strict_maxmin2_before  ⊑  clamp_float_ordered_strict_maxmin2_combined := by
  unfold clamp_float_ordered_strict_maxmin2_before clamp_float_ordered_strict_maxmin2_combined
  simp_alive_peephole
  sorry
def clamp_float_ordered_nonstrict_maxmin1_combined := [llvmfunc|
  llvm.func @clamp_float_ordered_nonstrict_maxmin1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ole" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_float_ordered_nonstrict_maxmin1   : clamp_float_ordered_nonstrict_maxmin1_before  ⊑  clamp_float_ordered_nonstrict_maxmin1_combined := by
  unfold clamp_float_ordered_nonstrict_maxmin1_before clamp_float_ordered_nonstrict_maxmin1_combined
  simp_alive_peephole
  sorry
def clamp_float_ordered_nonstrict_maxmin2_combined := [llvmfunc|
  llvm.func @clamp_float_ordered_nonstrict_maxmin2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "oge" %arg0, %0 : f32
    %3 = llvm.select %2, %0, %arg0 : i1, f32
    %4 = llvm.fcmp "ole" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_float_ordered_nonstrict_maxmin2   : clamp_float_ordered_nonstrict_maxmin2_before  ⊑  clamp_float_ordered_nonstrict_maxmin2_combined := by
  unfold clamp_float_ordered_nonstrict_maxmin2_before clamp_float_ordered_nonstrict_maxmin2_combined
  simp_alive_peephole
  sorry
def clamp_float_ordered_strict_minmax1_combined := [llvmfunc|
  llvm.func @clamp_float_ordered_strict_minmax1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ogt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_float_ordered_strict_minmax1   : clamp_float_ordered_strict_minmax1_before  ⊑  clamp_float_ordered_strict_minmax1_combined := by
  unfold clamp_float_ordered_strict_minmax1_before clamp_float_ordered_strict_minmax1_combined
  simp_alive_peephole
  sorry
def clamp_float_ordered_strict_minmax2_combined := [llvmfunc|
  llvm.func @clamp_float_ordered_strict_minmax2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ole" %arg0, %0 : f32
    %3 = llvm.select %2, %0, %arg0 : i1, f32
    %4 = llvm.fcmp "ogt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_float_ordered_strict_minmax2   : clamp_float_ordered_strict_minmax2_before  ⊑  clamp_float_ordered_strict_minmax2_combined := by
  unfold clamp_float_ordered_strict_minmax2_before clamp_float_ordered_strict_minmax2_combined
  simp_alive_peephole
  sorry
def clamp_float_ordered_nonstrict_minmax1_combined := [llvmfunc|
  llvm.func @clamp_float_ordered_nonstrict_minmax1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "oge" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_float_ordered_nonstrict_minmax1   : clamp_float_ordered_nonstrict_minmax1_before  ⊑  clamp_float_ordered_nonstrict_minmax1_combined := by
  unfold clamp_float_ordered_nonstrict_minmax1_before clamp_float_ordered_nonstrict_minmax1_combined
  simp_alive_peephole
  sorry
def clamp_float_ordered_nonstrict_minmax2_combined := [llvmfunc|
  llvm.func @clamp_float_ordered_nonstrict_minmax2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ole" %arg0, %0 : f32
    %3 = llvm.select %2, %0, %arg0 : i1, f32
    %4 = llvm.fcmp "oge" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_float_ordered_nonstrict_minmax2   : clamp_float_ordered_nonstrict_minmax2_before  ⊑  clamp_float_ordered_nonstrict_minmax2_combined := by
  unfold clamp_float_ordered_nonstrict_minmax2_before clamp_float_ordered_nonstrict_minmax2_combined
  simp_alive_peephole
  sorry
def clamp_float_unordered_strict_maxmin1_combined := [llvmfunc|
  llvm.func @clamp_float_unordered_strict_maxmin1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ult" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_float_unordered_strict_maxmin1   : clamp_float_unordered_strict_maxmin1_before  ⊑  clamp_float_unordered_strict_maxmin1_combined := by
  unfold clamp_float_unordered_strict_maxmin1_before clamp_float_unordered_strict_maxmin1_combined
  simp_alive_peephole
  sorry
def clamp_float_unordered_strict_maxmin2_combined := [llvmfunc|
  llvm.func @clamp_float_unordered_strict_maxmin2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "oge" %arg0, %0 : f32
    %3 = llvm.select %2, %0, %arg0 : i1, f32
    %4 = llvm.fcmp "ult" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_float_unordered_strict_maxmin2   : clamp_float_unordered_strict_maxmin2_before  ⊑  clamp_float_unordered_strict_maxmin2_combined := by
  unfold clamp_float_unordered_strict_maxmin2_before clamp_float_unordered_strict_maxmin2_combined
  simp_alive_peephole
  sorry
def clamp_float_unordered_nonstrict_maxmin1_combined := [llvmfunc|
  llvm.func @clamp_float_unordered_nonstrict_maxmin1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ule" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_float_unordered_nonstrict_maxmin1   : clamp_float_unordered_nonstrict_maxmin1_before  ⊑  clamp_float_unordered_nonstrict_maxmin1_combined := by
  unfold clamp_float_unordered_nonstrict_maxmin1_before clamp_float_unordered_nonstrict_maxmin1_combined
  simp_alive_peephole
  sorry
def clamp_float_unordered_nonstrict_maxmin2_combined := [llvmfunc|
  llvm.func @clamp_float_unordered_nonstrict_maxmin2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "oge" %arg0, %0 : f32
    %3 = llvm.select %2, %0, %arg0 : i1, f32
    %4 = llvm.fcmp "ule" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_float_unordered_nonstrict_maxmin2   : clamp_float_unordered_nonstrict_maxmin2_before  ⊑  clamp_float_unordered_nonstrict_maxmin2_combined := by
  unfold clamp_float_unordered_nonstrict_maxmin2_before clamp_float_unordered_nonstrict_maxmin2_combined
  simp_alive_peephole
  sorry
def clamp_float_unordered_strict_minmax1_combined := [llvmfunc|
  llvm.func @clamp_float_unordered_strict_minmax1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ugt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_float_unordered_strict_minmax1   : clamp_float_unordered_strict_minmax1_before  ⊑  clamp_float_unordered_strict_minmax1_combined := by
  unfold clamp_float_unordered_strict_minmax1_before clamp_float_unordered_strict_minmax1_combined
  simp_alive_peephole
  sorry
def clamp_float_unordered_strict_minmax2_combined := [llvmfunc|
  llvm.func @clamp_float_unordered_strict_minmax2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ole" %arg0, %0 : f32
    %3 = llvm.select %2, %0, %arg0 : i1, f32
    %4 = llvm.fcmp "ugt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_float_unordered_strict_minmax2   : clamp_float_unordered_strict_minmax2_before  ⊑  clamp_float_unordered_strict_minmax2_combined := by
  unfold clamp_float_unordered_strict_minmax2_before clamp_float_unordered_strict_minmax2_combined
  simp_alive_peephole
  sorry
def clamp_float_unordered_nonstrict_minmax1_combined := [llvmfunc|
  llvm.func @clamp_float_unordered_nonstrict_minmax1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "uge" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_float_unordered_nonstrict_minmax1   : clamp_float_unordered_nonstrict_minmax1_before  ⊑  clamp_float_unordered_nonstrict_minmax1_combined := by
  unfold clamp_float_unordered_nonstrict_minmax1_before clamp_float_unordered_nonstrict_minmax1_combined
  simp_alive_peephole
  sorry
def clamp_float_unordered_nonstrict_minmax2_combined := [llvmfunc|
  llvm.func @clamp_float_unordered_nonstrict_minmax2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ole" %arg0, %0 : f32
    %3 = llvm.select %2, %0, %arg0 : i1, f32
    %4 = llvm.fcmp "uge" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_clamp_float_unordered_nonstrict_minmax2   : clamp_float_unordered_nonstrict_minmax2_before  ⊑  clamp_float_unordered_nonstrict_minmax2_combined := by
  unfold clamp_float_unordered_nonstrict_minmax2_before clamp_float_unordered_nonstrict_minmax2_combined
  simp_alive_peephole
  sorry
def ui32_clamp_and_cast_to_float_combined := [llvmfunc|
  llvm.func @ui32_clamp_and_cast_to_float(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.intr.umin(%arg0, %1)  : (i32, i32) -> i32
    %5 = llvm.uitofp %4 : i32 to f32
    %6 = llvm.select %3, %2, %5 : i1, f32
    llvm.return %6 : f32
  }]

theorem inst_combine_ui32_clamp_and_cast_to_float   : ui32_clamp_and_cast_to_float_before  ⊑  ui32_clamp_and_cast_to_float_combined := by
  unfold ui32_clamp_and_cast_to_float_before ui32_clamp_and_cast_to_float_combined
  simp_alive_peephole
  sorry
def ui64_clamp_and_cast_to_float_combined := [llvmfunc|
  llvm.func @ui64_clamp_and_cast_to_float(%arg0: i64) -> f32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(255 : i64) : i64
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.icmp "eq" %arg0, %0 : i64
    %4 = llvm.intr.umin(%arg0, %1)  : (i64, i64) -> i64
    %5 = llvm.uitofp %4 : i64 to f32
    %6 = llvm.select %3, %2, %5 : i1, f32
    llvm.return %6 : f32
  }]

theorem inst_combine_ui64_clamp_and_cast_to_float   : ui64_clamp_and_cast_to_float_before  ⊑  ui64_clamp_and_cast_to_float_combined := by
  unfold ui64_clamp_and_cast_to_float_before ui64_clamp_and_cast_to_float_combined
  simp_alive_peephole
  sorry
def mixed_clamp_to_float_1_combined := [llvmfunc|
  llvm.func @mixed_clamp_to_float_1(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smax(%2, %1)  : (i32, i32) -> i32
    %4 = llvm.sitofp %3 : i32 to f32
    llvm.return %4 : f32
  }]

theorem inst_combine_mixed_clamp_to_float_1   : mixed_clamp_to_float_1_before  ⊑  mixed_clamp_to_float_1_combined := by
  unfold mixed_clamp_to_float_1_before mixed_clamp_to_float_1_combined
  simp_alive_peephole
  sorry
def mixed_clamp_to_i32_1_combined := [llvmfunc|
  llvm.func @mixed_clamp_to_i32_1(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.fcmp "ogt" %arg0, %0 : f32
    %4 = llvm.select %3, %0, %arg0 : i1, f32
    %5 = llvm.fptosi %4 : f32 to i32
    %6 = llvm.fptosi %arg0 : f32 to i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %7, %2, %5 : i1, i32
    llvm.return %8 : i32
  }]

theorem inst_combine_mixed_clamp_to_i32_1   : mixed_clamp_to_i32_1_before  ⊑  mixed_clamp_to_i32_1_combined := by
  unfold mixed_clamp_to_i32_1_before mixed_clamp_to_i32_1_combined
  simp_alive_peephole
  sorry
def mixed_clamp_to_float_2_combined := [llvmfunc|
  llvm.func @mixed_clamp_to_float_2(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smax(%2, %1)  : (i32, i32) -> i32
    %4 = llvm.sitofp %3 : i32 to f32
    llvm.return %4 : f32
  }]

theorem inst_combine_mixed_clamp_to_float_2   : mixed_clamp_to_float_2_before  ⊑  mixed_clamp_to_float_2_combined := by
  unfold mixed_clamp_to_float_2_before mixed_clamp_to_float_2_combined
  simp_alive_peephole
  sorry
def mixed_clamp_to_i32_2_combined := [llvmfunc|
  llvm.func @mixed_clamp_to_i32_2(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.fcmp "ogt" %arg0, %0 : f32
    %4 = llvm.select %3, %0, %arg0 : i1, f32
    %5 = llvm.fptosi %4 : f32 to i32
    %6 = llvm.fcmp "olt" %arg0, %1 : f32
    %7 = llvm.select %6, %2, %5 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_mixed_clamp_to_i32_2   : mixed_clamp_to_i32_2_before  ⊑  mixed_clamp_to_i32_2_combined := by
  unfold mixed_clamp_to_i32_2_before mixed_clamp_to_i32_2_combined
  simp_alive_peephole
  sorry
def mixed_clamp_to_float_vec_combined := [llvmfunc|
  llvm.func @mixed_clamp_to_float_vec(%arg0: vector<2xi32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<255> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.intr.smin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.sitofp %2 : vector<2xi32> to vector<2xf32>
    %4 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %5 = llvm.fcmp "ult" %4, %1 : vector<2xf32>
    %6 = llvm.select %5, %1, %3 : vector<2xi1>, vector<2xf32>
    llvm.return %6 : vector<2xf32>
  }]

theorem inst_combine_mixed_clamp_to_float_vec   : mixed_clamp_to_float_vec_before  ⊑  mixed_clamp_to_float_vec_combined := by
  unfold mixed_clamp_to_float_vec_before mixed_clamp_to_float_vec_combined
  simp_alive_peephole
  sorry
