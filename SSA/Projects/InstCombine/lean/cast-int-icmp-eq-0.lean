import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cast-int-icmp-eq-0
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def i32_cast_cmp_eq_int_0_sitofp_float_before := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_sitofp_float(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i32_cast_cmp_ne_int_0_sitofp_float_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_sitofp_float(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i32_cast_cmp_slt_int_0_sitofp_float_before := [llvmfunc|
  llvm.func @i32_cast_cmp_slt_int_0_sitofp_float(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i32_cast_cmp_sgt_int_0_sitofp_float_before := [llvmfunc|
  llvm.func @i32_cast_cmp_sgt_int_0_sitofp_float(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i32_cast_cmp_slt_int_1_sitofp_float_before := [llvmfunc|
  llvm.func @i32_cast_cmp_slt_int_1_sitofp_float(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i32_cast_cmp_sgt_int_m1_sitofp_float_before := [llvmfunc|
  llvm.func @i32_cast_cmp_sgt_int_m1_sitofp_float(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i32_cast_cmp_eq_int_0_sitofp_double_before := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_sitofp_double(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sitofp %arg0 : i32 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i32_cast_cmp_ne_int_0_sitofp_double_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_sitofp_double(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sitofp %arg0 : i32 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "ne" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i32_cast_cmp_slt_int_0_sitofp_double_before := [llvmfunc|
  llvm.func @i32_cast_cmp_slt_int_0_sitofp_double(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sitofp %arg0 : i32 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "slt" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i32_cast_cmp_sgt_int_0_sitofp_double_before := [llvmfunc|
  llvm.func @i32_cast_cmp_sgt_int_0_sitofp_double(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sitofp %arg0 : i32 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i32_cast_cmp_slt_int_1_sitofp_double_before := [llvmfunc|
  llvm.func @i32_cast_cmp_slt_int_1_sitofp_double(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.sitofp %arg0 : i32 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "slt" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i32_cast_cmp_sgt_int_m1_sitofp_double_before := [llvmfunc|
  llvm.func @i32_cast_cmp_sgt_int_m1_sitofp_double(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.sitofp %arg0 : i32 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i32_cast_cmp_eq_int_0_sitofp_half_before := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_sitofp_half(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.sitofp %arg0 : i32 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "eq" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i32_cast_cmp_ne_int_0_sitofp_half_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_sitofp_half(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.sitofp %arg0 : i32 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "ne" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i32_cast_cmp_slt_int_0_sitofp_half_before := [llvmfunc|
  llvm.func @i32_cast_cmp_slt_int_0_sitofp_half(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.sitofp %arg0 : i32 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "slt" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i32_cast_cmp_sgt_int_0_sitofp_half_before := [llvmfunc|
  llvm.func @i32_cast_cmp_sgt_int_0_sitofp_half(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.sitofp %arg0 : i32 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "sgt" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i32_cast_cmp_slt_int_1_sitofp_half_before := [llvmfunc|
  llvm.func @i32_cast_cmp_slt_int_1_sitofp_half(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.sitofp %arg0 : i32 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "slt" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i32_cast_cmp_sgt_int_m1_sitofp_half_before := [llvmfunc|
  llvm.func @i32_cast_cmp_sgt_int_m1_sitofp_half(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.sitofp %arg0 : i32 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "sgt" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i64_cast_cmp_eq_int_0_sitofp_float_before := [llvmfunc|
  llvm.func @i64_cast_cmp_eq_int_0_sitofp_float(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sitofp %arg0 : i64 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i64_cast_cmp_ne_int_0_sitofp_float_before := [llvmfunc|
  llvm.func @i64_cast_cmp_ne_int_0_sitofp_float(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sitofp %arg0 : i64 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i64_cast_cmp_slt_int_0_sitofp_float_before := [llvmfunc|
  llvm.func @i64_cast_cmp_slt_int_0_sitofp_float(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sitofp %arg0 : i64 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i64_cast_cmp_sgt_int_0_sitofp_float_before := [llvmfunc|
  llvm.func @i64_cast_cmp_sgt_int_0_sitofp_float(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sitofp %arg0 : i64 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i64_cast_cmp_slt_int_1_sitofp_float_before := [llvmfunc|
  llvm.func @i64_cast_cmp_slt_int_1_sitofp_float(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sitofp %arg0 : i64 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i64_cast_cmp_sgt_int_m1_sitofp_float_before := [llvmfunc|
  llvm.func @i64_cast_cmp_sgt_int_m1_sitofp_float(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sitofp %arg0 : i64 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i64_cast_cmp_eq_int_0_sitofp_double_before := [llvmfunc|
  llvm.func @i64_cast_cmp_eq_int_0_sitofp_double(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sitofp %arg0 : i64 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i64_cast_cmp_ne_int_0_sitofp_double_before := [llvmfunc|
  llvm.func @i64_cast_cmp_ne_int_0_sitofp_double(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sitofp %arg0 : i64 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "ne" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i64_cast_cmp_slt_int_0_sitofp_double_before := [llvmfunc|
  llvm.func @i64_cast_cmp_slt_int_0_sitofp_double(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sitofp %arg0 : i64 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "slt" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i64_cast_cmp_sgt_int_0_sitofp_double_before := [llvmfunc|
  llvm.func @i64_cast_cmp_sgt_int_0_sitofp_double(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sitofp %arg0 : i64 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i64_cast_cmp_slt_int_1_sitofp_double_before := [llvmfunc|
  llvm.func @i64_cast_cmp_slt_int_1_sitofp_double(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.sitofp %arg0 : i64 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "slt" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i64_cast_cmp_sgt_int_m1_sitofp_double_before := [llvmfunc|
  llvm.func @i64_cast_cmp_sgt_int_m1_sitofp_double(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.sitofp %arg0 : i64 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i64_cast_cmp_eq_int_0_sitofp_half_before := [llvmfunc|
  llvm.func @i64_cast_cmp_eq_int_0_sitofp_half(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.sitofp %arg0 : i64 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "eq" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i64_cast_cmp_ne_int_0_sitofp_half_before := [llvmfunc|
  llvm.func @i64_cast_cmp_ne_int_0_sitofp_half(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.sitofp %arg0 : i64 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "ne" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i64_cast_cmp_slt_int_0_sitofp_half_before := [llvmfunc|
  llvm.func @i64_cast_cmp_slt_int_0_sitofp_half(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.sitofp %arg0 : i64 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "slt" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i64_cast_cmp_sgt_int_0_sitofp_half_before := [llvmfunc|
  llvm.func @i64_cast_cmp_sgt_int_0_sitofp_half(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.sitofp %arg0 : i64 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "sgt" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i64_cast_cmp_slt_int_1_sitofp_half_before := [llvmfunc|
  llvm.func @i64_cast_cmp_slt_int_1_sitofp_half(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.sitofp %arg0 : i64 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "slt" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i64_cast_cmp_sgt_int_m1_sitofp_half_before := [llvmfunc|
  llvm.func @i64_cast_cmp_sgt_int_m1_sitofp_half(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.sitofp %arg0 : i64 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "sgt" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i16_cast_cmp_eq_int_0_sitofp_float_before := [llvmfunc|
  llvm.func @i16_cast_cmp_eq_int_0_sitofp_float(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sitofp %arg0 : i16 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i16_cast_cmp_ne_int_0_sitofp_float_before := [llvmfunc|
  llvm.func @i16_cast_cmp_ne_int_0_sitofp_float(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sitofp %arg0 : i16 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i16_cast_cmp_slt_int_0_sitofp_float_before := [llvmfunc|
  llvm.func @i16_cast_cmp_slt_int_0_sitofp_float(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sitofp %arg0 : i16 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i16_cast_cmp_sgt_int_0_sitofp_float_before := [llvmfunc|
  llvm.func @i16_cast_cmp_sgt_int_0_sitofp_float(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sitofp %arg0 : i16 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i16_cast_cmp_slt_int_1_sitofp_float_before := [llvmfunc|
  llvm.func @i16_cast_cmp_slt_int_1_sitofp_float(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sitofp %arg0 : i16 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i16_cast_cmp_sgt_int_m1_sitofp_float_before := [llvmfunc|
  llvm.func @i16_cast_cmp_sgt_int_m1_sitofp_float(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sitofp %arg0 : i16 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i16_cast_cmp_eq_int_0_sitofp_double_before := [llvmfunc|
  llvm.func @i16_cast_cmp_eq_int_0_sitofp_double(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sitofp %arg0 : i16 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i16_cast_cmp_ne_int_0_sitofp_double_before := [llvmfunc|
  llvm.func @i16_cast_cmp_ne_int_0_sitofp_double(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sitofp %arg0 : i16 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "ne" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i16_cast_cmp_slt_int_0_sitofp_double_before := [llvmfunc|
  llvm.func @i16_cast_cmp_slt_int_0_sitofp_double(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sitofp %arg0 : i16 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "slt" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i16_cast_cmp_sgt_int_0_sitofp_double_before := [llvmfunc|
  llvm.func @i16_cast_cmp_sgt_int_0_sitofp_double(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sitofp %arg0 : i16 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i16_cast_cmp_slt_int_1_sitofp_double_before := [llvmfunc|
  llvm.func @i16_cast_cmp_slt_int_1_sitofp_double(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.sitofp %arg0 : i16 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "slt" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i16_cast_cmp_sgt_int_m1_sitofp_double_before := [llvmfunc|
  llvm.func @i16_cast_cmp_sgt_int_m1_sitofp_double(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.sitofp %arg0 : i16 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "sgt" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i16_cast_cmp_eq_int_0_sitofp_half_before := [llvmfunc|
  llvm.func @i16_cast_cmp_eq_int_0_sitofp_half(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.sitofp %arg0 : i16 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "eq" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i16_cast_cmp_ne_int_0_sitofp_half_before := [llvmfunc|
  llvm.func @i16_cast_cmp_ne_int_0_sitofp_half(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.sitofp %arg0 : i16 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "ne" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i16_cast_cmp_slt_int_0_sitofp_half_before := [llvmfunc|
  llvm.func @i16_cast_cmp_slt_int_0_sitofp_half(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.sitofp %arg0 : i16 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "slt" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i16_cast_cmp_sgt_int_0_sitofp_half_before := [llvmfunc|
  llvm.func @i16_cast_cmp_sgt_int_0_sitofp_half(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.sitofp %arg0 : i16 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "sgt" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i16_cast_cmp_slt_int_1_sitofp_half_before := [llvmfunc|
  llvm.func @i16_cast_cmp_slt_int_1_sitofp_half(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.sitofp %arg0 : i16 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "slt" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i16_cast_cmp_sgt_int_m1_sitofp_half_before := [llvmfunc|
  llvm.func @i16_cast_cmp_sgt_int_m1_sitofp_half(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.sitofp %arg0 : i16 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "sgt" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i32_cast_cmp_ne_int_0_sitofp_double_vec_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_sitofp_double_vec(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<3xi64>) : vector<3xi64>
    %2 = llvm.sitofp %arg0 : vector<3xi32> to vector<3xf64>
    %3 = llvm.bitcast %2 : vector<3xf64> to vector<3xi64>
    %4 = llvm.icmp "ne" %3, %1 : vector<3xi64>
    llvm.return %4 : vector<3xi1>
  }]

def i32_cast_cmp_eq_int_0_sitofp_float_vec_poison_before := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_sitofp_float_vec_poison(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.sitofp %arg0 : vector<3xi32> to vector<3xf32>
    %10 = llvm.bitcast %9 : vector<3xf32> to vector<3xi32>
    %11 = llvm.icmp "eq" %10, %8 : vector<3xi32>
    llvm.return %11 : vector<3xi1>
  }]

def i64_cast_cmp_slt_int_1_sitofp_half_vec_poison_before := [llvmfunc|
  llvm.func @i64_cast_cmp_slt_int_1_sitofp_half_vec_poison(%arg0: vector<3xi64>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<3xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.sitofp %arg0 : vector<3xi64> to vector<3xf16>
    %10 = llvm.bitcast %9 : vector<3xf16> to vector<3xi16>
    %11 = llvm.icmp "slt" %10, %8 : vector<3xi16>
    llvm.return %11 : vector<3xi1>
  }]

def i16_cast_cmp_sgt_int_m1_sitofp_float_vec_poison_before := [llvmfunc|
  llvm.func @i16_cast_cmp_sgt_int_m1_sitofp_float_vec_poison(%arg0: vector<3xi16>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.sitofp %arg0 : vector<3xi16> to vector<3xf32>
    %10 = llvm.bitcast %9 : vector<3xf32> to vector<3xi32>
    %11 = llvm.icmp "sgt" %10, %8 : vector<3xi32>
    llvm.return %11 : vector<3xi1>
  }]

def i16_cast_cmp_sgt_int_m1_bitcast_vector_num_elements_sitofp_before := [llvmfunc|
  llvm.func @i16_cast_cmp_sgt_int_m1_bitcast_vector_num_elements_sitofp(%arg0: vector<3xi16>) -> vector<6xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<6xi16>) : vector<6xi16>
    %1 = llvm.sitofp %arg0 : vector<3xi16> to vector<3xf32>
    %2 = llvm.bitcast %1 : vector<3xf32> to vector<6xi16>
    %3 = llvm.icmp "sgt" %2, %0 : vector<6xi16>
    llvm.return %3 : vector<6xi1>
  }]

def i16_cast_cmp_sgt_int_m1_bitcast_vector_to_scalar_sitofp_before := [llvmfunc|
  llvm.func @i16_cast_cmp_sgt_int_m1_bitcast_vector_to_scalar_sitofp(%arg0: vector<3xi16>) -> i1 {
    %0 = llvm.mlir.constant(-1 : i96) : i96
    %1 = llvm.sitofp %arg0 : vector<3xi16> to vector<3xf32>
    %2 = llvm.bitcast %1 : vector<3xf32> to i96
    %3 = llvm.icmp "sgt" %2, %0 : i96
    llvm.return %3 : i1
  }]

def i16_cast_cmp_eq_int_0_bitcast_vector_num_elements_uitofp_before := [llvmfunc|
  llvm.func @i16_cast_cmp_eq_int_0_bitcast_vector_num_elements_uitofp(%arg0: vector<3xi16>) -> vector<6xi1> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<6xi16>) : vector<6xi16>
    %2 = llvm.uitofp %arg0 : vector<3xi16> to vector<3xf32>
    %3 = llvm.bitcast %2 : vector<3xf32> to vector<6xi16>
    %4 = llvm.icmp "eq" %3, %1 : vector<6xi16>
    llvm.return %4 : vector<6xi1>
  }]

def i16_cast_cmp_eq_int_0_bitcast_vector_to_scalar_uitofp_before := [llvmfunc|
  llvm.func @i16_cast_cmp_eq_int_0_bitcast_vector_to_scalar_uitofp(%arg0: vector<3xi16>) -> i1 {
    %0 = llvm.mlir.constant(0 : i96) : i96
    %1 = llvm.uitofp %arg0 : vector<3xi16> to vector<3xf32>
    %2 = llvm.bitcast %1 : vector<3xf32> to i96
    %3 = llvm.icmp "eq" %2, %0 : i96
    llvm.return %3 : i1
  }]

def PR55516_before := [llvmfunc|
  llvm.func @PR55516(%arg0: i64) -> vector<1xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<1xi64>) : vector<1xi64>
    %2 = llvm.sitofp %arg0 : i64 to f64
    %3 = llvm.bitcast %2 : f64 to vector<1xi64>
    %4 = llvm.icmp "eq" %3, %1 : vector<1xi64>
    llvm.return %4 : vector<1xi1>
  }]

def PR55516_alt_before := [llvmfunc|
  llvm.func @PR55516_alt(%arg0: vector<1xi64>) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sitofp %arg0 : vector<1xi64> to vector<1xf64>
    %2 = llvm.bitcast %1 : vector<1xf64> to i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i32_cast_cmp_eq_int_0_sitofp_float_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_sitofp_float(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_eq_int_0_sitofp_float   : i32_cast_cmp_eq_int_0_sitofp_float_before  ⊑  i32_cast_cmp_eq_int_0_sitofp_float_combined := by
  unfold i32_cast_cmp_eq_int_0_sitofp_float_before i32_cast_cmp_eq_int_0_sitofp_float_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ne_int_0_sitofp_float_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_sitofp_float(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_ne_int_0_sitofp_float   : i32_cast_cmp_ne_int_0_sitofp_float_before  ⊑  i32_cast_cmp_ne_int_0_sitofp_float_combined := by
  unfold i32_cast_cmp_ne_int_0_sitofp_float_before i32_cast_cmp_ne_int_0_sitofp_float_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_slt_int_0_sitofp_float_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_slt_int_0_sitofp_float(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_slt_int_0_sitofp_float   : i32_cast_cmp_slt_int_0_sitofp_float_before  ⊑  i32_cast_cmp_slt_int_0_sitofp_float_combined := by
  unfold i32_cast_cmp_slt_int_0_sitofp_float_before i32_cast_cmp_slt_int_0_sitofp_float_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_sgt_int_0_sitofp_float_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_sgt_int_0_sitofp_float(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_sgt_int_0_sitofp_float   : i32_cast_cmp_sgt_int_0_sitofp_float_before  ⊑  i32_cast_cmp_sgt_int_0_sitofp_float_combined := by
  unfold i32_cast_cmp_sgt_int_0_sitofp_float_before i32_cast_cmp_sgt_int_0_sitofp_float_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_slt_int_1_sitofp_float_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_slt_int_1_sitofp_float(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_slt_int_1_sitofp_float   : i32_cast_cmp_slt_int_1_sitofp_float_before  ⊑  i32_cast_cmp_slt_int_1_sitofp_float_combined := by
  unfold i32_cast_cmp_slt_int_1_sitofp_float_before i32_cast_cmp_slt_int_1_sitofp_float_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_sgt_int_m1_sitofp_float_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_sgt_int_m1_sitofp_float(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_sgt_int_m1_sitofp_float   : i32_cast_cmp_sgt_int_m1_sitofp_float_before  ⊑  i32_cast_cmp_sgt_int_m1_sitofp_float_combined := by
  unfold i32_cast_cmp_sgt_int_m1_sitofp_float_before i32_cast_cmp_sgt_int_m1_sitofp_float_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_eq_int_0_sitofp_double_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_sitofp_double(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_eq_int_0_sitofp_double   : i32_cast_cmp_eq_int_0_sitofp_double_before  ⊑  i32_cast_cmp_eq_int_0_sitofp_double_combined := by
  unfold i32_cast_cmp_eq_int_0_sitofp_double_before i32_cast_cmp_eq_int_0_sitofp_double_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ne_int_0_sitofp_double_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_sitofp_double(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_ne_int_0_sitofp_double   : i32_cast_cmp_ne_int_0_sitofp_double_before  ⊑  i32_cast_cmp_ne_int_0_sitofp_double_combined := by
  unfold i32_cast_cmp_ne_int_0_sitofp_double_before i32_cast_cmp_ne_int_0_sitofp_double_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_slt_int_0_sitofp_double_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_slt_int_0_sitofp_double(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_slt_int_0_sitofp_double   : i32_cast_cmp_slt_int_0_sitofp_double_before  ⊑  i32_cast_cmp_slt_int_0_sitofp_double_combined := by
  unfold i32_cast_cmp_slt_int_0_sitofp_double_before i32_cast_cmp_slt_int_0_sitofp_double_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_sgt_int_0_sitofp_double_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_sgt_int_0_sitofp_double(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_sgt_int_0_sitofp_double   : i32_cast_cmp_sgt_int_0_sitofp_double_before  ⊑  i32_cast_cmp_sgt_int_0_sitofp_double_combined := by
  unfold i32_cast_cmp_sgt_int_0_sitofp_double_before i32_cast_cmp_sgt_int_0_sitofp_double_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_slt_int_1_sitofp_double_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_slt_int_1_sitofp_double(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_slt_int_1_sitofp_double   : i32_cast_cmp_slt_int_1_sitofp_double_before  ⊑  i32_cast_cmp_slt_int_1_sitofp_double_combined := by
  unfold i32_cast_cmp_slt_int_1_sitofp_double_before i32_cast_cmp_slt_int_1_sitofp_double_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_sgt_int_m1_sitofp_double_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_sgt_int_m1_sitofp_double(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_sgt_int_m1_sitofp_double   : i32_cast_cmp_sgt_int_m1_sitofp_double_before  ⊑  i32_cast_cmp_sgt_int_m1_sitofp_double_combined := by
  unfold i32_cast_cmp_sgt_int_m1_sitofp_double_before i32_cast_cmp_sgt_int_m1_sitofp_double_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_eq_int_0_sitofp_half_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_sitofp_half(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_eq_int_0_sitofp_half   : i32_cast_cmp_eq_int_0_sitofp_half_before  ⊑  i32_cast_cmp_eq_int_0_sitofp_half_combined := by
  unfold i32_cast_cmp_eq_int_0_sitofp_half_before i32_cast_cmp_eq_int_0_sitofp_half_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ne_int_0_sitofp_half_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_sitofp_half(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_ne_int_0_sitofp_half   : i32_cast_cmp_ne_int_0_sitofp_half_before  ⊑  i32_cast_cmp_ne_int_0_sitofp_half_combined := by
  unfold i32_cast_cmp_ne_int_0_sitofp_half_before i32_cast_cmp_ne_int_0_sitofp_half_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_slt_int_0_sitofp_half_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_slt_int_0_sitofp_half(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_slt_int_0_sitofp_half   : i32_cast_cmp_slt_int_0_sitofp_half_before  ⊑  i32_cast_cmp_slt_int_0_sitofp_half_combined := by
  unfold i32_cast_cmp_slt_int_0_sitofp_half_before i32_cast_cmp_slt_int_0_sitofp_half_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_sgt_int_0_sitofp_half_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_sgt_int_0_sitofp_half(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_sgt_int_0_sitofp_half   : i32_cast_cmp_sgt_int_0_sitofp_half_before  ⊑  i32_cast_cmp_sgt_int_0_sitofp_half_combined := by
  unfold i32_cast_cmp_sgt_int_0_sitofp_half_before i32_cast_cmp_sgt_int_0_sitofp_half_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_slt_int_1_sitofp_half_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_slt_int_1_sitofp_half(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_slt_int_1_sitofp_half   : i32_cast_cmp_slt_int_1_sitofp_half_before  ⊑  i32_cast_cmp_slt_int_1_sitofp_half_combined := by
  unfold i32_cast_cmp_slt_int_1_sitofp_half_before i32_cast_cmp_slt_int_1_sitofp_half_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_sgt_int_m1_sitofp_half_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_sgt_int_m1_sitofp_half(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_sgt_int_m1_sitofp_half   : i32_cast_cmp_sgt_int_m1_sitofp_half_before  ⊑  i32_cast_cmp_sgt_int_m1_sitofp_half_combined := by
  unfold i32_cast_cmp_sgt_int_m1_sitofp_half_before i32_cast_cmp_sgt_int_m1_sitofp_half_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_eq_int_0_sitofp_float_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_eq_int_0_sitofp_float(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_eq_int_0_sitofp_float   : i64_cast_cmp_eq_int_0_sitofp_float_before  ⊑  i64_cast_cmp_eq_int_0_sitofp_float_combined := by
  unfold i64_cast_cmp_eq_int_0_sitofp_float_before i64_cast_cmp_eq_int_0_sitofp_float_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_ne_int_0_sitofp_float_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_ne_int_0_sitofp_float(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_ne_int_0_sitofp_float   : i64_cast_cmp_ne_int_0_sitofp_float_before  ⊑  i64_cast_cmp_ne_int_0_sitofp_float_combined := by
  unfold i64_cast_cmp_ne_int_0_sitofp_float_before i64_cast_cmp_ne_int_0_sitofp_float_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_slt_int_0_sitofp_float_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_slt_int_0_sitofp_float(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_slt_int_0_sitofp_float   : i64_cast_cmp_slt_int_0_sitofp_float_before  ⊑  i64_cast_cmp_slt_int_0_sitofp_float_combined := by
  unfold i64_cast_cmp_slt_int_0_sitofp_float_before i64_cast_cmp_slt_int_0_sitofp_float_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_sgt_int_0_sitofp_float_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_sgt_int_0_sitofp_float(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_sgt_int_0_sitofp_float   : i64_cast_cmp_sgt_int_0_sitofp_float_before  ⊑  i64_cast_cmp_sgt_int_0_sitofp_float_combined := by
  unfold i64_cast_cmp_sgt_int_0_sitofp_float_before i64_cast_cmp_sgt_int_0_sitofp_float_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_slt_int_1_sitofp_float_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_slt_int_1_sitofp_float(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_slt_int_1_sitofp_float   : i64_cast_cmp_slt_int_1_sitofp_float_before  ⊑  i64_cast_cmp_slt_int_1_sitofp_float_combined := by
  unfold i64_cast_cmp_slt_int_1_sitofp_float_before i64_cast_cmp_slt_int_1_sitofp_float_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_sgt_int_m1_sitofp_float_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_sgt_int_m1_sitofp_float(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_sgt_int_m1_sitofp_float   : i64_cast_cmp_sgt_int_m1_sitofp_float_before  ⊑  i64_cast_cmp_sgt_int_m1_sitofp_float_combined := by
  unfold i64_cast_cmp_sgt_int_m1_sitofp_float_before i64_cast_cmp_sgt_int_m1_sitofp_float_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_eq_int_0_sitofp_double_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_eq_int_0_sitofp_double(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_eq_int_0_sitofp_double   : i64_cast_cmp_eq_int_0_sitofp_double_before  ⊑  i64_cast_cmp_eq_int_0_sitofp_double_combined := by
  unfold i64_cast_cmp_eq_int_0_sitofp_double_before i64_cast_cmp_eq_int_0_sitofp_double_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_ne_int_0_sitofp_double_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_ne_int_0_sitofp_double(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_ne_int_0_sitofp_double   : i64_cast_cmp_ne_int_0_sitofp_double_before  ⊑  i64_cast_cmp_ne_int_0_sitofp_double_combined := by
  unfold i64_cast_cmp_ne_int_0_sitofp_double_before i64_cast_cmp_ne_int_0_sitofp_double_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_slt_int_0_sitofp_double_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_slt_int_0_sitofp_double(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_slt_int_0_sitofp_double   : i64_cast_cmp_slt_int_0_sitofp_double_before  ⊑  i64_cast_cmp_slt_int_0_sitofp_double_combined := by
  unfold i64_cast_cmp_slt_int_0_sitofp_double_before i64_cast_cmp_slt_int_0_sitofp_double_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_sgt_int_0_sitofp_double_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_sgt_int_0_sitofp_double(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_sgt_int_0_sitofp_double   : i64_cast_cmp_sgt_int_0_sitofp_double_before  ⊑  i64_cast_cmp_sgt_int_0_sitofp_double_combined := by
  unfold i64_cast_cmp_sgt_int_0_sitofp_double_before i64_cast_cmp_sgt_int_0_sitofp_double_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_slt_int_1_sitofp_double_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_slt_int_1_sitofp_double(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_slt_int_1_sitofp_double   : i64_cast_cmp_slt_int_1_sitofp_double_before  ⊑  i64_cast_cmp_slt_int_1_sitofp_double_combined := by
  unfold i64_cast_cmp_slt_int_1_sitofp_double_before i64_cast_cmp_slt_int_1_sitofp_double_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_sgt_int_m1_sitofp_double_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_sgt_int_m1_sitofp_double(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_sgt_int_m1_sitofp_double   : i64_cast_cmp_sgt_int_m1_sitofp_double_before  ⊑  i64_cast_cmp_sgt_int_m1_sitofp_double_combined := by
  unfold i64_cast_cmp_sgt_int_m1_sitofp_double_before i64_cast_cmp_sgt_int_m1_sitofp_double_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_eq_int_0_sitofp_half_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_eq_int_0_sitofp_half(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_eq_int_0_sitofp_half   : i64_cast_cmp_eq_int_0_sitofp_half_before  ⊑  i64_cast_cmp_eq_int_0_sitofp_half_combined := by
  unfold i64_cast_cmp_eq_int_0_sitofp_half_before i64_cast_cmp_eq_int_0_sitofp_half_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_ne_int_0_sitofp_half_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_ne_int_0_sitofp_half(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_ne_int_0_sitofp_half   : i64_cast_cmp_ne_int_0_sitofp_half_before  ⊑  i64_cast_cmp_ne_int_0_sitofp_half_combined := by
  unfold i64_cast_cmp_ne_int_0_sitofp_half_before i64_cast_cmp_ne_int_0_sitofp_half_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_slt_int_0_sitofp_half_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_slt_int_0_sitofp_half(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_slt_int_0_sitofp_half   : i64_cast_cmp_slt_int_0_sitofp_half_before  ⊑  i64_cast_cmp_slt_int_0_sitofp_half_combined := by
  unfold i64_cast_cmp_slt_int_0_sitofp_half_before i64_cast_cmp_slt_int_0_sitofp_half_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_sgt_int_0_sitofp_half_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_sgt_int_0_sitofp_half(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_sgt_int_0_sitofp_half   : i64_cast_cmp_sgt_int_0_sitofp_half_before  ⊑  i64_cast_cmp_sgt_int_0_sitofp_half_combined := by
  unfold i64_cast_cmp_sgt_int_0_sitofp_half_before i64_cast_cmp_sgt_int_0_sitofp_half_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_slt_int_1_sitofp_half_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_slt_int_1_sitofp_half(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_slt_int_1_sitofp_half   : i64_cast_cmp_slt_int_1_sitofp_half_before  ⊑  i64_cast_cmp_slt_int_1_sitofp_half_combined := by
  unfold i64_cast_cmp_slt_int_1_sitofp_half_before i64_cast_cmp_slt_int_1_sitofp_half_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_sgt_int_m1_sitofp_half_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_sgt_int_m1_sitofp_half(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_i64_cast_cmp_sgt_int_m1_sitofp_half   : i64_cast_cmp_sgt_int_m1_sitofp_half_before  ⊑  i64_cast_cmp_sgt_int_m1_sitofp_half_combined := by
  unfold i64_cast_cmp_sgt_int_m1_sitofp_half_before i64_cast_cmp_sgt_int_m1_sitofp_half_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_eq_int_0_sitofp_float_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_eq_int_0_sitofp_float(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.icmp "eq" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_i16_cast_cmp_eq_int_0_sitofp_float   : i16_cast_cmp_eq_int_0_sitofp_float_before  ⊑  i16_cast_cmp_eq_int_0_sitofp_float_combined := by
  unfold i16_cast_cmp_eq_int_0_sitofp_float_before i16_cast_cmp_eq_int_0_sitofp_float_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_ne_int_0_sitofp_float_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_ne_int_0_sitofp_float(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.icmp "ne" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_i16_cast_cmp_ne_int_0_sitofp_float   : i16_cast_cmp_ne_int_0_sitofp_float_before  ⊑  i16_cast_cmp_ne_int_0_sitofp_float_combined := by
  unfold i16_cast_cmp_ne_int_0_sitofp_float_before i16_cast_cmp_ne_int_0_sitofp_float_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_slt_int_0_sitofp_float_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_slt_int_0_sitofp_float(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.icmp "slt" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_i16_cast_cmp_slt_int_0_sitofp_float   : i16_cast_cmp_slt_int_0_sitofp_float_before  ⊑  i16_cast_cmp_slt_int_0_sitofp_float_combined := by
  unfold i16_cast_cmp_slt_int_0_sitofp_float_before i16_cast_cmp_slt_int_0_sitofp_float_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_sgt_int_0_sitofp_float_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_sgt_int_0_sitofp_float(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.icmp "sgt" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_i16_cast_cmp_sgt_int_0_sitofp_float   : i16_cast_cmp_sgt_int_0_sitofp_float_before  ⊑  i16_cast_cmp_sgt_int_0_sitofp_float_combined := by
  unfold i16_cast_cmp_sgt_int_0_sitofp_float_before i16_cast_cmp_sgt_int_0_sitofp_float_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_slt_int_1_sitofp_float_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_slt_int_1_sitofp_float(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.icmp "slt" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_i16_cast_cmp_slt_int_1_sitofp_float   : i16_cast_cmp_slt_int_1_sitofp_float_before  ⊑  i16_cast_cmp_slt_int_1_sitofp_float_combined := by
  unfold i16_cast_cmp_slt_int_1_sitofp_float_before i16_cast_cmp_slt_int_1_sitofp_float_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_sgt_int_m1_sitofp_float_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_sgt_int_m1_sitofp_float(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.icmp "sgt" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_i16_cast_cmp_sgt_int_m1_sitofp_float   : i16_cast_cmp_sgt_int_m1_sitofp_float_before  ⊑  i16_cast_cmp_sgt_int_m1_sitofp_float_combined := by
  unfold i16_cast_cmp_sgt_int_m1_sitofp_float_before i16_cast_cmp_sgt_int_m1_sitofp_float_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_eq_int_0_sitofp_double_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_eq_int_0_sitofp_double(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.icmp "eq" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_i16_cast_cmp_eq_int_0_sitofp_double   : i16_cast_cmp_eq_int_0_sitofp_double_before  ⊑  i16_cast_cmp_eq_int_0_sitofp_double_combined := by
  unfold i16_cast_cmp_eq_int_0_sitofp_double_before i16_cast_cmp_eq_int_0_sitofp_double_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_ne_int_0_sitofp_double_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_ne_int_0_sitofp_double(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.icmp "ne" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_i16_cast_cmp_ne_int_0_sitofp_double   : i16_cast_cmp_ne_int_0_sitofp_double_before  ⊑  i16_cast_cmp_ne_int_0_sitofp_double_combined := by
  unfold i16_cast_cmp_ne_int_0_sitofp_double_before i16_cast_cmp_ne_int_0_sitofp_double_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_slt_int_0_sitofp_double_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_slt_int_0_sitofp_double(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.icmp "slt" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_i16_cast_cmp_slt_int_0_sitofp_double   : i16_cast_cmp_slt_int_0_sitofp_double_before  ⊑  i16_cast_cmp_slt_int_0_sitofp_double_combined := by
  unfold i16_cast_cmp_slt_int_0_sitofp_double_before i16_cast_cmp_slt_int_0_sitofp_double_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_sgt_int_0_sitofp_double_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_sgt_int_0_sitofp_double(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.icmp "sgt" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_i16_cast_cmp_sgt_int_0_sitofp_double   : i16_cast_cmp_sgt_int_0_sitofp_double_before  ⊑  i16_cast_cmp_sgt_int_0_sitofp_double_combined := by
  unfold i16_cast_cmp_sgt_int_0_sitofp_double_before i16_cast_cmp_sgt_int_0_sitofp_double_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_slt_int_1_sitofp_double_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_slt_int_1_sitofp_double(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.icmp "slt" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_i16_cast_cmp_slt_int_1_sitofp_double   : i16_cast_cmp_slt_int_1_sitofp_double_before  ⊑  i16_cast_cmp_slt_int_1_sitofp_double_combined := by
  unfold i16_cast_cmp_slt_int_1_sitofp_double_before i16_cast_cmp_slt_int_1_sitofp_double_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_sgt_int_m1_sitofp_double_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_sgt_int_m1_sitofp_double(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.icmp "sgt" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_i16_cast_cmp_sgt_int_m1_sitofp_double   : i16_cast_cmp_sgt_int_m1_sitofp_double_before  ⊑  i16_cast_cmp_sgt_int_m1_sitofp_double_combined := by
  unfold i16_cast_cmp_sgt_int_m1_sitofp_double_before i16_cast_cmp_sgt_int_m1_sitofp_double_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_eq_int_0_sitofp_half_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_eq_int_0_sitofp_half(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.icmp "eq" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_i16_cast_cmp_eq_int_0_sitofp_half   : i16_cast_cmp_eq_int_0_sitofp_half_before  ⊑  i16_cast_cmp_eq_int_0_sitofp_half_combined := by
  unfold i16_cast_cmp_eq_int_0_sitofp_half_before i16_cast_cmp_eq_int_0_sitofp_half_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_ne_int_0_sitofp_half_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_ne_int_0_sitofp_half(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.icmp "ne" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_i16_cast_cmp_ne_int_0_sitofp_half   : i16_cast_cmp_ne_int_0_sitofp_half_before  ⊑  i16_cast_cmp_ne_int_0_sitofp_half_combined := by
  unfold i16_cast_cmp_ne_int_0_sitofp_half_before i16_cast_cmp_ne_int_0_sitofp_half_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_slt_int_0_sitofp_half_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_slt_int_0_sitofp_half(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.icmp "slt" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_i16_cast_cmp_slt_int_0_sitofp_half   : i16_cast_cmp_slt_int_0_sitofp_half_before  ⊑  i16_cast_cmp_slt_int_0_sitofp_half_combined := by
  unfold i16_cast_cmp_slt_int_0_sitofp_half_before i16_cast_cmp_slt_int_0_sitofp_half_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_sgt_int_0_sitofp_half_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_sgt_int_0_sitofp_half(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.icmp "sgt" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_i16_cast_cmp_sgt_int_0_sitofp_half   : i16_cast_cmp_sgt_int_0_sitofp_half_before  ⊑  i16_cast_cmp_sgt_int_0_sitofp_half_combined := by
  unfold i16_cast_cmp_sgt_int_0_sitofp_half_before i16_cast_cmp_sgt_int_0_sitofp_half_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_slt_int_1_sitofp_half_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_slt_int_1_sitofp_half(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.icmp "slt" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_i16_cast_cmp_slt_int_1_sitofp_half   : i16_cast_cmp_slt_int_1_sitofp_half_before  ⊑  i16_cast_cmp_slt_int_1_sitofp_half_combined := by
  unfold i16_cast_cmp_slt_int_1_sitofp_half_before i16_cast_cmp_slt_int_1_sitofp_half_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_sgt_int_m1_sitofp_half_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_sgt_int_m1_sitofp_half(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.icmp "sgt" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_i16_cast_cmp_sgt_int_m1_sitofp_half   : i16_cast_cmp_sgt_int_m1_sitofp_half_before  ⊑  i16_cast_cmp_sgt_int_m1_sitofp_half_combined := by
  unfold i16_cast_cmp_sgt_int_m1_sitofp_half_before i16_cast_cmp_sgt_int_m1_sitofp_half_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ne_int_0_sitofp_double_vec_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_sitofp_double_vec(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<3xi32>
    llvm.return %2 : vector<3xi1>
  }]

theorem inst_combine_i32_cast_cmp_ne_int_0_sitofp_double_vec   : i32_cast_cmp_ne_int_0_sitofp_double_vec_before  ⊑  i32_cast_cmp_ne_int_0_sitofp_double_vec_combined := by
  unfold i32_cast_cmp_ne_int_0_sitofp_double_vec_before i32_cast_cmp_ne_int_0_sitofp_double_vec_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_eq_int_0_sitofp_float_vec_poison_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_sitofp_float_vec_poison(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<3xi32>
    llvm.return %2 : vector<3xi1>
  }]

theorem inst_combine_i32_cast_cmp_eq_int_0_sitofp_float_vec_poison   : i32_cast_cmp_eq_int_0_sitofp_float_vec_poison_before  ⊑  i32_cast_cmp_eq_int_0_sitofp_float_vec_poison_combined := by
  unfold i32_cast_cmp_eq_int_0_sitofp_float_vec_poison_before i32_cast_cmp_eq_int_0_sitofp_float_vec_poison_combined
  simp_alive_peephole
  sorry
def i64_cast_cmp_slt_int_1_sitofp_half_vec_poison_combined := [llvmfunc|
  llvm.func @i64_cast_cmp_slt_int_1_sitofp_half_vec_poison(%arg0: vector<3xi64>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi64>) : vector<3xi64>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<3xi64>
    llvm.return %1 : vector<3xi1>
  }]

theorem inst_combine_i64_cast_cmp_slt_int_1_sitofp_half_vec_poison   : i64_cast_cmp_slt_int_1_sitofp_half_vec_poison_before  ⊑  i64_cast_cmp_slt_int_1_sitofp_half_vec_poison_combined := by
  unfold i64_cast_cmp_slt_int_1_sitofp_half_vec_poison_before i64_cast_cmp_slt_int_1_sitofp_half_vec_poison_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_sgt_int_m1_sitofp_float_vec_poison_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_sgt_int_m1_sitofp_float_vec_poison(%arg0: vector<3xi16>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<3xi16>
    llvm.return %1 : vector<3xi1>
  }]

theorem inst_combine_i16_cast_cmp_sgt_int_m1_sitofp_float_vec_poison   : i16_cast_cmp_sgt_int_m1_sitofp_float_vec_poison_before  ⊑  i16_cast_cmp_sgt_int_m1_sitofp_float_vec_poison_combined := by
  unfold i16_cast_cmp_sgt_int_m1_sitofp_float_vec_poison_before i16_cast_cmp_sgt_int_m1_sitofp_float_vec_poison_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_sgt_int_m1_bitcast_vector_num_elements_sitofp_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_sgt_int_m1_bitcast_vector_num_elements_sitofp(%arg0: vector<3xi16>) -> vector<6xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<6xi16>) : vector<6xi16>
    %1 = llvm.sitofp %arg0 : vector<3xi16> to vector<3xf32>
    %2 = llvm.bitcast %1 : vector<3xf32> to vector<6xi16>
    %3 = llvm.icmp "sgt" %2, %0 : vector<6xi16>
    llvm.return %3 : vector<6xi1>
  }]

theorem inst_combine_i16_cast_cmp_sgt_int_m1_bitcast_vector_num_elements_sitofp   : i16_cast_cmp_sgt_int_m1_bitcast_vector_num_elements_sitofp_before  ⊑  i16_cast_cmp_sgt_int_m1_bitcast_vector_num_elements_sitofp_combined := by
  unfold i16_cast_cmp_sgt_int_m1_bitcast_vector_num_elements_sitofp_before i16_cast_cmp_sgt_int_m1_bitcast_vector_num_elements_sitofp_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_sgt_int_m1_bitcast_vector_to_scalar_sitofp_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_sgt_int_m1_bitcast_vector_to_scalar_sitofp(%arg0: vector<3xi16>) -> i1 {
    %0 = llvm.mlir.constant(-1 : i96) : i96
    %1 = llvm.sitofp %arg0 : vector<3xi16> to vector<3xf32>
    %2 = llvm.bitcast %1 : vector<3xf32> to i96
    %3 = llvm.icmp "sgt" %2, %0 : i96
    llvm.return %3 : i1
  }]

theorem inst_combine_i16_cast_cmp_sgt_int_m1_bitcast_vector_to_scalar_sitofp   : i16_cast_cmp_sgt_int_m1_bitcast_vector_to_scalar_sitofp_before  ⊑  i16_cast_cmp_sgt_int_m1_bitcast_vector_to_scalar_sitofp_combined := by
  unfold i16_cast_cmp_sgt_int_m1_bitcast_vector_to_scalar_sitofp_before i16_cast_cmp_sgt_int_m1_bitcast_vector_to_scalar_sitofp_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_eq_int_0_bitcast_vector_num_elements_uitofp_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_eq_int_0_bitcast_vector_num_elements_uitofp(%arg0: vector<3xi16>) -> vector<6xi1> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<6xi16>) : vector<6xi16>
    %2 = llvm.uitofp %arg0 : vector<3xi16> to vector<3xf32>
    %3 = llvm.bitcast %2 : vector<3xf32> to vector<6xi16>
    %4 = llvm.icmp "eq" %3, %1 : vector<6xi16>
    llvm.return %4 : vector<6xi1>
  }]

theorem inst_combine_i16_cast_cmp_eq_int_0_bitcast_vector_num_elements_uitofp   : i16_cast_cmp_eq_int_0_bitcast_vector_num_elements_uitofp_before  ⊑  i16_cast_cmp_eq_int_0_bitcast_vector_num_elements_uitofp_combined := by
  unfold i16_cast_cmp_eq_int_0_bitcast_vector_num_elements_uitofp_before i16_cast_cmp_eq_int_0_bitcast_vector_num_elements_uitofp_combined
  simp_alive_peephole
  sorry
def i16_cast_cmp_eq_int_0_bitcast_vector_to_scalar_uitofp_combined := [llvmfunc|
  llvm.func @i16_cast_cmp_eq_int_0_bitcast_vector_to_scalar_uitofp(%arg0: vector<3xi16>) -> i1 {
    %0 = llvm.mlir.constant(0 : i96) : i96
    %1 = llvm.uitofp %arg0 : vector<3xi16> to vector<3xf32>
    %2 = llvm.bitcast %1 : vector<3xf32> to i96
    %3 = llvm.icmp "eq" %2, %0 : i96
    llvm.return %3 : i1
  }]

theorem inst_combine_i16_cast_cmp_eq_int_0_bitcast_vector_to_scalar_uitofp   : i16_cast_cmp_eq_int_0_bitcast_vector_to_scalar_uitofp_before  ⊑  i16_cast_cmp_eq_int_0_bitcast_vector_to_scalar_uitofp_combined := by
  unfold i16_cast_cmp_eq_int_0_bitcast_vector_to_scalar_uitofp_before i16_cast_cmp_eq_int_0_bitcast_vector_to_scalar_uitofp_combined
  simp_alive_peephole
  sorry
def PR55516_combined := [llvmfunc|
  llvm.func @PR55516(%arg0: i64) -> vector<1xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<1xi64>) : vector<1xi64>
    %2 = llvm.sitofp %arg0 : i64 to f64
    %3 = llvm.bitcast %2 : f64 to vector<1xi64>
    %4 = llvm.icmp "eq" %3, %1 : vector<1xi64>
    llvm.return %4 : vector<1xi1>
  }]

theorem inst_combine_PR55516   : PR55516_before  ⊑  PR55516_combined := by
  unfold PR55516_before PR55516_combined
  simp_alive_peephole
  sorry
def PR55516_alt_combined := [llvmfunc|
  llvm.func @PR55516_alt(%arg0: vector<1xi64>) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<1xi64>
    %2 = llvm.icmp "eq" %1, %0 : i64
    llvm.return %2 : i1
  }]

theorem inst_combine_PR55516_alt   : PR55516_alt_before  ⊑  PR55516_alt_combined := by
  unfold PR55516_alt_before PR55516_alt_combined
  simp_alive_peephole
  sorry
