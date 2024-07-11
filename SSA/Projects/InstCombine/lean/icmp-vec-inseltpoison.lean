import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-vec-inseltpoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sge_before := [llvmfunc|
  llvm.func @sge(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-127, 127]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "sge" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

def uge_before := [llvmfunc|
  llvm.func @uge(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "uge" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

def sle_before := [llvmfunc|
  llvm.func @sle(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[126, -128]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "sle" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

def ule_before := [llvmfunc|
  llvm.func @ule(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-2, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ule" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

def ult_min_signed_value_before := [llvmfunc|
  llvm.func @ult_min_signed_value(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

def sge_zero_before := [llvmfunc|
  llvm.func @sge_zero(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "sge" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def uge_zero_before := [llvmfunc|
  llvm.func @uge_zero(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "uge" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def sle_zero_before := [llvmfunc|
  llvm.func @sle_zero(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "sle" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def ule_zero_before := [llvmfunc|
  llvm.func @ule_zero(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "ule" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def sge_weird_before := [llvmfunc|
  llvm.func @sge_weird(%arg0: vector<3xi3>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i3) : i3
    %1 = llvm.mlir.constant(3 : i3) : i3
    %2 = llvm.mlir.constant(-3 : i3) : i3
    %3 = llvm.mlir.constant(dense<[-3, 3, 0]> : vector<3xi3>) : vector<3xi3>
    %4 = llvm.icmp "sge" %arg0, %3 : vector<3xi3>
    llvm.return %4 : vector<3xi1>
  }]

def uge_weird_before := [llvmfunc|
  llvm.func @uge_weird(%arg0: vector<3xi3>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(2 : i3) : i3
    %1 = llvm.mlir.constant(1 : i3) : i3
    %2 = llvm.mlir.constant(-1 : i3) : i3
    %3 = llvm.mlir.constant(dense<[-1, 1, 2]> : vector<3xi3>) : vector<3xi3>
    %4 = llvm.icmp "uge" %arg0, %3 : vector<3xi3>
    llvm.return %4 : vector<3xi1>
  }]

def sle_weird_before := [llvmfunc|
  llvm.func @sle_weird(%arg0: vector<3xi3>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i3) : i3
    %1 = llvm.mlir.constant(-4 : i3) : i3
    %2 = llvm.mlir.constant(2 : i3) : i3
    %3 = llvm.mlir.constant(dense<[2, -4, 0]> : vector<3xi3>) : vector<3xi3>
    %4 = llvm.icmp "sle" %arg0, %3 : vector<3xi3>
    llvm.return %4 : vector<3xi1>
  }]

def ule_weird_before := [llvmfunc|
  llvm.func @ule_weird(%arg0: vector<3xi3>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i3) : i3
    %1 = llvm.mlir.constant(0 : i3) : i3
    %2 = llvm.mlir.constant(-2 : i3) : i3
    %3 = llvm.mlir.constant(dense<[-2, 0, 1]> : vector<3xi3>) : vector<3xi3>
    %4 = llvm.icmp "ule" %arg0, %3 : vector<3xi3>
    llvm.return %4 : vector<3xi1>
  }]

def sge_min_before := [llvmfunc|
  llvm.func @sge_min(%arg0: vector<2xi3>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(1 : i3) : i3
    %1 = llvm.mlir.constant(-4 : i3) : i3
    %2 = llvm.mlir.constant(dense<[-4, 1]> : vector<2xi3>) : vector<2xi3>
    %3 = llvm.icmp "sge" %arg0, %2 : vector<2xi3>
    llvm.return %3 : vector<2xi1>
  }]

def uge_min_before := [llvmfunc|
  llvm.func @uge_min(%arg0: vector<2xi3>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i3) : i3
    %1 = llvm.mlir.constant(1 : i3) : i3
    %2 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi3>) : vector<2xi3>
    %3 = llvm.icmp "uge" %arg0, %2 : vector<2xi3>
    llvm.return %3 : vector<2xi1>
  }]

def sle_max_before := [llvmfunc|
  llvm.func @sle_max(%arg0: vector<2xi3>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(3 : i3) : i3
    %1 = llvm.mlir.constant(1 : i3) : i3
    %2 = llvm.mlir.constant(dense<[1, 3]> : vector<2xi3>) : vector<2xi3>
    %3 = llvm.icmp "sle" %arg0, %2 : vector<2xi3>
    llvm.return %3 : vector<2xi1>
  }]

def ule_max_before := [llvmfunc|
  llvm.func @ule_max(%arg0: vector<2xi3>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(1 : i3) : i3
    %1 = llvm.mlir.constant(-1 : i3) : i3
    %2 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi3>) : vector<2xi3>
    %3 = llvm.icmp "ule" %arg0, %2 : vector<2xi3>
    llvm.return %3 : vector<2xi1>
  }]

def PR27756_1_before := [llvmfunc|
  llvm.func @PR27756_1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.bitcast %3 : vector<2xi4> to i8
    %5 = llvm.mlir.undef : vector<2xi8>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<2xi8>
    %10 = llvm.icmp "sle" %arg0, %9 : vector<2xi8>
    llvm.return %10 : vector<2xi1>
  }]

def PR27756_2_before := [llvmfunc|
  llvm.func @PR27756_2(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(42 : i8) : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.icmp "sle" %arg0, %9 : vector<3xi8>
    llvm.return %10 : vector<3xi1>
  }]

def PR27756_3_before := [llvmfunc|
  llvm.func @PR27756_3(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.icmp "sge" %arg0, %9 : vector<3xi8>
    llvm.return %10 : vector<3xi1>
  }]

def PR27786_before := [llvmfunc|
  llvm.func @PR27786(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @someglobal : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i16
    %3 = llvm.bitcast %2 : i16 to vector<2xi8>
    %4 = llvm.icmp "sle" %arg0, %3 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def same_shuffle_inputs_icmp_before := [llvmfunc|
  llvm.func @same_shuffle_inputs_icmp(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [3, 3, 2, 0] : vector<4xi8> 
    %2 = llvm.shufflevector %arg1, %0 [3, 3, 2, 0] : vector<4xi8> 
    %3 = llvm.icmp "sgt" %1, %2 : vector<4xi8>
    llvm.return %3 : vector<4xi1>
  }]

def same_shuffle_inputs_fcmp_before := [llvmfunc|
  llvm.func @same_shuffle_inputs_fcmp(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<5xi1> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.shufflevector %arg0, %0 [0, 1, 3, 2, 0] : vector<4xf32> 
    %2 = llvm.shufflevector %arg1, %0 [0, 1, 3, 2, 0] : vector<4xf32> 
    %3 = llvm.fcmp "oeq" %1, %2 : vector<5xf32>
    llvm.return %3 : vector<5xi1>
  }]

def same_shuffle_inputs_icmp_extra_use1_before := [llvmfunc|
  llvm.func @same_shuffle_inputs_icmp_extra_use1(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [3, 3, 3, 3] : vector<4xi8> 
    %2 = llvm.shufflevector %arg1, %0 [3, 3, 3, 3] : vector<4xi8> 
    %3 = llvm.icmp "ugt" %1, %2 : vector<4xi8>
    llvm.call @use_v4i8(%1) : (vector<4xi8>) -> ()
    llvm.return %3 : vector<4xi1>
  }]

def same_shuffle_inputs_icmp_extra_use2_before := [llvmfunc|
  llvm.func @same_shuffle_inputs_icmp_extra_use2(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [3, 2] : vector<4xi8> 
    %2 = llvm.shufflevector %arg1, %0 [3, 2] : vector<4xi8> 
    %3 = llvm.icmp "eq" %1, %2 : vector<2xi8>
    llvm.call @use_v2i8(%2) : (vector<2xi8>) -> ()
    llvm.return %3 : vector<2xi1>
  }]

def same_shuffle_inputs_icmp_extra_use3_before := [llvmfunc|
  llvm.func @same_shuffle_inputs_icmp_extra_use3(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 0] : vector<4xi8> 
    %2 = llvm.shufflevector %arg1, %0 [0, 0] : vector<4xi8> 
    %3 = llvm.icmp "eq" %1, %2 : vector<2xi8>
    llvm.call @use_v2i8(%1) : (vector<2xi8>) -> ()
    llvm.call @use_v2i8(%2) : (vector<2xi8>) -> ()
    llvm.return %3 : vector<2xi1>
  }]

def splat_icmp_before := [llvmfunc|
  llvm.func @splat_icmp(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(dense<42> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [3, 3, 3, 3] : vector<4xi8> 
    %3 = llvm.icmp "sgt" %2, %1 : vector<4xi8>
    llvm.return %3 : vector<4xi1>
  }]

def splat_icmp_poison_before := [llvmfunc|
  llvm.func @splat_icmp_poison(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<4xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<4xi8>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi8>
    %12 = llvm.shufflevector %arg0, %0 [2, -1, -1, 2] : vector<4xi8> 
    %13 = llvm.icmp "ult" %12, %11 : vector<4xi8>
    llvm.return %13 : vector<4xi1>
  }]

def splat_icmp_larger_size_before := [llvmfunc|
  llvm.func @splat_icmp_larger_size(%arg0: vector<2xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<4xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<4xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<4xi8>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi8>
    %12 = llvm.shufflevector %arg0, %0 [1, -1, 1, -1] : vector<2xi8> 
    %13 = llvm.icmp "eq" %12, %11 : vector<4xi8>
    llvm.return %13 : vector<4xi1>
  }]

def splat_fcmp_smaller_size_before := [llvmfunc|
  llvm.func @splat_fcmp_smaller_size(%arg0: vector<5xf32>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<5xf32>
    %1 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %2 = llvm.mlir.poison : f32
    %3 = llvm.mlir.undef : vector<4xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<4xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xf32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<4xf32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xf32>
    %12 = llvm.shufflevector %arg0, %0 [1, -1, 1, -1] : vector<5xf32> 
    %13 = llvm.fcmp "oeq" %12, %11 : vector<4xf32>
    llvm.return %13 : vector<4xi1>
  }]

def splat_icmp_extra_use_before := [llvmfunc|
  llvm.func @splat_icmp_extra_use(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(dense<42> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [3, 3, 3, 3] : vector<4xi8> 
    llvm.call @use_v4i8(%2) : (vector<4xi8>) -> ()
    %3 = llvm.icmp "sgt" %2, %1 : vector<4xi8>
    llvm.return %3 : vector<4xi1>
  }]

def not_splat_icmp_before := [llvmfunc|
  llvm.func @not_splat_icmp(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(dense<42> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [3, 2, 3, 3] : vector<4xi8> 
    %3 = llvm.icmp "sgt" %2, %1 : vector<4xi8>
    llvm.return %3 : vector<4xi1>
  }]

def not_splat_icmp2_before := [llvmfunc|
  llvm.func @not_splat_icmp2(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[43, 42, 42, 42]> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [2, 2, 2, 2] : vector<4xi8> 
    %3 = llvm.icmp "sgt" %2, %1 : vector<4xi8>
    llvm.return %3 : vector<4xi1>
  }]

def sge_combined := [llvmfunc|
  llvm.func @sge(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-128, 126]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_sge   : sge_before  ⊑  sge_combined := by
  unfold sge_before sge_combined
  simp_alive_peephole
  sorry
def uge_combined := [llvmfunc|
  llvm.func @uge(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-2, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_uge   : uge_before  ⊑  uge_combined := by
  unfold uge_before uge_combined
  simp_alive_peephole
  sorry
def sle_combined := [llvmfunc|
  llvm.func @sle(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[127, -127]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_sle   : sle_before  ⊑  sle_combined := by
  unfold sle_before sle_combined
  simp_alive_peephole
  sorry
def ule_combined := [llvmfunc|
  llvm.func @ule(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_ule   : ule_before  ⊑  ule_combined := by
  unfold ule_before ule_combined
  simp_alive_peephole
  sorry
def ult_min_signed_value_combined := [llvmfunc|
  llvm.func @ult_min_signed_value(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_ult_min_signed_value   : ult_min_signed_value_before  ⊑  ult_min_signed_value_combined := by
  unfold ult_min_signed_value_before ult_min_signed_value_combined
  simp_alive_peephole
  sorry
def sge_zero_combined := [llvmfunc|
  llvm.func @sge_zero(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_sge_zero   : sge_zero_before  ⊑  sge_zero_combined := by
  unfold sge_zero_before sge_zero_combined
  simp_alive_peephole
  sorry
def uge_zero_combined := [llvmfunc|
  llvm.func @uge_zero(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_uge_zero   : uge_zero_before  ⊑  uge_zero_combined := by
  unfold uge_zero_before uge_zero_combined
  simp_alive_peephole
  sorry
def sle_zero_combined := [llvmfunc|
  llvm.func @sle_zero(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_sle_zero   : sle_zero_before  ⊑  sle_zero_combined := by
  unfold sle_zero_before sle_zero_combined
  simp_alive_peephole
  sorry
def ule_zero_combined := [llvmfunc|
  llvm.func @ule_zero(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_ule_zero   : ule_zero_before  ⊑  ule_zero_combined := by
  unfold ule_zero_before ule_zero_combined
  simp_alive_peephole
  sorry
def sge_weird_combined := [llvmfunc|
  llvm.func @sge_weird(%arg0: vector<3xi3>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(-1 : i3) : i3
    %1 = llvm.mlir.constant(2 : i3) : i3
    %2 = llvm.mlir.constant(-4 : i3) : i3
    %3 = llvm.mlir.constant(dense<[-4, 2, -1]> : vector<3xi3>) : vector<3xi3>
    %4 = llvm.icmp "sgt" %arg0, %3 : vector<3xi3>
    llvm.return %4 : vector<3xi1>
  }]

theorem inst_combine_sge_weird   : sge_weird_before  ⊑  sge_weird_combined := by
  unfold sge_weird_before sge_weird_combined
  simp_alive_peephole
  sorry
def uge_weird_combined := [llvmfunc|
  llvm.func @uge_weird(%arg0: vector<3xi3>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i3) : i3
    %1 = llvm.mlir.constant(0 : i3) : i3
    %2 = llvm.mlir.constant(-2 : i3) : i3
    %3 = llvm.mlir.constant(dense<[-2, 0, 1]> : vector<3xi3>) : vector<3xi3>
    %4 = llvm.icmp "ugt" %arg0, %3 : vector<3xi3>
    llvm.return %4 : vector<3xi1>
  }]

theorem inst_combine_uge_weird   : uge_weird_before  ⊑  uge_weird_combined := by
  unfold uge_weird_before uge_weird_combined
  simp_alive_peephole
  sorry
def sle_weird_combined := [llvmfunc|
  llvm.func @sle_weird(%arg0: vector<3xi3>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i3) : i3
    %1 = llvm.mlir.constant(-3 : i3) : i3
    %2 = llvm.mlir.constant(3 : i3) : i3
    %3 = llvm.mlir.constant(dense<[3, -3, 1]> : vector<3xi3>) : vector<3xi3>
    %4 = llvm.icmp "slt" %arg0, %3 : vector<3xi3>
    llvm.return %4 : vector<3xi1>
  }]

theorem inst_combine_sle_weird   : sle_weird_before  ⊑  sle_weird_combined := by
  unfold sle_weird_before sle_weird_combined
  simp_alive_peephole
  sorry
def ule_weird_combined := [llvmfunc|
  llvm.func @ule_weird(%arg0: vector<3xi3>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(2 : i3) : i3
    %1 = llvm.mlir.constant(1 : i3) : i3
    %2 = llvm.mlir.constant(-1 : i3) : i3
    %3 = llvm.mlir.constant(dense<[-1, 1, 2]> : vector<3xi3>) : vector<3xi3>
    %4 = llvm.icmp "ult" %arg0, %3 : vector<3xi3>
    llvm.return %4 : vector<3xi1>
  }]

theorem inst_combine_ule_weird   : ule_weird_before  ⊑  ule_weird_combined := by
  unfold ule_weird_before ule_weird_combined
  simp_alive_peephole
  sorry
def sge_min_combined := [llvmfunc|
  llvm.func @sge_min(%arg0: vector<2xi3>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(1 : i3) : i3
    %1 = llvm.mlir.constant(-4 : i3) : i3
    %2 = llvm.mlir.constant(dense<[-4, 1]> : vector<2xi3>) : vector<2xi3>
    %3 = llvm.icmp "sge" %arg0, %2 : vector<2xi3>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_sge_min   : sge_min_before  ⊑  sge_min_combined := by
  unfold sge_min_before sge_min_combined
  simp_alive_peephole
  sorry
def uge_min_combined := [llvmfunc|
  llvm.func @uge_min(%arg0: vector<2xi3>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i3) : i3
    %1 = llvm.mlir.constant(1 : i3) : i3
    %2 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi3>) : vector<2xi3>
    %3 = llvm.icmp "uge" %arg0, %2 : vector<2xi3>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_uge_min   : uge_min_before  ⊑  uge_min_combined := by
  unfold uge_min_before uge_min_combined
  simp_alive_peephole
  sorry
def sle_max_combined := [llvmfunc|
  llvm.func @sle_max(%arg0: vector<2xi3>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(3 : i3) : i3
    %1 = llvm.mlir.constant(1 : i3) : i3
    %2 = llvm.mlir.constant(dense<[1, 3]> : vector<2xi3>) : vector<2xi3>
    %3 = llvm.icmp "sle" %arg0, %2 : vector<2xi3>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_sle_max   : sle_max_before  ⊑  sle_max_combined := by
  unfold sle_max_before sle_max_combined
  simp_alive_peephole
  sorry
def ule_max_combined := [llvmfunc|
  llvm.func @ule_max(%arg0: vector<2xi3>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(1 : i3) : i3
    %1 = llvm.mlir.constant(-1 : i3) : i3
    %2 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi3>) : vector<2xi3>
    %3 = llvm.icmp "ule" %arg0, %2 : vector<2xi3>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_ule_max   : ule_max_before  ⊑  ule_max_combined := by
  unfold ule_max_before ule_max_combined
  simp_alive_peephole
  sorry
def PR27756_1_combined := [llvmfunc|
  llvm.func @PR27756_1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[34, 1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_PR27756_1   : PR27756_1_before  ⊑  PR27756_1_combined := by
  unfold PR27756_1_before PR27756_1_combined
  simp_alive_peephole
  sorry
def PR27756_2_combined := [llvmfunc|
  llvm.func @PR27756_2(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<[43, 43, 1]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<3xi8>
    llvm.return %1 : vector<3xi1>
  }]

theorem inst_combine_PR27756_2   : PR27756_2_before  ⊑  PR27756_2_combined := by
  unfold PR27756_2_before PR27756_2_combined
  simp_alive_peephole
  sorry
def PR27756_3_combined := [llvmfunc|
  llvm.func @PR27756_3(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<[0, 0, 41]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<3xi8>
    llvm.return %1 : vector<3xi1>
  }]

theorem inst_combine_PR27756_3   : PR27756_3_before  ⊑  PR27756_3_combined := by
  unfold PR27756_3_before PR27756_3_combined
  simp_alive_peephole
  sorry
def PR27786_combined := [llvmfunc|
  llvm.func @PR27786(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @someglobal : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i16
    %3 = llvm.bitcast %2 : i16 to vector<2xi8>
    %4 = llvm.icmp "sle" %arg0, %3 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_PR27786   : PR27786_before  ⊑  PR27786_combined := by
  unfold PR27786_before PR27786_combined
  simp_alive_peephole
  sorry
def same_shuffle_inputs_icmp_combined := [llvmfunc|
  llvm.func @same_shuffle_inputs_icmp(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi1>
    %1 = llvm.icmp "sgt" %arg0, %arg1 : vector<4xi8>
    %2 = llvm.shufflevector %1, %0 [3, 3, 2, 0] : vector<4xi1> 
    llvm.return %2 : vector<4xi1>
  }]

theorem inst_combine_same_shuffle_inputs_icmp   : same_shuffle_inputs_icmp_before  ⊑  same_shuffle_inputs_icmp_combined := by
  unfold same_shuffle_inputs_icmp_before same_shuffle_inputs_icmp_combined
  simp_alive_peephole
  sorry
def same_shuffle_inputs_fcmp_combined := [llvmfunc|
  llvm.func @same_shuffle_inputs_fcmp(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<5xi1> {
    %0 = llvm.mlir.poison : vector<4xi1>
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : vector<4xf32>
    %2 = llvm.shufflevector %1, %0 [0, 1, 3, 2, 0] : vector<4xi1> 
    llvm.return %2 : vector<5xi1>
  }]

theorem inst_combine_same_shuffle_inputs_fcmp   : same_shuffle_inputs_fcmp_before  ⊑  same_shuffle_inputs_fcmp_combined := by
  unfold same_shuffle_inputs_fcmp_before same_shuffle_inputs_fcmp_combined
  simp_alive_peephole
  sorry
def same_shuffle_inputs_icmp_extra_use1_combined := [llvmfunc|
  llvm.func @same_shuffle_inputs_icmp_extra_use1(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.poison : vector<4xi1>
    %2 = llvm.shufflevector %arg0, %0 [3, 3, 3, 3] : vector<4xi8> 
    %3 = llvm.icmp "ugt" %arg0, %arg1 : vector<4xi8>
    %4 = llvm.shufflevector %3, %1 [3, 3, 3, 3] : vector<4xi1> 
    llvm.call @use_v4i8(%2) : (vector<4xi8>) -> ()
    llvm.return %4 : vector<4xi1>
  }]

theorem inst_combine_same_shuffle_inputs_icmp_extra_use1   : same_shuffle_inputs_icmp_extra_use1_before  ⊑  same_shuffle_inputs_icmp_extra_use1_combined := by
  unfold same_shuffle_inputs_icmp_extra_use1_before same_shuffle_inputs_icmp_extra_use1_combined
  simp_alive_peephole
  sorry
def same_shuffle_inputs_icmp_extra_use2_combined := [llvmfunc|
  llvm.func @same_shuffle_inputs_icmp_extra_use2(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.poison : vector<4xi1>
    %2 = llvm.shufflevector %arg1, %0 [3, 2] : vector<4xi8> 
    %3 = llvm.icmp "eq" %arg0, %arg1 : vector<4xi8>
    %4 = llvm.shufflevector %3, %1 [3, 2] : vector<4xi1> 
    llvm.call @use_v2i8(%2) : (vector<2xi8>) -> ()
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_same_shuffle_inputs_icmp_extra_use2   : same_shuffle_inputs_icmp_extra_use2_before  ⊑  same_shuffle_inputs_icmp_extra_use2_combined := by
  unfold same_shuffle_inputs_icmp_extra_use2_before same_shuffle_inputs_icmp_extra_use2_combined
  simp_alive_peephole
  sorry
def same_shuffle_inputs_icmp_extra_use3_combined := [llvmfunc|
  llvm.func @same_shuffle_inputs_icmp_extra_use3(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 0] : vector<4xi8> 
    %2 = llvm.shufflevector %arg1, %0 [0, 0] : vector<4xi8> 
    %3 = llvm.icmp "eq" %1, %2 : vector<2xi8>
    llvm.call @use_v2i8(%1) : (vector<2xi8>) -> ()
    llvm.call @use_v2i8(%2) : (vector<2xi8>) -> ()
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_same_shuffle_inputs_icmp_extra_use3   : same_shuffle_inputs_icmp_extra_use3_before  ⊑  same_shuffle_inputs_icmp_extra_use3_combined := by
  unfold same_shuffle_inputs_icmp_extra_use3_before same_shuffle_inputs_icmp_extra_use3_combined
  simp_alive_peephole
  sorry
def splat_icmp_combined := [llvmfunc|
  llvm.func @splat_icmp(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.poison : vector<4xi1>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<4xi8>
    %3 = llvm.shufflevector %2, %1 [3, 3, 3, 3] : vector<4xi1> 
    llvm.return %3 : vector<4xi1>
  }]

theorem inst_combine_splat_icmp   : splat_icmp_before  ⊑  splat_icmp_combined := by
  unfold splat_icmp_before splat_icmp_combined
  simp_alive_peephole
  sorry
def splat_icmp_poison_combined := [llvmfunc|
  llvm.func @splat_icmp_poison(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.poison : vector<4xi1>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<4xi8>
    %3 = llvm.shufflevector %2, %1 [2, 2, 2, 2] : vector<4xi1> 
    llvm.return %3 : vector<4xi1>
  }]

theorem inst_combine_splat_icmp_poison   : splat_icmp_poison_before  ⊑  splat_icmp_poison_combined := by
  unfold splat_icmp_poison_before splat_icmp_poison_combined
  simp_alive_peephole
  sorry
def splat_icmp_larger_size_combined := [llvmfunc|
  llvm.func @splat_icmp_larger_size(%arg0: vector<2xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.poison : vector<2xi1>
    %2 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    %3 = llvm.shufflevector %2, %1 [1, 1, 1, 1] : vector<2xi1> 
    llvm.return %3 : vector<4xi1>
  }]

theorem inst_combine_splat_icmp_larger_size   : splat_icmp_larger_size_before  ⊑  splat_icmp_larger_size_combined := by
  unfold splat_icmp_larger_size_before splat_icmp_larger_size_combined
  simp_alive_peephole
  sorry
def splat_fcmp_smaller_size_combined := [llvmfunc|
  llvm.func @splat_fcmp_smaller_size(%arg0: vector<5xf32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<4.200000e+01> : vector<5xf32>) : vector<5xf32>
    %1 = llvm.mlir.poison : vector<5xi1>
    %2 = llvm.fcmp "oeq" %arg0, %0 : vector<5xf32>
    %3 = llvm.shufflevector %2, %1 [1, 1, 1, 1] : vector<5xi1> 
    llvm.return %3 : vector<4xi1>
  }]

theorem inst_combine_splat_fcmp_smaller_size   : splat_fcmp_smaller_size_before  ⊑  splat_fcmp_smaller_size_combined := by
  unfold splat_fcmp_smaller_size_before splat_fcmp_smaller_size_combined
  simp_alive_peephole
  sorry
def splat_icmp_extra_use_combined := [llvmfunc|
  llvm.func @splat_icmp_extra_use(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(dense<42> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [3, 3, 3, 3] : vector<4xi8> 
    llvm.call @use_v4i8(%2) : (vector<4xi8>) -> ()
    %3 = llvm.icmp "sgt" %2, %1 : vector<4xi8>
    llvm.return %3 : vector<4xi1>
  }]

theorem inst_combine_splat_icmp_extra_use   : splat_icmp_extra_use_before  ⊑  splat_icmp_extra_use_combined := by
  unfold splat_icmp_extra_use_before splat_icmp_extra_use_combined
  simp_alive_peephole
  sorry
def not_splat_icmp_combined := [llvmfunc|
  llvm.func @not_splat_icmp(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(dense<42> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [3, 2, 3, 3] : vector<4xi8> 
    %3 = llvm.icmp "sgt" %2, %1 : vector<4xi8>
    llvm.return %3 : vector<4xi1>
  }]

theorem inst_combine_not_splat_icmp   : not_splat_icmp_before  ⊑  not_splat_icmp_combined := by
  unfold not_splat_icmp_before not_splat_icmp_combined
  simp_alive_peephole
  sorry
def not_splat_icmp2_combined := [llvmfunc|
  llvm.func @not_splat_icmp2(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[43, 42, 42, 42]> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [2, 2, 2, 2] : vector<4xi8> 
    %3 = llvm.icmp "sgt" %2, %1 : vector<4xi8>
    llvm.return %3 : vector<4xi1>
  }]

theorem inst_combine_not_splat_icmp2   : not_splat_icmp2_before  ⊑  not_splat_icmp2_combined := by
  unfold not_splat_icmp2_before not_splat_icmp2_combined
  simp_alive_peephole
  sorry
