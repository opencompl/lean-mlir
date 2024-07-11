import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fcmp-denormals-are-zero
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def denormal_input_preserve_sign_fcmp_olt_smallest_normalized_before := [llvmfunc|
  llvm.func @denormal_input_preserve_sign_fcmp_olt_smallest_normalized(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "olt" %4, %0 : f32
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %6 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %7 = llvm.fcmp "olt" %6, %2 : f64
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %8 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %9 = llvm.fcmp "olt" %8, %3 : f16
    llvm.store volatile %9, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %10 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f32) -> f32]

    %11 = llvm.fcmp "olt" %10, %0 : f32
    llvm.store volatile %11, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return
  }]

def denormal_input_preserve_sign_fcmp_uge_smallest_normalized_before := [llvmfunc|
  llvm.func @denormal_input_preserve_sign_fcmp_uge_smallest_normalized(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "uge" %4, %0 : f32
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %6 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %7 = llvm.fcmp "uge" %6, %2 : f64
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %8 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %9 = llvm.fcmp "uge" %8, %3 : f16
    llvm.store volatile %9, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return
  }]

def denormal_input_preserve_sign_fcmp_oge_smallest_normalized_before := [llvmfunc|
  llvm.func @denormal_input_preserve_sign_fcmp_oge_smallest_normalized(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "oge" %4, %0 : f32
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %6 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %7 = llvm.fcmp "oge" %6, %2 : f64
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %8 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %9 = llvm.fcmp "oge" %8, %3 : f16
    llvm.store volatile %9, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return
  }]

def denormal_input_preserve_sign_fcmp_ult_smallest_normalized_before := [llvmfunc|
  llvm.func @denormal_input_preserve_sign_fcmp_ult_smallest_normalized(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "ult" %4, %0 : f32
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %6 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %7 = llvm.fcmp "ult" %6, %2 : f64
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %8 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %9 = llvm.fcmp "ult" %8, %3 : f16
    llvm.store volatile %9, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return
  }]

def denormal_input_preserve_sign_vector_fcmp_olt_smallest_normalized_before := [llvmfunc|
  llvm.func @denormal_input_preserve_sign_vector_fcmp_olt_smallest_normalized(%arg0: vector<2xf32>, %arg1: vector<2xf64>, %arg2: vector<2xf16>) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(dense<1.17549435E-38> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(dense<2.2250738585072014E-308> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.mlir.constant(dense<6.103520e-05> : vector<2xf16>) : vector<2xf16>
    %4 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %5 = llvm.fcmp "olt" %4, %0 : vector<2xf32>
    llvm.store volatile %5, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr]

    %6 = llvm.intr.fabs(%arg1)  : (vector<2xf64>) -> vector<2xf64>
    %7 = llvm.fcmp "olt" %6, %2 : vector<2xf64>
    llvm.store volatile %7, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr]

    %8 = llvm.intr.fabs(%arg2)  : (vector<2xf16>) -> vector<2xf16>
    %9 = llvm.fcmp "olt" %8, %3 : vector<2xf16>
    llvm.store volatile %9, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr]

    llvm.return
  }]

def denormal_input_preserve_sign_vector_fcmp_uge_smallest_normalized_before := [llvmfunc|
  llvm.func @denormal_input_preserve_sign_vector_fcmp_uge_smallest_normalized(%arg0: vector<2xf32>, %arg1: vector<2xf64>, %arg2: vector<2xf16>) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(dense<1.17549435E-38> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(dense<2.2250738585072014E-308> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.mlir.constant(dense<6.103520e-05> : vector<2xf16>) : vector<2xf16>
    %4 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %5 = llvm.fcmp "uge" %4, %0 : vector<2xf32>
    llvm.store volatile %5, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr]

    %6 = llvm.intr.fabs(%arg1)  : (vector<2xf64>) -> vector<2xf64>
    %7 = llvm.fcmp "uge" %6, %2 : vector<2xf64>
    llvm.store volatile %7, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr]

    %8 = llvm.intr.fabs(%arg2)  : (vector<2xf16>) -> vector<2xf16>
    %9 = llvm.fcmp "uge" %8, %3 : vector<2xf16>
    llvm.store volatile %9, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr]

    llvm.return
  }]

def denormal_input_preserve_sign_vector_fcmp_oge_smallest_normalized_before := [llvmfunc|
  llvm.func @denormal_input_preserve_sign_vector_fcmp_oge_smallest_normalized(%arg0: vector<2xf32>, %arg1: vector<2xf64>, %arg2: vector<2xf16>) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(dense<1.17549435E-38> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(dense<2.2250738585072014E-308> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.mlir.constant(dense<6.103520e-05> : vector<2xf16>) : vector<2xf16>
    %4 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %5 = llvm.fcmp "oge" %4, %0 : vector<2xf32>
    llvm.store volatile %5, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr]

    %6 = llvm.intr.fabs(%arg1)  : (vector<2xf64>) -> vector<2xf64>
    %7 = llvm.fcmp "oge" %6, %2 : vector<2xf64>
    llvm.store volatile %7, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr]

    %8 = llvm.intr.fabs(%arg2)  : (vector<2xf16>) -> vector<2xf16>
    %9 = llvm.fcmp "oge" %8, %3 : vector<2xf16>
    llvm.store volatile %9, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr]

    llvm.return
  }]

def denormal_input_preserve_sign_vector_fcmp_ult_smallest_normalized_before := [llvmfunc|
  llvm.func @denormal_input_preserve_sign_vector_fcmp_ult_smallest_normalized(%arg0: vector<2xf32>, %arg1: vector<2xf64>, %arg2: vector<2xf16>) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(dense<1.17549435E-38> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(dense<2.2250738585072014E-308> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.mlir.constant(dense<6.103520e-05> : vector<2xf16>) : vector<2xf16>
    %4 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %5 = llvm.fcmp "ult" %4, %0 : vector<2xf32>
    llvm.store volatile %5, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr]

    %6 = llvm.intr.fabs(%arg1)  : (vector<2xf64>) -> vector<2xf64>
    %7 = llvm.fcmp "ult" %6, %2 : vector<2xf64>
    llvm.store volatile %7, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr]

    %8 = llvm.intr.fabs(%arg2)  : (vector<2xf16>) -> vector<2xf16>
    %9 = llvm.fcmp "ult" %8, %3 : vector<2xf16>
    llvm.store volatile %9, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr]

    llvm.return
  }]

def denormal_input_positive_zero_fcmp_olt_smallest_normalized_before := [llvmfunc|
  llvm.func @denormal_input_positive_zero_fcmp_olt_smallest_normalized(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,positive-zero"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "olt" %4, %0 : f32
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %6 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %7 = llvm.fcmp "olt" %6, %2 : f64
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %8 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %9 = llvm.fcmp "olt" %8, %3 : f16
    llvm.store volatile %9, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return
  }]

def denormal_input_ieee_before := [llvmfunc|
  llvm.func @denormal_input_ieee(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,iee"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "olt" %4, %0 : f32
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %6 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %7 = llvm.fcmp "olt" %6, %2 : f64
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %8 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %9 = llvm.fcmp "olt" %8, %3 : f16
    llvm.store volatile %9, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return
  }]

def denormal_input_preserve_sign_f32_only_before := [llvmfunc|
  llvm.func @denormal_input_preserve_sign_f32_only(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "olt" %4, %0 : f32
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %6 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %7 = llvm.fcmp "olt" %6, %2 : f64
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %8 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %9 = llvm.fcmp "olt" %8, %3 : f16
    llvm.store volatile %9, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return
  }]

def wrong_fcmp_type_ole_before := [llvmfunc|
  llvm.func @wrong_fcmp_type_ole(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "ole" %4, %0 : f32
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %6 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %7 = llvm.fcmp "ole" %6, %2 : f64
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %8 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %9 = llvm.fcmp "ole" %8, %3 : f16
    llvm.store volatile %9, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return
  }]

def missing_fabs_before := [llvmfunc|
  llvm.func @missing_fabs(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.fcmp "olt" %arg0, %0 : f32
    llvm.store volatile %4, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %5 = llvm.fcmp "olt" %arg1, %2 : f64
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %6 = llvm.fcmp "olt" %arg2, %3 : f16
    llvm.store volatile %6, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return
  }]

def denormal_input_preserve_sign_fcmp_olt_smallest_normalized_combined := [llvmfunc|
  llvm.func @denormal_input_preserve_sign_fcmp_olt_smallest_normalized(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %4 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.store volatile %4, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %5 = llvm.fcmp "oeq" %arg1, %2 : f64
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.fcmp "oeq" %arg2, %3 : f16
    llvm.store volatile %6, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %7 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_denormal_input_preserve_sign_fcmp_olt_smallest_normalized   : denormal_input_preserve_sign_fcmp_olt_smallest_normalized_before  ⊑  denormal_input_preserve_sign_fcmp_olt_smallest_normalized_combined := by
  unfold denormal_input_preserve_sign_fcmp_olt_smallest_normalized_before denormal_input_preserve_sign_fcmp_olt_smallest_normalized_combined
  simp_alive_peephole
  sorry
def denormal_input_preserve_sign_fcmp_uge_smallest_normalized_combined := [llvmfunc|
  llvm.func @denormal_input_preserve_sign_fcmp_uge_smallest_normalized(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %4 = llvm.fcmp "une" %arg0, %0 : f32
    llvm.store volatile %4, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %5 = llvm.fcmp "une" %arg1, %2 : f64
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.fcmp "une" %arg2, %3 : f16
    llvm.store volatile %6, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_denormal_input_preserve_sign_fcmp_uge_smallest_normalized   : denormal_input_preserve_sign_fcmp_uge_smallest_normalized_before  ⊑  denormal_input_preserve_sign_fcmp_uge_smallest_normalized_combined := by
  unfold denormal_input_preserve_sign_fcmp_uge_smallest_normalized_before denormal_input_preserve_sign_fcmp_uge_smallest_normalized_combined
  simp_alive_peephole
  sorry
def denormal_input_preserve_sign_fcmp_oge_smallest_normalized_combined := [llvmfunc|
  llvm.func @denormal_input_preserve_sign_fcmp_oge_smallest_normalized(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %4 = llvm.fcmp "one" %arg0, %0 : f32
    llvm.store volatile %4, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %5 = llvm.fcmp "one" %arg1, %2 : f64
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.fcmp "one" %arg2, %3 : f16
    llvm.store volatile %6, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_denormal_input_preserve_sign_fcmp_oge_smallest_normalized   : denormal_input_preserve_sign_fcmp_oge_smallest_normalized_before  ⊑  denormal_input_preserve_sign_fcmp_oge_smallest_normalized_combined := by
  unfold denormal_input_preserve_sign_fcmp_oge_smallest_normalized_before denormal_input_preserve_sign_fcmp_oge_smallest_normalized_combined
  simp_alive_peephole
  sorry
def denormal_input_preserve_sign_fcmp_ult_smallest_normalized_combined := [llvmfunc|
  llvm.func @denormal_input_preserve_sign_fcmp_ult_smallest_normalized(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %4 = llvm.fcmp "ueq" %arg0, %0 : f32
    llvm.store volatile %4, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %5 = llvm.fcmp "ueq" %arg1, %2 : f64
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.fcmp "ueq" %arg2, %3 : f16
    llvm.store volatile %6, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_denormal_input_preserve_sign_fcmp_ult_smallest_normalized   : denormal_input_preserve_sign_fcmp_ult_smallest_normalized_before  ⊑  denormal_input_preserve_sign_fcmp_ult_smallest_normalized_combined := by
  unfold denormal_input_preserve_sign_fcmp_ult_smallest_normalized_before denormal_input_preserve_sign_fcmp_ult_smallest_normalized_combined
  simp_alive_peephole
  sorry
def denormal_input_preserve_sign_vector_fcmp_olt_smallest_normalized_combined := [llvmfunc|
  llvm.func @denormal_input_preserve_sign_vector_fcmp_olt_smallest_normalized(%arg0: vector<2xf32>, %arg1: vector<2xf64>, %arg2: vector<2xf16>) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.addressof @var : !llvm.ptr
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %5 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %6 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %7 = llvm.fcmp "oeq" %arg0, %1 : vector<2xf32>
    llvm.store volatile %7, %2 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    %8 = llvm.fcmp "oeq" %arg1, %4 : vector<2xf64>
    llvm.store volatile %8, %2 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    %9 = llvm.fcmp "oeq" %arg2, %6 : vector<2xf16>
    llvm.store volatile %9, %2 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_denormal_input_preserve_sign_vector_fcmp_olt_smallest_normalized   : denormal_input_preserve_sign_vector_fcmp_olt_smallest_normalized_before  ⊑  denormal_input_preserve_sign_vector_fcmp_olt_smallest_normalized_combined := by
  unfold denormal_input_preserve_sign_vector_fcmp_olt_smallest_normalized_before denormal_input_preserve_sign_vector_fcmp_olt_smallest_normalized_combined
  simp_alive_peephole
  sorry
def denormal_input_preserve_sign_vector_fcmp_uge_smallest_normalized_combined := [llvmfunc|
  llvm.func @denormal_input_preserve_sign_vector_fcmp_uge_smallest_normalized(%arg0: vector<2xf32>, %arg1: vector<2xf64>, %arg2: vector<2xf16>) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.addressof @var : !llvm.ptr
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %5 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %6 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %7 = llvm.fcmp "une" %arg0, %1 : vector<2xf32>
    llvm.store volatile %7, %2 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    %8 = llvm.fcmp "une" %arg1, %4 : vector<2xf64>
    llvm.store volatile %8, %2 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    %9 = llvm.fcmp "une" %arg2, %6 : vector<2xf16>
    llvm.store volatile %9, %2 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_denormal_input_preserve_sign_vector_fcmp_uge_smallest_normalized   : denormal_input_preserve_sign_vector_fcmp_uge_smallest_normalized_before  ⊑  denormal_input_preserve_sign_vector_fcmp_uge_smallest_normalized_combined := by
  unfold denormal_input_preserve_sign_vector_fcmp_uge_smallest_normalized_before denormal_input_preserve_sign_vector_fcmp_uge_smallest_normalized_combined
  simp_alive_peephole
  sorry
def denormal_input_preserve_sign_vector_fcmp_oge_smallest_normalized_combined := [llvmfunc|
  llvm.func @denormal_input_preserve_sign_vector_fcmp_oge_smallest_normalized(%arg0: vector<2xf32>, %arg1: vector<2xf64>, %arg2: vector<2xf16>) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.addressof @var : !llvm.ptr
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %5 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %6 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %7 = llvm.fcmp "one" %arg0, %1 : vector<2xf32>
    llvm.store volatile %7, %2 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    %8 = llvm.fcmp "one" %arg1, %4 : vector<2xf64>
    llvm.store volatile %8, %2 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    %9 = llvm.fcmp "one" %arg2, %6 : vector<2xf16>
    llvm.store volatile %9, %2 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_denormal_input_preserve_sign_vector_fcmp_oge_smallest_normalized   : denormal_input_preserve_sign_vector_fcmp_oge_smallest_normalized_before  ⊑  denormal_input_preserve_sign_vector_fcmp_oge_smallest_normalized_combined := by
  unfold denormal_input_preserve_sign_vector_fcmp_oge_smallest_normalized_before denormal_input_preserve_sign_vector_fcmp_oge_smallest_normalized_combined
  simp_alive_peephole
  sorry
def denormal_input_preserve_sign_vector_fcmp_ult_smallest_normalized_combined := [llvmfunc|
  llvm.func @denormal_input_preserve_sign_vector_fcmp_ult_smallest_normalized(%arg0: vector<2xf32>, %arg1: vector<2xf64>, %arg2: vector<2xf16>) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.addressof @var : !llvm.ptr
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %5 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %6 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %7 = llvm.fcmp "ueq" %arg0, %1 : vector<2xf32>
    llvm.store volatile %7, %2 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    %8 = llvm.fcmp "ueq" %arg1, %4 : vector<2xf64>
    llvm.store volatile %8, %2 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    %9 = llvm.fcmp "ueq" %arg2, %6 : vector<2xf16>
    llvm.store volatile %9, %2 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_denormal_input_preserve_sign_vector_fcmp_ult_smallest_normalized   : denormal_input_preserve_sign_vector_fcmp_ult_smallest_normalized_before  ⊑  denormal_input_preserve_sign_vector_fcmp_ult_smallest_normalized_combined := by
  unfold denormal_input_preserve_sign_vector_fcmp_ult_smallest_normalized_before denormal_input_preserve_sign_vector_fcmp_ult_smallest_normalized_combined
  simp_alive_peephole
  sorry
def denormal_input_positive_zero_fcmp_olt_smallest_normalized_combined := [llvmfunc|
  llvm.func @denormal_input_positive_zero_fcmp_olt_smallest_normalized(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,positive-zero"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %4 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.store volatile %4, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %5 = llvm.fcmp "oeq" %arg1, %2 : f64
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.fcmp "oeq" %arg2, %3 : f16
    llvm.store volatile %6, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_denormal_input_positive_zero_fcmp_olt_smallest_normalized   : denormal_input_positive_zero_fcmp_olt_smallest_normalized_before  ⊑  denormal_input_positive_zero_fcmp_olt_smallest_normalized_combined := by
  unfold denormal_input_positive_zero_fcmp_olt_smallest_normalized_before denormal_input_positive_zero_fcmp_olt_smallest_normalized_combined
  simp_alive_peephole
  sorry
def denormal_input_ieee_combined := [llvmfunc|
  llvm.func @denormal_input_ieee(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,iee"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "olt" %4, %0 : f32
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %7 = llvm.fcmp "olt" %6, %2 : f64
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %8 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %9 = llvm.fcmp "olt" %8, %3 : f16
    llvm.store volatile %9, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_denormal_input_ieee   : denormal_input_ieee_before  ⊑  denormal_input_ieee_combined := by
  unfold denormal_input_ieee_before denormal_input_ieee_combined
  simp_alive_peephole
  sorry
def denormal_input_preserve_sign_f32_only_combined := [llvmfunc|
  llvm.func @denormal_input_preserve_sign_f32_only(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.store volatile %4, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %5 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %6 = llvm.fcmp "olt" %5, %2 : f64
    llvm.store volatile %6, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %7 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %8 = llvm.fcmp "olt" %7, %3 : f16
    llvm.store volatile %8, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_denormal_input_preserve_sign_f32_only   : denormal_input_preserve_sign_f32_only_before  ⊑  denormal_input_preserve_sign_f32_only_combined := by
  unfold denormal_input_preserve_sign_f32_only_before denormal_input_preserve_sign_f32_only_combined
  simp_alive_peephole
  sorry
def wrong_fcmp_type_ole_combined := [llvmfunc|
  llvm.func @wrong_fcmp_type_ole(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "ole" %4, %0 : f32
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %7 = llvm.fcmp "ole" %6, %2 : f64
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %8 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %9 = llvm.fcmp "ole" %8, %3 : f16
    llvm.store volatile %9, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_wrong_fcmp_type_ole   : wrong_fcmp_type_ole_before  ⊑  wrong_fcmp_type_ole_combined := by
  unfold wrong_fcmp_type_ole_before wrong_fcmp_type_ole_combined
  simp_alive_peephole
  sorry
def missing_fabs_combined := [llvmfunc|
  llvm.func @missing_fabs(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.fcmp "olt" %arg0, %0 : f32
    llvm.store volatile %4, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %5 = llvm.fcmp "olt" %arg1, %2 : f64
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.fcmp "olt" %arg2, %3 : f16
    llvm.store volatile %6, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_missing_fabs   : missing_fabs_before  ⊑  missing_fabs_combined := by
  unfold missing_fabs_before missing_fabs_combined
  simp_alive_peephole
  sorry
