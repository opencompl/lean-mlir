import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-binop-cmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def select_xor_icmp_before := [llvmfunc|
  llvm.func @select_xor_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.xor %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_xor_icmp2_before := [llvmfunc|
  llvm.func @select_xor_icmp2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.xor %arg0, %arg2  : i32
    %3 = llvm.select %1, %arg1, %2 : i1, i32
    llvm.return %3 : i32
  }]

def select_xor_icmp_meta_before := [llvmfunc|
  llvm.func @select_xor_icmp_meta(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.xor %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_mul_icmp_before := [llvmfunc|
  llvm.func @select_mul_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.mul %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_add_icmp_before := [llvmfunc|
  llvm.func @select_add_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.add %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_or_icmp_before := [llvmfunc|
  llvm.func @select_or_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.or %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_and_icmp_before := [llvmfunc|
  llvm.func @select_and_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.and %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_xor_icmp_vec_before := [llvmfunc|
  llvm.func @select_xor_icmp_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %3 = llvm.xor %arg0, %arg2  : vector<2xi8>
    %4 = llvm.select %2, %3, %arg1 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def select_xor_icmp_vec_use_before := [llvmfunc|
  llvm.func @select_xor_icmp_vec_use(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi8>
    llvm.call @use(%2) : (vector<2xi1>) -> ()
    %3 = llvm.xor %arg0, %arg2  : vector<2xi8>
    %4 = llvm.select %2, %arg1, %3 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def select_xor_inv_icmp_before := [llvmfunc|
  llvm.func @select_xor_inv_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.xor %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_xor_inv_icmp2_before := [llvmfunc|
  llvm.func @select_xor_inv_icmp2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.xor %arg0, %arg2  : i32
    %3 = llvm.select %1, %arg1, %2 : i1, i32
    llvm.return %3 : i32
  }]

def select_fadd_fcmp_before := [llvmfunc|
  llvm.func @select_fadd_fcmp(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def select_fadd_fcmp_poszero_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_poszero(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def select_fadd_fcmp_2_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "une" %arg0, %0 : f32
    %3 = llvm.fadd %arg2, %1  : f32
    %4 = llvm.fadd %3, %arg0  : f32
    %5 = llvm.select %2, %arg1, %4 : i1, f32
    llvm.return %5 : f32
  }]

def select_fadd_fcmp_2_poszero_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_2_poszero(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %0  : f32
    %3 = llvm.fadd %2, %arg0  : f32
    %4 = llvm.select %1, %arg1, %3 : i1, f32
    llvm.return %4 : f32
  }]

def select_fadd_fcmp_3_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.fcmp "une" %arg0, %0 : f32
    %3 = llvm.fadd %1, %arg0  : f32
    %4 = llvm.select %2, %arg1, %3 : i1, f32
    llvm.return %4 : f32
  }]

def select_fadd_fcmp_3_poszero_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_3_poszero(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.fcmp "une" %arg0, %0 : f32
    %3 = llvm.fadd %1, %arg0  : f32
    %4 = llvm.select %2, %arg1, %3 : i1, f32
    llvm.return %4 : f32
  }]

def select_fadd_fcmp_4_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_4(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }]

def select_fadd_fcmp_4_poszero_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_4_poszero(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }]

def select_fadd_fcmp_5_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_5(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "oeq" %arg0, %0 : f32
    %3 = llvm.fadd %arg2, %1  : f32
    %4 = llvm.fadd %3, %arg0  : f32
    %5 = llvm.select %2, %4, %arg1 : i1, f32
    llvm.return %5 : f32
  }]

def select_fadd_fcmp_5_poszero_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_5_poszero(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %0  : f32
    %3 = llvm.fadd %2, %arg0  : f32
    %4 = llvm.select %1, %3, %arg1 : i1, f32
    llvm.return %4 : f32
  }]

def select_fadd_fcmp_6_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_6(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.fcmp "oeq" %arg0, %0 : f32
    %3 = llvm.fadd %arg0, %1  : f32
    %4 = llvm.select %2, %3, %arg1 : i1, f32
    llvm.return %4 : f32
  }]

def select_fadd_fcmp_6_poszero_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_6_poszero(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.fcmp "oeq" %arg0, %0 : f32
    %3 = llvm.fadd %arg0, %1  : f32
    %4 = llvm.select %2, %3, %arg1 : i1, f32
    llvm.return %4 : f32
  }]

def select_fmul_fcmp_before := [llvmfunc|
  llvm.func @select_fmul_fcmp(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def select_fsub_fcmp_before := [llvmfunc|
  llvm.func @select_fsub_fcmp(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fsub %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def select_fsub_fcmp_negzero_before := [llvmfunc|
  llvm.func @select_fsub_fcmp_negzero(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fsub %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def select_fdiv_fcmp_before := [llvmfunc|
  llvm.func @select_fdiv_fcmp(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fdiv %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def select_sub_icmp_before := [llvmfunc|
  llvm.func @select_sub_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_sub_icmp_2_before := [llvmfunc|
  llvm.func @select_sub_icmp_2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.sub %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_sub_icmp_3_before := [llvmfunc|
  llvm.func @select_sub_icmp_3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.sub %arg2, %arg0  : i32
    %3 = llvm.select %1, %arg1, %2 : i1, i32
    llvm.return %3 : i32
  }]

def select_sub_icmp_vec_before := [llvmfunc|
  llvm.func @select_sub_icmp_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %3 = llvm.sub %arg2, %arg0  : vector<2xi8>
    %4 = llvm.select %2, %3, %arg1 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def select_shl_icmp_before := [llvmfunc|
  llvm.func @select_shl_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.shl %arg2, %arg0  : i32
    %3 = llvm.select %1, %arg1, %2 : i1, i32
    llvm.return %3 : i32
  }]

def select_lshr_icmp_before := [llvmfunc|
  llvm.func @select_lshr_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.lshr %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_ashr_icmp_before := [llvmfunc|
  llvm.func @select_ashr_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.ashr %arg2, %arg0  : i32
    %3 = llvm.select %1, %arg1, %2 : i1, i32
    llvm.return %3 : i32
  }]

def select_udiv_icmp_before := [llvmfunc|
  llvm.func @select_udiv_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.udiv %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_sdiv_icmp_before := [llvmfunc|
  llvm.func @select_sdiv_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.sdiv %arg2, %arg0  : i32
    %3 = llvm.select %1, %arg1, %2 : i1, i32
    llvm.return %3 : i32
  }]

def select_xor_icmp_bad_1_before := [llvmfunc|
  llvm.func @select_xor_icmp_bad_1(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.icmp "eq" %arg0, %arg3 : i32
    %1 = llvm.xor %arg0, %arg2  : i32
    %2 = llvm.select %0, %1, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

def select_xor_icmp_bad_2_before := [llvmfunc|
  llvm.func @select_xor_icmp_bad_2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.xor %arg3, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_xor_icmp_bad_3_before := [llvmfunc|
  llvm.func @select_xor_icmp_bad_3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.xor %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_xor_fcmp_bad_4_before := [llvmfunc|
  llvm.func @select_xor_fcmp_bad_4(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: f32) -> i32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg3, %0 : f32
    %2 = llvm.xor %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_xor_icmp_bad_5_before := [llvmfunc|
  llvm.func @select_xor_icmp_bad_5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.xor %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_xor_icmp_bad_6_before := [llvmfunc|
  llvm.func @select_xor_icmp_bad_6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.xor %arg0, %arg2  : i32
    %3 = llvm.select %1, %arg1, %2 : i1, i32
    llvm.return %3 : i32
  }]

def select_xor_icmp_vec_bad_before := [llvmfunc|
  llvm.func @select_xor_icmp_vec_bad(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[5, 3]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    %2 = llvm.xor %arg0, %arg2  : vector<2xi8>
    %3 = llvm.select %1, %2, %arg1 : vector<2xi1>, vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def vec_select_no_equivalence_before := [llvmfunc|
  llvm.func @vec_select_no_equivalence(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi32> 
    %4 = llvm.icmp "eq" %arg0, %2 : vector<2xi32>
    %5 = llvm.select %4, %3, %arg0 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def select_xor_icmp_vec_undef_before := [llvmfunc|
  llvm.func @select_xor_icmp_vec_undef(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "eq" %arg0, %6 : vector<2xi8>
    %8 = llvm.xor %arg0, %arg2  : vector<2xi8>
    %9 = llvm.select %7, %8, %arg1 : vector<2xi1>, vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }]

def select_mul_icmp_bad_before := [llvmfunc|
  llvm.func @select_mul_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.mul %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_add_icmp_bad_before := [llvmfunc|
  llvm.func @select_add_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.add %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_and_icmp_zero_before := [llvmfunc|
  llvm.func @select_and_icmp_zero(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.and %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_or_icmp_bad_before := [llvmfunc|
  llvm.func @select_or_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.or %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_lshr_icmp_const_before := [llvmfunc|
  llvm.func @select_lshr_icmp_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

def select_lshr_icmp_const_reordered_before := [llvmfunc|
  llvm.func @select_lshr_icmp_const_reordered(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }]

def select_exact_lshr_icmp_const_before := [llvmfunc|
  llvm.func @select_exact_lshr_icmp_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

def select_lshr_icmp_const_large_exact_range_before := [llvmfunc|
  llvm.func @select_lshr_icmp_const_large_exact_range(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(63 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

def select_lshr_icmp_const_different_values_before := [llvmfunc|
  llvm.func @select_lshr_icmp_const_different_values(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.lshr %arg1, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

def select_fadd_fcmp_bad_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def select_fadd_fcmp_bad_2_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ueq" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def select_fadd_fcmp_bad_3_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_3(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.fcmp "one" %arg0, %arg3 : f32
    %1 = llvm.fadd %arg0, %arg2  : f32
    %2 = llvm.select %0, %arg1, %1 : i1, f32
    llvm.return %2 : f32
  }]

def select_fadd_fcmp_bad_4_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_4(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def select_fadd_fcmp_bad_5_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_5(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "one" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }]

def select_fadd_fcmp_bad_6_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_6(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }]

def select_fadd_fcmp_bad_7_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_7(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def select_fadd_fcmp_bad_8_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_8(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "one" %arg0, %0 : f32
    %3 = llvm.fadd %arg2, %1  : f32
    %4 = llvm.fadd %3, %arg0  : f32
    %5 = llvm.select %2, %arg1, %4 : i1, f32
    llvm.return %5 : f32
  }]

def select_fadd_fcmp_bad_9_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_9(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "one" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }]

def select_fadd_fcmp_bad_10_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_10(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "one" %arg0, %0 : f32
    %3 = llvm.fadd %arg2, %1  : f32
    %4 = llvm.fadd %3, %arg0  : f32
    %5 = llvm.select %2, %arg1, %4 : i1, f32
    llvm.return %5 : f32
  }]

def select_fadd_fcmp_bad_11_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_11(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "une" %arg0, %0 : f32
    %3 = llvm.fadd %arg2, %1  : f32
    %4 = llvm.fadd %3, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %5 = llvm.select %2, %arg1, %4 : i1, f32
    llvm.return %5 : f32
  }]

def select_fadd_fcmp_bad_12_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_12(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %arg0  : f32
    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }]

def select_fadd_fcmp_bad_13_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_13(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }]

def select_fadd_fcmp_bad_14_before := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_14(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }]

def select_fmul_fcmp_bad_before := [llvmfunc|
  llvm.func @select_fmul_fcmp_bad(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def select_fmul_fcmp_bad_2_before := [llvmfunc|
  llvm.func @select_fmul_fcmp_bad_2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fmul %arg0, %arg2  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def select_fmul_icmp_bad_before := [llvmfunc|
  llvm.func @select_fmul_icmp_bad(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg3, %0 : i32
    %2 = llvm.fmul %arg0, %arg2  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def select_fmul_icmp_bad_2_before := [llvmfunc|
  llvm.func @select_fmul_icmp_bad_2(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg3, %0 : i32
    %2 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def select_fdiv_fcmp_bad_before := [llvmfunc|
  llvm.func @select_fdiv_fcmp_bad(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fdiv %arg0, %arg2  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def select_fdiv_fcmp_bad_2_before := [llvmfunc|
  llvm.func @select_fdiv_fcmp_bad_2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fdiv %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def select_fsub_fcmp_bad_before := [llvmfunc|
  llvm.func @select_fsub_fcmp_bad(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fsub %arg2, %arg0  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def select_fsub_fcmp_bad_2_before := [llvmfunc|
  llvm.func @select_fsub_fcmp_bad_2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fsub %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def select_sub_icmp_bad_before := [llvmfunc|
  llvm.func @select_sub_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_sub_icmp_bad_2_before := [llvmfunc|
  llvm.func @select_sub_icmp_bad_2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_sub_icmp_bad_3_before := [llvmfunc|
  llvm.func @select_sub_icmp_bad_3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.sub %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_sub_icmp_4_before := [llvmfunc|
  llvm.func @select_sub_icmp_4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.sub %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_sub_icmp_bad_4_before := [llvmfunc|
  llvm.func @select_sub_icmp_bad_4(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg2, %arg3  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_sub_icmp_bad_5_before := [llvmfunc|
  llvm.func @select_sub_icmp_bad_5(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.icmp "eq" %arg0, %arg3 : i32
    %1 = llvm.sub %arg2, %arg0  : i32
    %2 = llvm.select %0, %1, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

def select_shl_icmp_bad_before := [llvmfunc|
  llvm.func @select_shl_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.shl %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_lshr_icmp_bad_before := [llvmfunc|
  llvm.func @select_lshr_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.lshr %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_ashr_icmp_bad_before := [llvmfunc|
  llvm.func @select_ashr_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.ashr %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_udiv_icmp_bad_before := [llvmfunc|
  llvm.func @select_udiv_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.udiv %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_sdiv_icmp_bad_before := [llvmfunc|
  llvm.func @select_sdiv_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sdiv %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_replace_one_use_before := [llvmfunc|
  llvm.func @select_replace_one_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg0, %arg1  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_replace_multi_use_before := [llvmfunc|
  llvm.func @select_replace_multi_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg0, %arg1  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_replace_fold_before := [llvmfunc|
  llvm.func @select_replace_fold(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.intr.fshr(%arg1, %arg2, %arg0)  : (i32, i32, i32) -> i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_replace_nested_before := [llvmfunc|
  llvm.func @select_replace_nested(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg1, %arg0  : i32
    %3 = llvm.add %2, %arg2  : i32
    %4 = llvm.select %1, %3, %arg1 : i1, i32
    llvm.return %4 : i32
  }]

def select_replace_nested_extra_use_before := [llvmfunc|
  llvm.func @select_replace_nested_extra_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg1, %arg0  : i32
    llvm.call @use.i32(%2) : (i32) -> ()
    %3 = llvm.add %2, %arg2  : i32
    %4 = llvm.select %1, %3, %arg1 : i1, i32
    llvm.return %4 : i32
  }]

def select_replace_nested_no_simplify_before := [llvmfunc|
  llvm.func @select_replace_nested_no_simplify(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg1, %arg0  : i32
    %3 = llvm.add %2, %arg2  : i32
    %4 = llvm.select %1, %3, %arg1 : i1, i32
    llvm.return %4 : i32
  }]

def select_replace_deeply_nested_before := [llvmfunc|
  llvm.func @select_replace_deeply_nested(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.sub %arg1, %arg0  : i32
    %4 = llvm.add %3, %arg2  : i32
    %5 = llvm.shl %4, %1  : i32
    %6 = llvm.select %2, %5, %arg1 : i1, i32
    llvm.return %6 : i32
  }]

def select_replace_constexpr_before := [llvmfunc|
  llvm.func @select_replace_constexpr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.icmp "eq" %arg0, %2 : i32
    %4 = llvm.add %arg0, %arg1  : i32
    %5 = llvm.select %3, %4, %arg2 : i1, i32
    llvm.return %5 : i32
  }]

def select_replace_undef_before := [llvmfunc|
  llvm.func @select_replace_undef(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.icmp "eq" %arg0, %6 : vector<2xi32>
    %8 = llvm.sub %arg0, %arg1  : vector<2xi32>
    %9 = llvm.select %7, %8, %arg1 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }]

def select_replace_call_speculatable_before := [llvmfunc|
  llvm.func @select_replace_call_speculatable(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.call @call_speculatable(%arg0, %arg0) : (i32, i32) -> i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_replace_call_non_speculatable_before := [llvmfunc|
  llvm.func @select_replace_call_non_speculatable(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.call @call_non_speculatable(%arg0, %arg0) : (i32, i32) -> i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_replace_sdiv_speculatable_before := [llvmfunc|
  llvm.func @select_replace_sdiv_speculatable(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sdiv %arg1, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_replace_sdiv_non_speculatable_before := [llvmfunc|
  llvm.func @select_replace_sdiv_non_speculatable(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sdiv %arg1, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_replace_udiv_speculatable_before := [llvmfunc|
  llvm.func @select_replace_udiv_speculatable(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.udiv %arg1, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_replace_udiv_non_speculatable_before := [llvmfunc|
  llvm.func @select_replace_udiv_non_speculatable(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.udiv %arg1, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def select_replace_phi_before := [llvmfunc|
  llvm.func @select_replace_phi(%arg0: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    llvm.br ^bb1(%0, %1 : i32, i32)
  ^bb1(%4: i32, %5: i32):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.add %4, %2  : i32
    %7 = llvm.icmp "eq" %4, %0 : i32
    %8 = llvm.select %7, %5, %3 : i1, i32
    llvm.call @use_i32(%8) : (i32) -> ()
    llvm.br ^bb1(%6, %4 : i32, i32)
  }]

def select_xor_icmp_combined := [llvmfunc|
  llvm.func @select_xor_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.select %1, %arg2, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_xor_icmp   : select_xor_icmp_before  ⊑  select_xor_icmp_combined := by
  unfold select_xor_icmp_before select_xor_icmp_combined
  simp_alive_peephole
  sorry
def select_xor_icmp2_combined := [llvmfunc|
  llvm.func @select_xor_icmp2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.select %1, %arg2, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_xor_icmp2   : select_xor_icmp2_before  ⊑  select_xor_icmp2_combined := by
  unfold select_xor_icmp2_before select_xor_icmp2_combined
  simp_alive_peephole
  sorry
def select_xor_icmp_meta_combined := [llvmfunc|
  llvm.func @select_xor_icmp_meta(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.select %1, %arg2, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_xor_icmp_meta   : select_xor_icmp_meta_before  ⊑  select_xor_icmp_meta_combined := by
  unfold select_xor_icmp_meta_before select_xor_icmp_meta_combined
  simp_alive_peephole
  sorry
def select_mul_icmp_combined := [llvmfunc|
  llvm.func @select_mul_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.select %1, %arg2, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_mul_icmp   : select_mul_icmp_before  ⊑  select_mul_icmp_combined := by
  unfold select_mul_icmp_before select_mul_icmp_combined
  simp_alive_peephole
  sorry
def select_add_icmp_combined := [llvmfunc|
  llvm.func @select_add_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.select %1, %arg2, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_add_icmp   : select_add_icmp_before  ⊑  select_add_icmp_combined := by
  unfold select_add_icmp_before select_add_icmp_combined
  simp_alive_peephole
  sorry
def select_or_icmp_combined := [llvmfunc|
  llvm.func @select_or_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.select %1, %arg2, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_or_icmp   : select_or_icmp_before  ⊑  select_or_icmp_combined := by
  unfold select_or_icmp_before select_or_icmp_combined
  simp_alive_peephole
  sorry
def select_and_icmp_combined := [llvmfunc|
  llvm.func @select_and_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.select %1, %arg2, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_and_icmp   : select_and_icmp_before  ⊑  select_and_icmp_combined := by
  unfold select_and_icmp_before select_and_icmp_combined
  simp_alive_peephole
  sorry
def select_xor_icmp_vec_combined := [llvmfunc|
  llvm.func @select_xor_icmp_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %3 = llvm.select %2, %arg2, %arg1 : vector<2xi1>, vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_select_xor_icmp_vec   : select_xor_icmp_vec_before  ⊑  select_xor_icmp_vec_combined := by
  unfold select_xor_icmp_vec_before select_xor_icmp_vec_combined
  simp_alive_peephole
  sorry
def select_xor_icmp_vec_use_combined := [llvmfunc|
  llvm.func @select_xor_icmp_vec_use(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi8>
    llvm.call @use(%2) : (vector<2xi1>) -> ()
    %3 = llvm.select %2, %arg1, %arg2 : vector<2xi1>, vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_select_xor_icmp_vec_use   : select_xor_icmp_vec_use_before  ⊑  select_xor_icmp_vec_use_combined := by
  unfold select_xor_icmp_vec_use_before select_xor_icmp_vec_use_combined
  simp_alive_peephole
  sorry
def select_xor_inv_icmp_combined := [llvmfunc|
  llvm.func @select_xor_inv_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.select %1, %arg2, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_xor_inv_icmp   : select_xor_inv_icmp_before  ⊑  select_xor_inv_icmp_combined := by
  unfold select_xor_inv_icmp_before select_xor_inv_icmp_combined
  simp_alive_peephole
  sorry
def select_xor_inv_icmp2_combined := [llvmfunc|
  llvm.func @select_xor_inv_icmp2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg1, %arg2 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_xor_inv_icmp2   : select_xor_inv_icmp2_before  ⊑  select_xor_inv_icmp2_combined := by
  unfold select_xor_inv_icmp2_before select_xor_inv_icmp2_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.select %1, %arg2, %arg1 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_fadd_fcmp   : select_fadd_fcmp_before  ⊑  select_fadd_fcmp_combined := by
  unfold select_fadd_fcmp_before select_fadd_fcmp_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_poszero_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_poszero(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.select %1, %arg2, %arg1 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_fadd_fcmp_poszero   : select_fadd_fcmp_poszero_before  ⊑  select_fadd_fcmp_poszero_combined := by
  unfold select_fadd_fcmp_poszero_before select_fadd_fcmp_poszero_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_2_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %0  : f32
    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fadd_fcmp_2   : select_fadd_fcmp_2_before  ⊑  select_fadd_fcmp_2_combined := by
  unfold select_fadd_fcmp_2_before select_fadd_fcmp_2_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_2_poszero_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_2_poszero(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %0  : f32
    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fadd_fcmp_2_poszero   : select_fadd_fcmp_2_poszero_before  ⊑  select_fadd_fcmp_2_poszero_combined := by
  unfold select_fadd_fcmp_2_poszero_before select_fadd_fcmp_2_poszero_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_3_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.fcmp "une" %arg0, %0 : f32
    %3 = llvm.select %2, %arg1, %1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fadd_fcmp_3   : select_fadd_fcmp_3_before  ⊑  select_fadd_fcmp_3_combined := by
  unfold select_fadd_fcmp_3_before select_fadd_fcmp_3_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_3_poszero_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_3_poszero(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.fcmp "une" %arg0, %0 : f32
    %3 = llvm.select %2, %arg1, %1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fadd_fcmp_3_poszero   : select_fadd_fcmp_3_poszero_before  ⊑  select_fadd_fcmp_3_poszero_combined := by
  unfold select_fadd_fcmp_3_poszero_before select_fadd_fcmp_3_poszero_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_4_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_4(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.select %1, %arg1, %arg2 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_fadd_fcmp_4   : select_fadd_fcmp_4_before  ⊑  select_fadd_fcmp_4_combined := by
  unfold select_fadd_fcmp_4_before select_fadd_fcmp_4_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_4_poszero_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_4_poszero(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.select %1, %arg1, %arg2 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_fadd_fcmp_4_poszero   : select_fadd_fcmp_4_poszero_before  ⊑  select_fadd_fcmp_4_poszero_combined := by
  unfold select_fadd_fcmp_4_poszero_before select_fadd_fcmp_4_poszero_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_5_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_5(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %0  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fadd_fcmp_5   : select_fadd_fcmp_5_before  ⊑  select_fadd_fcmp_5_combined := by
  unfold select_fadd_fcmp_5_before select_fadd_fcmp_5_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_5_poszero_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_5_poszero(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %0  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fadd_fcmp_5_poszero   : select_fadd_fcmp_5_poszero_before  ⊑  select_fadd_fcmp_5_poszero_combined := by
  unfold select_fadd_fcmp_5_poszero_before select_fadd_fcmp_5_poszero_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_6_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_6(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.fcmp "oeq" %arg0, %0 : f32
    %3 = llvm.select %2, %1, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fadd_fcmp_6   : select_fadd_fcmp_6_before  ⊑  select_fadd_fcmp_6_combined := by
  unfold select_fadd_fcmp_6_before select_fadd_fcmp_6_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_6_poszero_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_6_poszero(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.fcmp "oeq" %arg0, %0 : f32
    %3 = llvm.select %2, %1, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fadd_fcmp_6_poszero   : select_fadd_fcmp_6_poszero_before  ⊑  select_fadd_fcmp_6_poszero_combined := by
  unfold select_fadd_fcmp_6_poszero_before select_fadd_fcmp_6_poszero_combined
  simp_alive_peephole
  sorry
def select_fmul_fcmp_combined := [llvmfunc|
  llvm.func @select_fmul_fcmp(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.select %1, %arg2, %arg1 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_fmul_fcmp   : select_fmul_fcmp_before  ⊑  select_fmul_fcmp_combined := by
  unfold select_fmul_fcmp_before select_fmul_fcmp_combined
  simp_alive_peephole
  sorry
def select_fsub_fcmp_combined := [llvmfunc|
  llvm.func @select_fsub_fcmp(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.select %1, %arg2, %arg1 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_fsub_fcmp   : select_fsub_fcmp_before  ⊑  select_fsub_fcmp_combined := by
  unfold select_fsub_fcmp_before select_fsub_fcmp_combined
  simp_alive_peephole
  sorry
def select_fsub_fcmp_negzero_combined := [llvmfunc|
  llvm.func @select_fsub_fcmp_negzero(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.select %1, %arg2, %arg1 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_fsub_fcmp_negzero   : select_fsub_fcmp_negzero_before  ⊑  select_fsub_fcmp_negzero_combined := by
  unfold select_fsub_fcmp_negzero_before select_fsub_fcmp_negzero_combined
  simp_alive_peephole
  sorry
def select_fdiv_fcmp_combined := [llvmfunc|
  llvm.func @select_fdiv_fcmp(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.select %1, %arg2, %arg1 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_fdiv_fcmp   : select_fdiv_fcmp_before  ⊑  select_fdiv_fcmp_combined := by
  unfold select_fdiv_fcmp_before select_fdiv_fcmp_combined
  simp_alive_peephole
  sorry
def select_sub_icmp_combined := [llvmfunc|
  llvm.func @select_sub_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.select %1, %arg2, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_sub_icmp   : select_sub_icmp_before  ⊑  select_sub_icmp_combined := by
  unfold select_sub_icmp_before select_sub_icmp_combined
  simp_alive_peephole
  sorry
def select_sub_icmp_2_combined := [llvmfunc|
  llvm.func @select_sub_icmp_2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg2, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_sub_icmp_2   : select_sub_icmp_2_before  ⊑  select_sub_icmp_2_combined := by
  unfold select_sub_icmp_2_before select_sub_icmp_2_combined
  simp_alive_peephole
  sorry
def select_sub_icmp_3_combined := [llvmfunc|
  llvm.func @select_sub_icmp_3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg1, %arg2 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_sub_icmp_3   : select_sub_icmp_3_before  ⊑  select_sub_icmp_3_combined := by
  unfold select_sub_icmp_3_before select_sub_icmp_3_combined
  simp_alive_peephole
  sorry
def select_sub_icmp_vec_combined := [llvmfunc|
  llvm.func @select_sub_icmp_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %3 = llvm.select %2, %arg2, %arg1 : vector<2xi1>, vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_select_sub_icmp_vec   : select_sub_icmp_vec_before  ⊑  select_sub_icmp_vec_combined := by
  unfold select_sub_icmp_vec_before select_sub_icmp_vec_combined
  simp_alive_peephole
  sorry
def select_shl_icmp_combined := [llvmfunc|
  llvm.func @select_shl_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg1, %arg2 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_shl_icmp   : select_shl_icmp_before  ⊑  select_shl_icmp_combined := by
  unfold select_shl_icmp_before select_shl_icmp_combined
  simp_alive_peephole
  sorry
def select_lshr_icmp_combined := [llvmfunc|
  llvm.func @select_lshr_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.select %1, %arg2, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_lshr_icmp   : select_lshr_icmp_before  ⊑  select_lshr_icmp_combined := by
  unfold select_lshr_icmp_before select_lshr_icmp_combined
  simp_alive_peephole
  sorry
def select_ashr_icmp_combined := [llvmfunc|
  llvm.func @select_ashr_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg1, %arg2 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_ashr_icmp   : select_ashr_icmp_before  ⊑  select_ashr_icmp_combined := by
  unfold select_ashr_icmp_before select_ashr_icmp_combined
  simp_alive_peephole
  sorry
def select_udiv_icmp_combined := [llvmfunc|
  llvm.func @select_udiv_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.select %1, %arg2, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_udiv_icmp   : select_udiv_icmp_before  ⊑  select_udiv_icmp_combined := by
  unfold select_udiv_icmp_before select_udiv_icmp_combined
  simp_alive_peephole
  sorry
def select_sdiv_icmp_combined := [llvmfunc|
  llvm.func @select_sdiv_icmp(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg1, %arg2 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_sdiv_icmp   : select_sdiv_icmp_before  ⊑  select_sdiv_icmp_combined := by
  unfold select_sdiv_icmp_before select_sdiv_icmp_combined
  simp_alive_peephole
  sorry
def select_xor_icmp_bad_1_combined := [llvmfunc|
  llvm.func @select_xor_icmp_bad_1(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.icmp "eq" %arg0, %arg3 : i32
    %1 = llvm.xor %arg0, %arg2  : i32
    %2 = llvm.select %0, %1, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_xor_icmp_bad_1   : select_xor_icmp_bad_1_before  ⊑  select_xor_icmp_bad_1_combined := by
  unfold select_xor_icmp_bad_1_before select_xor_icmp_bad_1_combined
  simp_alive_peephole
  sorry
def select_xor_icmp_bad_2_combined := [llvmfunc|
  llvm.func @select_xor_icmp_bad_2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.xor %arg3, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_xor_icmp_bad_2   : select_xor_icmp_bad_2_before  ⊑  select_xor_icmp_bad_2_combined := by
  unfold select_xor_icmp_bad_2_before select_xor_icmp_bad_2_combined
  simp_alive_peephole
  sorry
def select_xor_icmp_bad_3_combined := [llvmfunc|
  llvm.func @select_xor_icmp_bad_3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_xor_icmp_bad_3   : select_xor_icmp_bad_3_before  ⊑  select_xor_icmp_bad_3_combined := by
  unfold select_xor_icmp_bad_3_before select_xor_icmp_bad_3_combined
  simp_alive_peephole
  sorry
def select_xor_fcmp_bad_4_combined := [llvmfunc|
  llvm.func @select_xor_fcmp_bad_4(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: f32) -> i32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg3, %0 : f32
    %2 = llvm.xor %arg0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_xor_fcmp_bad_4   : select_xor_fcmp_bad_4_before  ⊑  select_xor_fcmp_bad_4_combined := by
  unfold select_xor_fcmp_bad_4_before select_xor_fcmp_bad_4_combined
  simp_alive_peephole
  sorry
def select_xor_icmp_bad_5_combined := [llvmfunc|
  llvm.func @select_xor_icmp_bad_5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.xor %arg0, %arg2  : i32
    %3 = llvm.select %1, %arg1, %2 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_xor_icmp_bad_5   : select_xor_icmp_bad_5_before  ⊑  select_xor_icmp_bad_5_combined := by
  unfold select_xor_icmp_bad_5_before select_xor_icmp_bad_5_combined
  simp_alive_peephole
  sorry
def select_xor_icmp_bad_6_combined := [llvmfunc|
  llvm.func @select_xor_icmp_bad_6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_xor_icmp_bad_6   : select_xor_icmp_bad_6_before  ⊑  select_xor_icmp_bad_6_combined := by
  unfold select_xor_icmp_bad_6_before select_xor_icmp_bad_6_combined
  simp_alive_peephole
  sorry
def select_xor_icmp_vec_bad_combined := [llvmfunc|
  llvm.func @select_xor_icmp_vec_bad(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[5, 3]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    %2 = llvm.xor %arg0, %arg2  : vector<2xi8>
    %3 = llvm.select %1, %2, %arg1 : vector<2xi1>, vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_select_xor_icmp_vec_bad   : select_xor_icmp_vec_bad_before  ⊑  select_xor_icmp_vec_bad_combined := by
  unfold select_xor_icmp_vec_bad_before select_xor_icmp_vec_bad_combined
  simp_alive_peephole
  sorry
def vec_select_no_equivalence_combined := [llvmfunc|
  llvm.func @vec_select_no_equivalence(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi32> 
    %4 = llvm.icmp "eq" %arg0, %2 : vector<2xi32>
    %5 = llvm.select %4, %3, %arg0 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_vec_select_no_equivalence   : vec_select_no_equivalence_before  ⊑  vec_select_no_equivalence_combined := by
  unfold vec_select_no_equivalence_before vec_select_no_equivalence_combined
  simp_alive_peephole
  sorry
def select_xor_icmp_vec_undef_combined := [llvmfunc|
  llvm.func @select_xor_icmp_vec_undef(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "eq" %arg0, %6 : vector<2xi8>
    %8 = llvm.xor %arg0, %arg2  : vector<2xi8>
    %9 = llvm.select %7, %8, %arg1 : vector<2xi1>, vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }]

theorem inst_combine_select_xor_icmp_vec_undef   : select_xor_icmp_vec_undef_before  ⊑  select_xor_icmp_vec_undef_combined := by
  unfold select_xor_icmp_vec_undef_before select_xor_icmp_vec_undef_combined
  simp_alive_peephole
  sorry
def select_mul_icmp_bad_combined := [llvmfunc|
  llvm.func @select_mul_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.mul %arg2, %0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_mul_icmp_bad   : select_mul_icmp_bad_before  ⊑  select_mul_icmp_bad_combined := by
  unfold select_mul_icmp_bad_before select_mul_icmp_bad_combined
  simp_alive_peephole
  sorry
def select_add_icmp_bad_combined := [llvmfunc|
  llvm.func @select_add_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.add %arg2, %0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_add_icmp_bad   : select_add_icmp_bad_before  ⊑  select_add_icmp_bad_combined := by
  unfold select_add_icmp_bad_before select_add_icmp_bad_combined
  simp_alive_peephole
  sorry
def select_and_icmp_zero_combined := [llvmfunc|
  llvm.func @select_and_icmp_zero(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.select %1, %0, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_and_icmp_zero   : select_and_icmp_zero_before  ⊑  select_and_icmp_zero_combined := by
  unfold select_and_icmp_zero_before select_and_icmp_zero_combined
  simp_alive_peephole
  sorry
def select_or_icmp_bad_combined := [llvmfunc|
  llvm.func @select_or_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.or %arg2, %0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_or_icmp_bad   : select_or_icmp_bad_before  ⊑  select_or_icmp_bad_combined := by
  unfold select_or_icmp_bad_before select_or_icmp_bad_combined
  simp_alive_peephole
  sorry
def select_lshr_icmp_const_combined := [llvmfunc|
  llvm.func @select_lshr_icmp_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_select_lshr_icmp_const   : select_lshr_icmp_const_before  ⊑  select_lshr_icmp_const_combined := by
  unfold select_lshr_icmp_const_before select_lshr_icmp_const_combined
  simp_alive_peephole
  sorry
def select_lshr_icmp_const_reordered_combined := [llvmfunc|
  llvm.func @select_lshr_icmp_const_reordered(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_select_lshr_icmp_const_reordered   : select_lshr_icmp_const_reordered_before  ⊑  select_lshr_icmp_const_reordered_combined := by
  unfold select_lshr_icmp_const_reordered_before select_lshr_icmp_const_reordered_combined
  simp_alive_peephole
  sorry
def select_exact_lshr_icmp_const_combined := [llvmfunc|
  llvm.func @select_exact_lshr_icmp_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_select_exact_lshr_icmp_const   : select_exact_lshr_icmp_const_before  ⊑  select_exact_lshr_icmp_const_combined := by
  unfold select_exact_lshr_icmp_const_before select_exact_lshr_icmp_const_combined
  simp_alive_peephole
  sorry
def select_lshr_icmp_const_large_exact_range_combined := [llvmfunc|
  llvm.func @select_lshr_icmp_const_large_exact_range(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(63 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_select_lshr_icmp_const_large_exact_range   : select_lshr_icmp_const_large_exact_range_before  ⊑  select_lshr_icmp_const_large_exact_range_combined := by
  unfold select_lshr_icmp_const_large_exact_range_before select_lshr_icmp_const_large_exact_range_combined
  simp_alive_peephole
  sorry
def select_lshr_icmp_const_different_values_combined := [llvmfunc|
  llvm.func @select_lshr_icmp_const_different_values(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.lshr %arg1, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_select_lshr_icmp_const_different_values   : select_lshr_icmp_const_different_values_before  ⊑  select_lshr_icmp_const_different_values_combined := by
  unfold select_lshr_icmp_const_different_values_before select_lshr_icmp_const_different_values_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_bad_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fadd_fcmp_bad   : select_fadd_fcmp_bad_before  ⊑  select_fadd_fcmp_bad_combined := by
  unfold select_fadd_fcmp_bad_before select_fadd_fcmp_bad_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_bad_2_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ueq" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fadd_fcmp_bad_2   : select_fadd_fcmp_bad_2_before  ⊑  select_fadd_fcmp_bad_2_combined := by
  unfold select_fadd_fcmp_bad_2_before select_fadd_fcmp_bad_2_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_bad_3_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_3(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.fcmp "one" %arg0, %arg3 : f32
    %1 = llvm.fadd %arg0, %arg2  : f32
    %2 = llvm.select %0, %arg1, %1 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_fadd_fcmp_bad_3   : select_fadd_fcmp_bad_3_before  ⊑  select_fadd_fcmp_bad_3_combined := by
  unfold select_fadd_fcmp_bad_3_before select_fadd_fcmp_bad_3_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_bad_4_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_4(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fadd_fcmp_bad_4   : select_fadd_fcmp_bad_4_before  ⊑  select_fadd_fcmp_bad_4_combined := by
  unfold select_fadd_fcmp_bad_4_before select_fadd_fcmp_bad_4_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_bad_5_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_5(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "one" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fadd_fcmp_bad_5   : select_fadd_fcmp_bad_5_before  ⊑  select_fadd_fcmp_bad_5_combined := by
  unfold select_fadd_fcmp_bad_5_before select_fadd_fcmp_bad_5_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_bad_6_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_6(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fadd_fcmp_bad_6   : select_fadd_fcmp_bad_6_before  ⊑  select_fadd_fcmp_bad_6_combined := by
  unfold select_fadd_fcmp_bad_6_before select_fadd_fcmp_bad_6_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_bad_7_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_7(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fadd_fcmp_bad_7   : select_fadd_fcmp_bad_7_before  ⊑  select_fadd_fcmp_bad_7_combined := by
  unfold select_fadd_fcmp_bad_7_before select_fadd_fcmp_bad_7_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_bad_8_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_8(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "one" %arg0, %0 : f32
    %3 = llvm.fadd %arg2, %1  : f32
    %4 = llvm.fadd %3, %arg0  : f32
    %5 = llvm.select %2, %arg1, %4 : i1, f32
    llvm.return %5 : f32
  }]

theorem inst_combine_select_fadd_fcmp_bad_8   : select_fadd_fcmp_bad_8_before  ⊑  select_fadd_fcmp_bad_8_combined := by
  unfold select_fadd_fcmp_bad_8_before select_fadd_fcmp_bad_8_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_bad_9_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_9(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "one" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fadd_fcmp_bad_9   : select_fadd_fcmp_bad_9_before  ⊑  select_fadd_fcmp_bad_9_combined := by
  unfold select_fadd_fcmp_bad_9_before select_fadd_fcmp_bad_9_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_bad_10_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_10(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "one" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %0  : f32
    %3 = llvm.fadd %2, %arg0  : f32
    %4 = llvm.select %1, %arg1, %3 : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_select_fadd_fcmp_bad_10   : select_fadd_fcmp_bad_10_before  ⊑  select_fadd_fcmp_bad_10_combined := by
  unfold select_fadd_fcmp_bad_10_before select_fadd_fcmp_bad_10_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_bad_11_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_11(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "une" %arg0, %0 : f32
    %3 = llvm.fadd %arg2, %1  : f32
    %4 = llvm.select %2, %arg1, %3 : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_select_fadd_fcmp_bad_11   : select_fadd_fcmp_bad_11_before  ⊑  select_fadd_fcmp_bad_11_combined := by
  unfold select_fadd_fcmp_bad_11_before select_fadd_fcmp_bad_11_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_bad_12_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_12(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fadd %arg2, %arg0  : f32
    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fadd_fcmp_bad_12   : select_fadd_fcmp_bad_12_before  ⊑  select_fadd_fcmp_bad_12_combined := by
  unfold select_fadd_fcmp_bad_12_before select_fadd_fcmp_bad_12_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_bad_13_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_13(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fadd_fcmp_bad_13   : select_fadd_fcmp_bad_13_before  ⊑  select_fadd_fcmp_bad_13_combined := by
  unfold select_fadd_fcmp_bad_13_before select_fadd_fcmp_bad_13_combined
  simp_alive_peephole
  sorry
def select_fadd_fcmp_bad_14_combined := [llvmfunc|
  llvm.func @select_fadd_fcmp_bad_14(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fadd %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %arg1, %2 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fadd_fcmp_bad_14   : select_fadd_fcmp_bad_14_before  ⊑  select_fadd_fcmp_bad_14_combined := by
  unfold select_fadd_fcmp_bad_14_before select_fadd_fcmp_bad_14_combined
  simp_alive_peephole
  sorry
def select_fmul_fcmp_bad_combined := [llvmfunc|
  llvm.func @select_fmul_fcmp_bad(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fmul_fcmp_bad   : select_fmul_fcmp_bad_before  ⊑  select_fmul_fcmp_bad_combined := by
  unfold select_fmul_fcmp_bad_before select_fmul_fcmp_bad_combined
  simp_alive_peephole
  sorry
def select_fmul_fcmp_bad_2_combined := [llvmfunc|
  llvm.func @select_fmul_fcmp_bad_2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fmul %arg0, %arg2  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fmul_fcmp_bad_2   : select_fmul_fcmp_bad_2_before  ⊑  select_fmul_fcmp_bad_2_combined := by
  unfold select_fmul_fcmp_bad_2_before select_fmul_fcmp_bad_2_combined
  simp_alive_peephole
  sorry
def select_fmul_icmp_bad_combined := [llvmfunc|
  llvm.func @select_fmul_icmp_bad(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg3, %0 : i32
    %2 = llvm.fmul %arg0, %arg2  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fmul_icmp_bad   : select_fmul_icmp_bad_before  ⊑  select_fmul_icmp_bad_combined := by
  unfold select_fmul_icmp_bad_before select_fmul_icmp_bad_combined
  simp_alive_peephole
  sorry
def select_fmul_icmp_bad_2_combined := [llvmfunc|
  llvm.func @select_fmul_icmp_bad_2(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg3, %0 : i32
    %2 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fmul_icmp_bad_2   : select_fmul_icmp_bad_2_before  ⊑  select_fmul_icmp_bad_2_combined := by
  unfold select_fmul_icmp_bad_2_before select_fmul_icmp_bad_2_combined
  simp_alive_peephole
  sorry
def select_fdiv_fcmp_bad_combined := [llvmfunc|
  llvm.func @select_fdiv_fcmp_bad(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fdiv %arg0, %arg2  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fdiv_fcmp_bad   : select_fdiv_fcmp_bad_before  ⊑  select_fdiv_fcmp_bad_combined := by
  unfold select_fdiv_fcmp_bad_before select_fdiv_fcmp_bad_combined
  simp_alive_peephole
  sorry
def select_fdiv_fcmp_bad_2_combined := [llvmfunc|
  llvm.func @select_fdiv_fcmp_bad_2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fdiv %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fdiv_fcmp_bad_2   : select_fdiv_fcmp_bad_2_before  ⊑  select_fdiv_fcmp_bad_2_combined := by
  unfold select_fdiv_fcmp_bad_2_before select_fdiv_fcmp_bad_2_combined
  simp_alive_peephole
  sorry
def select_fsub_fcmp_bad_combined := [llvmfunc|
  llvm.func @select_fsub_fcmp_bad(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fsub %arg2, %arg0  : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fsub_fcmp_bad   : select_fsub_fcmp_bad_before  ⊑  select_fsub_fcmp_bad_combined := by
  unfold select_fsub_fcmp_bad_before select_fsub_fcmp_bad_combined
  simp_alive_peephole
  sorry
def select_fsub_fcmp_bad_2_combined := [llvmfunc|
  llvm.func @select_fsub_fcmp_bad_2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fsub %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.select %1, %2, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fsub_fcmp_bad_2   : select_fsub_fcmp_bad_2_before  ⊑  select_fsub_fcmp_bad_2_combined := by
  unfold select_fsub_fcmp_bad_2_before select_fsub_fcmp_bad_2_combined
  simp_alive_peephole
  sorry
def select_sub_icmp_bad_combined := [llvmfunc|
  llvm.func @select_sub_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg2  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_sub_icmp_bad   : select_sub_icmp_bad_before  ⊑  select_sub_icmp_bad_combined := by
  unfold select_sub_icmp_bad_before select_sub_icmp_bad_combined
  simp_alive_peephole
  sorry
def select_sub_icmp_bad_2_combined := [llvmfunc|
  llvm.func @select_sub_icmp_bad_2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.add %arg2, %1  : i32
    %4 = llvm.select %2, %3, %arg1 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_select_sub_icmp_bad_2   : select_sub_icmp_bad_2_before  ⊑  select_sub_icmp_bad_2_combined := by
  unfold select_sub_icmp_bad_2_before select_sub_icmp_bad_2_combined
  simp_alive_peephole
  sorry
def select_sub_icmp_bad_3_combined := [llvmfunc|
  llvm.func @select_sub_icmp_bad_3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.sub %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_sub_icmp_bad_3   : select_sub_icmp_bad_3_before  ⊑  select_sub_icmp_bad_3_combined := by
  unfold select_sub_icmp_bad_3_before select_sub_icmp_bad_3_combined
  simp_alive_peephole
  sorry
def select_sub_icmp_4_combined := [llvmfunc|
  llvm.func @select_sub_icmp_4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%1) : (i1) -> ()
    %2 = llvm.sub %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_sub_icmp_4   : select_sub_icmp_4_before  ⊑  select_sub_icmp_4_combined := by
  unfold select_sub_icmp_4_before select_sub_icmp_4_combined
  simp_alive_peephole
  sorry
def select_sub_icmp_bad_4_combined := [llvmfunc|
  llvm.func @select_sub_icmp_bad_4(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg2, %arg3  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_sub_icmp_bad_4   : select_sub_icmp_bad_4_before  ⊑  select_sub_icmp_bad_4_combined := by
  unfold select_sub_icmp_bad_4_before select_sub_icmp_bad_4_combined
  simp_alive_peephole
  sorry
def select_sub_icmp_bad_5_combined := [llvmfunc|
  llvm.func @select_sub_icmp_bad_5(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.icmp "eq" %arg0, %arg3 : i32
    %1 = llvm.sub %arg2, %arg0  : i32
    %2 = llvm.select %0, %1, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_sub_icmp_bad_5   : select_sub_icmp_bad_5_before  ⊑  select_sub_icmp_bad_5_combined := by
  unfold select_sub_icmp_bad_5_before select_sub_icmp_bad_5_combined
  simp_alive_peephole
  sorry
def select_shl_icmp_bad_combined := [llvmfunc|
  llvm.func @select_shl_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.shl %arg2, %0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_shl_icmp_bad   : select_shl_icmp_bad_before  ⊑  select_shl_icmp_bad_combined := by
  unfold select_shl_icmp_bad_before select_shl_icmp_bad_combined
  simp_alive_peephole
  sorry
def select_lshr_icmp_bad_combined := [llvmfunc|
  llvm.func @select_lshr_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.lshr %arg2, %0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_lshr_icmp_bad   : select_lshr_icmp_bad_before  ⊑  select_lshr_icmp_bad_combined := by
  unfold select_lshr_icmp_bad_before select_lshr_icmp_bad_combined
  simp_alive_peephole
  sorry
def select_ashr_icmp_bad_combined := [llvmfunc|
  llvm.func @select_ashr_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.ashr %arg2, %0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_ashr_icmp_bad   : select_ashr_icmp_bad_before  ⊑  select_ashr_icmp_bad_combined := by
  unfold select_ashr_icmp_bad_before select_ashr_icmp_bad_combined
  simp_alive_peephole
  sorry
def select_udiv_icmp_bad_combined := [llvmfunc|
  llvm.func @select_udiv_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.udiv %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_udiv_icmp_bad   : select_udiv_icmp_bad_before  ⊑  select_udiv_icmp_bad_combined := by
  unfold select_udiv_icmp_bad_before select_udiv_icmp_bad_combined
  simp_alive_peephole
  sorry
def select_sdiv_icmp_bad_combined := [llvmfunc|
  llvm.func @select_sdiv_icmp_bad(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sdiv %arg2, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_sdiv_icmp_bad   : select_sdiv_icmp_bad_before  ⊑  select_sdiv_icmp_bad_combined := by
  unfold select_sdiv_icmp_bad_before select_sdiv_icmp_bad_combined
  simp_alive_peephole
  sorry
def select_replace_one_use_combined := [llvmfunc|
  llvm.func @select_replace_one_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_replace_one_use   : select_replace_one_use_before  ⊑  select_replace_one_use_combined := by
  unfold select_replace_one_use_before select_replace_one_use_combined
  simp_alive_peephole
  sorry
def select_replace_multi_use_combined := [llvmfunc|
  llvm.func @select_replace_multi_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg0, %arg1  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_replace_multi_use   : select_replace_multi_use_before  ⊑  select_replace_multi_use_combined := by
  unfold select_replace_multi_use_before select_replace_multi_use_combined
  simp_alive_peephole
  sorry
def select_replace_fold_combined := [llvmfunc|
  llvm.func @select_replace_fold(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.select %1, %arg2, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_replace_fold   : select_replace_fold_before  ⊑  select_replace_fold_combined := by
  unfold select_replace_fold_before select_replace_fold_combined
  simp_alive_peephole
  sorry
def select_replace_nested_combined := [llvmfunc|
  llvm.func @select_replace_nested(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.select %1, %arg2, %0 : i1, i32
    %3 = llvm.add %2, %arg1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_replace_nested   : select_replace_nested_before  ⊑  select_replace_nested_combined := by
  unfold select_replace_nested_before select_replace_nested_combined
  simp_alive_peephole
  sorry
def select_replace_nested_extra_use_combined := [llvmfunc|
  llvm.func @select_replace_nested_extra_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sub %arg1, %arg0  : i32
    llvm.call @use.i32(%2) : (i32) -> ()
    %3 = llvm.add %2, %arg2  : i32
    %4 = llvm.select %1, %3, %arg1 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_select_replace_nested_extra_use   : select_replace_nested_extra_use_before  ⊑  select_replace_nested_extra_use_combined := by
  unfold select_replace_nested_extra_use_before select_replace_nested_extra_use_combined
  simp_alive_peephole
  sorry
def select_replace_nested_no_simplify_combined := [llvmfunc|
  llvm.func @select_replace_nested_no_simplify(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.add %arg1, %1  : i32
    %4 = llvm.add %3, %arg2  : i32
    %5 = llvm.select %2, %4, %arg1 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_select_replace_nested_no_simplify   : select_replace_nested_no_simplify_before  ⊑  select_replace_nested_no_simplify_combined := by
  unfold select_replace_nested_no_simplify_before select_replace_nested_no_simplify_combined
  simp_alive_peephole
  sorry
def select_replace_deeply_nested_combined := [llvmfunc|
  llvm.func @select_replace_deeply_nested(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.sub %arg1, %arg0  : i32
    %4 = llvm.add %3, %arg2  : i32
    %5 = llvm.shl %4, %1  : i32
    %6 = llvm.select %2, %5, %arg1 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_select_replace_deeply_nested   : select_replace_deeply_nested_before  ⊑  select_replace_deeply_nested_combined := by
  unfold select_replace_deeply_nested_before select_replace_deeply_nested_combined
  simp_alive_peephole
  sorry
def select_replace_constexpr_combined := [llvmfunc|
  llvm.func @select_replace_constexpr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.icmp "eq" %arg0, %2 : i32
    %4 = llvm.add %arg0, %arg1  : i32
    %5 = llvm.select %3, %4, %arg2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_select_replace_constexpr   : select_replace_constexpr_before  ⊑  select_replace_constexpr_combined := by
  unfold select_replace_constexpr_before select_replace_constexpr_combined
  simp_alive_peephole
  sorry
def select_replace_undef_combined := [llvmfunc|
  llvm.func @select_replace_undef(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.icmp "eq" %arg0, %6 : vector<2xi32>
    %8 = llvm.sub %arg0, %arg1  : vector<2xi32>
    %9 = llvm.select %7, %8, %arg1 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }]

theorem inst_combine_select_replace_undef   : select_replace_undef_before  ⊑  select_replace_undef_combined := by
  unfold select_replace_undef_before select_replace_undef_combined
  simp_alive_peephole
  sorry
def select_replace_call_speculatable_combined := [llvmfunc|
  llvm.func @select_replace_call_speculatable(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.call @call_speculatable(%0, %0) : (i32, i32) -> i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_replace_call_speculatable   : select_replace_call_speculatable_before  ⊑  select_replace_call_speculatable_combined := by
  unfold select_replace_call_speculatable_before select_replace_call_speculatable_combined
  simp_alive_peephole
  sorry
def select_replace_call_non_speculatable_combined := [llvmfunc|
  llvm.func @select_replace_call_non_speculatable(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.call @call_non_speculatable(%arg0, %arg0) : (i32, i32) -> i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_replace_call_non_speculatable   : select_replace_call_non_speculatable_before  ⊑  select_replace_call_non_speculatable_combined := by
  unfold select_replace_call_non_speculatable_before select_replace_call_non_speculatable_combined
  simp_alive_peephole
  sorry
def select_replace_sdiv_speculatable_combined := [llvmfunc|
  llvm.func @select_replace_sdiv_speculatable(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sdiv %arg1, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_replace_sdiv_speculatable   : select_replace_sdiv_speculatable_before  ⊑  select_replace_sdiv_speculatable_combined := by
  unfold select_replace_sdiv_speculatable_before select_replace_sdiv_speculatable_combined
  simp_alive_peephole
  sorry
def select_replace_sdiv_non_speculatable_combined := [llvmfunc|
  llvm.func @select_replace_sdiv_non_speculatable(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.sdiv %arg1, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_replace_sdiv_non_speculatable   : select_replace_sdiv_non_speculatable_before  ⊑  select_replace_sdiv_non_speculatable_combined := by
  unfold select_replace_sdiv_non_speculatable_before select_replace_sdiv_non_speculatable_combined
  simp_alive_peephole
  sorry
def select_replace_udiv_speculatable_combined := [llvmfunc|
  llvm.func @select_replace_udiv_speculatable(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.udiv %arg1, %arg0  : i32
    %3 = llvm.select %1, %2, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_replace_udiv_speculatable   : select_replace_udiv_speculatable_before  ⊑  select_replace_udiv_speculatable_combined := by
  unfold select_replace_udiv_speculatable_before select_replace_udiv_speculatable_combined
  simp_alive_peephole
  sorry
def select_replace_udiv_non_speculatable_combined := [llvmfunc|
  llvm.func @select_replace_udiv_non_speculatable(%arg0: i32, %arg1: i32) -> i32 {
    llvm.return %arg1 : i32
  }]

theorem inst_combine_select_replace_udiv_non_speculatable   : select_replace_udiv_non_speculatable_before  ⊑  select_replace_udiv_non_speculatable_combined := by
  unfold select_replace_udiv_non_speculatable_before select_replace_udiv_non_speculatable_combined
  simp_alive_peephole
  sorry
def select_replace_phi_combined := [llvmfunc|
  llvm.func @select_replace_phi(%arg0: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    llvm.br ^bb1(%0, %1 : i32, i32)
  ^bb1(%4: i32, %5: i32):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.add %4, %2  : i32
    %7 = llvm.icmp "eq" %4, %0 : i32
    %8 = llvm.select %7, %5, %3 : i1, i32
    llvm.call @use_i32(%8) : (i32) -> ()
    llvm.br ^bb1(%6, %4 : i32, i32)
  }]

theorem inst_combine_select_replace_phi   : select_replace_phi_before  ⊑  select_replace_phi_combined := by
  unfold select_replace_phi_before select_replace_phi_combined
  simp_alive_peephole
  sorry
