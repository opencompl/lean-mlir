import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  or-fcmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def PR1738_before := [llvmfunc|
  llvm.func @PR1738(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "uno" %arg0, %0 : f64
    %2 = llvm.fcmp "uno" %arg1, %0 : f64
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def PR1738_logical_before := [llvmfunc|
  llvm.func @PR1738_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.fcmp "uno" %arg0, %0 : f64
    %3 = llvm.fcmp "uno" %arg1, %0 : f64
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def PR1738_vec_undef_before := [llvmfunc|
  llvm.func @PR1738_vec_undef(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.mlir.undef : vector<2xf64>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<2xf64>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<2xf64>
    %12 = llvm.fcmp "uno" %arg0, %6 : vector<2xf64>
    %13 = llvm.fcmp "uno" %arg1, %11 : vector<2xf64>
    %14 = llvm.or %12, %13  : vector<2xi1>
    llvm.return %14 : vector<2xi1>
  }]

def PR1738_vec_poison_before := [llvmfunc|
  llvm.func @PR1738_vec_poison(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.mlir.undef : vector<2xf64>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<2xf64>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<2xf64>
    %12 = llvm.fcmp "uno" %arg0, %6 : vector<2xf64>
    %13 = llvm.fcmp "uno" %arg1, %11 : vector<2xf64>
    %14 = llvm.or %12, %13  : vector<2xi1>
    llvm.return %14 : vector<2xi1>
  }]

def PR41069_before := [llvmfunc|
  llvm.func @PR41069(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uno" %arg2, %0 : f64
    %3 = llvm.or %1, %2  : i1
    %4 = llvm.fcmp "uno" %arg3, %0 : f64
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

def PR41069_logical_before := [llvmfunc|
  llvm.func @PR41069_logical(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %3 = llvm.fcmp "uno" %arg2, %0 : f64
    %4 = llvm.select %2, %1, %3 : i1, i1
    %5 = llvm.fcmp "uno" %arg3, %0 : f64
    %6 = llvm.select %4, %1, %5 : i1, i1
    llvm.return %6 : i1
  }]

def PR41069_commute_before := [llvmfunc|
  llvm.func @PR41069_commute(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uno" %arg2, %0 : f64
    %3 = llvm.or %1, %2  : i1
    %4 = llvm.fcmp "uno" %arg3, %0 : f64
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

def PR41069_commute_logical_before := [llvmfunc|
  llvm.func @PR41069_commute_logical(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %3 = llvm.fcmp "uno" %arg2, %0 : f64
    %4 = llvm.select %2, %1, %3 : i1, i1
    %5 = llvm.fcmp "uno" %arg3, %0 : f64
    %6 = llvm.select %5, %1, %4 : i1, i1
    llvm.return %6 : i1
  }]

def PR41069_vec_before := [llvmfunc|
  llvm.func @PR41069_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.undef : vector<2xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : vector<2xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<2xf32>
    %8 = llvm.fcmp "uno" %arg1, %1 : vector<2xf32>
    %9 = llvm.or %8, %arg0  : vector<2xi1>
    %10 = llvm.fcmp "uno" %arg2, %7 : vector<2xf32>
    %11 = llvm.or %9, %10  : vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }]

def PR41069_vec_poison_before := [llvmfunc|
  llvm.func @PR41069_vec_poison(%arg0: vector<2xi1>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.poison : f32
    %3 = llvm.mlir.undef : vector<2xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : vector<2xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<2xf32>
    %8 = llvm.fcmp "uno" %arg1, %1 : vector<2xf32>
    %9 = llvm.or %8, %arg0  : vector<2xi1>
    %10 = llvm.fcmp "uno" %arg2, %7 : vector<2xf32>
    %11 = llvm.or %9, %10  : vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }]

def PR41069_vec_commute_before := [llvmfunc|
  llvm.func @PR41069_vec_commute(%arg0: vector<2xi1>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.undef : vector<2xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : vector<2xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<2xf32>
    %8 = llvm.fcmp "uno" %arg1, %1 : vector<2xf32>
    %9 = llvm.or %8, %arg0  : vector<2xi1>
    %10 = llvm.fcmp "uno" %arg2, %7 : vector<2xf32>
    %11 = llvm.or %10, %9  : vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }]

def PR41069_vec_commute_poison_before := [llvmfunc|
  llvm.func @PR41069_vec_commute_poison(%arg0: vector<2xi1>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.poison : f32
    %3 = llvm.mlir.undef : vector<2xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : vector<2xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<2xf32>
    %8 = llvm.fcmp "uno" %arg1, %1 : vector<2xf32>
    %9 = llvm.or %8, %arg0  : vector<2xi1>
    %10 = llvm.fcmp "uno" %arg2, %7 : vector<2xf32>
    %11 = llvm.or %10, %9  : vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }]

def fcmp_uno_nonzero_before := [llvmfunc|
  llvm.func @fcmp_uno_nonzero(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.fcmp "uno" %arg0, %0 : f32
    %3 = llvm.fcmp "uno" %arg1, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def fcmp_uno_nonzero_logical_before := [llvmfunc|
  llvm.func @fcmp_uno_nonzero_logical(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.fcmp "uno" %arg0, %0 : f32
    %4 = llvm.fcmp "uno" %arg1, %1 : f32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }]

def fcmp_uno_nonzero_vec_before := [llvmfunc|
  llvm.func @fcmp_uno_nonzero_vec(%arg0: vector<3xf32>, %arg1: vector<3xf32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %1 = llvm.mlir.constant(dense<[3.000000e+00, 2.000000e+00, 1.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %2 = llvm.fcmp "uno" %arg0, %0 : vector<3xf32>
    %3 = llvm.fcmp "uno" %arg1, %1 : vector<3xf32>
    %4 = llvm.or %2, %3  : vector<3xi1>
    llvm.return %4 : vector<3xi1>
  }]

def auto_gen_0_before := [llvmfunc|
  llvm.func @auto_gen_0(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_0_logical_before := [llvmfunc|
  llvm.func @auto_gen_0_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_0_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_0_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_1_before := [llvmfunc|
  llvm.func @auto_gen_1(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_1_logical_before := [llvmfunc|
  llvm.func @auto_gen_1_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_1_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_1_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_2_before := [llvmfunc|
  llvm.func @auto_gen_2(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_2_logical_before := [llvmfunc|
  llvm.func @auto_gen_2_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_2_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_2_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_3_before := [llvmfunc|
  llvm.func @auto_gen_3(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_3_logical_before := [llvmfunc|
  llvm.func @auto_gen_3_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_3_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_3_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_4_before := [llvmfunc|
  llvm.func @auto_gen_4(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_4_logical_before := [llvmfunc|
  llvm.func @auto_gen_4_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_4_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_4_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_5_before := [llvmfunc|
  llvm.func @auto_gen_5(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_5_logical_before := [llvmfunc|
  llvm.func @auto_gen_5_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_5_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_5_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_6_before := [llvmfunc|
  llvm.func @auto_gen_6(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_6_logical_before := [llvmfunc|
  llvm.func @auto_gen_6_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_6_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_6_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_7_before := [llvmfunc|
  llvm.func @auto_gen_7(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_7_logical_before := [llvmfunc|
  llvm.func @auto_gen_7_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_7_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_7_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_8_before := [llvmfunc|
  llvm.func @auto_gen_8(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_8_logical_before := [llvmfunc|
  llvm.func @auto_gen_8_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_8_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_8_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_9_before := [llvmfunc|
  llvm.func @auto_gen_9(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_9_logical_before := [llvmfunc|
  llvm.func @auto_gen_9_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_9_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_9_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_10_before := [llvmfunc|
  llvm.func @auto_gen_10(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_10_logical_before := [llvmfunc|
  llvm.func @auto_gen_10_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_10_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_10_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_11_before := [llvmfunc|
  llvm.func @auto_gen_11(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_11_logical_before := [llvmfunc|
  llvm.func @auto_gen_11_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_11_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_11_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_12_before := [llvmfunc|
  llvm.func @auto_gen_12(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_12_logical_before := [llvmfunc|
  llvm.func @auto_gen_12_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_12_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_12_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_13_before := [llvmfunc|
  llvm.func @auto_gen_13(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_13_logical_before := [llvmfunc|
  llvm.func @auto_gen_13_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_13_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_13_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_14_before := [llvmfunc|
  llvm.func @auto_gen_14(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_14_logical_before := [llvmfunc|
  llvm.func @auto_gen_14_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_14_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_14_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_15_before := [llvmfunc|
  llvm.func @auto_gen_15(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_15_logical_before := [llvmfunc|
  llvm.func @auto_gen_15_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_15_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_15_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_16_before := [llvmfunc|
  llvm.func @auto_gen_16(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_16_logical_before := [llvmfunc|
  llvm.func @auto_gen_16_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_16_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_16_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_17_before := [llvmfunc|
  llvm.func @auto_gen_17(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_17_logical_before := [llvmfunc|
  llvm.func @auto_gen_17_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_17_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_17_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_18_before := [llvmfunc|
  llvm.func @auto_gen_18(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_18_logical_before := [llvmfunc|
  llvm.func @auto_gen_18_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_18_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_18_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_19_before := [llvmfunc|
  llvm.func @auto_gen_19(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_19_logical_before := [llvmfunc|
  llvm.func @auto_gen_19_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_19_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_19_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_20_before := [llvmfunc|
  llvm.func @auto_gen_20(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_20_logical_before := [llvmfunc|
  llvm.func @auto_gen_20_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_20_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_20_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_21_before := [llvmfunc|
  llvm.func @auto_gen_21(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_21_logical_before := [llvmfunc|
  llvm.func @auto_gen_21_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_21_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_21_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_22_before := [llvmfunc|
  llvm.func @auto_gen_22(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_22_logical_before := [llvmfunc|
  llvm.func @auto_gen_22_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_22_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_22_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_23_before := [llvmfunc|
  llvm.func @auto_gen_23(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_23_logical_before := [llvmfunc|
  llvm.func @auto_gen_23_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_23_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_23_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_24_before := [llvmfunc|
  llvm.func @auto_gen_24(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_24_logical_before := [llvmfunc|
  llvm.func @auto_gen_24_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_24_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_24_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_25_before := [llvmfunc|
  llvm.func @auto_gen_25(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_25_logical_before := [llvmfunc|
  llvm.func @auto_gen_25_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_25_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_25_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_26_before := [llvmfunc|
  llvm.func @auto_gen_26(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_26_logical_before := [llvmfunc|
  llvm.func @auto_gen_26_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_26_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_26_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_27_before := [llvmfunc|
  llvm.func @auto_gen_27(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_27_logical_before := [llvmfunc|
  llvm.func @auto_gen_27_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_27_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_27_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_28_before := [llvmfunc|
  llvm.func @auto_gen_28(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_28_logical_before := [llvmfunc|
  llvm.func @auto_gen_28_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_28_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_28_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_29_before := [llvmfunc|
  llvm.func @auto_gen_29(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_29_logical_before := [llvmfunc|
  llvm.func @auto_gen_29_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_29_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_29_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_30_before := [llvmfunc|
  llvm.func @auto_gen_30(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_30_logical_before := [llvmfunc|
  llvm.func @auto_gen_30_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_30_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_30_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_31_before := [llvmfunc|
  llvm.func @auto_gen_31(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_31_logical_before := [llvmfunc|
  llvm.func @auto_gen_31_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_31_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_31_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_32_before := [llvmfunc|
  llvm.func @auto_gen_32(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_32_logical_before := [llvmfunc|
  llvm.func @auto_gen_32_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_32_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_32_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_33_before := [llvmfunc|
  llvm.func @auto_gen_33(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_33_logical_before := [llvmfunc|
  llvm.func @auto_gen_33_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_33_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_33_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_34_before := [llvmfunc|
  llvm.func @auto_gen_34(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_34_logical_before := [llvmfunc|
  llvm.func @auto_gen_34_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_34_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_34_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_35_before := [llvmfunc|
  llvm.func @auto_gen_35(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_35_logical_before := [llvmfunc|
  llvm.func @auto_gen_35_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_35_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_35_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_36_before := [llvmfunc|
  llvm.func @auto_gen_36(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_36_logical_before := [llvmfunc|
  llvm.func @auto_gen_36_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_36_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_36_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_37_before := [llvmfunc|
  llvm.func @auto_gen_37(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_37_logical_before := [llvmfunc|
  llvm.func @auto_gen_37_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_37_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_37_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_38_before := [llvmfunc|
  llvm.func @auto_gen_38(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_38_logical_before := [llvmfunc|
  llvm.func @auto_gen_38_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_38_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_38_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_39_before := [llvmfunc|
  llvm.func @auto_gen_39(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_39_logical_before := [llvmfunc|
  llvm.func @auto_gen_39_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_39_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_39_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_40_before := [llvmfunc|
  llvm.func @auto_gen_40(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_40_logical_before := [llvmfunc|
  llvm.func @auto_gen_40_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_40_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_40_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_41_before := [llvmfunc|
  llvm.func @auto_gen_41(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_41_logical_before := [llvmfunc|
  llvm.func @auto_gen_41_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_41_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_41_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_42_before := [llvmfunc|
  llvm.func @auto_gen_42(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_42_logical_before := [llvmfunc|
  llvm.func @auto_gen_42_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_42_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_42_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_43_before := [llvmfunc|
  llvm.func @auto_gen_43(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_43_logical_before := [llvmfunc|
  llvm.func @auto_gen_43_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_43_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_43_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_44_before := [llvmfunc|
  llvm.func @auto_gen_44(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_44_logical_before := [llvmfunc|
  llvm.func @auto_gen_44_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_44_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_44_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_45_before := [llvmfunc|
  llvm.func @auto_gen_45(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_45_logical_before := [llvmfunc|
  llvm.func @auto_gen_45_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_45_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_45_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_46_before := [llvmfunc|
  llvm.func @auto_gen_46(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_46_logical_before := [llvmfunc|
  llvm.func @auto_gen_46_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_46_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_46_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_47_before := [llvmfunc|
  llvm.func @auto_gen_47(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_47_logical_before := [llvmfunc|
  llvm.func @auto_gen_47_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_47_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_47_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_48_before := [llvmfunc|
  llvm.func @auto_gen_48(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_48_logical_before := [llvmfunc|
  llvm.func @auto_gen_48_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_48_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_48_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_49_before := [llvmfunc|
  llvm.func @auto_gen_49(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_49_logical_before := [llvmfunc|
  llvm.func @auto_gen_49_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_49_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_49_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_50_before := [llvmfunc|
  llvm.func @auto_gen_50(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_50_logical_before := [llvmfunc|
  llvm.func @auto_gen_50_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_50_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_50_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_51_before := [llvmfunc|
  llvm.func @auto_gen_51(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_51_logical_before := [llvmfunc|
  llvm.func @auto_gen_51_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_51_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_51_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_52_before := [llvmfunc|
  llvm.func @auto_gen_52(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_52_logical_before := [llvmfunc|
  llvm.func @auto_gen_52_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_52_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_52_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_53_before := [llvmfunc|
  llvm.func @auto_gen_53(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_53_logical_before := [llvmfunc|
  llvm.func @auto_gen_53_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_53_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_53_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_54_before := [llvmfunc|
  llvm.func @auto_gen_54(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_54_logical_before := [llvmfunc|
  llvm.func @auto_gen_54_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_54_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_54_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_55_before := [llvmfunc|
  llvm.func @auto_gen_55(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_55_logical_before := [llvmfunc|
  llvm.func @auto_gen_55_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_55_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_55_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_56_before := [llvmfunc|
  llvm.func @auto_gen_56(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_56_logical_before := [llvmfunc|
  llvm.func @auto_gen_56_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_56_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_56_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_57_before := [llvmfunc|
  llvm.func @auto_gen_57(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_57_logical_before := [llvmfunc|
  llvm.func @auto_gen_57_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_57_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_57_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_58_before := [llvmfunc|
  llvm.func @auto_gen_58(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_58_logical_before := [llvmfunc|
  llvm.func @auto_gen_58_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_58_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_58_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_59_before := [llvmfunc|
  llvm.func @auto_gen_59(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_59_logical_before := [llvmfunc|
  llvm.func @auto_gen_59_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_59_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_59_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_60_before := [llvmfunc|
  llvm.func @auto_gen_60(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_60_logical_before := [llvmfunc|
  llvm.func @auto_gen_60_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_60_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_60_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_61_before := [llvmfunc|
  llvm.func @auto_gen_61(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_61_logical_before := [llvmfunc|
  llvm.func @auto_gen_61_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_61_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_61_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_62_before := [llvmfunc|
  llvm.func @auto_gen_62(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_62_logical_before := [llvmfunc|
  llvm.func @auto_gen_62_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_62_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_62_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_63_before := [llvmfunc|
  llvm.func @auto_gen_63(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_63_logical_before := [llvmfunc|
  llvm.func @auto_gen_63_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_63_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_63_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_64_before := [llvmfunc|
  llvm.func @auto_gen_64(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_64_logical_before := [llvmfunc|
  llvm.func @auto_gen_64_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_64_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_64_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_65_before := [llvmfunc|
  llvm.func @auto_gen_65(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_65_logical_before := [llvmfunc|
  llvm.func @auto_gen_65_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_65_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_65_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_66_before := [llvmfunc|
  llvm.func @auto_gen_66(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_66_logical_before := [llvmfunc|
  llvm.func @auto_gen_66_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_66_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_66_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_67_before := [llvmfunc|
  llvm.func @auto_gen_67(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_67_logical_before := [llvmfunc|
  llvm.func @auto_gen_67_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_67_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_67_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_68_before := [llvmfunc|
  llvm.func @auto_gen_68(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_68_logical_before := [llvmfunc|
  llvm.func @auto_gen_68_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_68_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_68_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_69_before := [llvmfunc|
  llvm.func @auto_gen_69(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_69_logical_before := [llvmfunc|
  llvm.func @auto_gen_69_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_69_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_69_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_70_before := [llvmfunc|
  llvm.func @auto_gen_70(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_70_logical_before := [llvmfunc|
  llvm.func @auto_gen_70_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_70_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_70_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_71_before := [llvmfunc|
  llvm.func @auto_gen_71(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_71_logical_before := [llvmfunc|
  llvm.func @auto_gen_71_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_71_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_71_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_72_before := [llvmfunc|
  llvm.func @auto_gen_72(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_72_logical_before := [llvmfunc|
  llvm.func @auto_gen_72_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_72_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_72_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_73_before := [llvmfunc|
  llvm.func @auto_gen_73(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_73_logical_before := [llvmfunc|
  llvm.func @auto_gen_73_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_73_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_73_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_74_before := [llvmfunc|
  llvm.func @auto_gen_74(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_74_logical_before := [llvmfunc|
  llvm.func @auto_gen_74_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_74_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_74_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_75_before := [llvmfunc|
  llvm.func @auto_gen_75(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_75_logical_before := [llvmfunc|
  llvm.func @auto_gen_75_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_75_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_75_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_76_before := [llvmfunc|
  llvm.func @auto_gen_76(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_76_logical_before := [llvmfunc|
  llvm.func @auto_gen_76_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_76_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_76_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_77_before := [llvmfunc|
  llvm.func @auto_gen_77(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_77_logical_before := [llvmfunc|
  llvm.func @auto_gen_77_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_77_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_77_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_78_before := [llvmfunc|
  llvm.func @auto_gen_78(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_78_logical_before := [llvmfunc|
  llvm.func @auto_gen_78_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_78_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_78_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_79_before := [llvmfunc|
  llvm.func @auto_gen_79(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_79_logical_before := [llvmfunc|
  llvm.func @auto_gen_79_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_79_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_79_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_80_before := [llvmfunc|
  llvm.func @auto_gen_80(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_80_logical_before := [llvmfunc|
  llvm.func @auto_gen_80_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_80_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_80_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_81_before := [llvmfunc|
  llvm.func @auto_gen_81(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_81_logical_before := [llvmfunc|
  llvm.func @auto_gen_81_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_81_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_81_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_82_before := [llvmfunc|
  llvm.func @auto_gen_82(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_82_logical_before := [llvmfunc|
  llvm.func @auto_gen_82_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_82_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_82_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_83_before := [llvmfunc|
  llvm.func @auto_gen_83(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_83_logical_before := [llvmfunc|
  llvm.func @auto_gen_83_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_83_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_83_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_84_before := [llvmfunc|
  llvm.func @auto_gen_84(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_84_logical_before := [llvmfunc|
  llvm.func @auto_gen_84_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_84_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_84_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_85_before := [llvmfunc|
  llvm.func @auto_gen_85(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_85_logical_before := [llvmfunc|
  llvm.func @auto_gen_85_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_85_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_85_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_86_before := [llvmfunc|
  llvm.func @auto_gen_86(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_86_logical_before := [llvmfunc|
  llvm.func @auto_gen_86_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_86_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_86_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_87_before := [llvmfunc|
  llvm.func @auto_gen_87(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_87_logical_before := [llvmfunc|
  llvm.func @auto_gen_87_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_87_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_87_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_88_before := [llvmfunc|
  llvm.func @auto_gen_88(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_88_logical_before := [llvmfunc|
  llvm.func @auto_gen_88_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_88_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_88_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_89_before := [llvmfunc|
  llvm.func @auto_gen_89(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_89_logical_before := [llvmfunc|
  llvm.func @auto_gen_89_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_89_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_89_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_90_before := [llvmfunc|
  llvm.func @auto_gen_90(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_90_logical_before := [llvmfunc|
  llvm.func @auto_gen_90_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_90_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_90_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_91_before := [llvmfunc|
  llvm.func @auto_gen_91(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_91_logical_before := [llvmfunc|
  llvm.func @auto_gen_91_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_91_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_91_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_92_before := [llvmfunc|
  llvm.func @auto_gen_92(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_92_logical_before := [llvmfunc|
  llvm.func @auto_gen_92_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_92_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_92_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_93_before := [llvmfunc|
  llvm.func @auto_gen_93(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_93_logical_before := [llvmfunc|
  llvm.func @auto_gen_93_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_93_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_93_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_94_before := [llvmfunc|
  llvm.func @auto_gen_94(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_94_logical_before := [llvmfunc|
  llvm.func @auto_gen_94_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_94_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_94_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_95_before := [llvmfunc|
  llvm.func @auto_gen_95(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_95_logical_before := [llvmfunc|
  llvm.func @auto_gen_95_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_95_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_95_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_96_before := [llvmfunc|
  llvm.func @auto_gen_96(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_96_logical_before := [llvmfunc|
  llvm.func @auto_gen_96_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_96_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_96_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_97_before := [llvmfunc|
  llvm.func @auto_gen_97(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_97_logical_before := [llvmfunc|
  llvm.func @auto_gen_97_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_97_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_97_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_98_before := [llvmfunc|
  llvm.func @auto_gen_98(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_98_logical_before := [llvmfunc|
  llvm.func @auto_gen_98_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_98_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_98_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_99_before := [llvmfunc|
  llvm.func @auto_gen_99(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_99_logical_before := [llvmfunc|
  llvm.func @auto_gen_99_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_99_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_99_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_100_before := [llvmfunc|
  llvm.func @auto_gen_100(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_100_logical_before := [llvmfunc|
  llvm.func @auto_gen_100_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_100_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_100_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_101_before := [llvmfunc|
  llvm.func @auto_gen_101(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_101_logical_before := [llvmfunc|
  llvm.func @auto_gen_101_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_101_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_101_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_102_before := [llvmfunc|
  llvm.func @auto_gen_102(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_102_logical_before := [llvmfunc|
  llvm.func @auto_gen_102_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_102_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_102_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_103_before := [llvmfunc|
  llvm.func @auto_gen_103(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_103_logical_before := [llvmfunc|
  llvm.func @auto_gen_103_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_103_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_103_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_104_before := [llvmfunc|
  llvm.func @auto_gen_104(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_104_logical_before := [llvmfunc|
  llvm.func @auto_gen_104_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "une" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_104_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_104_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_105_before := [llvmfunc|
  llvm.func @auto_gen_105(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_105_logical_before := [llvmfunc|
  llvm.func @auto_gen_105_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_105_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_105_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_106_before := [llvmfunc|
  llvm.func @auto_gen_106(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_106_logical_before := [llvmfunc|
  llvm.func @auto_gen_106_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_106_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_106_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_107_before := [llvmfunc|
  llvm.func @auto_gen_107(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_107_logical_before := [llvmfunc|
  llvm.func @auto_gen_107_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_107_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_107_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_108_before := [llvmfunc|
  llvm.func @auto_gen_108(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_108_logical_before := [llvmfunc|
  llvm.func @auto_gen_108_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_108_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_108_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_109_before := [llvmfunc|
  llvm.func @auto_gen_109(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_109_logical_before := [llvmfunc|
  llvm.func @auto_gen_109_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_109_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_109_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_110_before := [llvmfunc|
  llvm.func @auto_gen_110(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_110_logical_before := [llvmfunc|
  llvm.func @auto_gen_110_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_110_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_110_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_111_before := [llvmfunc|
  llvm.func @auto_gen_111(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_111_logical_before := [llvmfunc|
  llvm.func @auto_gen_111_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_111_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_111_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_112_before := [llvmfunc|
  llvm.func @auto_gen_112(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_112_logical_before := [llvmfunc|
  llvm.func @auto_gen_112_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_112_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_112_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_113_before := [llvmfunc|
  llvm.func @auto_gen_113(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_113_logical_before := [llvmfunc|
  llvm.func @auto_gen_113_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_113_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_113_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_114_before := [llvmfunc|
  llvm.func @auto_gen_114(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_114_logical_before := [llvmfunc|
  llvm.func @auto_gen_114_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_114_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_114_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_115_before := [llvmfunc|
  llvm.func @auto_gen_115(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_115_logical_before := [llvmfunc|
  llvm.func @auto_gen_115_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_115_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_115_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_116_before := [llvmfunc|
  llvm.func @auto_gen_116(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_116_logical_before := [llvmfunc|
  llvm.func @auto_gen_116_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_116_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_116_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_117_before := [llvmfunc|
  llvm.func @auto_gen_117(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_117_logical_before := [llvmfunc|
  llvm.func @auto_gen_117_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_117_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_117_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_118_before := [llvmfunc|
  llvm.func @auto_gen_118(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_118_logical_before := [llvmfunc|
  llvm.func @auto_gen_118_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "une" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_118_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_118_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_119_before := [llvmfunc|
  llvm.func @auto_gen_119(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_119_logical_before := [llvmfunc|
  llvm.func @auto_gen_119_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_119_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_119_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_120_before := [llvmfunc|
  llvm.func @auto_gen_120(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_120_logical_before := [llvmfunc|
  llvm.func @auto_gen_120_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_120_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_120_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_121_before := [llvmfunc|
  llvm.func @auto_gen_121(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_121_logical_before := [llvmfunc|
  llvm.func @auto_gen_121_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_121_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_121_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_122_before := [llvmfunc|
  llvm.func @auto_gen_122(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_122_logical_before := [llvmfunc|
  llvm.func @auto_gen_122_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_122_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_122_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_123_before := [llvmfunc|
  llvm.func @auto_gen_123(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_123_logical_before := [llvmfunc|
  llvm.func @auto_gen_123_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_123_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_123_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_124_before := [llvmfunc|
  llvm.func @auto_gen_124(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_124_logical_before := [llvmfunc|
  llvm.func @auto_gen_124_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_124_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_124_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_125_before := [llvmfunc|
  llvm.func @auto_gen_125(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_125_logical_before := [llvmfunc|
  llvm.func @auto_gen_125_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_125_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_125_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_126_before := [llvmfunc|
  llvm.func @auto_gen_126(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_126_logical_before := [llvmfunc|
  llvm.func @auto_gen_126_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_126_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_126_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_127_before := [llvmfunc|
  llvm.func @auto_gen_127(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_127_logical_before := [llvmfunc|
  llvm.func @auto_gen_127_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_127_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_127_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_128_before := [llvmfunc|
  llvm.func @auto_gen_128(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_128_logical_before := [llvmfunc|
  llvm.func @auto_gen_128_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_128_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_128_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_129_before := [llvmfunc|
  llvm.func @auto_gen_129(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_129_logical_before := [llvmfunc|
  llvm.func @auto_gen_129_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_129_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_129_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_130_before := [llvmfunc|
  llvm.func @auto_gen_130(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_130_logical_before := [llvmfunc|
  llvm.func @auto_gen_130_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_130_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_130_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_131_before := [llvmfunc|
  llvm.func @auto_gen_131(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_131_logical_before := [llvmfunc|
  llvm.func @auto_gen_131_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_131_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_131_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_132_before := [llvmfunc|
  llvm.func @auto_gen_132(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_132_logical_before := [llvmfunc|
  llvm.func @auto_gen_132_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_132_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_132_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_133_before := [llvmfunc|
  llvm.func @auto_gen_133(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_133_logical_before := [llvmfunc|
  llvm.func @auto_gen_133_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "une" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_133_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_133_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_134_before := [llvmfunc|
  llvm.func @auto_gen_134(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_134_logical_before := [llvmfunc|
  llvm.func @auto_gen_134_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_134_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_134_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_135_before := [llvmfunc|
  llvm.func @auto_gen_135(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def auto_gen_135_logical_before := [llvmfunc|
  llvm.func @auto_gen_135_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def auto_gen_135_logical_fmf_before := [llvmfunc|
  llvm.func @auto_gen_135_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fcmp "_true" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def intersect_fmf_1_before := [llvmfunc|
  llvm.func @intersect_fmf_1(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %1 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def intersect_fmf_2_before := [llvmfunc|
  llvm.func @intersect_fmf_2(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def intersect_fmf_3_before := [llvmfunc|
  llvm.func @intersect_fmf_3(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def intersect_fmf_4_before := [llvmfunc|
  llvm.func @intersect_fmf_4(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<ninf>} : f64]

    %1 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def PR1738_combined := [llvmfunc|
  llvm.func @PR1738(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_PR1738   : PR1738_before  ⊑  PR1738_combined := by
  unfold PR1738_before PR1738_combined
  simp_alive_peephole
  sorry
def PR1738_logical_combined := [llvmfunc|
  llvm.func @PR1738_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.fcmp "uno" %arg0, %0 : f64
    %3 = llvm.fcmp "uno" %arg1, %0 : f64
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_PR1738_logical   : PR1738_logical_before  ⊑  PR1738_logical_combined := by
  unfold PR1738_logical_before PR1738_logical_combined
  simp_alive_peephole
  sorry
def PR1738_vec_undef_combined := [llvmfunc|
  llvm.func @PR1738_vec_undef(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : vector<2xf64>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_PR1738_vec_undef   : PR1738_vec_undef_before  ⊑  PR1738_vec_undef_combined := by
  unfold PR1738_vec_undef_before PR1738_vec_undef_combined
  simp_alive_peephole
  sorry
def PR1738_vec_poison_combined := [llvmfunc|
  llvm.func @PR1738_vec_poison(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : vector<2xf64>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_PR1738_vec_poison   : PR1738_vec_poison_before  ⊑  PR1738_vec_poison_combined := by
  unfold PR1738_vec_poison_before PR1738_vec_poison_combined
  simp_alive_peephole
  sorry
def PR41069_combined := [llvmfunc|
  llvm.func @PR41069(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "uno" %arg3, %arg2 : f64
    %2 = llvm.or %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_PR41069   : PR41069_before  ⊑  PR41069_combined := by
  unfold PR41069_before PR41069_combined
  simp_alive_peephole
  sorry
def PR41069_logical_combined := [llvmfunc|
  llvm.func @PR41069_logical(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %3 = llvm.fcmp "uno" %arg2, %0 : f64
    %4 = llvm.select %2, %1, %3 : i1, i1
    %5 = llvm.fcmp "uno" %arg3, %0 : f64
    %6 = llvm.select %4, %1, %5 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_PR41069_logical   : PR41069_logical_before  ⊑  PR41069_logical_combined := by
  unfold PR41069_logical_before PR41069_logical_combined
  simp_alive_peephole
  sorry
def PR41069_commute_combined := [llvmfunc|
  llvm.func @PR41069_commute(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "uno" %arg3, %arg2 : f64
    %2 = llvm.or %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_PR41069_commute   : PR41069_commute_before  ⊑  PR41069_commute_combined := by
  unfold PR41069_commute_before PR41069_commute_combined
  simp_alive_peephole
  sorry
def PR41069_commute_logical_combined := [llvmfunc|
  llvm.func @PR41069_commute_logical(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %3 = llvm.fcmp "uno" %arg2, %0 : f64
    %4 = llvm.fcmp "uno" %arg3, %0 : f64
    %5 = llvm.select %4, %1, %2 : i1, i1
    %6 = llvm.select %5, %1, %3 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_PR41069_commute_logical   : PR41069_commute_logical_before  ⊑  PR41069_commute_logical_combined := by
  unfold PR41069_commute_logical_before PR41069_commute_logical_combined
  simp_alive_peephole
  sorry
def PR41069_vec_combined := [llvmfunc|
  llvm.func @PR41069_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fcmp "uno" %arg2, %arg1 : vector<2xf32>
    %1 = llvm.or %0, %arg0  : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_PR41069_vec   : PR41069_vec_before  ⊑  PR41069_vec_combined := by
  unfold PR41069_vec_before PR41069_vec_combined
  simp_alive_peephole
  sorry
def PR41069_vec_poison_combined := [llvmfunc|
  llvm.func @PR41069_vec_poison(%arg0: vector<2xi1>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fcmp "uno" %arg2, %arg1 : vector<2xf32>
    %1 = llvm.or %0, %arg0  : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_PR41069_vec_poison   : PR41069_vec_poison_before  ⊑  PR41069_vec_poison_combined := by
  unfold PR41069_vec_poison_before PR41069_vec_poison_combined
  simp_alive_peephole
  sorry
def PR41069_vec_commute_combined := [llvmfunc|
  llvm.func @PR41069_vec_commute(%arg0: vector<2xi1>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fcmp "uno" %arg2, %arg1 : vector<2xf32>
    %1 = llvm.or %0, %arg0  : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_PR41069_vec_commute   : PR41069_vec_commute_before  ⊑  PR41069_vec_commute_combined := by
  unfold PR41069_vec_commute_before PR41069_vec_commute_combined
  simp_alive_peephole
  sorry
def PR41069_vec_commute_poison_combined := [llvmfunc|
  llvm.func @PR41069_vec_commute_poison(%arg0: vector<2xi1>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fcmp "uno" %arg2, %arg1 : vector<2xf32>
    %1 = llvm.or %0, %arg0  : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_PR41069_vec_commute_poison   : PR41069_vec_commute_poison_before  ⊑  PR41069_vec_commute_poison_combined := by
  unfold PR41069_vec_commute_poison_before PR41069_vec_commute_poison_combined
  simp_alive_peephole
  sorry
def fcmp_uno_nonzero_combined := [llvmfunc|
  llvm.func @fcmp_uno_nonzero(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f32
    llvm.return %0 : i1
  }]

theorem inst_combine_fcmp_uno_nonzero   : fcmp_uno_nonzero_before  ⊑  fcmp_uno_nonzero_combined := by
  unfold fcmp_uno_nonzero_before fcmp_uno_nonzero_combined
  simp_alive_peephole
  sorry
def fcmp_uno_nonzero_logical_combined := [llvmfunc|
  llvm.func @fcmp_uno_nonzero_logical(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.fcmp "uno" %arg0, %0 : f32
    %3 = llvm.fcmp "uno" %arg1, %0 : f32
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_fcmp_uno_nonzero_logical   : fcmp_uno_nonzero_logical_before  ⊑  fcmp_uno_nonzero_logical_combined := by
  unfold fcmp_uno_nonzero_logical_before fcmp_uno_nonzero_logical_combined
  simp_alive_peephole
  sorry
def fcmp_uno_nonzero_vec_combined := [llvmfunc|
  llvm.func @fcmp_uno_nonzero_vec(%arg0: vector<3xf32>, %arg1: vector<3xf32>) -> vector<3xi1> {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : vector<3xf32>
    llvm.return %0 : vector<3xi1>
  }]

theorem inst_combine_fcmp_uno_nonzero_vec   : fcmp_uno_nonzero_vec_before  ⊑  fcmp_uno_nonzero_vec_combined := by
  unfold fcmp_uno_nonzero_vec_before fcmp_uno_nonzero_vec_combined
  simp_alive_peephole
  sorry
def auto_gen_0_combined := [llvmfunc|
  llvm.func @auto_gen_0(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_0   : auto_gen_0_before  ⊑  auto_gen_0_combined := by
  unfold auto_gen_0_before auto_gen_0_combined
  simp_alive_peephole
  sorry
def auto_gen_0_logical_combined := [llvmfunc|
  llvm.func @auto_gen_0_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_0_logical   : auto_gen_0_logical_before  ⊑  auto_gen_0_logical_combined := by
  unfold auto_gen_0_logical_before auto_gen_0_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_0_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_0_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_0_logical_fmf   : auto_gen_0_logical_fmf_before  ⊑  auto_gen_0_logical_fmf_combined := by
  unfold auto_gen_0_logical_fmf_before auto_gen_0_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_1_combined := [llvmfunc|
  llvm.func @auto_gen_1(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_1   : auto_gen_1_before  ⊑  auto_gen_1_combined := by
  unfold auto_gen_1_before auto_gen_1_combined
  simp_alive_peephole
  sorry
def auto_gen_1_logical_combined := [llvmfunc|
  llvm.func @auto_gen_1_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_1_logical   : auto_gen_1_logical_before  ⊑  auto_gen_1_logical_combined := by
  unfold auto_gen_1_logical_before auto_gen_1_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_1_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_1_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_1_logical_fmf   : auto_gen_1_logical_fmf_before  ⊑  auto_gen_1_logical_fmf_combined := by
  unfold auto_gen_1_logical_fmf_before auto_gen_1_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_1_logical_fmf   : auto_gen_1_logical_fmf_before  ⊑  auto_gen_1_logical_fmf_combined := by
  unfold auto_gen_1_logical_fmf_before auto_gen_1_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_2_combined := [llvmfunc|
  llvm.func @auto_gen_2(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_2   : auto_gen_2_before  ⊑  auto_gen_2_combined := by
  unfold auto_gen_2_before auto_gen_2_combined
  simp_alive_peephole
  sorry
def auto_gen_2_logical_combined := [llvmfunc|
  llvm.func @auto_gen_2_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_2_logical   : auto_gen_2_logical_before  ⊑  auto_gen_2_logical_combined := by
  unfold auto_gen_2_logical_before auto_gen_2_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_2_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_2_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_2_logical_fmf   : auto_gen_2_logical_fmf_before  ⊑  auto_gen_2_logical_fmf_combined := by
  unfold auto_gen_2_logical_fmf_before auto_gen_2_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_3_combined := [llvmfunc|
  llvm.func @auto_gen_3(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_3   : auto_gen_3_before  ⊑  auto_gen_3_combined := by
  unfold auto_gen_3_before auto_gen_3_combined
  simp_alive_peephole
  sorry
def auto_gen_3_logical_combined := [llvmfunc|
  llvm.func @auto_gen_3_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_3_logical   : auto_gen_3_logical_before  ⊑  auto_gen_3_logical_combined := by
  unfold auto_gen_3_logical_before auto_gen_3_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_3_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_3_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_3_logical_fmf   : auto_gen_3_logical_fmf_before  ⊑  auto_gen_3_logical_fmf_combined := by
  unfold auto_gen_3_logical_fmf_before auto_gen_3_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_3_logical_fmf   : auto_gen_3_logical_fmf_before  ⊑  auto_gen_3_logical_fmf_combined := by
  unfold auto_gen_3_logical_fmf_before auto_gen_3_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_4_combined := [llvmfunc|
  llvm.func @auto_gen_4(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_4   : auto_gen_4_before  ⊑  auto_gen_4_combined := by
  unfold auto_gen_4_before auto_gen_4_combined
  simp_alive_peephole
  sorry
def auto_gen_4_logical_combined := [llvmfunc|
  llvm.func @auto_gen_4_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_4_logical   : auto_gen_4_logical_before  ⊑  auto_gen_4_logical_combined := by
  unfold auto_gen_4_logical_before auto_gen_4_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_4_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_4_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_4_logical_fmf   : auto_gen_4_logical_fmf_before  ⊑  auto_gen_4_logical_fmf_combined := by
  unfold auto_gen_4_logical_fmf_before auto_gen_4_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_5_combined := [llvmfunc|
  llvm.func @auto_gen_5(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_5   : auto_gen_5_before  ⊑  auto_gen_5_combined := by
  unfold auto_gen_5_before auto_gen_5_combined
  simp_alive_peephole
  sorry
def auto_gen_5_logical_combined := [llvmfunc|
  llvm.func @auto_gen_5_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_5_logical   : auto_gen_5_logical_before  ⊑  auto_gen_5_logical_combined := by
  unfold auto_gen_5_logical_before auto_gen_5_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_5_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_5_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_5_logical_fmf   : auto_gen_5_logical_fmf_before  ⊑  auto_gen_5_logical_fmf_combined := by
  unfold auto_gen_5_logical_fmf_before auto_gen_5_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_5_logical_fmf   : auto_gen_5_logical_fmf_before  ⊑  auto_gen_5_logical_fmf_combined := by
  unfold auto_gen_5_logical_fmf_before auto_gen_5_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_6_combined := [llvmfunc|
  llvm.func @auto_gen_6(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_6   : auto_gen_6_before  ⊑  auto_gen_6_combined := by
  unfold auto_gen_6_before auto_gen_6_combined
  simp_alive_peephole
  sorry
def auto_gen_6_logical_combined := [llvmfunc|
  llvm.func @auto_gen_6_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_6_logical   : auto_gen_6_logical_before  ⊑  auto_gen_6_logical_combined := by
  unfold auto_gen_6_logical_before auto_gen_6_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_6_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_6_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_6_logical_fmf   : auto_gen_6_logical_fmf_before  ⊑  auto_gen_6_logical_fmf_combined := by
  unfold auto_gen_6_logical_fmf_before auto_gen_6_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_7_combined := [llvmfunc|
  llvm.func @auto_gen_7(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_7   : auto_gen_7_before  ⊑  auto_gen_7_combined := by
  unfold auto_gen_7_before auto_gen_7_combined
  simp_alive_peephole
  sorry
def auto_gen_7_logical_combined := [llvmfunc|
  llvm.func @auto_gen_7_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_7_logical   : auto_gen_7_logical_before  ⊑  auto_gen_7_logical_combined := by
  unfold auto_gen_7_logical_before auto_gen_7_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_7_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_7_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_7_logical_fmf   : auto_gen_7_logical_fmf_before  ⊑  auto_gen_7_logical_fmf_combined := by
  unfold auto_gen_7_logical_fmf_before auto_gen_7_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_7_logical_fmf   : auto_gen_7_logical_fmf_before  ⊑  auto_gen_7_logical_fmf_combined := by
  unfold auto_gen_7_logical_fmf_before auto_gen_7_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_8_combined := [llvmfunc|
  llvm.func @auto_gen_8(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_8   : auto_gen_8_before  ⊑  auto_gen_8_combined := by
  unfold auto_gen_8_before auto_gen_8_combined
  simp_alive_peephole
  sorry
def auto_gen_8_logical_combined := [llvmfunc|
  llvm.func @auto_gen_8_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_8_logical   : auto_gen_8_logical_before  ⊑  auto_gen_8_logical_combined := by
  unfold auto_gen_8_logical_before auto_gen_8_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_8_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_8_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_8_logical_fmf   : auto_gen_8_logical_fmf_before  ⊑  auto_gen_8_logical_fmf_combined := by
  unfold auto_gen_8_logical_fmf_before auto_gen_8_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_9_combined := [llvmfunc|
  llvm.func @auto_gen_9(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_9   : auto_gen_9_before  ⊑  auto_gen_9_combined := by
  unfold auto_gen_9_before auto_gen_9_combined
  simp_alive_peephole
  sorry
def auto_gen_9_logical_combined := [llvmfunc|
  llvm.func @auto_gen_9_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_9_logical   : auto_gen_9_logical_before  ⊑  auto_gen_9_logical_combined := by
  unfold auto_gen_9_logical_before auto_gen_9_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_9_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_9_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_9_logical_fmf   : auto_gen_9_logical_fmf_before  ⊑  auto_gen_9_logical_fmf_combined := by
  unfold auto_gen_9_logical_fmf_before auto_gen_9_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_9_logical_fmf   : auto_gen_9_logical_fmf_before  ⊑  auto_gen_9_logical_fmf_combined := by
  unfold auto_gen_9_logical_fmf_before auto_gen_9_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_10_combined := [llvmfunc|
  llvm.func @auto_gen_10(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_10   : auto_gen_10_before  ⊑  auto_gen_10_combined := by
  unfold auto_gen_10_before auto_gen_10_combined
  simp_alive_peephole
  sorry
def auto_gen_10_logical_combined := [llvmfunc|
  llvm.func @auto_gen_10_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_10_logical   : auto_gen_10_logical_before  ⊑  auto_gen_10_logical_combined := by
  unfold auto_gen_10_logical_before auto_gen_10_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_10_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_10_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_10_logical_fmf   : auto_gen_10_logical_fmf_before  ⊑  auto_gen_10_logical_fmf_combined := by
  unfold auto_gen_10_logical_fmf_before auto_gen_10_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_11_combined := [llvmfunc|
  llvm.func @auto_gen_11(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_11   : auto_gen_11_before  ⊑  auto_gen_11_combined := by
  unfold auto_gen_11_before auto_gen_11_combined
  simp_alive_peephole
  sorry
def auto_gen_11_logical_combined := [llvmfunc|
  llvm.func @auto_gen_11_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_11_logical   : auto_gen_11_logical_before  ⊑  auto_gen_11_logical_combined := by
  unfold auto_gen_11_logical_before auto_gen_11_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_11_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_11_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_11_logical_fmf   : auto_gen_11_logical_fmf_before  ⊑  auto_gen_11_logical_fmf_combined := by
  unfold auto_gen_11_logical_fmf_before auto_gen_11_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_11_logical_fmf   : auto_gen_11_logical_fmf_before  ⊑  auto_gen_11_logical_fmf_combined := by
  unfold auto_gen_11_logical_fmf_before auto_gen_11_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_12_combined := [llvmfunc|
  llvm.func @auto_gen_12(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_12   : auto_gen_12_before  ⊑  auto_gen_12_combined := by
  unfold auto_gen_12_before auto_gen_12_combined
  simp_alive_peephole
  sorry
def auto_gen_12_logical_combined := [llvmfunc|
  llvm.func @auto_gen_12_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_12_logical   : auto_gen_12_logical_before  ⊑  auto_gen_12_logical_combined := by
  unfold auto_gen_12_logical_before auto_gen_12_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_12_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_12_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_12_logical_fmf   : auto_gen_12_logical_fmf_before  ⊑  auto_gen_12_logical_fmf_combined := by
  unfold auto_gen_12_logical_fmf_before auto_gen_12_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_13_combined := [llvmfunc|
  llvm.func @auto_gen_13(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_13   : auto_gen_13_before  ⊑  auto_gen_13_combined := by
  unfold auto_gen_13_before auto_gen_13_combined
  simp_alive_peephole
  sorry
def auto_gen_13_logical_combined := [llvmfunc|
  llvm.func @auto_gen_13_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_13_logical   : auto_gen_13_logical_before  ⊑  auto_gen_13_logical_combined := by
  unfold auto_gen_13_logical_before auto_gen_13_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_13_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_13_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_13_logical_fmf   : auto_gen_13_logical_fmf_before  ⊑  auto_gen_13_logical_fmf_combined := by
  unfold auto_gen_13_logical_fmf_before auto_gen_13_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_14_combined := [llvmfunc|
  llvm.func @auto_gen_14(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_14   : auto_gen_14_before  ⊑  auto_gen_14_combined := by
  unfold auto_gen_14_before auto_gen_14_combined
  simp_alive_peephole
  sorry
def auto_gen_14_logical_combined := [llvmfunc|
  llvm.func @auto_gen_14_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_14_logical   : auto_gen_14_logical_before  ⊑  auto_gen_14_logical_combined := by
  unfold auto_gen_14_logical_before auto_gen_14_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_14_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_14_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_14_logical_fmf   : auto_gen_14_logical_fmf_before  ⊑  auto_gen_14_logical_fmf_combined := by
  unfold auto_gen_14_logical_fmf_before auto_gen_14_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_15_combined := [llvmfunc|
  llvm.func @auto_gen_15(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_15   : auto_gen_15_before  ⊑  auto_gen_15_combined := by
  unfold auto_gen_15_before auto_gen_15_combined
  simp_alive_peephole
  sorry
def auto_gen_15_logical_combined := [llvmfunc|
  llvm.func @auto_gen_15_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_15_logical   : auto_gen_15_logical_before  ⊑  auto_gen_15_logical_combined := by
  unfold auto_gen_15_logical_before auto_gen_15_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_15_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_15_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_15_logical_fmf   : auto_gen_15_logical_fmf_before  ⊑  auto_gen_15_logical_fmf_combined := by
  unfold auto_gen_15_logical_fmf_before auto_gen_15_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_15_logical_fmf   : auto_gen_15_logical_fmf_before  ⊑  auto_gen_15_logical_fmf_combined := by
  unfold auto_gen_15_logical_fmf_before auto_gen_15_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_16_combined := [llvmfunc|
  llvm.func @auto_gen_16(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_16   : auto_gen_16_before  ⊑  auto_gen_16_combined := by
  unfold auto_gen_16_before auto_gen_16_combined
  simp_alive_peephole
  sorry
def auto_gen_16_logical_combined := [llvmfunc|
  llvm.func @auto_gen_16_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_16_logical   : auto_gen_16_logical_before  ⊑  auto_gen_16_logical_combined := by
  unfold auto_gen_16_logical_before auto_gen_16_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_16_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_16_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_16_logical_fmf   : auto_gen_16_logical_fmf_before  ⊑  auto_gen_16_logical_fmf_combined := by
  unfold auto_gen_16_logical_fmf_before auto_gen_16_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_17_combined := [llvmfunc|
  llvm.func @auto_gen_17(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_17   : auto_gen_17_before  ⊑  auto_gen_17_combined := by
  unfold auto_gen_17_before auto_gen_17_combined
  simp_alive_peephole
  sorry
def auto_gen_17_logical_combined := [llvmfunc|
  llvm.func @auto_gen_17_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_17_logical   : auto_gen_17_logical_before  ⊑  auto_gen_17_logical_combined := by
  unfold auto_gen_17_logical_before auto_gen_17_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_17_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_17_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_17_logical_fmf   : auto_gen_17_logical_fmf_before  ⊑  auto_gen_17_logical_fmf_combined := by
  unfold auto_gen_17_logical_fmf_before auto_gen_17_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_18_combined := [llvmfunc|
  llvm.func @auto_gen_18(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_18   : auto_gen_18_before  ⊑  auto_gen_18_combined := by
  unfold auto_gen_18_before auto_gen_18_combined
  simp_alive_peephole
  sorry
def auto_gen_18_logical_combined := [llvmfunc|
  llvm.func @auto_gen_18_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_18_logical   : auto_gen_18_logical_before  ⊑  auto_gen_18_logical_combined := by
  unfold auto_gen_18_logical_before auto_gen_18_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_18_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_18_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_18_logical_fmf   : auto_gen_18_logical_fmf_before  ⊑  auto_gen_18_logical_fmf_combined := by
  unfold auto_gen_18_logical_fmf_before auto_gen_18_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_19_combined := [llvmfunc|
  llvm.func @auto_gen_19(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_19   : auto_gen_19_before  ⊑  auto_gen_19_combined := by
  unfold auto_gen_19_before auto_gen_19_combined
  simp_alive_peephole
  sorry
def auto_gen_19_logical_combined := [llvmfunc|
  llvm.func @auto_gen_19_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_19_logical   : auto_gen_19_logical_before  ⊑  auto_gen_19_logical_combined := by
  unfold auto_gen_19_logical_before auto_gen_19_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_19_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_19_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_19_logical_fmf   : auto_gen_19_logical_fmf_before  ⊑  auto_gen_19_logical_fmf_combined := by
  unfold auto_gen_19_logical_fmf_before auto_gen_19_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_19_logical_fmf   : auto_gen_19_logical_fmf_before  ⊑  auto_gen_19_logical_fmf_combined := by
  unfold auto_gen_19_logical_fmf_before auto_gen_19_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_20_combined := [llvmfunc|
  llvm.func @auto_gen_20(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_20   : auto_gen_20_before  ⊑  auto_gen_20_combined := by
  unfold auto_gen_20_before auto_gen_20_combined
  simp_alive_peephole
  sorry
def auto_gen_20_logical_combined := [llvmfunc|
  llvm.func @auto_gen_20_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_20_logical   : auto_gen_20_logical_before  ⊑  auto_gen_20_logical_combined := by
  unfold auto_gen_20_logical_before auto_gen_20_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_20_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_20_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_20_logical_fmf   : auto_gen_20_logical_fmf_before  ⊑  auto_gen_20_logical_fmf_combined := by
  unfold auto_gen_20_logical_fmf_before auto_gen_20_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_21_combined := [llvmfunc|
  llvm.func @auto_gen_21(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_21   : auto_gen_21_before  ⊑  auto_gen_21_combined := by
  unfold auto_gen_21_before auto_gen_21_combined
  simp_alive_peephole
  sorry
def auto_gen_21_logical_combined := [llvmfunc|
  llvm.func @auto_gen_21_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_21_logical   : auto_gen_21_logical_before  ⊑  auto_gen_21_logical_combined := by
  unfold auto_gen_21_logical_before auto_gen_21_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_21_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_21_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_21_logical_fmf   : auto_gen_21_logical_fmf_before  ⊑  auto_gen_21_logical_fmf_combined := by
  unfold auto_gen_21_logical_fmf_before auto_gen_21_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_21_logical_fmf   : auto_gen_21_logical_fmf_before  ⊑  auto_gen_21_logical_fmf_combined := by
  unfold auto_gen_21_logical_fmf_before auto_gen_21_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_22_combined := [llvmfunc|
  llvm.func @auto_gen_22(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_22   : auto_gen_22_before  ⊑  auto_gen_22_combined := by
  unfold auto_gen_22_before auto_gen_22_combined
  simp_alive_peephole
  sorry
def auto_gen_22_logical_combined := [llvmfunc|
  llvm.func @auto_gen_22_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_22_logical   : auto_gen_22_logical_before  ⊑  auto_gen_22_logical_combined := by
  unfold auto_gen_22_logical_before auto_gen_22_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_22_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_22_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_22_logical_fmf   : auto_gen_22_logical_fmf_before  ⊑  auto_gen_22_logical_fmf_combined := by
  unfold auto_gen_22_logical_fmf_before auto_gen_22_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_23_combined := [llvmfunc|
  llvm.func @auto_gen_23(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_23   : auto_gen_23_before  ⊑  auto_gen_23_combined := by
  unfold auto_gen_23_before auto_gen_23_combined
  simp_alive_peephole
  sorry
def auto_gen_23_logical_combined := [llvmfunc|
  llvm.func @auto_gen_23_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_23_logical   : auto_gen_23_logical_before  ⊑  auto_gen_23_logical_combined := by
  unfold auto_gen_23_logical_before auto_gen_23_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_23_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_23_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_23_logical_fmf   : auto_gen_23_logical_fmf_before  ⊑  auto_gen_23_logical_fmf_combined := by
  unfold auto_gen_23_logical_fmf_before auto_gen_23_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_23_logical_fmf   : auto_gen_23_logical_fmf_before  ⊑  auto_gen_23_logical_fmf_combined := by
  unfold auto_gen_23_logical_fmf_before auto_gen_23_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_24_combined := [llvmfunc|
  llvm.func @auto_gen_24(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_24   : auto_gen_24_before  ⊑  auto_gen_24_combined := by
  unfold auto_gen_24_before auto_gen_24_combined
  simp_alive_peephole
  sorry
def auto_gen_24_logical_combined := [llvmfunc|
  llvm.func @auto_gen_24_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_24_logical   : auto_gen_24_logical_before  ⊑  auto_gen_24_logical_combined := by
  unfold auto_gen_24_logical_before auto_gen_24_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_24_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_24_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_24_logical_fmf   : auto_gen_24_logical_fmf_before  ⊑  auto_gen_24_logical_fmf_combined := by
  unfold auto_gen_24_logical_fmf_before auto_gen_24_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_25_combined := [llvmfunc|
  llvm.func @auto_gen_25(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_25   : auto_gen_25_before  ⊑  auto_gen_25_combined := by
  unfold auto_gen_25_before auto_gen_25_combined
  simp_alive_peephole
  sorry
def auto_gen_25_logical_combined := [llvmfunc|
  llvm.func @auto_gen_25_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_25_logical   : auto_gen_25_logical_before  ⊑  auto_gen_25_logical_combined := by
  unfold auto_gen_25_logical_before auto_gen_25_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_25_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_25_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_25_logical_fmf   : auto_gen_25_logical_fmf_before  ⊑  auto_gen_25_logical_fmf_combined := by
  unfold auto_gen_25_logical_fmf_before auto_gen_25_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_25_logical_fmf   : auto_gen_25_logical_fmf_before  ⊑  auto_gen_25_logical_fmf_combined := by
  unfold auto_gen_25_logical_fmf_before auto_gen_25_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_26_combined := [llvmfunc|
  llvm.func @auto_gen_26(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_26   : auto_gen_26_before  ⊑  auto_gen_26_combined := by
  unfold auto_gen_26_before auto_gen_26_combined
  simp_alive_peephole
  sorry
def auto_gen_26_logical_combined := [llvmfunc|
  llvm.func @auto_gen_26_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_26_logical   : auto_gen_26_logical_before  ⊑  auto_gen_26_logical_combined := by
  unfold auto_gen_26_logical_before auto_gen_26_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_26_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_26_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_26_logical_fmf   : auto_gen_26_logical_fmf_before  ⊑  auto_gen_26_logical_fmf_combined := by
  unfold auto_gen_26_logical_fmf_before auto_gen_26_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_27_combined := [llvmfunc|
  llvm.func @auto_gen_27(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_27   : auto_gen_27_before  ⊑  auto_gen_27_combined := by
  unfold auto_gen_27_before auto_gen_27_combined
  simp_alive_peephole
  sorry
def auto_gen_27_logical_combined := [llvmfunc|
  llvm.func @auto_gen_27_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_27_logical   : auto_gen_27_logical_before  ⊑  auto_gen_27_logical_combined := by
  unfold auto_gen_27_logical_before auto_gen_27_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_27_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_27_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_27_logical_fmf   : auto_gen_27_logical_fmf_before  ⊑  auto_gen_27_logical_fmf_combined := by
  unfold auto_gen_27_logical_fmf_before auto_gen_27_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_27_logical_fmf   : auto_gen_27_logical_fmf_before  ⊑  auto_gen_27_logical_fmf_combined := by
  unfold auto_gen_27_logical_fmf_before auto_gen_27_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_28_combined := [llvmfunc|
  llvm.func @auto_gen_28(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_28   : auto_gen_28_before  ⊑  auto_gen_28_combined := by
  unfold auto_gen_28_before auto_gen_28_combined
  simp_alive_peephole
  sorry
def auto_gen_28_logical_combined := [llvmfunc|
  llvm.func @auto_gen_28_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_28_logical   : auto_gen_28_logical_before  ⊑  auto_gen_28_logical_combined := by
  unfold auto_gen_28_logical_before auto_gen_28_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_28_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_28_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_28_logical_fmf   : auto_gen_28_logical_fmf_before  ⊑  auto_gen_28_logical_fmf_combined := by
  unfold auto_gen_28_logical_fmf_before auto_gen_28_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_29_combined := [llvmfunc|
  llvm.func @auto_gen_29(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_29   : auto_gen_29_before  ⊑  auto_gen_29_combined := by
  unfold auto_gen_29_before auto_gen_29_combined
  simp_alive_peephole
  sorry
def auto_gen_29_logical_combined := [llvmfunc|
  llvm.func @auto_gen_29_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_29_logical   : auto_gen_29_logical_before  ⊑  auto_gen_29_logical_combined := by
  unfold auto_gen_29_logical_before auto_gen_29_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_29_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_29_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_29_logical_fmf   : auto_gen_29_logical_fmf_before  ⊑  auto_gen_29_logical_fmf_combined := by
  unfold auto_gen_29_logical_fmf_before auto_gen_29_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_30_combined := [llvmfunc|
  llvm.func @auto_gen_30(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_30   : auto_gen_30_before  ⊑  auto_gen_30_combined := by
  unfold auto_gen_30_before auto_gen_30_combined
  simp_alive_peephole
  sorry
def auto_gen_30_logical_combined := [llvmfunc|
  llvm.func @auto_gen_30_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_30_logical   : auto_gen_30_logical_before  ⊑  auto_gen_30_logical_combined := by
  unfold auto_gen_30_logical_before auto_gen_30_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_30_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_30_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_30_logical_fmf   : auto_gen_30_logical_fmf_before  ⊑  auto_gen_30_logical_fmf_combined := by
  unfold auto_gen_30_logical_fmf_before auto_gen_30_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_31_combined := [llvmfunc|
  llvm.func @auto_gen_31(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_31   : auto_gen_31_before  ⊑  auto_gen_31_combined := by
  unfold auto_gen_31_before auto_gen_31_combined
  simp_alive_peephole
  sorry
def auto_gen_31_logical_combined := [llvmfunc|
  llvm.func @auto_gen_31_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_31_logical   : auto_gen_31_logical_before  ⊑  auto_gen_31_logical_combined := by
  unfold auto_gen_31_logical_before auto_gen_31_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_31_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_31_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_31_logical_fmf   : auto_gen_31_logical_fmf_before  ⊑  auto_gen_31_logical_fmf_combined := by
  unfold auto_gen_31_logical_fmf_before auto_gen_31_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_32_combined := [llvmfunc|
  llvm.func @auto_gen_32(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_32   : auto_gen_32_before  ⊑  auto_gen_32_combined := by
  unfold auto_gen_32_before auto_gen_32_combined
  simp_alive_peephole
  sorry
def auto_gen_32_logical_combined := [llvmfunc|
  llvm.func @auto_gen_32_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_32_logical   : auto_gen_32_logical_before  ⊑  auto_gen_32_logical_combined := by
  unfold auto_gen_32_logical_before auto_gen_32_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_32_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_32_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_32_logical_fmf   : auto_gen_32_logical_fmf_before  ⊑  auto_gen_32_logical_fmf_combined := by
  unfold auto_gen_32_logical_fmf_before auto_gen_32_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_33_combined := [llvmfunc|
  llvm.func @auto_gen_33(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_33   : auto_gen_33_before  ⊑  auto_gen_33_combined := by
  unfold auto_gen_33_before auto_gen_33_combined
  simp_alive_peephole
  sorry
def auto_gen_33_logical_combined := [llvmfunc|
  llvm.func @auto_gen_33_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_33_logical   : auto_gen_33_logical_before  ⊑  auto_gen_33_logical_combined := by
  unfold auto_gen_33_logical_before auto_gen_33_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_33_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_33_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_33_logical_fmf   : auto_gen_33_logical_fmf_before  ⊑  auto_gen_33_logical_fmf_combined := by
  unfold auto_gen_33_logical_fmf_before auto_gen_33_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_34_combined := [llvmfunc|
  llvm.func @auto_gen_34(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_34   : auto_gen_34_before  ⊑  auto_gen_34_combined := by
  unfold auto_gen_34_before auto_gen_34_combined
  simp_alive_peephole
  sorry
def auto_gen_34_logical_combined := [llvmfunc|
  llvm.func @auto_gen_34_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_34_logical   : auto_gen_34_logical_before  ⊑  auto_gen_34_logical_combined := by
  unfold auto_gen_34_logical_before auto_gen_34_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_34_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_34_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_34_logical_fmf   : auto_gen_34_logical_fmf_before  ⊑  auto_gen_34_logical_fmf_combined := by
  unfold auto_gen_34_logical_fmf_before auto_gen_34_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_35_combined := [llvmfunc|
  llvm.func @auto_gen_35(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_35   : auto_gen_35_before  ⊑  auto_gen_35_combined := by
  unfold auto_gen_35_before auto_gen_35_combined
  simp_alive_peephole
  sorry
def auto_gen_35_logical_combined := [llvmfunc|
  llvm.func @auto_gen_35_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_35_logical   : auto_gen_35_logical_before  ⊑  auto_gen_35_logical_combined := by
  unfold auto_gen_35_logical_before auto_gen_35_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_35_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_35_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_35_logical_fmf   : auto_gen_35_logical_fmf_before  ⊑  auto_gen_35_logical_fmf_combined := by
  unfold auto_gen_35_logical_fmf_before auto_gen_35_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_36_combined := [llvmfunc|
  llvm.func @auto_gen_36(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_36   : auto_gen_36_before  ⊑  auto_gen_36_combined := by
  unfold auto_gen_36_before auto_gen_36_combined
  simp_alive_peephole
  sorry
def auto_gen_36_logical_combined := [llvmfunc|
  llvm.func @auto_gen_36_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_36_logical   : auto_gen_36_logical_before  ⊑  auto_gen_36_logical_combined := by
  unfold auto_gen_36_logical_before auto_gen_36_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_36_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_36_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_36_logical_fmf   : auto_gen_36_logical_fmf_before  ⊑  auto_gen_36_logical_fmf_combined := by
  unfold auto_gen_36_logical_fmf_before auto_gen_36_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_37_combined := [llvmfunc|
  llvm.func @auto_gen_37(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_37   : auto_gen_37_before  ⊑  auto_gen_37_combined := by
  unfold auto_gen_37_before auto_gen_37_combined
  simp_alive_peephole
  sorry
def auto_gen_37_logical_combined := [llvmfunc|
  llvm.func @auto_gen_37_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_37_logical   : auto_gen_37_logical_before  ⊑  auto_gen_37_logical_combined := by
  unfold auto_gen_37_logical_before auto_gen_37_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_37_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_37_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_37_logical_fmf   : auto_gen_37_logical_fmf_before  ⊑  auto_gen_37_logical_fmf_combined := by
  unfold auto_gen_37_logical_fmf_before auto_gen_37_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_37_logical_fmf   : auto_gen_37_logical_fmf_before  ⊑  auto_gen_37_logical_fmf_combined := by
  unfold auto_gen_37_logical_fmf_before auto_gen_37_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_38_combined := [llvmfunc|
  llvm.func @auto_gen_38(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_38   : auto_gen_38_before  ⊑  auto_gen_38_combined := by
  unfold auto_gen_38_before auto_gen_38_combined
  simp_alive_peephole
  sorry
def auto_gen_38_logical_combined := [llvmfunc|
  llvm.func @auto_gen_38_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_38_logical   : auto_gen_38_logical_before  ⊑  auto_gen_38_logical_combined := by
  unfold auto_gen_38_logical_before auto_gen_38_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_38_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_38_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_38_logical_fmf   : auto_gen_38_logical_fmf_before  ⊑  auto_gen_38_logical_fmf_combined := by
  unfold auto_gen_38_logical_fmf_before auto_gen_38_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_39_combined := [llvmfunc|
  llvm.func @auto_gen_39(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_39   : auto_gen_39_before  ⊑  auto_gen_39_combined := by
  unfold auto_gen_39_before auto_gen_39_combined
  simp_alive_peephole
  sorry
def auto_gen_39_logical_combined := [llvmfunc|
  llvm.func @auto_gen_39_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_39_logical   : auto_gen_39_logical_before  ⊑  auto_gen_39_logical_combined := by
  unfold auto_gen_39_logical_before auto_gen_39_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_39_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_39_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_39_logical_fmf   : auto_gen_39_logical_fmf_before  ⊑  auto_gen_39_logical_fmf_combined := by
  unfold auto_gen_39_logical_fmf_before auto_gen_39_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_39_logical_fmf   : auto_gen_39_logical_fmf_before  ⊑  auto_gen_39_logical_fmf_combined := by
  unfold auto_gen_39_logical_fmf_before auto_gen_39_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_40_combined := [llvmfunc|
  llvm.func @auto_gen_40(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_40   : auto_gen_40_before  ⊑  auto_gen_40_combined := by
  unfold auto_gen_40_before auto_gen_40_combined
  simp_alive_peephole
  sorry
def auto_gen_40_logical_combined := [llvmfunc|
  llvm.func @auto_gen_40_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_40_logical   : auto_gen_40_logical_before  ⊑  auto_gen_40_logical_combined := by
  unfold auto_gen_40_logical_before auto_gen_40_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_40_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_40_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_40_logical_fmf   : auto_gen_40_logical_fmf_before  ⊑  auto_gen_40_logical_fmf_combined := by
  unfold auto_gen_40_logical_fmf_before auto_gen_40_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_41_combined := [llvmfunc|
  llvm.func @auto_gen_41(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_41   : auto_gen_41_before  ⊑  auto_gen_41_combined := by
  unfold auto_gen_41_before auto_gen_41_combined
  simp_alive_peephole
  sorry
def auto_gen_41_logical_combined := [llvmfunc|
  llvm.func @auto_gen_41_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_41_logical   : auto_gen_41_logical_before  ⊑  auto_gen_41_logical_combined := by
  unfold auto_gen_41_logical_before auto_gen_41_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_41_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_41_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_41_logical_fmf   : auto_gen_41_logical_fmf_before  ⊑  auto_gen_41_logical_fmf_combined := by
  unfold auto_gen_41_logical_fmf_before auto_gen_41_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_41_logical_fmf   : auto_gen_41_logical_fmf_before  ⊑  auto_gen_41_logical_fmf_combined := by
  unfold auto_gen_41_logical_fmf_before auto_gen_41_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_42_combined := [llvmfunc|
  llvm.func @auto_gen_42(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_42   : auto_gen_42_before  ⊑  auto_gen_42_combined := by
  unfold auto_gen_42_before auto_gen_42_combined
  simp_alive_peephole
  sorry
def auto_gen_42_logical_combined := [llvmfunc|
  llvm.func @auto_gen_42_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_42_logical   : auto_gen_42_logical_before  ⊑  auto_gen_42_logical_combined := by
  unfold auto_gen_42_logical_before auto_gen_42_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_42_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_42_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_42_logical_fmf   : auto_gen_42_logical_fmf_before  ⊑  auto_gen_42_logical_fmf_combined := by
  unfold auto_gen_42_logical_fmf_before auto_gen_42_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_43_combined := [llvmfunc|
  llvm.func @auto_gen_43(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_43   : auto_gen_43_before  ⊑  auto_gen_43_combined := by
  unfold auto_gen_43_before auto_gen_43_combined
  simp_alive_peephole
  sorry
def auto_gen_43_logical_combined := [llvmfunc|
  llvm.func @auto_gen_43_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_43_logical   : auto_gen_43_logical_before  ⊑  auto_gen_43_logical_combined := by
  unfold auto_gen_43_logical_before auto_gen_43_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_43_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_43_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_43_logical_fmf   : auto_gen_43_logical_fmf_before  ⊑  auto_gen_43_logical_fmf_combined := by
  unfold auto_gen_43_logical_fmf_before auto_gen_43_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_44_combined := [llvmfunc|
  llvm.func @auto_gen_44(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_44   : auto_gen_44_before  ⊑  auto_gen_44_combined := by
  unfold auto_gen_44_before auto_gen_44_combined
  simp_alive_peephole
  sorry
def auto_gen_44_logical_combined := [llvmfunc|
  llvm.func @auto_gen_44_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_44_logical   : auto_gen_44_logical_before  ⊑  auto_gen_44_logical_combined := by
  unfold auto_gen_44_logical_before auto_gen_44_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_44_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_44_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_44_logical_fmf   : auto_gen_44_logical_fmf_before  ⊑  auto_gen_44_logical_fmf_combined := by
  unfold auto_gen_44_logical_fmf_before auto_gen_44_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_45_combined := [llvmfunc|
  llvm.func @auto_gen_45(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_45   : auto_gen_45_before  ⊑  auto_gen_45_combined := by
  unfold auto_gen_45_before auto_gen_45_combined
  simp_alive_peephole
  sorry
def auto_gen_45_logical_combined := [llvmfunc|
  llvm.func @auto_gen_45_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_45_logical   : auto_gen_45_logical_before  ⊑  auto_gen_45_logical_combined := by
  unfold auto_gen_45_logical_before auto_gen_45_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_45_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_45_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_45_logical_fmf   : auto_gen_45_logical_fmf_before  ⊑  auto_gen_45_logical_fmf_combined := by
  unfold auto_gen_45_logical_fmf_before auto_gen_45_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_45_logical_fmf   : auto_gen_45_logical_fmf_before  ⊑  auto_gen_45_logical_fmf_combined := by
  unfold auto_gen_45_logical_fmf_before auto_gen_45_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_46_combined := [llvmfunc|
  llvm.func @auto_gen_46(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_46   : auto_gen_46_before  ⊑  auto_gen_46_combined := by
  unfold auto_gen_46_before auto_gen_46_combined
  simp_alive_peephole
  sorry
def auto_gen_46_logical_combined := [llvmfunc|
  llvm.func @auto_gen_46_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_46_logical   : auto_gen_46_logical_before  ⊑  auto_gen_46_logical_combined := by
  unfold auto_gen_46_logical_before auto_gen_46_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_46_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_46_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_46_logical_fmf   : auto_gen_46_logical_fmf_before  ⊑  auto_gen_46_logical_fmf_combined := by
  unfold auto_gen_46_logical_fmf_before auto_gen_46_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_47_combined := [llvmfunc|
  llvm.func @auto_gen_47(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_47   : auto_gen_47_before  ⊑  auto_gen_47_combined := by
  unfold auto_gen_47_before auto_gen_47_combined
  simp_alive_peephole
  sorry
def auto_gen_47_logical_combined := [llvmfunc|
  llvm.func @auto_gen_47_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_47_logical   : auto_gen_47_logical_before  ⊑  auto_gen_47_logical_combined := by
  unfold auto_gen_47_logical_before auto_gen_47_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_47_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_47_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_47_logical_fmf   : auto_gen_47_logical_fmf_before  ⊑  auto_gen_47_logical_fmf_combined := by
  unfold auto_gen_47_logical_fmf_before auto_gen_47_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_47_logical_fmf   : auto_gen_47_logical_fmf_before  ⊑  auto_gen_47_logical_fmf_combined := by
  unfold auto_gen_47_logical_fmf_before auto_gen_47_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_48_combined := [llvmfunc|
  llvm.func @auto_gen_48(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_48   : auto_gen_48_before  ⊑  auto_gen_48_combined := by
  unfold auto_gen_48_before auto_gen_48_combined
  simp_alive_peephole
  sorry
def auto_gen_48_logical_combined := [llvmfunc|
  llvm.func @auto_gen_48_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_48_logical   : auto_gen_48_logical_before  ⊑  auto_gen_48_logical_combined := by
  unfold auto_gen_48_logical_before auto_gen_48_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_48_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_48_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_48_logical_fmf   : auto_gen_48_logical_fmf_before  ⊑  auto_gen_48_logical_fmf_combined := by
  unfold auto_gen_48_logical_fmf_before auto_gen_48_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_49_combined := [llvmfunc|
  llvm.func @auto_gen_49(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_49   : auto_gen_49_before  ⊑  auto_gen_49_combined := by
  unfold auto_gen_49_before auto_gen_49_combined
  simp_alive_peephole
  sorry
def auto_gen_49_logical_combined := [llvmfunc|
  llvm.func @auto_gen_49_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_49_logical   : auto_gen_49_logical_before  ⊑  auto_gen_49_logical_combined := by
  unfold auto_gen_49_logical_before auto_gen_49_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_49_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_49_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_49_logical_fmf   : auto_gen_49_logical_fmf_before  ⊑  auto_gen_49_logical_fmf_combined := by
  unfold auto_gen_49_logical_fmf_before auto_gen_49_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_49_logical_fmf   : auto_gen_49_logical_fmf_before  ⊑  auto_gen_49_logical_fmf_combined := by
  unfold auto_gen_49_logical_fmf_before auto_gen_49_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_50_combined := [llvmfunc|
  llvm.func @auto_gen_50(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_50   : auto_gen_50_before  ⊑  auto_gen_50_combined := by
  unfold auto_gen_50_before auto_gen_50_combined
  simp_alive_peephole
  sorry
def auto_gen_50_logical_combined := [llvmfunc|
  llvm.func @auto_gen_50_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_50_logical   : auto_gen_50_logical_before  ⊑  auto_gen_50_logical_combined := by
  unfold auto_gen_50_logical_before auto_gen_50_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_50_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_50_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_50_logical_fmf   : auto_gen_50_logical_fmf_before  ⊑  auto_gen_50_logical_fmf_combined := by
  unfold auto_gen_50_logical_fmf_before auto_gen_50_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_51_combined := [llvmfunc|
  llvm.func @auto_gen_51(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_51   : auto_gen_51_before  ⊑  auto_gen_51_combined := by
  unfold auto_gen_51_before auto_gen_51_combined
  simp_alive_peephole
  sorry
def auto_gen_51_logical_combined := [llvmfunc|
  llvm.func @auto_gen_51_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_51_logical   : auto_gen_51_logical_before  ⊑  auto_gen_51_logical_combined := by
  unfold auto_gen_51_logical_before auto_gen_51_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_51_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_51_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_51_logical_fmf   : auto_gen_51_logical_fmf_before  ⊑  auto_gen_51_logical_fmf_combined := by
  unfold auto_gen_51_logical_fmf_before auto_gen_51_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_51_logical_fmf   : auto_gen_51_logical_fmf_before  ⊑  auto_gen_51_logical_fmf_combined := by
  unfold auto_gen_51_logical_fmf_before auto_gen_51_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_52_combined := [llvmfunc|
  llvm.func @auto_gen_52(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_52   : auto_gen_52_before  ⊑  auto_gen_52_combined := by
  unfold auto_gen_52_before auto_gen_52_combined
  simp_alive_peephole
  sorry
def auto_gen_52_logical_combined := [llvmfunc|
  llvm.func @auto_gen_52_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_52_logical   : auto_gen_52_logical_before  ⊑  auto_gen_52_logical_combined := by
  unfold auto_gen_52_logical_before auto_gen_52_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_52_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_52_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_52_logical_fmf   : auto_gen_52_logical_fmf_before  ⊑  auto_gen_52_logical_fmf_combined := by
  unfold auto_gen_52_logical_fmf_before auto_gen_52_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_53_combined := [llvmfunc|
  llvm.func @auto_gen_53(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_53   : auto_gen_53_before  ⊑  auto_gen_53_combined := by
  unfold auto_gen_53_before auto_gen_53_combined
  simp_alive_peephole
  sorry
def auto_gen_53_logical_combined := [llvmfunc|
  llvm.func @auto_gen_53_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_53_logical   : auto_gen_53_logical_before  ⊑  auto_gen_53_logical_combined := by
  unfold auto_gen_53_logical_before auto_gen_53_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_53_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_53_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_53_logical_fmf   : auto_gen_53_logical_fmf_before  ⊑  auto_gen_53_logical_fmf_combined := by
  unfold auto_gen_53_logical_fmf_before auto_gen_53_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_53_logical_fmf   : auto_gen_53_logical_fmf_before  ⊑  auto_gen_53_logical_fmf_combined := by
  unfold auto_gen_53_logical_fmf_before auto_gen_53_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_54_combined := [llvmfunc|
  llvm.func @auto_gen_54(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_54   : auto_gen_54_before  ⊑  auto_gen_54_combined := by
  unfold auto_gen_54_before auto_gen_54_combined
  simp_alive_peephole
  sorry
def auto_gen_54_logical_combined := [llvmfunc|
  llvm.func @auto_gen_54_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_54_logical   : auto_gen_54_logical_before  ⊑  auto_gen_54_logical_combined := by
  unfold auto_gen_54_logical_before auto_gen_54_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_54_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_54_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_54_logical_fmf   : auto_gen_54_logical_fmf_before  ⊑  auto_gen_54_logical_fmf_combined := by
  unfold auto_gen_54_logical_fmf_before auto_gen_54_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_55_combined := [llvmfunc|
  llvm.func @auto_gen_55(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_55   : auto_gen_55_before  ⊑  auto_gen_55_combined := by
  unfold auto_gen_55_before auto_gen_55_combined
  simp_alive_peephole
  sorry
def auto_gen_55_logical_combined := [llvmfunc|
  llvm.func @auto_gen_55_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_55_logical   : auto_gen_55_logical_before  ⊑  auto_gen_55_logical_combined := by
  unfold auto_gen_55_logical_before auto_gen_55_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_55_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_55_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_55_logical_fmf   : auto_gen_55_logical_fmf_before  ⊑  auto_gen_55_logical_fmf_combined := by
  unfold auto_gen_55_logical_fmf_before auto_gen_55_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_55_logical_fmf   : auto_gen_55_logical_fmf_before  ⊑  auto_gen_55_logical_fmf_combined := by
  unfold auto_gen_55_logical_fmf_before auto_gen_55_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_56_combined := [llvmfunc|
  llvm.func @auto_gen_56(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_56   : auto_gen_56_before  ⊑  auto_gen_56_combined := by
  unfold auto_gen_56_before auto_gen_56_combined
  simp_alive_peephole
  sorry
def auto_gen_56_logical_combined := [llvmfunc|
  llvm.func @auto_gen_56_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_56_logical   : auto_gen_56_logical_before  ⊑  auto_gen_56_logical_combined := by
  unfold auto_gen_56_logical_before auto_gen_56_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_56_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_56_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_56_logical_fmf   : auto_gen_56_logical_fmf_before  ⊑  auto_gen_56_logical_fmf_combined := by
  unfold auto_gen_56_logical_fmf_before auto_gen_56_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_57_combined := [llvmfunc|
  llvm.func @auto_gen_57(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_57   : auto_gen_57_before  ⊑  auto_gen_57_combined := by
  unfold auto_gen_57_before auto_gen_57_combined
  simp_alive_peephole
  sorry
def auto_gen_57_logical_combined := [llvmfunc|
  llvm.func @auto_gen_57_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_57_logical   : auto_gen_57_logical_before  ⊑  auto_gen_57_logical_combined := by
  unfold auto_gen_57_logical_before auto_gen_57_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_57_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_57_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_57_logical_fmf   : auto_gen_57_logical_fmf_before  ⊑  auto_gen_57_logical_fmf_combined := by
  unfold auto_gen_57_logical_fmf_before auto_gen_57_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_57_logical_fmf   : auto_gen_57_logical_fmf_before  ⊑  auto_gen_57_logical_fmf_combined := by
  unfold auto_gen_57_logical_fmf_before auto_gen_57_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_58_combined := [llvmfunc|
  llvm.func @auto_gen_58(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_58   : auto_gen_58_before  ⊑  auto_gen_58_combined := by
  unfold auto_gen_58_before auto_gen_58_combined
  simp_alive_peephole
  sorry
def auto_gen_58_logical_combined := [llvmfunc|
  llvm.func @auto_gen_58_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_58_logical   : auto_gen_58_logical_before  ⊑  auto_gen_58_logical_combined := by
  unfold auto_gen_58_logical_before auto_gen_58_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_58_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_58_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_58_logical_fmf   : auto_gen_58_logical_fmf_before  ⊑  auto_gen_58_logical_fmf_combined := by
  unfold auto_gen_58_logical_fmf_before auto_gen_58_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_59_combined := [llvmfunc|
  llvm.func @auto_gen_59(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_59   : auto_gen_59_before  ⊑  auto_gen_59_combined := by
  unfold auto_gen_59_before auto_gen_59_combined
  simp_alive_peephole
  sorry
def auto_gen_59_logical_combined := [llvmfunc|
  llvm.func @auto_gen_59_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_59_logical   : auto_gen_59_logical_before  ⊑  auto_gen_59_logical_combined := by
  unfold auto_gen_59_logical_before auto_gen_59_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_59_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_59_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_59_logical_fmf   : auto_gen_59_logical_fmf_before  ⊑  auto_gen_59_logical_fmf_combined := by
  unfold auto_gen_59_logical_fmf_before auto_gen_59_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_60_combined := [llvmfunc|
  llvm.func @auto_gen_60(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_60   : auto_gen_60_before  ⊑  auto_gen_60_combined := by
  unfold auto_gen_60_before auto_gen_60_combined
  simp_alive_peephole
  sorry
def auto_gen_60_logical_combined := [llvmfunc|
  llvm.func @auto_gen_60_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_60_logical   : auto_gen_60_logical_before  ⊑  auto_gen_60_logical_combined := by
  unfold auto_gen_60_logical_before auto_gen_60_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_60_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_60_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_60_logical_fmf   : auto_gen_60_logical_fmf_before  ⊑  auto_gen_60_logical_fmf_combined := by
  unfold auto_gen_60_logical_fmf_before auto_gen_60_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_61_combined := [llvmfunc|
  llvm.func @auto_gen_61(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_61   : auto_gen_61_before  ⊑  auto_gen_61_combined := by
  unfold auto_gen_61_before auto_gen_61_combined
  simp_alive_peephole
  sorry
def auto_gen_61_logical_combined := [llvmfunc|
  llvm.func @auto_gen_61_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_61_logical   : auto_gen_61_logical_before  ⊑  auto_gen_61_logical_combined := by
  unfold auto_gen_61_logical_before auto_gen_61_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_61_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_61_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_61_logical_fmf   : auto_gen_61_logical_fmf_before  ⊑  auto_gen_61_logical_fmf_combined := by
  unfold auto_gen_61_logical_fmf_before auto_gen_61_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_62_combined := [llvmfunc|
  llvm.func @auto_gen_62(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_62   : auto_gen_62_before  ⊑  auto_gen_62_combined := by
  unfold auto_gen_62_before auto_gen_62_combined
  simp_alive_peephole
  sorry
def auto_gen_62_logical_combined := [llvmfunc|
  llvm.func @auto_gen_62_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_62_logical   : auto_gen_62_logical_before  ⊑  auto_gen_62_logical_combined := by
  unfold auto_gen_62_logical_before auto_gen_62_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_62_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_62_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_62_logical_fmf   : auto_gen_62_logical_fmf_before  ⊑  auto_gen_62_logical_fmf_combined := by
  unfold auto_gen_62_logical_fmf_before auto_gen_62_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_63_combined := [llvmfunc|
  llvm.func @auto_gen_63(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_63   : auto_gen_63_before  ⊑  auto_gen_63_combined := by
  unfold auto_gen_63_before auto_gen_63_combined
  simp_alive_peephole
  sorry
def auto_gen_63_logical_combined := [llvmfunc|
  llvm.func @auto_gen_63_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_63_logical   : auto_gen_63_logical_before  ⊑  auto_gen_63_logical_combined := by
  unfold auto_gen_63_logical_before auto_gen_63_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_63_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_63_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_63_logical_fmf   : auto_gen_63_logical_fmf_before  ⊑  auto_gen_63_logical_fmf_combined := by
  unfold auto_gen_63_logical_fmf_before auto_gen_63_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_63_logical_fmf   : auto_gen_63_logical_fmf_before  ⊑  auto_gen_63_logical_fmf_combined := by
  unfold auto_gen_63_logical_fmf_before auto_gen_63_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_64_combined := [llvmfunc|
  llvm.func @auto_gen_64(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_64   : auto_gen_64_before  ⊑  auto_gen_64_combined := by
  unfold auto_gen_64_before auto_gen_64_combined
  simp_alive_peephole
  sorry
def auto_gen_64_logical_combined := [llvmfunc|
  llvm.func @auto_gen_64_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_64_logical   : auto_gen_64_logical_before  ⊑  auto_gen_64_logical_combined := by
  unfold auto_gen_64_logical_before auto_gen_64_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_64_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_64_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_64_logical_fmf   : auto_gen_64_logical_fmf_before  ⊑  auto_gen_64_logical_fmf_combined := by
  unfold auto_gen_64_logical_fmf_before auto_gen_64_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_65_combined := [llvmfunc|
  llvm.func @auto_gen_65(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_65   : auto_gen_65_before  ⊑  auto_gen_65_combined := by
  unfold auto_gen_65_before auto_gen_65_combined
  simp_alive_peephole
  sorry
def auto_gen_65_logical_combined := [llvmfunc|
  llvm.func @auto_gen_65_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_65_logical   : auto_gen_65_logical_before  ⊑  auto_gen_65_logical_combined := by
  unfold auto_gen_65_logical_before auto_gen_65_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_65_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_65_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_65_logical_fmf   : auto_gen_65_logical_fmf_before  ⊑  auto_gen_65_logical_fmf_combined := by
  unfold auto_gen_65_logical_fmf_before auto_gen_65_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_65_logical_fmf   : auto_gen_65_logical_fmf_before  ⊑  auto_gen_65_logical_fmf_combined := by
  unfold auto_gen_65_logical_fmf_before auto_gen_65_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_66_combined := [llvmfunc|
  llvm.func @auto_gen_66(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_66   : auto_gen_66_before  ⊑  auto_gen_66_combined := by
  unfold auto_gen_66_before auto_gen_66_combined
  simp_alive_peephole
  sorry
def auto_gen_66_logical_combined := [llvmfunc|
  llvm.func @auto_gen_66_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_66_logical   : auto_gen_66_logical_before  ⊑  auto_gen_66_logical_combined := by
  unfold auto_gen_66_logical_before auto_gen_66_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_66_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_66_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_66_logical_fmf   : auto_gen_66_logical_fmf_before  ⊑  auto_gen_66_logical_fmf_combined := by
  unfold auto_gen_66_logical_fmf_before auto_gen_66_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_67_combined := [llvmfunc|
  llvm.func @auto_gen_67(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_67   : auto_gen_67_before  ⊑  auto_gen_67_combined := by
  unfold auto_gen_67_before auto_gen_67_combined
  simp_alive_peephole
  sorry
def auto_gen_67_logical_combined := [llvmfunc|
  llvm.func @auto_gen_67_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_67_logical   : auto_gen_67_logical_before  ⊑  auto_gen_67_logical_combined := by
  unfold auto_gen_67_logical_before auto_gen_67_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_67_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_67_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_67_logical_fmf   : auto_gen_67_logical_fmf_before  ⊑  auto_gen_67_logical_fmf_combined := by
  unfold auto_gen_67_logical_fmf_before auto_gen_67_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_67_logical_fmf   : auto_gen_67_logical_fmf_before  ⊑  auto_gen_67_logical_fmf_combined := by
  unfold auto_gen_67_logical_fmf_before auto_gen_67_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_68_combined := [llvmfunc|
  llvm.func @auto_gen_68(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_68   : auto_gen_68_before  ⊑  auto_gen_68_combined := by
  unfold auto_gen_68_before auto_gen_68_combined
  simp_alive_peephole
  sorry
def auto_gen_68_logical_combined := [llvmfunc|
  llvm.func @auto_gen_68_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_68_logical   : auto_gen_68_logical_before  ⊑  auto_gen_68_logical_combined := by
  unfold auto_gen_68_logical_before auto_gen_68_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_68_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_68_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_68_logical_fmf   : auto_gen_68_logical_fmf_before  ⊑  auto_gen_68_logical_fmf_combined := by
  unfold auto_gen_68_logical_fmf_before auto_gen_68_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_69_combined := [llvmfunc|
  llvm.func @auto_gen_69(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_69   : auto_gen_69_before  ⊑  auto_gen_69_combined := by
  unfold auto_gen_69_before auto_gen_69_combined
  simp_alive_peephole
  sorry
def auto_gen_69_logical_combined := [llvmfunc|
  llvm.func @auto_gen_69_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_69_logical   : auto_gen_69_logical_before  ⊑  auto_gen_69_logical_combined := by
  unfold auto_gen_69_logical_before auto_gen_69_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_69_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_69_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_69_logical_fmf   : auto_gen_69_logical_fmf_before  ⊑  auto_gen_69_logical_fmf_combined := by
  unfold auto_gen_69_logical_fmf_before auto_gen_69_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_70_combined := [llvmfunc|
  llvm.func @auto_gen_70(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_70   : auto_gen_70_before  ⊑  auto_gen_70_combined := by
  unfold auto_gen_70_before auto_gen_70_combined
  simp_alive_peephole
  sorry
def auto_gen_70_logical_combined := [llvmfunc|
  llvm.func @auto_gen_70_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_70_logical   : auto_gen_70_logical_before  ⊑  auto_gen_70_logical_combined := by
  unfold auto_gen_70_logical_before auto_gen_70_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_70_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_70_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_70_logical_fmf   : auto_gen_70_logical_fmf_before  ⊑  auto_gen_70_logical_fmf_combined := by
  unfold auto_gen_70_logical_fmf_before auto_gen_70_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_71_combined := [llvmfunc|
  llvm.func @auto_gen_71(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_71   : auto_gen_71_before  ⊑  auto_gen_71_combined := by
  unfold auto_gen_71_before auto_gen_71_combined
  simp_alive_peephole
  sorry
def auto_gen_71_logical_combined := [llvmfunc|
  llvm.func @auto_gen_71_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_71_logical   : auto_gen_71_logical_before  ⊑  auto_gen_71_logical_combined := by
  unfold auto_gen_71_logical_before auto_gen_71_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_71_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_71_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_71_logical_fmf   : auto_gen_71_logical_fmf_before  ⊑  auto_gen_71_logical_fmf_combined := by
  unfold auto_gen_71_logical_fmf_before auto_gen_71_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_71_logical_fmf   : auto_gen_71_logical_fmf_before  ⊑  auto_gen_71_logical_fmf_combined := by
  unfold auto_gen_71_logical_fmf_before auto_gen_71_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_72_combined := [llvmfunc|
  llvm.func @auto_gen_72(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_72   : auto_gen_72_before  ⊑  auto_gen_72_combined := by
  unfold auto_gen_72_before auto_gen_72_combined
  simp_alive_peephole
  sorry
def auto_gen_72_logical_combined := [llvmfunc|
  llvm.func @auto_gen_72_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_72_logical   : auto_gen_72_logical_before  ⊑  auto_gen_72_logical_combined := by
  unfold auto_gen_72_logical_before auto_gen_72_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_72_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_72_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_72_logical_fmf   : auto_gen_72_logical_fmf_before  ⊑  auto_gen_72_logical_fmf_combined := by
  unfold auto_gen_72_logical_fmf_before auto_gen_72_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_73_combined := [llvmfunc|
  llvm.func @auto_gen_73(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_73   : auto_gen_73_before  ⊑  auto_gen_73_combined := by
  unfold auto_gen_73_before auto_gen_73_combined
  simp_alive_peephole
  sorry
def auto_gen_73_logical_combined := [llvmfunc|
  llvm.func @auto_gen_73_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_73_logical   : auto_gen_73_logical_before  ⊑  auto_gen_73_logical_combined := by
  unfold auto_gen_73_logical_before auto_gen_73_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_73_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_73_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_73_logical_fmf   : auto_gen_73_logical_fmf_before  ⊑  auto_gen_73_logical_fmf_combined := by
  unfold auto_gen_73_logical_fmf_before auto_gen_73_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_74_combined := [llvmfunc|
  llvm.func @auto_gen_74(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_74   : auto_gen_74_before  ⊑  auto_gen_74_combined := by
  unfold auto_gen_74_before auto_gen_74_combined
  simp_alive_peephole
  sorry
def auto_gen_74_logical_combined := [llvmfunc|
  llvm.func @auto_gen_74_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_74_logical   : auto_gen_74_logical_before  ⊑  auto_gen_74_logical_combined := by
  unfold auto_gen_74_logical_before auto_gen_74_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_74_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_74_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_74_logical_fmf   : auto_gen_74_logical_fmf_before  ⊑  auto_gen_74_logical_fmf_combined := by
  unfold auto_gen_74_logical_fmf_before auto_gen_74_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_75_combined := [llvmfunc|
  llvm.func @auto_gen_75(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_75   : auto_gen_75_before  ⊑  auto_gen_75_combined := by
  unfold auto_gen_75_before auto_gen_75_combined
  simp_alive_peephole
  sorry
def auto_gen_75_logical_combined := [llvmfunc|
  llvm.func @auto_gen_75_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_75_logical   : auto_gen_75_logical_before  ⊑  auto_gen_75_logical_combined := by
  unfold auto_gen_75_logical_before auto_gen_75_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_75_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_75_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_75_logical_fmf   : auto_gen_75_logical_fmf_before  ⊑  auto_gen_75_logical_fmf_combined := by
  unfold auto_gen_75_logical_fmf_before auto_gen_75_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_75_logical_fmf   : auto_gen_75_logical_fmf_before  ⊑  auto_gen_75_logical_fmf_combined := by
  unfold auto_gen_75_logical_fmf_before auto_gen_75_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_76_combined := [llvmfunc|
  llvm.func @auto_gen_76(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_76   : auto_gen_76_before  ⊑  auto_gen_76_combined := by
  unfold auto_gen_76_before auto_gen_76_combined
  simp_alive_peephole
  sorry
def auto_gen_76_logical_combined := [llvmfunc|
  llvm.func @auto_gen_76_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_76_logical   : auto_gen_76_logical_before  ⊑  auto_gen_76_logical_combined := by
  unfold auto_gen_76_logical_before auto_gen_76_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_76_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_76_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_76_logical_fmf   : auto_gen_76_logical_fmf_before  ⊑  auto_gen_76_logical_fmf_combined := by
  unfold auto_gen_76_logical_fmf_before auto_gen_76_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_77_combined := [llvmfunc|
  llvm.func @auto_gen_77(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_77   : auto_gen_77_before  ⊑  auto_gen_77_combined := by
  unfold auto_gen_77_before auto_gen_77_combined
  simp_alive_peephole
  sorry
def auto_gen_77_logical_combined := [llvmfunc|
  llvm.func @auto_gen_77_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_77_logical   : auto_gen_77_logical_before  ⊑  auto_gen_77_logical_combined := by
  unfold auto_gen_77_logical_before auto_gen_77_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_77_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_77_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_77_logical_fmf   : auto_gen_77_logical_fmf_before  ⊑  auto_gen_77_logical_fmf_combined := by
  unfold auto_gen_77_logical_fmf_before auto_gen_77_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_77_logical_fmf   : auto_gen_77_logical_fmf_before  ⊑  auto_gen_77_logical_fmf_combined := by
  unfold auto_gen_77_logical_fmf_before auto_gen_77_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_78_combined := [llvmfunc|
  llvm.func @auto_gen_78(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_78   : auto_gen_78_before  ⊑  auto_gen_78_combined := by
  unfold auto_gen_78_before auto_gen_78_combined
  simp_alive_peephole
  sorry
def auto_gen_78_logical_combined := [llvmfunc|
  llvm.func @auto_gen_78_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_78_logical   : auto_gen_78_logical_before  ⊑  auto_gen_78_logical_combined := by
  unfold auto_gen_78_logical_before auto_gen_78_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_78_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_78_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_78_logical_fmf   : auto_gen_78_logical_fmf_before  ⊑  auto_gen_78_logical_fmf_combined := by
  unfold auto_gen_78_logical_fmf_before auto_gen_78_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_79_combined := [llvmfunc|
  llvm.func @auto_gen_79(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_79   : auto_gen_79_before  ⊑  auto_gen_79_combined := by
  unfold auto_gen_79_before auto_gen_79_combined
  simp_alive_peephole
  sorry
def auto_gen_79_logical_combined := [llvmfunc|
  llvm.func @auto_gen_79_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_79_logical   : auto_gen_79_logical_before  ⊑  auto_gen_79_logical_combined := by
  unfold auto_gen_79_logical_before auto_gen_79_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_79_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_79_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_79_logical_fmf   : auto_gen_79_logical_fmf_before  ⊑  auto_gen_79_logical_fmf_combined := by
  unfold auto_gen_79_logical_fmf_before auto_gen_79_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_79_logical_fmf   : auto_gen_79_logical_fmf_before  ⊑  auto_gen_79_logical_fmf_combined := by
  unfold auto_gen_79_logical_fmf_before auto_gen_79_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_80_combined := [llvmfunc|
  llvm.func @auto_gen_80(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_80   : auto_gen_80_before  ⊑  auto_gen_80_combined := by
  unfold auto_gen_80_before auto_gen_80_combined
  simp_alive_peephole
  sorry
def auto_gen_80_logical_combined := [llvmfunc|
  llvm.func @auto_gen_80_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_80_logical   : auto_gen_80_logical_before  ⊑  auto_gen_80_logical_combined := by
  unfold auto_gen_80_logical_before auto_gen_80_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_80_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_80_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_80_logical_fmf   : auto_gen_80_logical_fmf_before  ⊑  auto_gen_80_logical_fmf_combined := by
  unfold auto_gen_80_logical_fmf_before auto_gen_80_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_81_combined := [llvmfunc|
  llvm.func @auto_gen_81(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_81   : auto_gen_81_before  ⊑  auto_gen_81_combined := by
  unfold auto_gen_81_before auto_gen_81_combined
  simp_alive_peephole
  sorry
def auto_gen_81_logical_combined := [llvmfunc|
  llvm.func @auto_gen_81_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_81_logical   : auto_gen_81_logical_before  ⊑  auto_gen_81_logical_combined := by
  unfold auto_gen_81_logical_before auto_gen_81_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_81_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_81_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_81_logical_fmf   : auto_gen_81_logical_fmf_before  ⊑  auto_gen_81_logical_fmf_combined := by
  unfold auto_gen_81_logical_fmf_before auto_gen_81_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_82_combined := [llvmfunc|
  llvm.func @auto_gen_82(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_82   : auto_gen_82_before  ⊑  auto_gen_82_combined := by
  unfold auto_gen_82_before auto_gen_82_combined
  simp_alive_peephole
  sorry
def auto_gen_82_logical_combined := [llvmfunc|
  llvm.func @auto_gen_82_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_82_logical   : auto_gen_82_logical_before  ⊑  auto_gen_82_logical_combined := by
  unfold auto_gen_82_logical_before auto_gen_82_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_82_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_82_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_82_logical_fmf   : auto_gen_82_logical_fmf_before  ⊑  auto_gen_82_logical_fmf_combined := by
  unfold auto_gen_82_logical_fmf_before auto_gen_82_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_83_combined := [llvmfunc|
  llvm.func @auto_gen_83(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_83   : auto_gen_83_before  ⊑  auto_gen_83_combined := by
  unfold auto_gen_83_before auto_gen_83_combined
  simp_alive_peephole
  sorry
def auto_gen_83_logical_combined := [llvmfunc|
  llvm.func @auto_gen_83_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_83_logical   : auto_gen_83_logical_before  ⊑  auto_gen_83_logical_combined := by
  unfold auto_gen_83_logical_before auto_gen_83_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_83_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_83_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_83_logical_fmf   : auto_gen_83_logical_fmf_before  ⊑  auto_gen_83_logical_fmf_combined := by
  unfold auto_gen_83_logical_fmf_before auto_gen_83_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_83_logical_fmf   : auto_gen_83_logical_fmf_before  ⊑  auto_gen_83_logical_fmf_combined := by
  unfold auto_gen_83_logical_fmf_before auto_gen_83_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_84_combined := [llvmfunc|
  llvm.func @auto_gen_84(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_84   : auto_gen_84_before  ⊑  auto_gen_84_combined := by
  unfold auto_gen_84_before auto_gen_84_combined
  simp_alive_peephole
  sorry
def auto_gen_84_logical_combined := [llvmfunc|
  llvm.func @auto_gen_84_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_84_logical   : auto_gen_84_logical_before  ⊑  auto_gen_84_logical_combined := by
  unfold auto_gen_84_logical_before auto_gen_84_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_84_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_84_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_84_logical_fmf   : auto_gen_84_logical_fmf_before  ⊑  auto_gen_84_logical_fmf_combined := by
  unfold auto_gen_84_logical_fmf_before auto_gen_84_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_85_combined := [llvmfunc|
  llvm.func @auto_gen_85(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_85   : auto_gen_85_before  ⊑  auto_gen_85_combined := by
  unfold auto_gen_85_before auto_gen_85_combined
  simp_alive_peephole
  sorry
def auto_gen_85_logical_combined := [llvmfunc|
  llvm.func @auto_gen_85_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_85_logical   : auto_gen_85_logical_before  ⊑  auto_gen_85_logical_combined := by
  unfold auto_gen_85_logical_before auto_gen_85_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_85_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_85_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_85_logical_fmf   : auto_gen_85_logical_fmf_before  ⊑  auto_gen_85_logical_fmf_combined := by
  unfold auto_gen_85_logical_fmf_before auto_gen_85_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_86_combined := [llvmfunc|
  llvm.func @auto_gen_86(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_86   : auto_gen_86_before  ⊑  auto_gen_86_combined := by
  unfold auto_gen_86_before auto_gen_86_combined
  simp_alive_peephole
  sorry
def auto_gen_86_logical_combined := [llvmfunc|
  llvm.func @auto_gen_86_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_86_logical   : auto_gen_86_logical_before  ⊑  auto_gen_86_logical_combined := by
  unfold auto_gen_86_logical_before auto_gen_86_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_86_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_86_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_86_logical_fmf   : auto_gen_86_logical_fmf_before  ⊑  auto_gen_86_logical_fmf_combined := by
  unfold auto_gen_86_logical_fmf_before auto_gen_86_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_87_combined := [llvmfunc|
  llvm.func @auto_gen_87(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_87   : auto_gen_87_before  ⊑  auto_gen_87_combined := by
  unfold auto_gen_87_before auto_gen_87_combined
  simp_alive_peephole
  sorry
def auto_gen_87_logical_combined := [llvmfunc|
  llvm.func @auto_gen_87_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_87_logical   : auto_gen_87_logical_before  ⊑  auto_gen_87_logical_combined := by
  unfold auto_gen_87_logical_before auto_gen_87_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_87_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_87_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_87_logical_fmf   : auto_gen_87_logical_fmf_before  ⊑  auto_gen_87_logical_fmf_combined := by
  unfold auto_gen_87_logical_fmf_before auto_gen_87_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_88_combined := [llvmfunc|
  llvm.func @auto_gen_88(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_88   : auto_gen_88_before  ⊑  auto_gen_88_combined := by
  unfold auto_gen_88_before auto_gen_88_combined
  simp_alive_peephole
  sorry
def auto_gen_88_logical_combined := [llvmfunc|
  llvm.func @auto_gen_88_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_88_logical   : auto_gen_88_logical_before  ⊑  auto_gen_88_logical_combined := by
  unfold auto_gen_88_logical_before auto_gen_88_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_88_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_88_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_88_logical_fmf   : auto_gen_88_logical_fmf_before  ⊑  auto_gen_88_logical_fmf_combined := by
  unfold auto_gen_88_logical_fmf_before auto_gen_88_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_89_combined := [llvmfunc|
  llvm.func @auto_gen_89(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_89   : auto_gen_89_before  ⊑  auto_gen_89_combined := by
  unfold auto_gen_89_before auto_gen_89_combined
  simp_alive_peephole
  sorry
def auto_gen_89_logical_combined := [llvmfunc|
  llvm.func @auto_gen_89_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_89_logical   : auto_gen_89_logical_before  ⊑  auto_gen_89_logical_combined := by
  unfold auto_gen_89_logical_before auto_gen_89_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_89_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_89_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_89_logical_fmf   : auto_gen_89_logical_fmf_before  ⊑  auto_gen_89_logical_fmf_combined := by
  unfold auto_gen_89_logical_fmf_before auto_gen_89_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_89_logical_fmf   : auto_gen_89_logical_fmf_before  ⊑  auto_gen_89_logical_fmf_combined := by
  unfold auto_gen_89_logical_fmf_before auto_gen_89_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_90_combined := [llvmfunc|
  llvm.func @auto_gen_90(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_90   : auto_gen_90_before  ⊑  auto_gen_90_combined := by
  unfold auto_gen_90_before auto_gen_90_combined
  simp_alive_peephole
  sorry
def auto_gen_90_logical_combined := [llvmfunc|
  llvm.func @auto_gen_90_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_90_logical   : auto_gen_90_logical_before  ⊑  auto_gen_90_logical_combined := by
  unfold auto_gen_90_logical_before auto_gen_90_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_90_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_90_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_90_logical_fmf   : auto_gen_90_logical_fmf_before  ⊑  auto_gen_90_logical_fmf_combined := by
  unfold auto_gen_90_logical_fmf_before auto_gen_90_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_91_combined := [llvmfunc|
  llvm.func @auto_gen_91(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_91   : auto_gen_91_before  ⊑  auto_gen_91_combined := by
  unfold auto_gen_91_before auto_gen_91_combined
  simp_alive_peephole
  sorry
def auto_gen_91_logical_combined := [llvmfunc|
  llvm.func @auto_gen_91_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_91_logical   : auto_gen_91_logical_before  ⊑  auto_gen_91_logical_combined := by
  unfold auto_gen_91_logical_before auto_gen_91_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_91_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_91_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_91_logical_fmf   : auto_gen_91_logical_fmf_before  ⊑  auto_gen_91_logical_fmf_combined := by
  unfold auto_gen_91_logical_fmf_before auto_gen_91_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_91_logical_fmf   : auto_gen_91_logical_fmf_before  ⊑  auto_gen_91_logical_fmf_combined := by
  unfold auto_gen_91_logical_fmf_before auto_gen_91_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_92_combined := [llvmfunc|
  llvm.func @auto_gen_92(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_92   : auto_gen_92_before  ⊑  auto_gen_92_combined := by
  unfold auto_gen_92_before auto_gen_92_combined
  simp_alive_peephole
  sorry
def auto_gen_92_logical_combined := [llvmfunc|
  llvm.func @auto_gen_92_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_92_logical   : auto_gen_92_logical_before  ⊑  auto_gen_92_logical_combined := by
  unfold auto_gen_92_logical_before auto_gen_92_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_92_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_92_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_92_logical_fmf   : auto_gen_92_logical_fmf_before  ⊑  auto_gen_92_logical_fmf_combined := by
  unfold auto_gen_92_logical_fmf_before auto_gen_92_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_93_combined := [llvmfunc|
  llvm.func @auto_gen_93(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_93   : auto_gen_93_before  ⊑  auto_gen_93_combined := by
  unfold auto_gen_93_before auto_gen_93_combined
  simp_alive_peephole
  sorry
def auto_gen_93_logical_combined := [llvmfunc|
  llvm.func @auto_gen_93_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_93_logical   : auto_gen_93_logical_before  ⊑  auto_gen_93_logical_combined := by
  unfold auto_gen_93_logical_before auto_gen_93_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_93_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_93_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_93_logical_fmf   : auto_gen_93_logical_fmf_before  ⊑  auto_gen_93_logical_fmf_combined := by
  unfold auto_gen_93_logical_fmf_before auto_gen_93_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_93_logical_fmf   : auto_gen_93_logical_fmf_before  ⊑  auto_gen_93_logical_fmf_combined := by
  unfold auto_gen_93_logical_fmf_before auto_gen_93_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_94_combined := [llvmfunc|
  llvm.func @auto_gen_94(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_94   : auto_gen_94_before  ⊑  auto_gen_94_combined := by
  unfold auto_gen_94_before auto_gen_94_combined
  simp_alive_peephole
  sorry
def auto_gen_94_logical_combined := [llvmfunc|
  llvm.func @auto_gen_94_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_94_logical   : auto_gen_94_logical_before  ⊑  auto_gen_94_logical_combined := by
  unfold auto_gen_94_logical_before auto_gen_94_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_94_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_94_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_94_logical_fmf   : auto_gen_94_logical_fmf_before  ⊑  auto_gen_94_logical_fmf_combined := by
  unfold auto_gen_94_logical_fmf_before auto_gen_94_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_95_combined := [llvmfunc|
  llvm.func @auto_gen_95(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_95   : auto_gen_95_before  ⊑  auto_gen_95_combined := by
  unfold auto_gen_95_before auto_gen_95_combined
  simp_alive_peephole
  sorry
def auto_gen_95_logical_combined := [llvmfunc|
  llvm.func @auto_gen_95_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_95_logical   : auto_gen_95_logical_before  ⊑  auto_gen_95_logical_combined := by
  unfold auto_gen_95_logical_before auto_gen_95_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_95_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_95_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_95_logical_fmf   : auto_gen_95_logical_fmf_before  ⊑  auto_gen_95_logical_fmf_combined := by
  unfold auto_gen_95_logical_fmf_before auto_gen_95_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_95_logical_fmf   : auto_gen_95_logical_fmf_before  ⊑  auto_gen_95_logical_fmf_combined := by
  unfold auto_gen_95_logical_fmf_before auto_gen_95_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_96_combined := [llvmfunc|
  llvm.func @auto_gen_96(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_96   : auto_gen_96_before  ⊑  auto_gen_96_combined := by
  unfold auto_gen_96_before auto_gen_96_combined
  simp_alive_peephole
  sorry
def auto_gen_96_logical_combined := [llvmfunc|
  llvm.func @auto_gen_96_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_96_logical   : auto_gen_96_logical_before  ⊑  auto_gen_96_logical_combined := by
  unfold auto_gen_96_logical_before auto_gen_96_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_96_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_96_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_96_logical_fmf   : auto_gen_96_logical_fmf_before  ⊑  auto_gen_96_logical_fmf_combined := by
  unfold auto_gen_96_logical_fmf_before auto_gen_96_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_97_combined := [llvmfunc|
  llvm.func @auto_gen_97(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_97   : auto_gen_97_before  ⊑  auto_gen_97_combined := by
  unfold auto_gen_97_before auto_gen_97_combined
  simp_alive_peephole
  sorry
def auto_gen_97_logical_combined := [llvmfunc|
  llvm.func @auto_gen_97_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_97_logical   : auto_gen_97_logical_before  ⊑  auto_gen_97_logical_combined := by
  unfold auto_gen_97_logical_before auto_gen_97_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_97_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_97_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_97_logical_fmf   : auto_gen_97_logical_fmf_before  ⊑  auto_gen_97_logical_fmf_combined := by
  unfold auto_gen_97_logical_fmf_before auto_gen_97_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_97_logical_fmf   : auto_gen_97_logical_fmf_before  ⊑  auto_gen_97_logical_fmf_combined := by
  unfold auto_gen_97_logical_fmf_before auto_gen_97_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_98_combined := [llvmfunc|
  llvm.func @auto_gen_98(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_98   : auto_gen_98_before  ⊑  auto_gen_98_combined := by
  unfold auto_gen_98_before auto_gen_98_combined
  simp_alive_peephole
  sorry
def auto_gen_98_logical_combined := [llvmfunc|
  llvm.func @auto_gen_98_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_98_logical   : auto_gen_98_logical_before  ⊑  auto_gen_98_logical_combined := by
  unfold auto_gen_98_logical_before auto_gen_98_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_98_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_98_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_98_logical_fmf   : auto_gen_98_logical_fmf_before  ⊑  auto_gen_98_logical_fmf_combined := by
  unfold auto_gen_98_logical_fmf_before auto_gen_98_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_99_combined := [llvmfunc|
  llvm.func @auto_gen_99(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_99   : auto_gen_99_before  ⊑  auto_gen_99_combined := by
  unfold auto_gen_99_before auto_gen_99_combined
  simp_alive_peephole
  sorry
def auto_gen_99_logical_combined := [llvmfunc|
  llvm.func @auto_gen_99_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_99_logical   : auto_gen_99_logical_before  ⊑  auto_gen_99_logical_combined := by
  unfold auto_gen_99_logical_before auto_gen_99_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_99_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_99_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_99_logical_fmf   : auto_gen_99_logical_fmf_before  ⊑  auto_gen_99_logical_fmf_combined := by
  unfold auto_gen_99_logical_fmf_before auto_gen_99_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_100_combined := [llvmfunc|
  llvm.func @auto_gen_100(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_100   : auto_gen_100_before  ⊑  auto_gen_100_combined := by
  unfold auto_gen_100_before auto_gen_100_combined
  simp_alive_peephole
  sorry
def auto_gen_100_logical_combined := [llvmfunc|
  llvm.func @auto_gen_100_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_100_logical   : auto_gen_100_logical_before  ⊑  auto_gen_100_logical_combined := by
  unfold auto_gen_100_logical_before auto_gen_100_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_100_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_100_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_100_logical_fmf   : auto_gen_100_logical_fmf_before  ⊑  auto_gen_100_logical_fmf_combined := by
  unfold auto_gen_100_logical_fmf_before auto_gen_100_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_101_combined := [llvmfunc|
  llvm.func @auto_gen_101(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_101   : auto_gen_101_before  ⊑  auto_gen_101_combined := by
  unfold auto_gen_101_before auto_gen_101_combined
  simp_alive_peephole
  sorry
def auto_gen_101_logical_combined := [llvmfunc|
  llvm.func @auto_gen_101_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_101_logical   : auto_gen_101_logical_before  ⊑  auto_gen_101_logical_combined := by
  unfold auto_gen_101_logical_before auto_gen_101_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_101_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_101_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_101_logical_fmf   : auto_gen_101_logical_fmf_before  ⊑  auto_gen_101_logical_fmf_combined := by
  unfold auto_gen_101_logical_fmf_before auto_gen_101_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_102_combined := [llvmfunc|
  llvm.func @auto_gen_102(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_102   : auto_gen_102_before  ⊑  auto_gen_102_combined := by
  unfold auto_gen_102_before auto_gen_102_combined
  simp_alive_peephole
  sorry
def auto_gen_102_logical_combined := [llvmfunc|
  llvm.func @auto_gen_102_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_102_logical   : auto_gen_102_logical_before  ⊑  auto_gen_102_logical_combined := by
  unfold auto_gen_102_logical_before auto_gen_102_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_102_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_102_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_102_logical_fmf   : auto_gen_102_logical_fmf_before  ⊑  auto_gen_102_logical_fmf_combined := by
  unfold auto_gen_102_logical_fmf_before auto_gen_102_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_103_combined := [llvmfunc|
  llvm.func @auto_gen_103(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_103   : auto_gen_103_before  ⊑  auto_gen_103_combined := by
  unfold auto_gen_103_before auto_gen_103_combined
  simp_alive_peephole
  sorry
def auto_gen_103_logical_combined := [llvmfunc|
  llvm.func @auto_gen_103_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_103_logical   : auto_gen_103_logical_before  ⊑  auto_gen_103_logical_combined := by
  unfold auto_gen_103_logical_before auto_gen_103_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_103_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_103_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_103_logical_fmf   : auto_gen_103_logical_fmf_before  ⊑  auto_gen_103_logical_fmf_combined := by
  unfold auto_gen_103_logical_fmf_before auto_gen_103_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_104_combined := [llvmfunc|
  llvm.func @auto_gen_104(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_104   : auto_gen_104_before  ⊑  auto_gen_104_combined := by
  unfold auto_gen_104_before auto_gen_104_combined
  simp_alive_peephole
  sorry
def auto_gen_104_logical_combined := [llvmfunc|
  llvm.func @auto_gen_104_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_104_logical   : auto_gen_104_logical_before  ⊑  auto_gen_104_logical_combined := by
  unfold auto_gen_104_logical_before auto_gen_104_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_104_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_104_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_104_logical_fmf   : auto_gen_104_logical_fmf_before  ⊑  auto_gen_104_logical_fmf_combined := by
  unfold auto_gen_104_logical_fmf_before auto_gen_104_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_105_combined := [llvmfunc|
  llvm.func @auto_gen_105(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_105   : auto_gen_105_before  ⊑  auto_gen_105_combined := by
  unfold auto_gen_105_before auto_gen_105_combined
  simp_alive_peephole
  sorry
def auto_gen_105_logical_combined := [llvmfunc|
  llvm.func @auto_gen_105_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_105_logical   : auto_gen_105_logical_before  ⊑  auto_gen_105_logical_combined := by
  unfold auto_gen_105_logical_before auto_gen_105_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_105_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_105_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_105_logical_fmf   : auto_gen_105_logical_fmf_before  ⊑  auto_gen_105_logical_fmf_combined := by
  unfold auto_gen_105_logical_fmf_before auto_gen_105_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_106_combined := [llvmfunc|
  llvm.func @auto_gen_106(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_106   : auto_gen_106_before  ⊑  auto_gen_106_combined := by
  unfold auto_gen_106_before auto_gen_106_combined
  simp_alive_peephole
  sorry
def auto_gen_106_logical_combined := [llvmfunc|
  llvm.func @auto_gen_106_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_106_logical   : auto_gen_106_logical_before  ⊑  auto_gen_106_logical_combined := by
  unfold auto_gen_106_logical_before auto_gen_106_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_106_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_106_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_106_logical_fmf   : auto_gen_106_logical_fmf_before  ⊑  auto_gen_106_logical_fmf_combined := by
  unfold auto_gen_106_logical_fmf_before auto_gen_106_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_107_combined := [llvmfunc|
  llvm.func @auto_gen_107(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_107   : auto_gen_107_before  ⊑  auto_gen_107_combined := by
  unfold auto_gen_107_before auto_gen_107_combined
  simp_alive_peephole
  sorry
def auto_gen_107_logical_combined := [llvmfunc|
  llvm.func @auto_gen_107_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_107_logical   : auto_gen_107_logical_before  ⊑  auto_gen_107_logical_combined := by
  unfold auto_gen_107_logical_before auto_gen_107_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_107_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_107_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_107_logical_fmf   : auto_gen_107_logical_fmf_before  ⊑  auto_gen_107_logical_fmf_combined := by
  unfold auto_gen_107_logical_fmf_before auto_gen_107_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_107_logical_fmf   : auto_gen_107_logical_fmf_before  ⊑  auto_gen_107_logical_fmf_combined := by
  unfold auto_gen_107_logical_fmf_before auto_gen_107_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_108_combined := [llvmfunc|
  llvm.func @auto_gen_108(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_108   : auto_gen_108_before  ⊑  auto_gen_108_combined := by
  unfold auto_gen_108_before auto_gen_108_combined
  simp_alive_peephole
  sorry
def auto_gen_108_logical_combined := [llvmfunc|
  llvm.func @auto_gen_108_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_108_logical   : auto_gen_108_logical_before  ⊑  auto_gen_108_logical_combined := by
  unfold auto_gen_108_logical_before auto_gen_108_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_108_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_108_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_108_logical_fmf   : auto_gen_108_logical_fmf_before  ⊑  auto_gen_108_logical_fmf_combined := by
  unfold auto_gen_108_logical_fmf_before auto_gen_108_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_109_combined := [llvmfunc|
  llvm.func @auto_gen_109(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_109   : auto_gen_109_before  ⊑  auto_gen_109_combined := by
  unfold auto_gen_109_before auto_gen_109_combined
  simp_alive_peephole
  sorry
def auto_gen_109_logical_combined := [llvmfunc|
  llvm.func @auto_gen_109_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_109_logical   : auto_gen_109_logical_before  ⊑  auto_gen_109_logical_combined := by
  unfold auto_gen_109_logical_before auto_gen_109_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_109_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_109_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_109_logical_fmf   : auto_gen_109_logical_fmf_before  ⊑  auto_gen_109_logical_fmf_combined := by
  unfold auto_gen_109_logical_fmf_before auto_gen_109_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_109_logical_fmf   : auto_gen_109_logical_fmf_before  ⊑  auto_gen_109_logical_fmf_combined := by
  unfold auto_gen_109_logical_fmf_before auto_gen_109_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_110_combined := [llvmfunc|
  llvm.func @auto_gen_110(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_110   : auto_gen_110_before  ⊑  auto_gen_110_combined := by
  unfold auto_gen_110_before auto_gen_110_combined
  simp_alive_peephole
  sorry
def auto_gen_110_logical_combined := [llvmfunc|
  llvm.func @auto_gen_110_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_110_logical   : auto_gen_110_logical_before  ⊑  auto_gen_110_logical_combined := by
  unfold auto_gen_110_logical_before auto_gen_110_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_110_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_110_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_110_logical_fmf   : auto_gen_110_logical_fmf_before  ⊑  auto_gen_110_logical_fmf_combined := by
  unfold auto_gen_110_logical_fmf_before auto_gen_110_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_111_combined := [llvmfunc|
  llvm.func @auto_gen_111(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_111   : auto_gen_111_before  ⊑  auto_gen_111_combined := by
  unfold auto_gen_111_before auto_gen_111_combined
  simp_alive_peephole
  sorry
def auto_gen_111_logical_combined := [llvmfunc|
  llvm.func @auto_gen_111_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_111_logical   : auto_gen_111_logical_before  ⊑  auto_gen_111_logical_combined := by
  unfold auto_gen_111_logical_before auto_gen_111_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_111_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_111_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_111_logical_fmf   : auto_gen_111_logical_fmf_before  ⊑  auto_gen_111_logical_fmf_combined := by
  unfold auto_gen_111_logical_fmf_before auto_gen_111_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_111_logical_fmf   : auto_gen_111_logical_fmf_before  ⊑  auto_gen_111_logical_fmf_combined := by
  unfold auto_gen_111_logical_fmf_before auto_gen_111_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_112_combined := [llvmfunc|
  llvm.func @auto_gen_112(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_112   : auto_gen_112_before  ⊑  auto_gen_112_combined := by
  unfold auto_gen_112_before auto_gen_112_combined
  simp_alive_peephole
  sorry
def auto_gen_112_logical_combined := [llvmfunc|
  llvm.func @auto_gen_112_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_112_logical   : auto_gen_112_logical_before  ⊑  auto_gen_112_logical_combined := by
  unfold auto_gen_112_logical_before auto_gen_112_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_112_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_112_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_112_logical_fmf   : auto_gen_112_logical_fmf_before  ⊑  auto_gen_112_logical_fmf_combined := by
  unfold auto_gen_112_logical_fmf_before auto_gen_112_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_113_combined := [llvmfunc|
  llvm.func @auto_gen_113(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_113   : auto_gen_113_before  ⊑  auto_gen_113_combined := by
  unfold auto_gen_113_before auto_gen_113_combined
  simp_alive_peephole
  sorry
def auto_gen_113_logical_combined := [llvmfunc|
  llvm.func @auto_gen_113_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_113_logical   : auto_gen_113_logical_before  ⊑  auto_gen_113_logical_combined := by
  unfold auto_gen_113_logical_before auto_gen_113_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_113_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_113_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_113_logical_fmf   : auto_gen_113_logical_fmf_before  ⊑  auto_gen_113_logical_fmf_combined := by
  unfold auto_gen_113_logical_fmf_before auto_gen_113_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_113_logical_fmf   : auto_gen_113_logical_fmf_before  ⊑  auto_gen_113_logical_fmf_combined := by
  unfold auto_gen_113_logical_fmf_before auto_gen_113_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_114_combined := [llvmfunc|
  llvm.func @auto_gen_114(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_114   : auto_gen_114_before  ⊑  auto_gen_114_combined := by
  unfold auto_gen_114_before auto_gen_114_combined
  simp_alive_peephole
  sorry
def auto_gen_114_logical_combined := [llvmfunc|
  llvm.func @auto_gen_114_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_114_logical   : auto_gen_114_logical_before  ⊑  auto_gen_114_logical_combined := by
  unfold auto_gen_114_logical_before auto_gen_114_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_114_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_114_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_114_logical_fmf   : auto_gen_114_logical_fmf_before  ⊑  auto_gen_114_logical_fmf_combined := by
  unfold auto_gen_114_logical_fmf_before auto_gen_114_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_115_combined := [llvmfunc|
  llvm.func @auto_gen_115(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_115   : auto_gen_115_before  ⊑  auto_gen_115_combined := by
  unfold auto_gen_115_before auto_gen_115_combined
  simp_alive_peephole
  sorry
def auto_gen_115_logical_combined := [llvmfunc|
  llvm.func @auto_gen_115_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_115_logical   : auto_gen_115_logical_before  ⊑  auto_gen_115_logical_combined := by
  unfold auto_gen_115_logical_before auto_gen_115_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_115_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_115_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_115_logical_fmf   : auto_gen_115_logical_fmf_before  ⊑  auto_gen_115_logical_fmf_combined := by
  unfold auto_gen_115_logical_fmf_before auto_gen_115_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_115_logical_fmf   : auto_gen_115_logical_fmf_before  ⊑  auto_gen_115_logical_fmf_combined := by
  unfold auto_gen_115_logical_fmf_before auto_gen_115_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_116_combined := [llvmfunc|
  llvm.func @auto_gen_116(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_116   : auto_gen_116_before  ⊑  auto_gen_116_combined := by
  unfold auto_gen_116_before auto_gen_116_combined
  simp_alive_peephole
  sorry
def auto_gen_116_logical_combined := [llvmfunc|
  llvm.func @auto_gen_116_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_116_logical   : auto_gen_116_logical_before  ⊑  auto_gen_116_logical_combined := by
  unfold auto_gen_116_logical_before auto_gen_116_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_116_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_116_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_116_logical_fmf   : auto_gen_116_logical_fmf_before  ⊑  auto_gen_116_logical_fmf_combined := by
  unfold auto_gen_116_logical_fmf_before auto_gen_116_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_117_combined := [llvmfunc|
  llvm.func @auto_gen_117(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_117   : auto_gen_117_before  ⊑  auto_gen_117_combined := by
  unfold auto_gen_117_before auto_gen_117_combined
  simp_alive_peephole
  sorry
def auto_gen_117_logical_combined := [llvmfunc|
  llvm.func @auto_gen_117_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_117_logical   : auto_gen_117_logical_before  ⊑  auto_gen_117_logical_combined := by
  unfold auto_gen_117_logical_before auto_gen_117_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_117_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_117_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_auto_gen_117_logical_fmf   : auto_gen_117_logical_fmf_before  ⊑  auto_gen_117_logical_fmf_combined := by
  unfold auto_gen_117_logical_fmf_before auto_gen_117_logical_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_117_logical_fmf   : auto_gen_117_logical_fmf_before  ⊑  auto_gen_117_logical_fmf_combined := by
  unfold auto_gen_117_logical_fmf_before auto_gen_117_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_118_combined := [llvmfunc|
  llvm.func @auto_gen_118(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_118   : auto_gen_118_before  ⊑  auto_gen_118_combined := by
  unfold auto_gen_118_before auto_gen_118_combined
  simp_alive_peephole
  sorry
def auto_gen_118_logical_combined := [llvmfunc|
  llvm.func @auto_gen_118_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_118_logical   : auto_gen_118_logical_before  ⊑  auto_gen_118_logical_combined := by
  unfold auto_gen_118_logical_before auto_gen_118_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_118_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_118_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_118_logical_fmf   : auto_gen_118_logical_fmf_before  ⊑  auto_gen_118_logical_fmf_combined := by
  unfold auto_gen_118_logical_fmf_before auto_gen_118_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_119_combined := [llvmfunc|
  llvm.func @auto_gen_119(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_119   : auto_gen_119_before  ⊑  auto_gen_119_combined := by
  unfold auto_gen_119_before auto_gen_119_combined
  simp_alive_peephole
  sorry
def auto_gen_119_logical_combined := [llvmfunc|
  llvm.func @auto_gen_119_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_119_logical   : auto_gen_119_logical_before  ⊑  auto_gen_119_logical_combined := by
  unfold auto_gen_119_logical_before auto_gen_119_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_119_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_119_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_119_logical_fmf   : auto_gen_119_logical_fmf_before  ⊑  auto_gen_119_logical_fmf_combined := by
  unfold auto_gen_119_logical_fmf_before auto_gen_119_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_120_combined := [llvmfunc|
  llvm.func @auto_gen_120(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_120   : auto_gen_120_before  ⊑  auto_gen_120_combined := by
  unfold auto_gen_120_before auto_gen_120_combined
  simp_alive_peephole
  sorry
def auto_gen_120_logical_combined := [llvmfunc|
  llvm.func @auto_gen_120_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_120_logical   : auto_gen_120_logical_before  ⊑  auto_gen_120_logical_combined := by
  unfold auto_gen_120_logical_before auto_gen_120_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_120_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_120_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_120_logical_fmf   : auto_gen_120_logical_fmf_before  ⊑  auto_gen_120_logical_fmf_combined := by
  unfold auto_gen_120_logical_fmf_before auto_gen_120_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_121_combined := [llvmfunc|
  llvm.func @auto_gen_121(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_121   : auto_gen_121_before  ⊑  auto_gen_121_combined := by
  unfold auto_gen_121_before auto_gen_121_combined
  simp_alive_peephole
  sorry
def auto_gen_121_logical_combined := [llvmfunc|
  llvm.func @auto_gen_121_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_121_logical   : auto_gen_121_logical_before  ⊑  auto_gen_121_logical_combined := by
  unfold auto_gen_121_logical_before auto_gen_121_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_121_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_121_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_121_logical_fmf   : auto_gen_121_logical_fmf_before  ⊑  auto_gen_121_logical_fmf_combined := by
  unfold auto_gen_121_logical_fmf_before auto_gen_121_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_122_combined := [llvmfunc|
  llvm.func @auto_gen_122(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_122   : auto_gen_122_before  ⊑  auto_gen_122_combined := by
  unfold auto_gen_122_before auto_gen_122_combined
  simp_alive_peephole
  sorry
def auto_gen_122_logical_combined := [llvmfunc|
  llvm.func @auto_gen_122_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_122_logical   : auto_gen_122_logical_before  ⊑  auto_gen_122_logical_combined := by
  unfold auto_gen_122_logical_before auto_gen_122_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_122_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_122_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_122_logical_fmf   : auto_gen_122_logical_fmf_before  ⊑  auto_gen_122_logical_fmf_combined := by
  unfold auto_gen_122_logical_fmf_before auto_gen_122_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_123_combined := [llvmfunc|
  llvm.func @auto_gen_123(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_123   : auto_gen_123_before  ⊑  auto_gen_123_combined := by
  unfold auto_gen_123_before auto_gen_123_combined
  simp_alive_peephole
  sorry
def auto_gen_123_logical_combined := [llvmfunc|
  llvm.func @auto_gen_123_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_123_logical   : auto_gen_123_logical_before  ⊑  auto_gen_123_logical_combined := by
  unfold auto_gen_123_logical_before auto_gen_123_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_123_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_123_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_123_logical_fmf   : auto_gen_123_logical_fmf_before  ⊑  auto_gen_123_logical_fmf_combined := by
  unfold auto_gen_123_logical_fmf_before auto_gen_123_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_124_combined := [llvmfunc|
  llvm.func @auto_gen_124(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_124   : auto_gen_124_before  ⊑  auto_gen_124_combined := by
  unfold auto_gen_124_before auto_gen_124_combined
  simp_alive_peephole
  sorry
def auto_gen_124_logical_combined := [llvmfunc|
  llvm.func @auto_gen_124_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_124_logical   : auto_gen_124_logical_before  ⊑  auto_gen_124_logical_combined := by
  unfold auto_gen_124_logical_before auto_gen_124_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_124_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_124_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_124_logical_fmf   : auto_gen_124_logical_fmf_before  ⊑  auto_gen_124_logical_fmf_combined := by
  unfold auto_gen_124_logical_fmf_before auto_gen_124_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_125_combined := [llvmfunc|
  llvm.func @auto_gen_125(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_125   : auto_gen_125_before  ⊑  auto_gen_125_combined := by
  unfold auto_gen_125_before auto_gen_125_combined
  simp_alive_peephole
  sorry
def auto_gen_125_logical_combined := [llvmfunc|
  llvm.func @auto_gen_125_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_125_logical   : auto_gen_125_logical_before  ⊑  auto_gen_125_logical_combined := by
  unfold auto_gen_125_logical_before auto_gen_125_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_125_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_125_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_125_logical_fmf   : auto_gen_125_logical_fmf_before  ⊑  auto_gen_125_logical_fmf_combined := by
  unfold auto_gen_125_logical_fmf_before auto_gen_125_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_126_combined := [llvmfunc|
  llvm.func @auto_gen_126(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_126   : auto_gen_126_before  ⊑  auto_gen_126_combined := by
  unfold auto_gen_126_before auto_gen_126_combined
  simp_alive_peephole
  sorry
def auto_gen_126_logical_combined := [llvmfunc|
  llvm.func @auto_gen_126_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_126_logical   : auto_gen_126_logical_before  ⊑  auto_gen_126_logical_combined := by
  unfold auto_gen_126_logical_before auto_gen_126_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_126_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_126_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_126_logical_fmf   : auto_gen_126_logical_fmf_before  ⊑  auto_gen_126_logical_fmf_combined := by
  unfold auto_gen_126_logical_fmf_before auto_gen_126_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_127_combined := [llvmfunc|
  llvm.func @auto_gen_127(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_127   : auto_gen_127_before  ⊑  auto_gen_127_combined := by
  unfold auto_gen_127_before auto_gen_127_combined
  simp_alive_peephole
  sorry
def auto_gen_127_logical_combined := [llvmfunc|
  llvm.func @auto_gen_127_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_127_logical   : auto_gen_127_logical_before  ⊑  auto_gen_127_logical_combined := by
  unfold auto_gen_127_logical_before auto_gen_127_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_127_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_127_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_127_logical_fmf   : auto_gen_127_logical_fmf_before  ⊑  auto_gen_127_logical_fmf_combined := by
  unfold auto_gen_127_logical_fmf_before auto_gen_127_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_128_combined := [llvmfunc|
  llvm.func @auto_gen_128(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_128   : auto_gen_128_before  ⊑  auto_gen_128_combined := by
  unfold auto_gen_128_before auto_gen_128_combined
  simp_alive_peephole
  sorry
def auto_gen_128_logical_combined := [llvmfunc|
  llvm.func @auto_gen_128_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_128_logical   : auto_gen_128_logical_before  ⊑  auto_gen_128_logical_combined := by
  unfold auto_gen_128_logical_before auto_gen_128_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_128_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_128_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_128_logical_fmf   : auto_gen_128_logical_fmf_before  ⊑  auto_gen_128_logical_fmf_combined := by
  unfold auto_gen_128_logical_fmf_before auto_gen_128_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_129_combined := [llvmfunc|
  llvm.func @auto_gen_129(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_129   : auto_gen_129_before  ⊑  auto_gen_129_combined := by
  unfold auto_gen_129_before auto_gen_129_combined
  simp_alive_peephole
  sorry
def auto_gen_129_logical_combined := [llvmfunc|
  llvm.func @auto_gen_129_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_129_logical   : auto_gen_129_logical_before  ⊑  auto_gen_129_logical_combined := by
  unfold auto_gen_129_logical_before auto_gen_129_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_129_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_129_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_129_logical_fmf   : auto_gen_129_logical_fmf_before  ⊑  auto_gen_129_logical_fmf_combined := by
  unfold auto_gen_129_logical_fmf_before auto_gen_129_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_130_combined := [llvmfunc|
  llvm.func @auto_gen_130(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_130   : auto_gen_130_before  ⊑  auto_gen_130_combined := by
  unfold auto_gen_130_before auto_gen_130_combined
  simp_alive_peephole
  sorry
def auto_gen_130_logical_combined := [llvmfunc|
  llvm.func @auto_gen_130_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_130_logical   : auto_gen_130_logical_before  ⊑  auto_gen_130_logical_combined := by
  unfold auto_gen_130_logical_before auto_gen_130_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_130_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_130_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_130_logical_fmf   : auto_gen_130_logical_fmf_before  ⊑  auto_gen_130_logical_fmf_combined := by
  unfold auto_gen_130_logical_fmf_before auto_gen_130_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_131_combined := [llvmfunc|
  llvm.func @auto_gen_131(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_131   : auto_gen_131_before  ⊑  auto_gen_131_combined := by
  unfold auto_gen_131_before auto_gen_131_combined
  simp_alive_peephole
  sorry
def auto_gen_131_logical_combined := [llvmfunc|
  llvm.func @auto_gen_131_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_131_logical   : auto_gen_131_logical_before  ⊑  auto_gen_131_logical_combined := by
  unfold auto_gen_131_logical_before auto_gen_131_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_131_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_131_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_131_logical_fmf   : auto_gen_131_logical_fmf_before  ⊑  auto_gen_131_logical_fmf_combined := by
  unfold auto_gen_131_logical_fmf_before auto_gen_131_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_132_combined := [llvmfunc|
  llvm.func @auto_gen_132(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_132   : auto_gen_132_before  ⊑  auto_gen_132_combined := by
  unfold auto_gen_132_before auto_gen_132_combined
  simp_alive_peephole
  sorry
def auto_gen_132_logical_combined := [llvmfunc|
  llvm.func @auto_gen_132_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_132_logical   : auto_gen_132_logical_before  ⊑  auto_gen_132_logical_combined := by
  unfold auto_gen_132_logical_before auto_gen_132_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_132_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_132_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_132_logical_fmf   : auto_gen_132_logical_fmf_before  ⊑  auto_gen_132_logical_fmf_combined := by
  unfold auto_gen_132_logical_fmf_before auto_gen_132_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_133_combined := [llvmfunc|
  llvm.func @auto_gen_133(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_133   : auto_gen_133_before  ⊑  auto_gen_133_combined := by
  unfold auto_gen_133_before auto_gen_133_combined
  simp_alive_peephole
  sorry
def auto_gen_133_logical_combined := [llvmfunc|
  llvm.func @auto_gen_133_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_133_logical   : auto_gen_133_logical_before  ⊑  auto_gen_133_logical_combined := by
  unfold auto_gen_133_logical_before auto_gen_133_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_133_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_133_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_133_logical_fmf   : auto_gen_133_logical_fmf_before  ⊑  auto_gen_133_logical_fmf_combined := by
  unfold auto_gen_133_logical_fmf_before auto_gen_133_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_134_combined := [llvmfunc|
  llvm.func @auto_gen_134(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_134   : auto_gen_134_before  ⊑  auto_gen_134_combined := by
  unfold auto_gen_134_before auto_gen_134_combined
  simp_alive_peephole
  sorry
def auto_gen_134_logical_combined := [llvmfunc|
  llvm.func @auto_gen_134_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_134_logical   : auto_gen_134_logical_before  ⊑  auto_gen_134_logical_combined := by
  unfold auto_gen_134_logical_before auto_gen_134_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_134_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_134_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_134_logical_fmf   : auto_gen_134_logical_fmf_before  ⊑  auto_gen_134_logical_fmf_combined := by
  unfold auto_gen_134_logical_fmf_before auto_gen_134_logical_fmf_combined
  simp_alive_peephole
  sorry
def auto_gen_135_combined := [llvmfunc|
  llvm.func @auto_gen_135(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_135   : auto_gen_135_before  ⊑  auto_gen_135_combined := by
  unfold auto_gen_135_before auto_gen_135_combined
  simp_alive_peephole
  sorry
def auto_gen_135_logical_combined := [llvmfunc|
  llvm.func @auto_gen_135_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_135_logical   : auto_gen_135_logical_before  ⊑  auto_gen_135_logical_combined := by
  unfold auto_gen_135_logical_before auto_gen_135_logical_combined
  simp_alive_peephole
  sorry
def auto_gen_135_logical_fmf_combined := [llvmfunc|
  llvm.func @auto_gen_135_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_auto_gen_135_logical_fmf   : auto_gen_135_logical_fmf_before  ⊑  auto_gen_135_logical_fmf_combined := by
  unfold auto_gen_135_logical_fmf_before auto_gen_135_logical_fmf_combined
  simp_alive_peephole
  sorry
def intersect_fmf_1_combined := [llvmfunc|
  llvm.func @intersect_fmf_1(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_intersect_fmf_1   : intersect_fmf_1_before  ⊑  intersect_fmf_1_combined := by
  unfold intersect_fmf_1_before intersect_fmf_1_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_intersect_fmf_1   : intersect_fmf_1_before  ⊑  intersect_fmf_1_combined := by
  unfold intersect_fmf_1_before intersect_fmf_1_combined
  simp_alive_peephole
  sorry
def intersect_fmf_2_combined := [llvmfunc|
  llvm.func @intersect_fmf_2(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_intersect_fmf_2   : intersect_fmf_2_before  ⊑  intersect_fmf_2_combined := by
  unfold intersect_fmf_2_before intersect_fmf_2_combined
  simp_alive_peephole
  sorry
def intersect_fmf_3_combined := [llvmfunc|
  llvm.func @intersect_fmf_3(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_intersect_fmf_3   : intersect_fmf_3_before  ⊑  intersect_fmf_3_combined := by
  unfold intersect_fmf_3_before intersect_fmf_3_combined
  simp_alive_peephole
  sorry
def intersect_fmf_4_combined := [llvmfunc|
  llvm.func @intersect_fmf_4(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    llvm.return %0 : i1
  }]

theorem inst_combine_intersect_fmf_4   : intersect_fmf_4_before  ⊑  intersect_fmf_4_combined := by
  unfold intersect_fmf_4_before intersect_fmf_4_combined
  simp_alive_peephole
  sorry
