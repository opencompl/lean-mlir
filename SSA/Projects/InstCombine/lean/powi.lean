import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  powi
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def powi_fneg_even_int_before := [llvmfunc|
  llvm.func @powi_fneg_even_int(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.fneg %arg0  : f64
    %2 = llvm.intr.powi(%1, %0)  : (f64, i32) -> f64
    llvm.return %2 : f64
  }]

def powi_fabs_even_int_before := [llvmfunc|
  llvm.func @powi_fabs_even_int(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.intr.powi(%1, %0)  : (f64, i32) -> f64
    llvm.return %2 : f64
  }]

def powi_copysign_even_int_before := [llvmfunc|
  llvm.func @powi_copysign_even_int(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.intr.copysign(%arg0, %arg1)  : (f64, f64) -> f64
    %2 = llvm.intr.powi(%1, %0)  : (f64, i32) -> f64
    llvm.return %2 : f64
  }]

def powi_fneg_odd_int_before := [llvmfunc|
  llvm.func @powi_fneg_odd_int(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.fneg %arg0  : f64
    %2 = llvm.intr.powi(%1, %0)  : (f64, i32) -> f64
    llvm.return %2 : f64
  }]

def powi_fabs_odd_int_before := [llvmfunc|
  llvm.func @powi_fabs_odd_int(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.intr.powi(%1, %0)  : (f64, i32) -> f64
    llvm.return %2 : f64
  }]

def powi_copysign_odd_int_before := [llvmfunc|
  llvm.func @powi_copysign_odd_int(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.copysign(%arg0, %arg1)  : (f64, f64) -> f64
    %2 = llvm.intr.powi(%1, %0)  : (f64, i32) -> f64
    llvm.return %2 : f64
  }]

def powi_fmul_arg0_no_reassoc_before := [llvmfunc|
  llvm.func @powi_fmul_arg0_no_reassoc(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  : (f64, i32) -> f64
    %1 = llvm.fmul %0, %arg0  : f64
    llvm.return %1 : f64
  }]

def powi_fmul_arg0_before := [llvmfunc|
  llvm.func @powi_fmul_arg0(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  : (f64, i32) -> f64
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %1 : f64
  }]

def powi_fmul_arg0_use_before := [llvmfunc|
  llvm.func @powi_fmul_arg0_use(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  : (f64, i32) -> f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %1 : f64
  }]

def powi_fmul_powi_no_reassoc1_before := [llvmfunc|
  llvm.func @powi_fmul_powi_no_reassoc1(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %1 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %2 = llvm.fmul %1, %0  : f64
    llvm.return %2 : f64
  }]

def powi_fmul_powi_no_reassoc2_before := [llvmfunc|
  llvm.func @powi_fmul_powi_no_reassoc2(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %1 = llvm.intr.powi(%arg0, %arg2)  : (f64, i32) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def powi_fmul_powi_no_reassoc3_before := [llvmfunc|
  llvm.func @powi_fmul_powi_no_reassoc3(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  : (f64, i32) -> f64
    %1 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def powi_fmul_powi_before := [llvmfunc|
  llvm.func @powi_fmul_powi(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %1 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def powi_fmul_powi_fast_on_fmul_before := [llvmfunc|
  llvm.func @powi_fmul_powi_fast_on_fmul(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64]

    %1 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64]

    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    llvm.return %2 : f64
  }]

def powi_fmul_powi_fast_on_powi_before := [llvmfunc|
  llvm.func @powi_fmul_powi_fast_on_powi(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64]

    %1 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64]

    %2 = llvm.fmul %1, %0  : f64
    llvm.return %2 : f64
  }]

def powi_fmul_powi_same_power_before := [llvmfunc|
  llvm.func @powi_fmul_powi_same_power(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %1 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def powi_fmul_powi_different_integer_types_before := [llvmfunc|
  llvm.func @powi_fmul_powi_different_integer_types(%arg0: f64, %arg1: i32, %arg2: i16) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %1 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i16) -> f64]

    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def powi_fmul_powi_use_first_before := [llvmfunc|
  llvm.func @powi_fmul_powi_use_first(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def powi_fmul_powi_use_second_before := [llvmfunc|
  llvm.func @powi_fmul_powi_use_second(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def powi_fmul_different_base_before := [llvmfunc|
  llvm.func @powi_fmul_different_base(%arg0: f64, %arg1: f64, %arg2: i32, %arg3: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg2)  : (f64, i32) -> f64
    %1 = llvm.intr.powi(%arg1, %arg3)  : (f64, i32) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def different_types_powi_before := [llvmfunc|
  llvm.func @different_types_powi(%arg0: f64, %arg1: i32, %arg2: i64) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  : (f64, i32) -> f64
    %1 = llvm.intr.powi(%arg0, %arg2)  : (f64, i64) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def fdiv_pow_powi_before := [llvmfunc|
  llvm.func @fdiv_pow_powi(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %2 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

    llvm.return %2 : f64
  }]

def fdiv_powf_powi_before := [llvmfunc|
  llvm.func @fdiv_powf_powi(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f32, i32) -> f32]

    %2 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fdiv_pow_powi_multi_use_before := [llvmfunc|
  llvm.func @fdiv_pow_powi_multi_use(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    %2 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

def fdiv_powf_powi_missing_reassoc_before := [llvmfunc|
  llvm.func @fdiv_powf_powi_missing_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f32, i32) -> f32
    %2 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fdiv_powf_powi_missing_reassoc1_before := [llvmfunc|
  llvm.func @fdiv_powf_powi_missing_reassoc1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f32, i32) -> f32]

    %2 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    llvm.return %2 : f32
  }]

def fdiv_powf_powi_missing_nnan_before := [llvmfunc|
  llvm.func @fdiv_powf_powi_missing_nnan(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f32, i32) -> f32
    %2 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fdiv_pow_powi_negative_before := [llvmfunc|
  llvm.func @fdiv_pow_powi_negative(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    %2 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

    llvm.return %2 : f64
  }]

def fdiv_pow_powi_negative_variable_before := [llvmfunc|
  llvm.func @fdiv_pow_powi_negative_variable(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

    llvm.return %1 : f64
  }]

def fdiv_fmul_powi_before := [llvmfunc|
  llvm.func @fdiv_fmul_powi(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %2 = llvm.fmul %arg1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

    llvm.return %3 : f64
  }]

def fdiv_fmul_powi_2_before := [llvmfunc|
  llvm.func @fdiv_fmul_powi_2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %2 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

    llvm.return %3 : f64
  }]

def fdiv_fmul_powi_vector_before := [llvmfunc|
  llvm.func @fdiv_fmul_powi_vector(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (vector<2xf32>, i32) -> vector<2xf32>]

    %2 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<2xf32>]

    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : vector<2xf32>]

    llvm.return %3 : vector<2xf32>
  }]

def fdiv_fmul_powi_missing_reassoc1_before := [llvmfunc|
  llvm.func @fdiv_fmul_powi_missing_reassoc1(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %2 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    llvm.return %3 : f64
  }]

def fdiv_fmul_powi_missing_reassoc2_before := [llvmfunc|
  llvm.func @fdiv_fmul_powi_missing_reassoc2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %2 = llvm.fmul %arg0, %arg0  : f64
    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

    llvm.return %3 : f64
  }]

def fdiv_fmul_powi_missing_reassoc3_before := [llvmfunc|
  llvm.func @fdiv_fmul_powi_missing_reassoc3(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    %2 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

    llvm.return %3 : f64
  }]

def fdiv_fmul_powi_missing_nnan_before := [llvmfunc|
  llvm.func @fdiv_fmul_powi_missing_nnan(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %2 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %3 : f64
  }]

def fdiv_fmul_powi_negative_wrap_before := [llvmfunc|
  llvm.func @fdiv_fmul_powi_negative_wrap(%arg0: f64 {llvm.noundef}) -> f64 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def fdiv_fmul_powi_multi_use_before := [llvmfunc|
  llvm.func @fdiv_fmul_powi_multi_use(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    llvm.call @use(%1) : (f64) -> ()
    %2 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

    llvm.return %3 : f64
  }]

def powi_fmul_powi_x_before := [llvmfunc|
  llvm.func @powi_fmul_powi_x(%arg0: f64 {llvm.noundef}) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def powi_fmul_powi_x_multi_use_before := [llvmfunc|
  llvm.func @powi_fmul_powi_x_multi_use(%arg0: f64 {llvm.noundef}) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    llvm.call @use(%1) : (f64) -> ()
    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def powi_fmul_powi_x_missing_reassoc_before := [llvmfunc|
  llvm.func @powi_fmul_powi_x_missing_reassoc(%arg0: f64 {llvm.noundef}) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    %2 = llvm.fmul %1, %arg0  : f64
    llvm.return %2 : f64
  }]

def powi_fmul_powi_x_overflow_before := [llvmfunc|
  llvm.func @powi_fmul_powi_x_overflow(%arg0: f64 {llvm.noundef}) -> f64 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def powi_fneg_even_int_combined := [llvmfunc|
  llvm.func @powi_fneg_even_int(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_powi_fneg_even_int   : powi_fneg_even_int_before  ⊑  powi_fneg_even_int_combined := by
  unfold powi_fneg_even_int_before powi_fneg_even_int_combined
  simp_alive_peephole
  sorry
def powi_fabs_even_int_combined := [llvmfunc|
  llvm.func @powi_fabs_even_int(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_powi_fabs_even_int   : powi_fabs_even_int_before  ⊑  powi_fabs_even_int_combined := by
  unfold powi_fabs_even_int_before powi_fabs_even_int_combined
  simp_alive_peephole
  sorry
def powi_copysign_even_int_combined := [llvmfunc|
  llvm.func @powi_copysign_even_int(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_powi_copysign_even_int   : powi_copysign_even_int_before  ⊑  powi_copysign_even_int_combined := by
  unfold powi_copysign_even_int_before powi_copysign_even_int_combined
  simp_alive_peephole
  sorry
def powi_fneg_odd_int_combined := [llvmfunc|
  llvm.func @powi_fneg_odd_int(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.fneg %arg0  : f64
    %2 = llvm.intr.powi(%1, %0)  : (f64, i32) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_powi_fneg_odd_int   : powi_fneg_odd_int_before  ⊑  powi_fneg_odd_int_combined := by
  unfold powi_fneg_odd_int_before powi_fneg_odd_int_combined
  simp_alive_peephole
  sorry
def powi_fabs_odd_int_combined := [llvmfunc|
  llvm.func @powi_fabs_odd_int(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.intr.powi(%1, %0)  : (f64, i32) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_powi_fabs_odd_int   : powi_fabs_odd_int_before  ⊑  powi_fabs_odd_int_combined := by
  unfold powi_fabs_odd_int_before powi_fabs_odd_int_combined
  simp_alive_peephole
  sorry
def powi_copysign_odd_int_combined := [llvmfunc|
  llvm.func @powi_copysign_odd_int(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.copysign(%arg0, %arg1)  : (f64, f64) -> f64
    %2 = llvm.intr.powi(%1, %0)  : (f64, i32) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_powi_copysign_odd_int   : powi_copysign_odd_int_before  ⊑  powi_copysign_odd_int_combined := by
  unfold powi_copysign_odd_int_before powi_copysign_odd_int_combined
  simp_alive_peephole
  sorry
def powi_fmul_arg0_no_reassoc_combined := [llvmfunc|
  llvm.func @powi_fmul_arg0_no_reassoc(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  : (f64, i32) -> f64
    %1 = llvm.fmul %0, %arg0  : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_powi_fmul_arg0_no_reassoc   : powi_fmul_arg0_no_reassoc_before  ⊑  powi_fmul_arg0_no_reassoc_combined := by
  unfold powi_fmul_arg0_no_reassoc_before powi_fmul_arg0_no_reassoc_combined
  simp_alive_peephole
  sorry
def powi_fmul_arg0_combined := [llvmfunc|
  llvm.func @powi_fmul_arg0(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  : (f64, i32) -> f64
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_powi_fmul_arg0   : powi_fmul_arg0_before  ⊑  powi_fmul_arg0_combined := by
  unfold powi_fmul_arg0_before powi_fmul_arg0_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_powi_fmul_arg0   : powi_fmul_arg0_before  ⊑  powi_fmul_arg0_combined := by
  unfold powi_fmul_arg0_before powi_fmul_arg0_combined
  simp_alive_peephole
  sorry
def powi_fmul_arg0_use_combined := [llvmfunc|
  llvm.func @powi_fmul_arg0_use(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  : (f64, i32) -> f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_powi_fmul_arg0_use   : powi_fmul_arg0_use_before  ⊑  powi_fmul_arg0_use_combined := by
  unfold powi_fmul_arg0_use_before powi_fmul_arg0_use_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_powi_fmul_arg0_use   : powi_fmul_arg0_use_before  ⊑  powi_fmul_arg0_use_combined := by
  unfold powi_fmul_arg0_use_before powi_fmul_arg0_use_combined
  simp_alive_peephole
  sorry
def powi_fmul_powi_no_reassoc1_combined := [llvmfunc|
  llvm.func @powi_fmul_powi_no_reassoc1(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_powi_fmul_powi_no_reassoc1   : powi_fmul_powi_no_reassoc1_before  ⊑  powi_fmul_powi_no_reassoc1_combined := by
  unfold powi_fmul_powi_no_reassoc1_before powi_fmul_powi_no_reassoc1_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_powi_fmul_powi_no_reassoc1   : powi_fmul_powi_no_reassoc1_before  ⊑  powi_fmul_powi_no_reassoc1_combined := by
  unfold powi_fmul_powi_no_reassoc1_before powi_fmul_powi_no_reassoc1_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %1, %0  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_powi_fmul_powi_no_reassoc1   : powi_fmul_powi_no_reassoc1_before  ⊑  powi_fmul_powi_no_reassoc1_combined := by
  unfold powi_fmul_powi_no_reassoc1_before powi_fmul_powi_no_reassoc1_combined
  simp_alive_peephole
  sorry
def powi_fmul_powi_no_reassoc2_combined := [llvmfunc|
  llvm.func @powi_fmul_powi_no_reassoc2(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.add %arg2, %arg1  : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_powi_fmul_powi_no_reassoc2   : powi_fmul_powi_no_reassoc2_before  ⊑  powi_fmul_powi_no_reassoc2_combined := by
  unfold powi_fmul_powi_no_reassoc2_before powi_fmul_powi_no_reassoc2_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_powi_fmul_powi_no_reassoc2   : powi_fmul_powi_no_reassoc2_before  ⊑  powi_fmul_powi_no_reassoc2_combined := by
  unfold powi_fmul_powi_no_reassoc2_before powi_fmul_powi_no_reassoc2_combined
  simp_alive_peephole
  sorry
def powi_fmul_powi_no_reassoc3_combined := [llvmfunc|
  llvm.func @powi_fmul_powi_no_reassoc3(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.add %arg2, %arg1  : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_powi_fmul_powi_no_reassoc3   : powi_fmul_powi_no_reassoc3_before  ⊑  powi_fmul_powi_no_reassoc3_combined := by
  unfold powi_fmul_powi_no_reassoc3_before powi_fmul_powi_no_reassoc3_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_powi_fmul_powi_no_reassoc3   : powi_fmul_powi_no_reassoc3_before  ⊑  powi_fmul_powi_no_reassoc3_combined := by
  unfold powi_fmul_powi_no_reassoc3_before powi_fmul_powi_no_reassoc3_combined
  simp_alive_peephole
  sorry
def powi_fmul_powi_combined := [llvmfunc|
  llvm.func @powi_fmul_powi(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.add %arg2, %arg1  : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_powi_fmul_powi   : powi_fmul_powi_before  ⊑  powi_fmul_powi_combined := by
  unfold powi_fmul_powi_before powi_fmul_powi_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_powi_fmul_powi   : powi_fmul_powi_before  ⊑  powi_fmul_powi_combined := by
  unfold powi_fmul_powi_before powi_fmul_powi_combined
  simp_alive_peephole
  sorry
def powi_fmul_powi_fast_on_fmul_combined := [llvmfunc|
  llvm.func @powi_fmul_powi_fast_on_fmul(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.add %arg2, %arg1  : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64]

theorem inst_combine_powi_fmul_powi_fast_on_fmul   : powi_fmul_powi_fast_on_fmul_before  ⊑  powi_fmul_powi_fast_on_fmul_combined := by
  unfold powi_fmul_powi_fast_on_fmul_before powi_fmul_powi_fast_on_fmul_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_powi_fmul_powi_fast_on_fmul   : powi_fmul_powi_fast_on_fmul_before  ⊑  powi_fmul_powi_fast_on_fmul_combined := by
  unfold powi_fmul_powi_fast_on_fmul_before powi_fmul_powi_fast_on_fmul_combined
  simp_alive_peephole
  sorry
def powi_fmul_powi_fast_on_powi_combined := [llvmfunc|
  llvm.func @powi_fmul_powi_fast_on_powi(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64]

theorem inst_combine_powi_fmul_powi_fast_on_powi   : powi_fmul_powi_fast_on_powi_before  ⊑  powi_fmul_powi_fast_on_powi_combined := by
  unfold powi_fmul_powi_fast_on_powi_before powi_fmul_powi_fast_on_powi_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64]

theorem inst_combine_powi_fmul_powi_fast_on_powi   : powi_fmul_powi_fast_on_powi_before  ⊑  powi_fmul_powi_fast_on_powi_combined := by
  unfold powi_fmul_powi_fast_on_powi_before powi_fmul_powi_fast_on_powi_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %1, %0  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_powi_fmul_powi_fast_on_powi   : powi_fmul_powi_fast_on_powi_before  ⊑  powi_fmul_powi_fast_on_powi_combined := by
  unfold powi_fmul_powi_fast_on_powi_before powi_fmul_powi_fast_on_powi_combined
  simp_alive_peephole
  sorry
def powi_fmul_powi_same_power_combined := [llvmfunc|
  llvm.func @powi_fmul_powi_same_power(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %arg1, %0  : i32
    %2 = llvm.intr.powi(%arg0, %1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_powi_fmul_powi_same_power   : powi_fmul_powi_same_power_before  ⊑  powi_fmul_powi_same_power_combined := by
  unfold powi_fmul_powi_same_power_before powi_fmul_powi_same_power_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_powi_fmul_powi_same_power   : powi_fmul_powi_same_power_before  ⊑  powi_fmul_powi_same_power_combined := by
  unfold powi_fmul_powi_same_power_before powi_fmul_powi_same_power_combined
  simp_alive_peephole
  sorry
def powi_fmul_powi_different_integer_types_combined := [llvmfunc|
  llvm.func @powi_fmul_powi_different_integer_types(%arg0: f64, %arg1: i32, %arg2: i16) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_powi_fmul_powi_different_integer_types   : powi_fmul_powi_different_integer_types_before  ⊑  powi_fmul_powi_different_integer_types_combined := by
  unfold powi_fmul_powi_different_integer_types_before powi_fmul_powi_different_integer_types_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i16) -> f64]

theorem inst_combine_powi_fmul_powi_different_integer_types   : powi_fmul_powi_different_integer_types_before  ⊑  powi_fmul_powi_different_integer_types_combined := by
  unfold powi_fmul_powi_different_integer_types_before powi_fmul_powi_different_integer_types_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_powi_fmul_powi_different_integer_types   : powi_fmul_powi_different_integer_types_before  ⊑  powi_fmul_powi_different_integer_types_combined := by
  unfold powi_fmul_powi_different_integer_types_before powi_fmul_powi_different_integer_types_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_powi_fmul_powi_different_integer_types   : powi_fmul_powi_different_integer_types_before  ⊑  powi_fmul_powi_different_integer_types_combined := by
  unfold powi_fmul_powi_different_integer_types_before powi_fmul_powi_different_integer_types_combined
  simp_alive_peephole
  sorry
def powi_fmul_powi_use_first_combined := [llvmfunc|
  llvm.func @powi_fmul_powi_use_first(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_powi_fmul_powi_use_first   : powi_fmul_powi_use_first_before  ⊑  powi_fmul_powi_use_first_combined := by
  unfold powi_fmul_powi_use_first_before powi_fmul_powi_use_first_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.add %arg1, %arg2  : i32
    %2 = llvm.intr.powi(%arg0, %1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_powi_fmul_powi_use_first   : powi_fmul_powi_use_first_before  ⊑  powi_fmul_powi_use_first_combined := by
  unfold powi_fmul_powi_use_first_before powi_fmul_powi_use_first_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_powi_fmul_powi_use_first   : powi_fmul_powi_use_first_before  ⊑  powi_fmul_powi_use_first_combined := by
  unfold powi_fmul_powi_use_first_before powi_fmul_powi_use_first_combined
  simp_alive_peephole
  sorry
def powi_fmul_powi_use_second_combined := [llvmfunc|
  llvm.func @powi_fmul_powi_use_second(%arg0: f64, %arg1: i32, %arg2: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_powi_fmul_powi_use_second   : powi_fmul_powi_use_second_before  ⊑  powi_fmul_powi_use_second_combined := by
  unfold powi_fmul_powi_use_second_before powi_fmul_powi_use_second_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.add %arg1, %arg2  : i32
    %2 = llvm.intr.powi(%arg0, %1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_powi_fmul_powi_use_second   : powi_fmul_powi_use_second_before  ⊑  powi_fmul_powi_use_second_combined := by
  unfold powi_fmul_powi_use_second_before powi_fmul_powi_use_second_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_powi_fmul_powi_use_second   : powi_fmul_powi_use_second_before  ⊑  powi_fmul_powi_use_second_combined := by
  unfold powi_fmul_powi_use_second_before powi_fmul_powi_use_second_combined
  simp_alive_peephole
  sorry
def powi_fmul_different_base_combined := [llvmfunc|
  llvm.func @powi_fmul_different_base(%arg0: f64, %arg1: f64, %arg2: i32, %arg3: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg2)  : (f64, i32) -> f64
    %1 = llvm.intr.powi(%arg1, %arg3)  : (f64, i32) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_powi_fmul_different_base   : powi_fmul_different_base_before  ⊑  powi_fmul_different_base_combined := by
  unfold powi_fmul_different_base_before powi_fmul_different_base_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_powi_fmul_different_base   : powi_fmul_different_base_before  ⊑  powi_fmul_different_base_combined := by
  unfold powi_fmul_different_base_before powi_fmul_different_base_combined
  simp_alive_peephole
  sorry
def different_types_powi_combined := [llvmfunc|
  llvm.func @different_types_powi(%arg0: f64, %arg1: i32, %arg2: i64) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  : (f64, i32) -> f64
    %1 = llvm.intr.powi(%arg0, %arg2)  : (f64, i64) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_different_types_powi   : different_types_powi_before  ⊑  different_types_powi_combined := by
  unfold different_types_powi_before different_types_powi_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_different_types_powi   : different_types_powi_before  ⊑  different_types_powi_combined := by
  unfold different_types_powi_before different_types_powi_combined
  simp_alive_peephole
  sorry
def fdiv_pow_powi_combined := [llvmfunc|
  llvm.func @fdiv_pow_powi(%arg0: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

theorem inst_combine_fdiv_pow_powi   : fdiv_pow_powi_before  ⊑  fdiv_pow_powi_combined := by
  unfold fdiv_pow_powi_before fdiv_pow_powi_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f64
  }]

theorem inst_combine_fdiv_pow_powi   : fdiv_pow_powi_before  ⊑  fdiv_pow_powi_combined := by
  unfold fdiv_pow_powi_before fdiv_pow_powi_combined
  simp_alive_peephole
  sorry
def fdiv_powf_powi_combined := [llvmfunc|
  llvm.func @fdiv_powf_powi(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(99 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : (f32, i32) -> f32]

theorem inst_combine_fdiv_powf_powi   : fdiv_powf_powi_before  ⊑  fdiv_powf_powi_combined := by
  unfold fdiv_powf_powi_before fdiv_powf_powi_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_fdiv_powf_powi   : fdiv_powf_powi_before  ⊑  fdiv_powf_powi_combined := by
  unfold fdiv_powf_powi_before fdiv_powf_powi_combined
  simp_alive_peephole
  sorry
def fdiv_pow_powi_multi_use_combined := [llvmfunc|
  llvm.func @fdiv_pow_powi_multi_use(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    %2 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

theorem inst_combine_fdiv_pow_powi_multi_use   : fdiv_pow_powi_multi_use_before  ⊑  fdiv_pow_powi_multi_use_combined := by
  unfold fdiv_pow_powi_multi_use_before fdiv_pow_powi_multi_use_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

theorem inst_combine_fdiv_pow_powi_multi_use   : fdiv_pow_powi_multi_use_before  ⊑  fdiv_pow_powi_multi_use_combined := by
  unfold fdiv_pow_powi_multi_use_before fdiv_pow_powi_multi_use_combined
  simp_alive_peephole
  sorry
def fdiv_powf_powi_missing_reassoc_combined := [llvmfunc|
  llvm.func @fdiv_powf_powi_missing_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(99 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : (f32, i32) -> f32]

theorem inst_combine_fdiv_powf_powi_missing_reassoc   : fdiv_powf_powi_missing_reassoc_before  ⊑  fdiv_powf_powi_missing_reassoc_combined := by
  unfold fdiv_powf_powi_missing_reassoc_before fdiv_powf_powi_missing_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_fdiv_powf_powi_missing_reassoc   : fdiv_powf_powi_missing_reassoc_before  ⊑  fdiv_powf_powi_missing_reassoc_combined := by
  unfold fdiv_powf_powi_missing_reassoc_before fdiv_powf_powi_missing_reassoc_combined
  simp_alive_peephole
  sorry
def fdiv_powf_powi_missing_reassoc1_combined := [llvmfunc|
  llvm.func @fdiv_powf_powi_missing_reassoc1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f32, i32) -> f32]

theorem inst_combine_fdiv_powf_powi_missing_reassoc1   : fdiv_powf_powi_missing_reassoc1_before  ⊑  fdiv_powf_powi_missing_reassoc1_combined := by
  unfold fdiv_powf_powi_missing_reassoc1_before fdiv_powf_powi_missing_reassoc1_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

theorem inst_combine_fdiv_powf_powi_missing_reassoc1   : fdiv_powf_powi_missing_reassoc1_before  ⊑  fdiv_powf_powi_missing_reassoc1_combined := by
  unfold fdiv_powf_powi_missing_reassoc1_before fdiv_powf_powi_missing_reassoc1_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_fdiv_powf_powi_missing_reassoc1   : fdiv_powf_powi_missing_reassoc1_before  ⊑  fdiv_powf_powi_missing_reassoc1_combined := by
  unfold fdiv_powf_powi_missing_reassoc1_before fdiv_powf_powi_missing_reassoc1_combined
  simp_alive_peephole
  sorry
def fdiv_powf_powi_missing_nnan_combined := [llvmfunc|
  llvm.func @fdiv_powf_powi_missing_nnan(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f32, i32) -> f32
    %2 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_fdiv_powf_powi_missing_nnan   : fdiv_powf_powi_missing_nnan_before  ⊑  fdiv_powf_powi_missing_nnan_combined := by
  unfold fdiv_powf_powi_missing_nnan_before fdiv_powf_powi_missing_nnan_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_fdiv_powf_powi_missing_nnan   : fdiv_powf_powi_missing_nnan_before  ⊑  fdiv_powf_powi_missing_nnan_combined := by
  unfold fdiv_powf_powi_missing_nnan_before fdiv_powf_powi_missing_nnan_combined
  simp_alive_peephole
  sorry
def fdiv_pow_powi_negative_combined := [llvmfunc|
  llvm.func @fdiv_pow_powi_negative(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    %2 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

theorem inst_combine_fdiv_pow_powi_negative   : fdiv_pow_powi_negative_before  ⊑  fdiv_pow_powi_negative_combined := by
  unfold fdiv_pow_powi_negative_before fdiv_pow_powi_negative_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_fdiv_pow_powi_negative   : fdiv_pow_powi_negative_before  ⊑  fdiv_pow_powi_negative_combined := by
  unfold fdiv_pow_powi_negative_before fdiv_pow_powi_negative_combined
  simp_alive_peephole
  sorry
def fdiv_pow_powi_negative_variable_combined := [llvmfunc|
  llvm.func @fdiv_pow_powi_negative_variable(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_fdiv_pow_powi_negative_variable   : fdiv_pow_powi_negative_variable_before  ⊑  fdiv_pow_powi_negative_variable_combined := by
  unfold fdiv_pow_powi_negative_variable_before fdiv_pow_powi_negative_variable_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

theorem inst_combine_fdiv_pow_powi_negative_variable   : fdiv_pow_powi_negative_variable_before  ⊑  fdiv_pow_powi_negative_variable_combined := by
  unfold fdiv_pow_powi_negative_variable_before fdiv_pow_powi_negative_variable_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_fdiv_pow_powi_negative_variable   : fdiv_pow_powi_negative_variable_before  ⊑  fdiv_pow_powi_negative_variable_combined := by
  unfold fdiv_pow_powi_negative_variable_before fdiv_pow_powi_negative_variable_combined
  simp_alive_peephole
  sorry
def fdiv_fmul_powi_combined := [llvmfunc|
  llvm.func @fdiv_fmul_powi(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_fdiv_fmul_powi   : fdiv_fmul_powi_before  ⊑  fdiv_fmul_powi_combined := by
  unfold fdiv_fmul_powi_before fdiv_fmul_powi_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %arg1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_fdiv_fmul_powi   : fdiv_fmul_powi_before  ⊑  fdiv_fmul_powi_combined := by
  unfold fdiv_fmul_powi_before fdiv_fmul_powi_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

theorem inst_combine_fdiv_fmul_powi   : fdiv_fmul_powi_before  ⊑  fdiv_fmul_powi_combined := by
  unfold fdiv_fmul_powi_before fdiv_fmul_powi_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f64
  }]

theorem inst_combine_fdiv_fmul_powi   : fdiv_fmul_powi_before  ⊑  fdiv_fmul_powi_combined := by
  unfold fdiv_fmul_powi_before fdiv_fmul_powi_combined
  simp_alive_peephole
  sorry
def fdiv_fmul_powi_2_combined := [llvmfunc|
  llvm.func @fdiv_fmul_powi_2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_fdiv_fmul_powi_2   : fdiv_fmul_powi_2_before  ⊑  fdiv_fmul_powi_2_combined := by
  unfold fdiv_fmul_powi_2_before fdiv_fmul_powi_2_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_fdiv_fmul_powi_2   : fdiv_fmul_powi_2_before  ⊑  fdiv_fmul_powi_2_combined := by
  unfold fdiv_fmul_powi_2_before fdiv_fmul_powi_2_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

theorem inst_combine_fdiv_fmul_powi_2   : fdiv_fmul_powi_2_before  ⊑  fdiv_fmul_powi_2_combined := by
  unfold fdiv_fmul_powi_2_before fdiv_fmul_powi_2_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f64
  }]

theorem inst_combine_fdiv_fmul_powi_2   : fdiv_fmul_powi_2_before  ⊑  fdiv_fmul_powi_2_combined := by
  unfold fdiv_fmul_powi_2_before fdiv_fmul_powi_2_combined
  simp_alive_peephole
  sorry
def fdiv_fmul_powi_vector_combined := [llvmfunc|
  llvm.func @fdiv_fmul_powi_vector(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (vector<2xf32>, i32) -> vector<2xf32>]

theorem inst_combine_fdiv_fmul_powi_vector   : fdiv_fmul_powi_vector_before  ⊑  fdiv_fmul_powi_vector_combined := by
  unfold fdiv_fmul_powi_vector_before fdiv_fmul_powi_vector_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<2xf32>]

theorem inst_combine_fdiv_fmul_powi_vector   : fdiv_fmul_powi_vector_before  ⊑  fdiv_fmul_powi_vector_combined := by
  unfold fdiv_fmul_powi_vector_before fdiv_fmul_powi_vector_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : vector<2xf32>]

theorem inst_combine_fdiv_fmul_powi_vector   : fdiv_fmul_powi_vector_before  ⊑  fdiv_fmul_powi_vector_combined := by
  unfold fdiv_fmul_powi_vector_before fdiv_fmul_powi_vector_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<2xf32>
  }]

theorem inst_combine_fdiv_fmul_powi_vector   : fdiv_fmul_powi_vector_before  ⊑  fdiv_fmul_powi_vector_combined := by
  unfold fdiv_fmul_powi_vector_before fdiv_fmul_powi_vector_combined
  simp_alive_peephole
  sorry
def fdiv_fmul_powi_missing_reassoc1_combined := [llvmfunc|
  llvm.func @fdiv_fmul_powi_missing_reassoc1(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_fdiv_fmul_powi_missing_reassoc1   : fdiv_fmul_powi_missing_reassoc1_before  ⊑  fdiv_fmul_powi_missing_reassoc1_combined := by
  unfold fdiv_fmul_powi_missing_reassoc1_before fdiv_fmul_powi_missing_reassoc1_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_fdiv_fmul_powi_missing_reassoc1   : fdiv_fmul_powi_missing_reassoc1_before  ⊑  fdiv_fmul_powi_missing_reassoc1_combined := by
  unfold fdiv_fmul_powi_missing_reassoc1_before fdiv_fmul_powi_missing_reassoc1_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

theorem inst_combine_fdiv_fmul_powi_missing_reassoc1   : fdiv_fmul_powi_missing_reassoc1_before  ⊑  fdiv_fmul_powi_missing_reassoc1_combined := by
  unfold fdiv_fmul_powi_missing_reassoc1_before fdiv_fmul_powi_missing_reassoc1_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f64
  }]

theorem inst_combine_fdiv_fmul_powi_missing_reassoc1   : fdiv_fmul_powi_missing_reassoc1_before  ⊑  fdiv_fmul_powi_missing_reassoc1_combined := by
  unfold fdiv_fmul_powi_missing_reassoc1_before fdiv_fmul_powi_missing_reassoc1_combined
  simp_alive_peephole
  sorry
def fdiv_fmul_powi_missing_reassoc2_combined := [llvmfunc|
  llvm.func @fdiv_fmul_powi_missing_reassoc2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_fdiv_fmul_powi_missing_reassoc2   : fdiv_fmul_powi_missing_reassoc2_before  ⊑  fdiv_fmul_powi_missing_reassoc2_combined := by
  unfold fdiv_fmul_powi_missing_reassoc2_before fdiv_fmul_powi_missing_reassoc2_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %arg0, %arg0  : f64
    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

theorem inst_combine_fdiv_fmul_powi_missing_reassoc2   : fdiv_fmul_powi_missing_reassoc2_before  ⊑  fdiv_fmul_powi_missing_reassoc2_combined := by
  unfold fdiv_fmul_powi_missing_reassoc2_before fdiv_fmul_powi_missing_reassoc2_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f64
  }]

theorem inst_combine_fdiv_fmul_powi_missing_reassoc2   : fdiv_fmul_powi_missing_reassoc2_before  ⊑  fdiv_fmul_powi_missing_reassoc2_combined := by
  unfold fdiv_fmul_powi_missing_reassoc2_before fdiv_fmul_powi_missing_reassoc2_combined
  simp_alive_peephole
  sorry
def fdiv_fmul_powi_missing_reassoc3_combined := [llvmfunc|
  llvm.func @fdiv_fmul_powi_missing_reassoc3(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    %2 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_fdiv_fmul_powi_missing_reassoc3   : fdiv_fmul_powi_missing_reassoc3_before  ⊑  fdiv_fmul_powi_missing_reassoc3_combined := by
  unfold fdiv_fmul_powi_missing_reassoc3_before fdiv_fmul_powi_missing_reassoc3_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

theorem inst_combine_fdiv_fmul_powi_missing_reassoc3   : fdiv_fmul_powi_missing_reassoc3_before  ⊑  fdiv_fmul_powi_missing_reassoc3_combined := by
  unfold fdiv_fmul_powi_missing_reassoc3_before fdiv_fmul_powi_missing_reassoc3_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f64
  }]

theorem inst_combine_fdiv_fmul_powi_missing_reassoc3   : fdiv_fmul_powi_missing_reassoc3_before  ⊑  fdiv_fmul_powi_missing_reassoc3_combined := by
  unfold fdiv_fmul_powi_missing_reassoc3_before fdiv_fmul_powi_missing_reassoc3_combined
  simp_alive_peephole
  sorry
def fdiv_fmul_powi_missing_nnan_combined := [llvmfunc|
  llvm.func @fdiv_fmul_powi_missing_nnan(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_fdiv_fmul_powi_missing_nnan   : fdiv_fmul_powi_missing_nnan_before  ⊑  fdiv_fmul_powi_missing_nnan_combined := by
  unfold fdiv_fmul_powi_missing_nnan_before fdiv_fmul_powi_missing_nnan_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_fdiv_fmul_powi_missing_nnan   : fdiv_fmul_powi_missing_nnan_before  ⊑  fdiv_fmul_powi_missing_nnan_combined := by
  unfold fdiv_fmul_powi_missing_nnan_before fdiv_fmul_powi_missing_nnan_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_fdiv_fmul_powi_missing_nnan   : fdiv_fmul_powi_missing_nnan_before  ⊑  fdiv_fmul_powi_missing_nnan_combined := by
  unfold fdiv_fmul_powi_missing_nnan_before fdiv_fmul_powi_missing_nnan_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f64
  }]

theorem inst_combine_fdiv_fmul_powi_missing_nnan   : fdiv_fmul_powi_missing_nnan_before  ⊑  fdiv_fmul_powi_missing_nnan_combined := by
  unfold fdiv_fmul_powi_missing_nnan_before fdiv_fmul_powi_missing_nnan_combined
  simp_alive_peephole
  sorry
def fdiv_fmul_powi_negative_wrap_combined := [llvmfunc|
  llvm.func @fdiv_fmul_powi_negative_wrap(%arg0: f64 {llvm.noundef}) -> f64 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_fdiv_fmul_powi_negative_wrap   : fdiv_fmul_powi_negative_wrap_before  ⊑  fdiv_fmul_powi_negative_wrap_combined := by
  unfold fdiv_fmul_powi_negative_wrap_before fdiv_fmul_powi_negative_wrap_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_fdiv_fmul_powi_negative_wrap   : fdiv_fmul_powi_negative_wrap_before  ⊑  fdiv_fmul_powi_negative_wrap_combined := by
  unfold fdiv_fmul_powi_negative_wrap_before fdiv_fmul_powi_negative_wrap_combined
  simp_alive_peephole
  sorry
def fdiv_fmul_powi_multi_use_combined := [llvmfunc|
  llvm.func @fdiv_fmul_powi_multi_use(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_fdiv_fmul_powi_multi_use   : fdiv_fmul_powi_multi_use_before  ⊑  fdiv_fmul_powi_multi_use_combined := by
  unfold fdiv_fmul_powi_multi_use_before fdiv_fmul_powi_multi_use_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%1) : (f64) -> ()
    %2 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_fdiv_fmul_powi_multi_use   : fdiv_fmul_powi_multi_use_before  ⊑  fdiv_fmul_powi_multi_use_combined := by
  unfold fdiv_fmul_powi_multi_use_before fdiv_fmul_powi_multi_use_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

theorem inst_combine_fdiv_fmul_powi_multi_use   : fdiv_fmul_powi_multi_use_before  ⊑  fdiv_fmul_powi_multi_use_combined := by
  unfold fdiv_fmul_powi_multi_use_before fdiv_fmul_powi_multi_use_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f64
  }]

theorem inst_combine_fdiv_fmul_powi_multi_use   : fdiv_fmul_powi_multi_use_before  ⊑  fdiv_fmul_powi_multi_use_combined := by
  unfold fdiv_fmul_powi_multi_use_before fdiv_fmul_powi_multi_use_combined
  simp_alive_peephole
  sorry
def powi_fmul_powi_x_combined := [llvmfunc|
  llvm.func @powi_fmul_powi_x(%arg0: f64 {llvm.noundef}) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, i32) -> f64]

theorem inst_combine_powi_fmul_powi_x   : powi_fmul_powi_x_before  ⊑  powi_fmul_powi_x_combined := by
  unfold powi_fmul_powi_x_before powi_fmul_powi_x_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_powi_fmul_powi_x   : powi_fmul_powi_x_before  ⊑  powi_fmul_powi_x_combined := by
  unfold powi_fmul_powi_x_before powi_fmul_powi_x_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_powi_fmul_powi_x   : powi_fmul_powi_x_before  ⊑  powi_fmul_powi_x_combined := by
  unfold powi_fmul_powi_x_before powi_fmul_powi_x_combined
  simp_alive_peephole
  sorry
def powi_fmul_powi_x_multi_use_combined := [llvmfunc|
  llvm.func @powi_fmul_powi_x_multi_use(%arg0: f64 {llvm.noundef}) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    llvm.call @use(%1) : (f64) -> ()
    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_powi_fmul_powi_x_multi_use   : powi_fmul_powi_x_multi_use_before  ⊑  powi_fmul_powi_x_multi_use_combined := by
  unfold powi_fmul_powi_x_multi_use_before powi_fmul_powi_x_multi_use_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_powi_fmul_powi_x_multi_use   : powi_fmul_powi_x_multi_use_before  ⊑  powi_fmul_powi_x_multi_use_combined := by
  unfold powi_fmul_powi_x_multi_use_before powi_fmul_powi_x_multi_use_combined
  simp_alive_peephole
  sorry
def powi_fmul_powi_x_missing_reassoc_combined := [llvmfunc|
  llvm.func @powi_fmul_powi_x_missing_reassoc(%arg0: f64 {llvm.noundef}) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    %2 = llvm.fmul %1, %arg0  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_powi_fmul_powi_x_missing_reassoc   : powi_fmul_powi_x_missing_reassoc_before  ⊑  powi_fmul_powi_x_missing_reassoc_combined := by
  unfold powi_fmul_powi_x_missing_reassoc_before powi_fmul_powi_x_missing_reassoc_combined
  simp_alive_peephole
  sorry
def powi_fmul_powi_x_overflow_combined := [llvmfunc|
  llvm.func @powi_fmul_powi_x_overflow(%arg0: f64 {llvm.noundef}) -> f64 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  : (f64, i32) -> f64
    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_powi_fmul_powi_x_overflow   : powi_fmul_powi_x_overflow_before  ⊑  powi_fmul_powi_x_overflow_combined := by
  unfold powi_fmul_powi_x_overflow_before powi_fmul_powi_x_overflow_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_powi_fmul_powi_x_overflow   : powi_fmul_powi_x_overflow_before  ⊑  powi_fmul_powi_x_overflow_combined := by
  unfold powi_fmul_powi_x_overflow_before powi_fmul_powi_x_overflow_combined
  simp_alive_peephole
  sorry
