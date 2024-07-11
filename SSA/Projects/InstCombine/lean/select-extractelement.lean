import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-extractelement
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def extract_one_select_before := [llvmfunc|
  llvm.func @extract_one_select(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: i32) -> f32 attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.icmp "ne" %arg2, %0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, vector<4xf32>
    %4 = llvm.extractelement %3[%1 : i32] : vector<4xf32>
    llvm.return %4 : f32
  }]

def extract_two_select_before := [llvmfunc|
  llvm.func @extract_two_select(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: i32) -> vector<2xf32> attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xf32>
    %4 = llvm.icmp "ne" %arg2, %0 : i32
    %5 = llvm.select %4, %arg0, %arg1 : i1, vector<4xf32>
    %6 = llvm.extractelement %5[%1 : i32] : vector<4xf32>
    %7 = llvm.extractelement %5[%2 : i32] : vector<4xf32>
    %8 = llvm.insertelement %6, %3[%0 : i32] : vector<2xf32>
    %9 = llvm.insertelement %7, %8[%1 : i32] : vector<2xf32>
    llvm.return %9 : vector<2xf32>
  }]

def extract_one_select_user_before := [llvmfunc|
  llvm.func @extract_one_select_user(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: i32) -> f32 attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.icmp "ne" %arg2, %0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, vector<4xf32>
    %4 = llvm.extractelement %3[%1 : i32] : vector<4xf32>
    llvm.call @v4float_user(%3) : (vector<4xf32>) -> ()
    llvm.return %4 : f32
  }]

def extract_one_vselect_user_before := [llvmfunc|
  llvm.func @extract_one_vselect_user(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xi32>) -> f32 attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.icmp "ne" %arg2, %1 : vector<4xi32>
    %4 = llvm.select %3, %arg0, %arg1 : vector<4xi1>, vector<4xf32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xf32>
    llvm.call @v4float_user(%4) : (vector<4xf32>) -> ()
    llvm.return %5 : f32
  }]

def extract_one_vselect_before := [llvmfunc|
  llvm.func @extract_one_vselect(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xi32>) -> f32 attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.icmp "ne" %arg2, %1 : vector<4xi32>
    %3 = llvm.select %2, %arg0, %arg1 : vector<4xi1>, vector<4xf32>
    %4 = llvm.extractelement %3[%0 : i32] : vector<4xf32>
    llvm.return %4 : f32
  }]

def extract_two_vselect_before := [llvmfunc|
  llvm.func @extract_two_vselect(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xi32>) -> vector<2xf32> attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.icmp "ne" %arg2, %1 : vector<4xi32>
    %6 = llvm.select %5, %arg0, %arg1 : vector<4xi1>, vector<4xf32>
    %7 = llvm.extractelement %6[%2 : i32] : vector<4xf32>
    %8 = llvm.extractelement %6[%3 : i32] : vector<4xf32>
    %9 = llvm.insertelement %7, %4[%0 : i32] : vector<2xf32>
    %10 = llvm.insertelement %8, %9[%2 : i32] : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }]

def simple_vector_select_before := [llvmfunc|
  llvm.func @simple_vector_select(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xi32>) -> vector<4xf32> attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xf32>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.extractelement %arg2[%0 : i32] : vector<4xi32>
    %6 = llvm.icmp "ne" %5, %0 : i32
    %7 = llvm.select %6, %arg0, %arg1 : i1, vector<4xf32>
    %8 = llvm.extractelement %7[%0 : i32] : vector<4xf32>
    %9 = llvm.insertelement %8, %1[%0 : i32] : vector<4xf32>
    %10 = llvm.extractelement %arg2[%2 : i32] : vector<4xi32>
    %11 = llvm.icmp "ne" %10, %0 : i32
    %12 = llvm.select %11, %arg0, %arg1 : i1, vector<4xf32>
    %13 = llvm.extractelement %12[%2 : i32] : vector<4xf32>
    %14 = llvm.insertelement %13, %9[%2 : i32] : vector<4xf32>
    %15 = llvm.extractelement %arg2[%3 : i32] : vector<4xi32>
    %16 = llvm.icmp "ne" %15, %0 : i32
    %17 = llvm.select %16, %arg0, %arg1 : i1, vector<4xf32>
    %18 = llvm.extractelement %17[%3 : i32] : vector<4xf32>
    %19 = llvm.insertelement %18, %14[%3 : i32] : vector<4xf32>
    %20 = llvm.extractelement %arg2[%4 : i32] : vector<4xi32>
    %21 = llvm.icmp "ne" %20, %0 : i32
    %22 = llvm.select %21, %arg0, %arg1 : i1, vector<4xf32>
    %23 = llvm.extractelement %22[%4 : i32] : vector<4xf32>
    %24 = llvm.insertelement %23, %19[%4 : i32] : vector<4xf32>
    llvm.return %24 : vector<4xf32>
  }]

def extract_cond_before := [llvmfunc|
  llvm.func @extract_cond(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.extractelement %arg2[%0 : i32] : vector<4xi1>
    %2 = llvm.select %1, %arg0, %arg1 : i1, vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

def splat_cond_before := [llvmfunc|
  llvm.func @splat_cond(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.shufflevector %arg2, %0 [3, 3, 3, 3] : vector<4xi1> 
    %2 = llvm.select %1, %arg0, %arg1 : vector<4xi1>, vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

def extract_cond_extra_use_before := [llvmfunc|
  llvm.func @extract_cond_extra_use(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.extractelement %arg2[%0 : i32] : vector<4xi1>
    llvm.call @extra_use(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg0, %arg1 : i1, vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

def extract_cond_variable_index_before := [llvmfunc|
  llvm.func @extract_cond_variable_index(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>, %arg3: i32) -> vector<4xi32> {
    %0 = llvm.extractelement %arg2[%arg3 : i32] : vector<4xi1>
    %1 = llvm.select %0, %arg0, %arg1 : i1, vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

def extract_cond_type_mismatch_before := [llvmfunc|
  llvm.func @extract_cond_type_mismatch(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<5xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.extractelement %arg2[%0 : i32] : vector<5xi1>
    %2 = llvm.select %1, %arg0, %arg1 : i1, vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

def inf_loop_partial_undef_before := [llvmfunc|
  llvm.func @inf_loop_partial_undef(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi32>, %arg3: vector<2xi32>) -> i32 {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.undef : vector<2xi1>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi1>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi1>
    %8 = llvm.mlir.constant(true) : i1
    %9 = llvm.mlir.undef : vector<2xi1>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi1>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi1>
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %16 = llvm.add %arg3, %0 overflow<nsw>  : vector<2xi32>
    %17 = llvm.icmp "slt" %16, %arg2 : vector<2xi32>
    %18 = llvm.and %arg0, %arg1  : vector<2xi1>
    %19 = llvm.select %18, %17, %7 : vector<2xi1>, vector<2xi1>
    %20 = llvm.xor %19, %13  : vector<2xi1>
    %21 = llvm.select %20, %15, %arg3 : vector<2xi1>, vector<2xi32>
    %22 = llvm.extractelement %21[%14 : i32] : vector<2xi32>
    llvm.return %22 : i32
  }]

def extract_one_select_combined := [llvmfunc|
  llvm.func @extract_one_select(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: i32) -> f32 attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.icmp "eq" %arg2, %0 : i32
    %3 = llvm.select %2, %arg1, %arg0 : i1, vector<4xf32>
    %4 = llvm.extractelement %3[%1 : i64] : vector<4xf32>
    llvm.return %4 : f32
  }]

theorem inst_combine_extract_one_select   : extract_one_select_before  ⊑  extract_one_select_combined := by
  unfold extract_one_select_before extract_one_select_combined
  simp_alive_peephole
  sorry
def extract_two_select_combined := [llvmfunc|
  llvm.func @extract_two_select(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: i32) -> vector<2xf32> attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xf32>
    %2 = llvm.icmp "eq" %arg2, %0 : i32
    %3 = llvm.select %2, %arg1, %arg0 : i1, vector<4xf32>
    %4 = llvm.shufflevector %3, %1 [1, 2] : vector<4xf32> 
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_extract_two_select   : extract_two_select_before  ⊑  extract_two_select_combined := by
  unfold extract_two_select_before extract_two_select_combined
  simp_alive_peephole
  sorry
def extract_one_select_user_combined := [llvmfunc|
  llvm.func @extract_one_select_user(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: i32) -> f32 attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.icmp "eq" %arg2, %0 : i32
    %3 = llvm.select %2, %arg1, %arg0 : i1, vector<4xf32>
    %4 = llvm.extractelement %3[%1 : i64] : vector<4xf32>
    llvm.call @v4float_user(%3) : (vector<4xf32>) -> ()
    llvm.return %4 : f32
  }]

theorem inst_combine_extract_one_select_user   : extract_one_select_user_before  ⊑  extract_one_select_user_combined := by
  unfold extract_one_select_user_before extract_one_select_user_combined
  simp_alive_peephole
  sorry
def extract_one_vselect_user_combined := [llvmfunc|
  llvm.func @extract_one_vselect_user(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xi32>) -> f32 attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.icmp "eq" %arg2, %1 : vector<4xi32>
    %4 = llvm.select %3, %arg1, %arg0 : vector<4xi1>, vector<4xf32>
    %5 = llvm.extractelement %4[%2 : i64] : vector<4xf32>
    llvm.call @v4float_user(%4) : (vector<4xf32>) -> ()
    llvm.return %5 : f32
  }]

theorem inst_combine_extract_one_vselect_user   : extract_one_vselect_user_before  ⊑  extract_one_vselect_user_combined := by
  unfold extract_one_vselect_user_before extract_one_vselect_user_combined
  simp_alive_peephole
  sorry
def extract_one_vselect_combined := [llvmfunc|
  llvm.func @extract_one_vselect(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xi32>) -> f32 attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.icmp "eq" %arg2, %1 : vector<4xi32>
    %4 = llvm.select %3, %arg1, %arg0 : vector<4xi1>, vector<4xf32>
    %5 = llvm.extractelement %4[%2 : i64] : vector<4xf32>
    llvm.return %5 : f32
  }]

theorem inst_combine_extract_one_vselect   : extract_one_vselect_before  ⊑  extract_one_vselect_combined := by
  unfold extract_one_vselect_before extract_one_vselect_combined
  simp_alive_peephole
  sorry
def extract_two_vselect_combined := [llvmfunc|
  llvm.func @extract_two_vselect(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xi32>) -> vector<2xf32> attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.poison : vector<4xf32>
    %3 = llvm.icmp "eq" %arg2, %1 : vector<4xi32>
    %4 = llvm.select %3, %arg1, %arg0 : vector<4xi1>, vector<4xf32>
    %5 = llvm.shufflevector %4, %2 [1, 2] : vector<4xf32> 
    llvm.return %5 : vector<2xf32>
  }]

theorem inst_combine_extract_two_vselect   : extract_two_vselect_before  ⊑  extract_two_vselect_combined := by
  unfold extract_two_vselect_before extract_two_vselect_combined
  simp_alive_peephole
  sorry
def simple_vector_select_combined := [llvmfunc|
  llvm.func @simple_vector_select(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xi32>) -> vector<4xf32> attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.extractelement %arg2[%0 : i64] : vector<4xi32>
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.select %6, %arg1, %arg0 : i1, vector<4xf32>
    %8 = llvm.extractelement %arg2[%2 : i64] : vector<4xi32>
    %9 = llvm.icmp "eq" %8, %1 : i32
    %10 = llvm.select %9, %arg1, %arg0 : i1, vector<4xf32>
    %11 = llvm.shufflevector %7, %10 [0, 5, -1, -1] : vector<4xf32> 
    %12 = llvm.extractelement %arg2[%3 : i64] : vector<4xi32>
    %13 = llvm.icmp "eq" %12, %1 : i32
    %14 = llvm.select %13, %arg1, %arg0 : i1, vector<4xf32>
    %15 = llvm.shufflevector %11, %14 [0, 1, 6, -1] : vector<4xf32> 
    %16 = llvm.extractelement %arg2[%4 : i64] : vector<4xi32>
    %17 = llvm.icmp "eq" %16, %1 : i32
    %18 = llvm.select %17, %arg1, %arg0 : i1, vector<4xf32>
    %19 = llvm.shufflevector %15, %18 [0, 1, 2, 7] : vector<4xf32> 
    llvm.return %19 : vector<4xf32>
  }]

theorem inst_combine_simple_vector_select   : simple_vector_select_before  ⊑  simple_vector_select_combined := by
  unfold simple_vector_select_before simple_vector_select_combined
  simp_alive_peephole
  sorry
def extract_cond_combined := [llvmfunc|
  llvm.func @extract_cond(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi1>
    %1 = llvm.shufflevector %arg2, %0 [3, 3, 3, 3] : vector<4xi1> 
    %2 = llvm.select %1, %arg0, %arg1 : vector<4xi1>, vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_extract_cond   : extract_cond_before  ⊑  extract_cond_combined := by
  unfold extract_cond_before extract_cond_combined
  simp_alive_peephole
  sorry
def splat_cond_combined := [llvmfunc|
  llvm.func @splat_cond(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi1>
    %1 = llvm.shufflevector %arg2, %0 [3, 3, 3, 3] : vector<4xi1> 
    %2 = llvm.select %1, %arg0, %arg1 : vector<4xi1>, vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_splat_cond   : splat_cond_before  ⊑  splat_cond_combined := by
  unfold splat_cond_before splat_cond_combined
  simp_alive_peephole
  sorry
def extract_cond_extra_use_combined := [llvmfunc|
  llvm.func @extract_cond_extra_use(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.extractelement %arg2[%0 : i64] : vector<4xi1>
    llvm.call @extra_use(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg0, %arg1 : i1, vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_extract_cond_extra_use   : extract_cond_extra_use_before  ⊑  extract_cond_extra_use_combined := by
  unfold extract_cond_extra_use_before extract_cond_extra_use_combined
  simp_alive_peephole
  sorry
def extract_cond_variable_index_combined := [llvmfunc|
  llvm.func @extract_cond_variable_index(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>, %arg3: i32) -> vector<4xi32> {
    %0 = llvm.extractelement %arg2[%arg3 : i32] : vector<4xi1>
    %1 = llvm.select %0, %arg0, %arg1 : i1, vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_extract_cond_variable_index   : extract_cond_variable_index_before  ⊑  extract_cond_variable_index_combined := by
  unfold extract_cond_variable_index_before extract_cond_variable_index_combined
  simp_alive_peephole
  sorry
def extract_cond_type_mismatch_combined := [llvmfunc|
  llvm.func @extract_cond_type_mismatch(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<5xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<5xi1>
    %1 = llvm.shufflevector %arg2, %0 [1, 1, 1, 1] : vector<5xi1> 
    %2 = llvm.select %1, %arg0, %arg1 : vector<4xi1>, vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_extract_cond_type_mismatch   : extract_cond_type_mismatch_before  ⊑  extract_cond_type_mismatch_combined := by
  unfold extract_cond_type_mismatch_before extract_cond_type_mismatch_combined
  simp_alive_peephole
  sorry
def inf_loop_partial_undef_combined := [llvmfunc|
  llvm.func @inf_loop_partial_undef(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi32>, %arg3: vector<2xi32>) -> i32 {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.undef : vector<2xi1>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi1>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi1>
    %8 = llvm.mlir.poison : i32
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.undef : vector<2xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %8, %12[%13 : i32] : vector<2xi32>
    %15 = llvm.mlir.constant(0 : i64) : i64
    %16 = llvm.add %arg3, %0 overflow<nsw>  : vector<2xi32>
    %17 = llvm.icmp "sge" %16, %arg2 : vector<2xi32>
    %18 = llvm.and %arg0, %arg1  : vector<2xi1>
    %19 = llvm.select %18, %17, %7 : vector<2xi1>, vector<2xi1>
    %20 = llvm.select %19, %14, %arg3 : vector<2xi1>, vector<2xi32>
    %21 = llvm.extractelement %20[%15 : i64] : vector<2xi32>
    llvm.return %21 : i32
  }]

theorem inst_combine_inf_loop_partial_undef   : inf_loop_partial_undef_before  ⊑  inf_loop_partial_undef_combined := by
  unfold inf_loop_partial_undef_before inf_loop_partial_undef_combined
  simp_alive_peephole
  sorry
