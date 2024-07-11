import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cast-int-fcmp-eq-0
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def i32_cast_cmp_oeq_int_0_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_int_n0_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_n0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_int_0_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_int_n0_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_n0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_one_int_0_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_one_int_0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "one" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_one_int_n0_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_one_int_n0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "one" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_one_int_0_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_one_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "one" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_one_int_n0_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_one_int_n0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "one" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_ueq_int_0_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ueq_int_0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_ueq_int_n0_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ueq_int_n0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_ueq_int_0_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ueq_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_ueq_int_n0_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ueq_int_n0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_une_int_0_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_une_int_0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "une" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_une_int_n0_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_une_int_n0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "une" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_une_int_0_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_une_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "une" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_une_int_n0_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_une_int_n0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "une" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_ogt_int_0_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ogt_int_0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ogt" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_ogt_int_n0_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ogt_int_n0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ogt" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_ogt_int_0_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ogt_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ogt" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_ogt_int_n0_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ogt_int_n0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ogt" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_ole_int_0_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ole_int_0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ole" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_ole_int_0_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ole_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ole" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_olt_int_0_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_olt_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "olt" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i64_cast_cmp_oeq_int_0_uitofp_before := [llvmfunc|
  llvm.func @i64_cast_cmp_oeq_int_0_uitofp(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i64 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i64_cast_cmp_oeq_int_0_sitofp_before := [llvmfunc|
  llvm.func @i64_cast_cmp_oeq_int_0_sitofp(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i64 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i64_cast_cmp_oeq_int_0_uitofp_half_before := [llvmfunc|
  llvm.func @i64_cast_cmp_oeq_int_0_uitofp_half(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.uitofp %arg0 : i64 to f16
    %2 = llvm.fcmp "oeq" %1, %0 : f16
    llvm.return %2 : i1
  }]

def i64_cast_cmp_oeq_int_0_sitofp_half_before := [llvmfunc|
  llvm.func @i64_cast_cmp_oeq_int_0_sitofp_half(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.sitofp %arg0 : i64 to f16
    %2 = llvm.fcmp "oeq" %1, %0 : f16
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_int_0_uitofp_ppcf128_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_0_uitofp_ppcf128(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f128) : !llvm.ppc_fp128
    %1 = llvm.uitofp %arg0 : i32 to !llvm.ppc_fp128
    %2 = llvm.fcmp "oeq" %1, %0 : !llvm.ppc_fp128
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_int_i24max_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_i24max_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0x4B7FFFFF : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_int_i24max_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_i24max_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0x4B7FFFFF : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_int_i24maxp1_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_i24maxp1_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0x4B800000 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_int_i24maxp1_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_i24maxp1_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0x4B800000 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_int_i32umax_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_i32umax_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4.2949673E+9 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_int_big_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_big_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8.58993459E+9 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_int_i32umax_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_i32umax_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4.2949673E+9 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_int_i32imin_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_i32imin_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2.14748365E+9 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_int_i32imax_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_i32imax_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2.14748365E+9 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_int_i32imax_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_i32imax_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2.14748365E+9 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_int_negi32umax_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_negi32umax_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-4.2949673E+9 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_half_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_half_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_half_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_half_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_one_half_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_one_half_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "one" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_one_half_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_one_half_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "one" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_ueq_half_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ueq_half_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_ueq_half_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ueq_half_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_une_half_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_une_half_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "une" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_une_half_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_une_half_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "une" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_int_inf_uitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_inf_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_cast_cmp_oeq_int_inf_sitofp_before := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_inf_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i128_cast_cmp_oeq_int_inf_uitofp_before := [llvmfunc|
  llvm.func @i128_cast_cmp_oeq_int_inf_uitofp(%arg0: i128) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.uitofp %arg0 : i128 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def i32_vec_cast_cmp_oeq_vec_int_0_sitofp_before := [llvmfunc|
  llvm.func @i32_vec_cast_cmp_oeq_vec_int_0_sitofp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %3 = llvm.fcmp "oeq" %2, %1 : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }]

def i32_vec_cast_cmp_oeq_vec_int_n0_sitofp_before := [llvmfunc|
  llvm.func @i32_vec_cast_cmp_oeq_vec_int_n0_sitofp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %2 = llvm.fcmp "oeq" %1, %0 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

def i32_vec_cast_cmp_oeq_vec_int_i32imax_sitofp_before := [llvmfunc|
  llvm.func @i32_vec_cast_cmp_oeq_vec_int_i32imax_sitofp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2.14748365E+9> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %2 = llvm.fcmp "oeq" %1, %0 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

def i32_vec_cast_cmp_oeq_vec_int_negi32umax_sitofp_before := [llvmfunc|
  llvm.func @i32_vec_cast_cmp_oeq_vec_int_negi32umax_sitofp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-4.2949673E+9> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %2 = llvm.fcmp "oeq" %1, %0 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

def i32_vec_cast_cmp_oeq_vec_half_sitofp_before := [llvmfunc|
  llvm.func @i32_vec_cast_cmp_oeq_vec_half_sitofp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5.000000e-01> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %2 = llvm.fcmp "oeq" %1, %0 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

def i32_vec_cast_cmp_oeq_vec_int_inf_sitofp_before := [llvmfunc|
  llvm.func @i32_vec_cast_cmp_oeq_vec_int_inf_sitofp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<0x7F800000> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %2 = llvm.fcmp "oeq" %1, %0 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

def i32_cast_cmp_oeq_int_0_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_int_0_uitofp   : i32_cast_cmp_oeq_int_0_uitofp_before  ⊑  i32_cast_cmp_oeq_int_0_uitofp_combined := by
  unfold i32_cast_cmp_oeq_int_0_uitofp_before i32_cast_cmp_oeq_int_0_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_int_n0_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_n0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_int_n0_uitofp   : i32_cast_cmp_oeq_int_n0_uitofp_before  ⊑  i32_cast_cmp_oeq_int_n0_uitofp_combined := by
  unfold i32_cast_cmp_oeq_int_n0_uitofp_before i32_cast_cmp_oeq_int_n0_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_int_0_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_int_0_sitofp   : i32_cast_cmp_oeq_int_0_sitofp_before  ⊑  i32_cast_cmp_oeq_int_0_sitofp_combined := by
  unfold i32_cast_cmp_oeq_int_0_sitofp_before i32_cast_cmp_oeq_int_0_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_int_n0_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_n0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_int_n0_sitofp   : i32_cast_cmp_oeq_int_n0_sitofp_before  ⊑  i32_cast_cmp_oeq_int_n0_sitofp_combined := by
  unfold i32_cast_cmp_oeq_int_n0_sitofp_before i32_cast_cmp_oeq_int_n0_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_one_int_0_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_one_int_0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_one_int_0_uitofp   : i32_cast_cmp_one_int_0_uitofp_before  ⊑  i32_cast_cmp_one_int_0_uitofp_combined := by
  unfold i32_cast_cmp_one_int_0_uitofp_before i32_cast_cmp_one_int_0_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_one_int_n0_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_one_int_n0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_one_int_n0_uitofp   : i32_cast_cmp_one_int_n0_uitofp_before  ⊑  i32_cast_cmp_one_int_n0_uitofp_combined := by
  unfold i32_cast_cmp_one_int_n0_uitofp_before i32_cast_cmp_one_int_n0_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_one_int_0_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_one_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_one_int_0_sitofp   : i32_cast_cmp_one_int_0_sitofp_before  ⊑  i32_cast_cmp_one_int_0_sitofp_combined := by
  unfold i32_cast_cmp_one_int_0_sitofp_before i32_cast_cmp_one_int_0_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_one_int_n0_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_one_int_n0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_one_int_n0_sitofp   : i32_cast_cmp_one_int_n0_sitofp_before  ⊑  i32_cast_cmp_one_int_n0_sitofp_combined := by
  unfold i32_cast_cmp_one_int_n0_sitofp_before i32_cast_cmp_one_int_n0_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ueq_int_0_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ueq_int_0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_ueq_int_0_uitofp   : i32_cast_cmp_ueq_int_0_uitofp_before  ⊑  i32_cast_cmp_ueq_int_0_uitofp_combined := by
  unfold i32_cast_cmp_ueq_int_0_uitofp_before i32_cast_cmp_ueq_int_0_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ueq_int_n0_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ueq_int_n0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_ueq_int_n0_uitofp   : i32_cast_cmp_ueq_int_n0_uitofp_before  ⊑  i32_cast_cmp_ueq_int_n0_uitofp_combined := by
  unfold i32_cast_cmp_ueq_int_n0_uitofp_before i32_cast_cmp_ueq_int_n0_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ueq_int_0_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ueq_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_ueq_int_0_sitofp   : i32_cast_cmp_ueq_int_0_sitofp_before  ⊑  i32_cast_cmp_ueq_int_0_sitofp_combined := by
  unfold i32_cast_cmp_ueq_int_0_sitofp_before i32_cast_cmp_ueq_int_0_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ueq_int_n0_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ueq_int_n0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_ueq_int_n0_sitofp   : i32_cast_cmp_ueq_int_n0_sitofp_before  ⊑  i32_cast_cmp_ueq_int_n0_sitofp_combined := by
  unfold i32_cast_cmp_ueq_int_n0_sitofp_before i32_cast_cmp_ueq_int_n0_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_une_int_0_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_une_int_0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_une_int_0_uitofp   : i32_cast_cmp_une_int_0_uitofp_before  ⊑  i32_cast_cmp_une_int_0_uitofp_combined := by
  unfold i32_cast_cmp_une_int_0_uitofp_before i32_cast_cmp_une_int_0_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_une_int_n0_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_une_int_n0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_une_int_n0_uitofp   : i32_cast_cmp_une_int_n0_uitofp_before  ⊑  i32_cast_cmp_une_int_n0_uitofp_combined := by
  unfold i32_cast_cmp_une_int_n0_uitofp_before i32_cast_cmp_une_int_n0_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_une_int_0_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_une_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_une_int_0_sitofp   : i32_cast_cmp_une_int_0_sitofp_before  ⊑  i32_cast_cmp_une_int_0_sitofp_combined := by
  unfold i32_cast_cmp_une_int_0_sitofp_before i32_cast_cmp_une_int_0_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_une_int_n0_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_une_int_n0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_une_int_n0_sitofp   : i32_cast_cmp_une_int_n0_sitofp_before  ⊑  i32_cast_cmp_une_int_n0_sitofp_combined := by
  unfold i32_cast_cmp_une_int_n0_sitofp_before i32_cast_cmp_une_int_n0_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ogt_int_0_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ogt_int_0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_ogt_int_0_uitofp   : i32_cast_cmp_ogt_int_0_uitofp_before  ⊑  i32_cast_cmp_ogt_int_0_uitofp_combined := by
  unfold i32_cast_cmp_ogt_int_0_uitofp_before i32_cast_cmp_ogt_int_0_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ogt_int_n0_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ogt_int_n0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_ogt_int_n0_uitofp   : i32_cast_cmp_ogt_int_n0_uitofp_before  ⊑  i32_cast_cmp_ogt_int_n0_uitofp_combined := by
  unfold i32_cast_cmp_ogt_int_n0_uitofp_before i32_cast_cmp_ogt_int_n0_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ogt_int_0_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ogt_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_ogt_int_0_sitofp   : i32_cast_cmp_ogt_int_0_sitofp_before  ⊑  i32_cast_cmp_ogt_int_0_sitofp_combined := by
  unfold i32_cast_cmp_ogt_int_0_sitofp_before i32_cast_cmp_ogt_int_0_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ogt_int_n0_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ogt_int_n0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_ogt_int_n0_sitofp   : i32_cast_cmp_ogt_int_n0_sitofp_before  ⊑  i32_cast_cmp_ogt_int_n0_sitofp_combined := by
  unfold i32_cast_cmp_ogt_int_n0_sitofp_before i32_cast_cmp_ogt_int_n0_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ole_int_0_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ole_int_0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_ole_int_0_uitofp   : i32_cast_cmp_ole_int_0_uitofp_before  ⊑  i32_cast_cmp_ole_int_0_uitofp_combined := by
  unfold i32_cast_cmp_ole_int_0_uitofp_before i32_cast_cmp_ole_int_0_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ole_int_0_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ole_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_ole_int_0_sitofp   : i32_cast_cmp_ole_int_0_sitofp_before  ⊑  i32_cast_cmp_ole_int_0_sitofp_combined := by
  unfold i32_cast_cmp_ole_int_0_sitofp_before i32_cast_cmp_ole_int_0_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_olt_int_0_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_olt_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_olt_int_0_sitofp   : i32_cast_cmp_olt_int_0_sitofp_before  ⊑  i32_cast_cmp_olt_int_0_sitofp_combined := by
  unfold i32_cast_cmp_olt_int_0_sitofp_before i32_cast_cmp_olt_int_0_sitofp_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_oeq_int_0_uitofp_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_oeq_int_0_uitofp(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_oeq_int_0_uitofp   : i64_cast_cmp_oeq_int_0_uitofp_before  ⊑  i64_cast_cmp_oeq_int_0_uitofp_combined := by
  unfold i64_cast_cmp_oeq_int_0_uitofp_before i64_cast_cmp_oeq_int_0_uitofp_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_oeq_int_0_sitofp_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_oeq_int_0_sitofp(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_oeq_int_0_sitofp   : i64_cast_cmp_oeq_int_0_sitofp_before  ⊑  i64_cast_cmp_oeq_int_0_sitofp_combined := by
  unfold i64_cast_cmp_oeq_int_0_sitofp_before i64_cast_cmp_oeq_int_0_sitofp_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_oeq_int_0_uitofp_half_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_oeq_int_0_uitofp_half(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_oeq_int_0_uitofp_half   : i64_cast_cmp_oeq_int_0_uitofp_half_before  ⊑  i64_cast_cmp_oeq_int_0_uitofp_half_combined := by
  unfold i64_cast_cmp_oeq_int_0_uitofp_half_before i64_cast_cmp_oeq_int_0_uitofp_half_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_oeq_int_0_sitofp_half_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_oeq_int_0_sitofp_half(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_oeq_int_0_sitofp_half   : i64_cast_cmp_oeq_int_0_sitofp_half_before  ⊑  i64_cast_cmp_oeq_int_0_sitofp_half_combined := by
  unfold i64_cast_cmp_oeq_int_0_sitofp_half_before i64_cast_cmp_oeq_int_0_sitofp_half_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_int_0_uitofp_ppcf128_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_0_uitofp_ppcf128(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f128) : !llvm.ppc_fp128
    %1 = llvm.uitofp %arg0 : i32 to !llvm.ppc_fp128
    %2 = llvm.fcmp "oeq" %1, %0 : !llvm.ppc_fp128
    llvm.return %2 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_int_0_uitofp_ppcf128   : i32_cast_cmp_oeq_int_0_uitofp_ppcf128_before  ⊑  i32_cast_cmp_oeq_int_0_uitofp_ppcf128_combined := by
  unfold i32_cast_cmp_oeq_int_0_uitofp_ppcf128_before i32_cast_cmp_oeq_int_0_uitofp_ppcf128_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_int_i24max_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_i24max_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(16777215 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_int_i24max_uitofp   : i32_cast_cmp_oeq_int_i24max_uitofp_before  ⊑  i32_cast_cmp_oeq_int_i24max_uitofp_combined := by
  unfold i32_cast_cmp_oeq_int_i24max_uitofp_before i32_cast_cmp_oeq_int_i24max_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_int_i24max_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_i24max_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(16777215 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_int_i24max_sitofp   : i32_cast_cmp_oeq_int_i24max_sitofp_before  ⊑  i32_cast_cmp_oeq_int_i24max_sitofp_combined := by
  unfold i32_cast_cmp_oeq_int_i24max_sitofp_before i32_cast_cmp_oeq_int_i24max_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_int_i24maxp1_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_i24maxp1_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0x4B800000 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_int_i24maxp1_uitofp   : i32_cast_cmp_oeq_int_i24maxp1_uitofp_before  ⊑  i32_cast_cmp_oeq_int_i24maxp1_uitofp_combined := by
  unfold i32_cast_cmp_oeq_int_i24maxp1_uitofp_before i32_cast_cmp_oeq_int_i24maxp1_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_int_i24maxp1_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_i24maxp1_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0x4B800000 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_int_i24maxp1_sitofp   : i32_cast_cmp_oeq_int_i24maxp1_sitofp_before  ⊑  i32_cast_cmp_oeq_int_i24maxp1_sitofp_combined := by
  unfold i32_cast_cmp_oeq_int_i24maxp1_sitofp_before i32_cast_cmp_oeq_int_i24maxp1_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_int_i32umax_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_i32umax_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4.2949673E+9 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_int_i32umax_uitofp   : i32_cast_cmp_oeq_int_i32umax_uitofp_before  ⊑  i32_cast_cmp_oeq_int_i32umax_uitofp_combined := by
  unfold i32_cast_cmp_oeq_int_i32umax_uitofp_before i32_cast_cmp_oeq_int_i32umax_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_int_big_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_big_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_int_big_uitofp   : i32_cast_cmp_oeq_int_big_uitofp_before  ⊑  i32_cast_cmp_oeq_int_big_uitofp_combined := by
  unfold i32_cast_cmp_oeq_int_big_uitofp_before i32_cast_cmp_oeq_int_big_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_int_i32umax_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_i32umax_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_int_i32umax_sitofp   : i32_cast_cmp_oeq_int_i32umax_sitofp_before  ⊑  i32_cast_cmp_oeq_int_i32umax_sitofp_combined := by
  unfold i32_cast_cmp_oeq_int_i32umax_sitofp_before i32_cast_cmp_oeq_int_i32umax_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_int_i32imin_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_i32imin_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2.14748365E+9 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_int_i32imin_sitofp   : i32_cast_cmp_oeq_int_i32imin_sitofp_before  ⊑  i32_cast_cmp_oeq_int_i32imin_sitofp_combined := by
  unfold i32_cast_cmp_oeq_int_i32imin_sitofp_before i32_cast_cmp_oeq_int_i32imin_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_int_i32imax_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_i32imax_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2.14748365E+9 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_int_i32imax_uitofp   : i32_cast_cmp_oeq_int_i32imax_uitofp_before  ⊑  i32_cast_cmp_oeq_int_i32imax_uitofp_combined := by
  unfold i32_cast_cmp_oeq_int_i32imax_uitofp_before i32_cast_cmp_oeq_int_i32imax_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_int_i32imax_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_i32imax_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2.14748365E+9 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_int_i32imax_sitofp   : i32_cast_cmp_oeq_int_i32imax_sitofp_before  ⊑  i32_cast_cmp_oeq_int_i32imax_sitofp_combined := by
  unfold i32_cast_cmp_oeq_int_i32imax_sitofp_before i32_cast_cmp_oeq_int_i32imax_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_int_negi32umax_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_negi32umax_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_int_negi32umax_sitofp   : i32_cast_cmp_oeq_int_negi32umax_sitofp_before  ⊑  i32_cast_cmp_oeq_int_negi32umax_sitofp_combined := by
  unfold i32_cast_cmp_oeq_int_negi32umax_sitofp_before i32_cast_cmp_oeq_int_negi32umax_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_half_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_half_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_half_uitofp   : i32_cast_cmp_oeq_half_uitofp_before  ⊑  i32_cast_cmp_oeq_half_uitofp_combined := by
  unfold i32_cast_cmp_oeq_half_uitofp_before i32_cast_cmp_oeq_half_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_half_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_half_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_half_sitofp   : i32_cast_cmp_oeq_half_sitofp_before  ⊑  i32_cast_cmp_oeq_half_sitofp_combined := by
  unfold i32_cast_cmp_oeq_half_sitofp_before i32_cast_cmp_oeq_half_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_one_half_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_one_half_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_i32_cast_cmp_one_half_uitofp   : i32_cast_cmp_one_half_uitofp_before  ⊑  i32_cast_cmp_one_half_uitofp_combined := by
  unfold i32_cast_cmp_one_half_uitofp_before i32_cast_cmp_one_half_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_one_half_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_one_half_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_i32_cast_cmp_one_half_sitofp   : i32_cast_cmp_one_half_sitofp_before  ⊑  i32_cast_cmp_one_half_sitofp_combined := by
  unfold i32_cast_cmp_one_half_sitofp_before i32_cast_cmp_one_half_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ueq_half_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ueq_half_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_i32_cast_cmp_ueq_half_uitofp   : i32_cast_cmp_ueq_half_uitofp_before  ⊑  i32_cast_cmp_ueq_half_uitofp_combined := by
  unfold i32_cast_cmp_ueq_half_uitofp_before i32_cast_cmp_ueq_half_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ueq_half_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ueq_half_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_i32_cast_cmp_ueq_half_sitofp   : i32_cast_cmp_ueq_half_sitofp_before  ⊑  i32_cast_cmp_ueq_half_sitofp_combined := by
  unfold i32_cast_cmp_ueq_half_sitofp_before i32_cast_cmp_ueq_half_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_une_half_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_une_half_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_i32_cast_cmp_une_half_uitofp   : i32_cast_cmp_une_half_uitofp_before  ⊑  i32_cast_cmp_une_half_uitofp_combined := by
  unfold i32_cast_cmp_une_half_uitofp_before i32_cast_cmp_une_half_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_une_half_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_une_half_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_i32_cast_cmp_une_half_sitofp   : i32_cast_cmp_une_half_sitofp_before  ⊑  i32_cast_cmp_une_half_sitofp_combined := by
  unfold i32_cast_cmp_une_half_sitofp_before i32_cast_cmp_une_half_sitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_int_inf_uitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_inf_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_int_inf_uitofp   : i32_cast_cmp_oeq_int_inf_uitofp_before  ⊑  i32_cast_cmp_oeq_int_inf_uitofp_combined := by
  unfold i32_cast_cmp_oeq_int_inf_uitofp_before i32_cast_cmp_oeq_int_inf_uitofp_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_oeq_int_inf_sitofp_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_oeq_int_inf_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_i32_cast_cmp_oeq_int_inf_sitofp   : i32_cast_cmp_oeq_int_inf_sitofp_before  ⊑  i32_cast_cmp_oeq_int_inf_sitofp_combined := by
  unfold i32_cast_cmp_oeq_int_inf_sitofp_before i32_cast_cmp_oeq_int_inf_sitofp_combined
  simp_alive_peephole
  sorry
def i128_cast_cmp_oeq_int_inf_uitofp_combined := [llvmfunc|
  llvm.func @i128_cast_cmp_oeq_int_inf_uitofp(%arg0: i128) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.uitofp %arg0 : i128 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_i128_cast_cmp_oeq_int_inf_uitofp   : i128_cast_cmp_oeq_int_inf_uitofp_before  ⊑  i128_cast_cmp_oeq_int_inf_uitofp_combined := by
  unfold i128_cast_cmp_oeq_int_inf_uitofp_before i128_cast_cmp_oeq_int_inf_uitofp_combined
  simp_alive_peephole
  sorry
def i32_vec_cast_cmp_oeq_vec_int_0_sitofp_combined := [llvmfunc|
  llvm.func @i32_vec_cast_cmp_oeq_vec_int_0_sitofp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %3 = llvm.fcmp "oeq" %2, %1 : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_i32_vec_cast_cmp_oeq_vec_int_0_sitofp   : i32_vec_cast_cmp_oeq_vec_int_0_sitofp_before  ⊑  i32_vec_cast_cmp_oeq_vec_int_0_sitofp_combined := by
  unfold i32_vec_cast_cmp_oeq_vec_int_0_sitofp_before i32_vec_cast_cmp_oeq_vec_int_0_sitofp_combined
  simp_alive_peephole
  sorry
def i32_vec_cast_cmp_oeq_vec_int_n0_sitofp_combined := [llvmfunc|
  llvm.func @i32_vec_cast_cmp_oeq_vec_int_n0_sitofp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %3 = llvm.fcmp "oeq" %2, %1 : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_i32_vec_cast_cmp_oeq_vec_int_n0_sitofp   : i32_vec_cast_cmp_oeq_vec_int_n0_sitofp_before  ⊑  i32_vec_cast_cmp_oeq_vec_int_n0_sitofp_combined := by
  unfold i32_vec_cast_cmp_oeq_vec_int_n0_sitofp_before i32_vec_cast_cmp_oeq_vec_int_n0_sitofp_combined
  simp_alive_peephole
  sorry
def i32_vec_cast_cmp_oeq_vec_int_i32imax_sitofp_combined := [llvmfunc|
  llvm.func @i32_vec_cast_cmp_oeq_vec_int_i32imax_sitofp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2.14748365E+9> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %2 = llvm.fcmp "oeq" %1, %0 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_i32_vec_cast_cmp_oeq_vec_int_i32imax_sitofp   : i32_vec_cast_cmp_oeq_vec_int_i32imax_sitofp_before  ⊑  i32_vec_cast_cmp_oeq_vec_int_i32imax_sitofp_combined := by
  unfold i32_vec_cast_cmp_oeq_vec_int_i32imax_sitofp_before i32_vec_cast_cmp_oeq_vec_int_i32imax_sitofp_combined
  simp_alive_peephole
  sorry
def i32_vec_cast_cmp_oeq_vec_int_negi32umax_sitofp_combined := [llvmfunc|
  llvm.func @i32_vec_cast_cmp_oeq_vec_int_negi32umax_sitofp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-4.2949673E+9> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %2 = llvm.fcmp "oeq" %1, %0 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_i32_vec_cast_cmp_oeq_vec_int_negi32umax_sitofp   : i32_vec_cast_cmp_oeq_vec_int_negi32umax_sitofp_before  ⊑  i32_vec_cast_cmp_oeq_vec_int_negi32umax_sitofp_combined := by
  unfold i32_vec_cast_cmp_oeq_vec_int_negi32umax_sitofp_before i32_vec_cast_cmp_oeq_vec_int_negi32umax_sitofp_combined
  simp_alive_peephole
  sorry
def i32_vec_cast_cmp_oeq_vec_half_sitofp_combined := [llvmfunc|
  llvm.func @i32_vec_cast_cmp_oeq_vec_half_sitofp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5.000000e-01> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %2 = llvm.fcmp "oeq" %1, %0 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_i32_vec_cast_cmp_oeq_vec_half_sitofp   : i32_vec_cast_cmp_oeq_vec_half_sitofp_before  ⊑  i32_vec_cast_cmp_oeq_vec_half_sitofp_combined := by
  unfold i32_vec_cast_cmp_oeq_vec_half_sitofp_before i32_vec_cast_cmp_oeq_vec_half_sitofp_combined
  simp_alive_peephole
  sorry
def i32_vec_cast_cmp_oeq_vec_int_inf_sitofp_combined := [llvmfunc|
  llvm.func @i32_vec_cast_cmp_oeq_vec_int_inf_sitofp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_i32_vec_cast_cmp_oeq_vec_int_inf_sitofp   : i32_vec_cast_cmp_oeq_vec_int_inf_sitofp_before  ⊑  i32_vec_cast_cmp_oeq_vec_int_inf_sitofp_combined := by
  unfold i32_vec_cast_cmp_oeq_vec_int_inf_sitofp_before i32_vec_cast_cmp_oeq_vec_int_inf_sitofp_combined
  simp_alive_peephole
  sorry
