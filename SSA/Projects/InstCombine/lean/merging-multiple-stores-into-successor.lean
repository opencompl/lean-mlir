import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  merging-multiple-stores-into-successor
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def _Z4testv_before := [llvmfunc|
  llvm.func @_Z4testv() {
    %0 = llvm.mlir.addressof @var_7 : !llvm.ptr
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.addressof @var_1 : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.addressof @var_0 : !llvm.ptr
    %5 = llvm.mlir.addressof @var_5 : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.addressof @arr_2 : !llvm.ptr
    %8 = llvm.mlir.addressof @arr_4 : !llvm.ptr
    %9 = llvm.mlir.addressof @arr_3 : !llvm.ptr
    %10 = llvm.mlir.constant(1 : i64) : i64
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.getelementptr inbounds %7[%11, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %13 = llvm.getelementptr inbounds %8[%11, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i16>
    %14 = llvm.getelementptr inbounds %9[%11, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i32>
    %15 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %16 = llvm.icmp "eq" %15, %1 : i8
    %17 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %18 = llvm.icmp "eq" %17, %3 : i32
    %19 = llvm.load %4 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %20 = llvm.sext %19 : i16 to i64
    %21 = llvm.load %5 {alignment = 8 : i64} : !llvm.ptr -> i64]

    %22 = llvm.select %18, %21, %20 : i1, i64
    %23 = llvm.sext %19 : i16 to i32
    llvm.cond_br %16, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.store %6, %7 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %19, %8 {alignment = 2 : i64} : i16, !llvm.ptr]

    llvm.store %23, %9 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %6, %12 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %19, %13 {alignment = 2 : i64} : i16, !llvm.ptr]

    llvm.store %23, %14 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    %24 = llvm.trunc %22 : i64 to i32
    llvm.store %24, %7 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %19, %8 {alignment = 2 : i64} : i16, !llvm.ptr]

    llvm.store %23, %9 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %24, %12 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %19, %13 {alignment = 2 : i64} : i16, !llvm.ptr]

    llvm.store %23, %14 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return
  }]

def diff_types_same_width_merge_before := [llvmfunc|
  llvm.func @diff_types_same_width_merge(%arg0: i1, %arg1: f16, %arg2: i16) -> f16 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f16 {alignment = 2 : i64} : (i32) -> !llvm.ptr]

    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 2 : i64} : f16, !llvm.ptr]

    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 2 : i64} : i16, !llvm.ptr]

    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 2 : i64} : !llvm.ptr -> f16]

    llvm.return %2 : f16
  }]

def diff_types_diff_width_no_merge_before := [llvmfunc|
  llvm.func @diff_types_diff_width_no_merge(%arg0: i1, %arg1: i32, %arg2: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %2 : i32
  }]

def vec_no_merge_before := [llvmfunc|
  llvm.func @vec_no_merge(%arg0: i1, %arg1: vector<2xi32>, %arg2: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 16 : i64} : !llvm.ptr -> vector<4xi32>]

    llvm.return %2 : vector<4xi32>
  }]

def one_elem_struct_merge(%arg0: i1, %arg1: !llvm.struct<"struct.half", (f16)>, %arg2: f16) -> !llvm.struct<"struct.half", _before := [llvmfunc|
  llvm.func @one_elem_struct_merge(%arg0: i1, %arg1: !llvm.struct<"struct.half", (f16)>, %arg2: f16) -> !llvm.struct<"struct.half", (f16)> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 2 : i64} : !llvm.struct<"struct.half", (f16)>, !llvm.ptr]

    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 2 : i64} : f16, !llvm.ptr]

    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 2 : i64} : !llvm.ptr -> !llvm.struct<"struct.half", (f16)>]

    llvm.return %2 : !llvm.struct<"struct.half", (f16)>
  }]

def multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _before := [llvmfunc|
  llvm.func @multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", (f16, i32)> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 4 : i64} : !llvm.struct<"struct.tup", (f16, i32)>, !llvm.ptr]

    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 2 : i64} : f16, !llvm.ptr]

    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"struct.tup", (f16, i32)>]

    llvm.return %2 : !llvm.struct<"struct.tup", (f16, i32)>
  }]

def same_types_diff_align_no_merge_before := [llvmfunc|
  llvm.func @same_types_diff_align_no_merge(%arg0: i1, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i16 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 8 : i64} : i16, !llvm.ptr]

    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 4 : i64} : i16, !llvm.ptr]

    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 2 : i64} : !llvm.ptr -> i16]

    llvm.return %2 : i16
  }]

def ptrtoint_merge_before := [llvmfunc|
  llvm.func @ptrtoint_merge(%arg0: i1, %arg1: i64, %arg2: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i64]

    llvm.return %2 : i64
  }]

def inttoptr_merge_before := [llvmfunc|
  llvm.func @inttoptr_merge(%arg0: i1, %arg1: i64, %arg2: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.return %2 : !llvm.ptr
  }]

def pr46688_before := [llvmfunc|
  llvm.func @pr46688(%arg0: i1, %arg1: i32, %arg2: i16, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.zext %arg2 : i16 to i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    %4 = llvm.lshr %3, %arg1  : i32
    %5 = llvm.lshr %4, %arg1  : i32
    %6 = llvm.trunc %5 : i32 to i16
    llvm.store %6, %arg3 {alignment = 2 : i64} : i16, !llvm.ptr]

    %7 = llvm.and %5, %0  : i32
    llvm.store %7, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    %8 = llvm.zext %arg2 : i16 to i32
    %9 = llvm.lshr %8, %arg1  : i32
    %10 = llvm.lshr %9, %arg1  : i32
    %11 = llvm.lshr %10, %arg1  : i32
    %12 = llvm.lshr %11, %arg1  : i32
    %13 = llvm.trunc %12 : i32 to i16
    llvm.store %13, %arg3 {alignment = 2 : i64} : i16, !llvm.ptr]

    llvm.store %12, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return
  }]

def _Z4testv_combined := [llvmfunc|
  llvm.func @_Z4testv() {
    %0 = llvm.mlir.addressof @var_7 : !llvm.ptr
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.addressof @var_0 : !llvm.ptr
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.addressof @var_1 : !llvm.ptr
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.addressof @var_5 : !llvm.ptr
    %7 = llvm.mlir.addressof @arr_2 : !llvm.ptr
    %8 = llvm.mlir.addressof @arr_4 : !llvm.ptr
    %9 = llvm.mlir.addressof @arr_3 : !llvm.ptr
    %10 = llvm.mlir.constant(1 : i64) : i64
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.getelementptr inbounds %7[%11, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %13 = llvm.getelementptr inbounds %8[%11, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i16>
    %14 = llvm.getelementptr inbounds %9[%11, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i32>
    %15 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine__Z4testv   : _Z4testv_before  ⊑  _Z4testv_combined := by
  unfold _Z4testv_before _Z4testv_combined
  simp_alive_peephole
  sorry
    %16 = llvm.icmp "eq" %15, %1 : i8
    %17 = llvm.load %2 {alignment = 2 : i64} : !llvm.ptr -> i16]

theorem inst_combine__Z4testv   : _Z4testv_before  ⊑  _Z4testv_combined := by
  unfold _Z4testv_before _Z4testv_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %16, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%3 : i32)
  ^bb2:  // pred: ^bb0
    %18 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine__Z4testv   : _Z4testv_before  ⊑  _Z4testv_combined := by
  unfold _Z4testv_before _Z4testv_combined
  simp_alive_peephole
  sorry
    %19 = llvm.icmp "eq" %18, %5 : i32
    %20 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> i64]

theorem inst_combine__Z4testv   : _Z4testv_before  ⊑  _Z4testv_combined := by
  unfold _Z4testv_before _Z4testv_combined
  simp_alive_peephole
  sorry
    %21 = llvm.sext %17 : i16 to i64
    %22 = llvm.select %19, %20, %21 : i1, i64
    %23 = llvm.trunc %22 : i64 to i32
    llvm.br ^bb3(%23 : i32)
  ^bb3(%24: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %24, %7 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine__Z4testv   : _Z4testv_before  ⊑  _Z4testv_combined := by
  unfold _Z4testv_before _Z4testv_combined
  simp_alive_peephole
  sorry
    llvm.store %17, %8 {alignment = 2 : i64} : i16, !llvm.ptr]

theorem inst_combine__Z4testv   : _Z4testv_before  ⊑  _Z4testv_combined := by
  unfold _Z4testv_before _Z4testv_combined
  simp_alive_peephole
  sorry
    %25 = llvm.sext %17 : i16 to i32
    llvm.store %25, %9 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine__Z4testv   : _Z4testv_before  ⊑  _Z4testv_combined := by
  unfold _Z4testv_before _Z4testv_combined
  simp_alive_peephole
  sorry
    llvm.store %24, %12 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine__Z4testv   : _Z4testv_before  ⊑  _Z4testv_combined := by
  unfold _Z4testv_before _Z4testv_combined
  simp_alive_peephole
  sorry
    llvm.store %17, %13 {alignment = 2 : i64} : i16, !llvm.ptr]

theorem inst_combine__Z4testv   : _Z4testv_before  ⊑  _Z4testv_combined := by
  unfold _Z4testv_before _Z4testv_combined
  simp_alive_peephole
  sorry
    llvm.store %25, %14 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine__Z4testv   : _Z4testv_before  ⊑  _Z4testv_combined := by
  unfold _Z4testv_before _Z4testv_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine__Z4testv   : _Z4testv_before  ⊑  _Z4testv_combined := by
  unfold _Z4testv_before _Z4testv_combined
  simp_alive_peephole
  sorry
def diff_types_same_width_merge_combined := [llvmfunc|
  llvm.func @diff_types_same_width_merge(%arg0: i1, %arg1: f16, %arg2: i16) -> f16 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : f16)
  ^bb2:  // pred: ^bb0
    %0 = llvm.bitcast %arg2 : i16 to f16
    llvm.br ^bb3(%0 : f16)
  ^bb3(%1: f16):  // 2 preds: ^bb1, ^bb2
    llvm.return %1 : f16
  }]

theorem inst_combine_diff_types_same_width_merge   : diff_types_same_width_merge_before  ⊑  diff_types_same_width_merge_combined := by
  unfold diff_types_same_width_merge_before diff_types_same_width_merge_combined
  simp_alive_peephole
  sorry
def diff_types_diff_width_no_merge_combined := [llvmfunc|
  llvm.func @diff_types_diff_width_no_merge(%arg0: i1, %arg1: i32, %arg2: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_diff_types_diff_width_no_merge   : diff_types_diff_width_no_merge_before  ⊑  diff_types_diff_width_no_merge_combined := by
  unfold diff_types_diff_width_no_merge_before diff_types_diff_width_no_merge_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_diff_types_diff_width_no_merge   : diff_types_diff_width_no_merge_before  ⊑  diff_types_diff_width_no_merge_combined := by
  unfold diff_types_diff_width_no_merge_before diff_types_diff_width_no_merge_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_diff_types_diff_width_no_merge   : diff_types_diff_width_no_merge_before  ⊑  diff_types_diff_width_no_merge_combined := by
  unfold diff_types_diff_width_no_merge_before diff_types_diff_width_no_merge_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_diff_types_diff_width_no_merge   : diff_types_diff_width_no_merge_before  ⊑  diff_types_diff_width_no_merge_combined := by
  unfold diff_types_diff_width_no_merge_before diff_types_diff_width_no_merge_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_diff_types_diff_width_no_merge   : diff_types_diff_width_no_merge_before  ⊑  diff_types_diff_width_no_merge_combined := by
  unfold diff_types_diff_width_no_merge_before diff_types_diff_width_no_merge_combined
  simp_alive_peephole
  sorry
def vec_no_merge_combined := [llvmfunc|
  llvm.func @vec_no_merge(%arg0: i1, %arg1: vector<2xi32>, %arg2: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_vec_no_merge   : vec_no_merge_before  ⊑  vec_no_merge_combined := by
  unfold vec_no_merge_before vec_no_merge_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

theorem inst_combine_vec_no_merge   : vec_no_merge_before  ⊑  vec_no_merge_combined := by
  unfold vec_no_merge_before vec_no_merge_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

theorem inst_combine_vec_no_merge   : vec_no_merge_before  ⊑  vec_no_merge_combined := by
  unfold vec_no_merge_before vec_no_merge_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 16 : i64} : !llvm.ptr -> vector<4xi32>]

theorem inst_combine_vec_no_merge   : vec_no_merge_before  ⊑  vec_no_merge_combined := by
  unfold vec_no_merge_before vec_no_merge_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_vec_no_merge   : vec_no_merge_before  ⊑  vec_no_merge_combined := by
  unfold vec_no_merge_before vec_no_merge_combined
  simp_alive_peephole
  sorry
def one_elem_struct_merge(%arg0: i1, %arg1: !llvm.struct<"struct.half", (f16)>, %arg2: f16) -> !llvm.struct<"struct.half", _combined := [llvmfunc|
  llvm.func @one_elem_struct_merge(%arg0: i1, %arg1: !llvm.struct<"struct.half", (f16)>, %arg2: f16) -> !llvm.struct<"struct.half", (f16)> {
    %0 = llvm.mlir.poison : !llvm.struct<"struct.half", (f16)>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[0] : !llvm.struct<"struct.half", (f16)> 
    llvm.br ^bb3(%1 : f16)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg2 : f16)
  ^bb3(%2: f16):  // 2 preds: ^bb1, ^bb2
    %3 = llvm.insertvalue %2, %0[0] : !llvm.struct<"struct.half", (f16)> 
    llvm.return %3 : !llvm.struct<"struct.half", (f16)>
  }]

theorem inst_combine_one_elem_struct_merge(%arg0: i1, %arg1: !llvm.struct<"struct.half", (f16)>, %arg2: f16) -> !llvm.struct<"struct.half",    : one_elem_struct_merge(%arg0: i1, %arg1: !llvm.struct<"struct.half", (f16)>, %arg2: f16) -> !llvm.struct<"struct.half", _before  ⊑  one_elem_struct_merge(%arg0: i1, %arg1: !llvm.struct<"struct.half", (f16)>, %arg2: f16) -> !llvm.struct<"struct.half", _combined := by
  unfold one_elem_struct_merge(%arg0: i1, %arg1: !llvm.struct<"struct.half", (f16)>, %arg2: f16) -> !llvm.struct<"struct.half", _before one_elem_struct_merge(%arg0: i1, %arg1: !llvm.struct<"struct.half", (f16)>, %arg2: f16) -> !llvm.struct<"struct.half", _combined
  simp_alive_peephole
  sorry
def multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _combined := [llvmfunc|
  llvm.func @multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", (f16, i32)> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup",    : multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _before  ⊑  multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _combined := by
  unfold multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _before multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _combined
  simp_alive_peephole
  sorry
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 4 : i64} : !llvm.struct<"struct.tup", (f16, i32)>, !llvm.ptr]

theorem inst_combine_multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup",    : multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _before  ⊑  multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _combined := by
  unfold multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _before multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _combined
  simp_alive_peephole
  sorry
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 2 : i64} : f16, !llvm.ptr]

theorem inst_combine_multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup",    : multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _before  ⊑  multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _combined := by
  unfold multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _before multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _combined
  simp_alive_peephole
  sorry
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"struct.tup", (f16, i32)>]

theorem inst_combine_multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup",    : multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _before  ⊑  multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _combined := by
  unfold multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _before multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _combined
  simp_alive_peephole
  sorry
    llvm.return %2 : !llvm.struct<"struct.tup", (f16, i32)>
  }]

theorem inst_combine_multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup",    : multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _before  ⊑  multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _combined := by
  unfold multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _before multi_elem_struct_no_merge(%arg0: i1, %arg1: !llvm.struct<"struct.tup", (f16, i32)>, %arg2: f16) -> !llvm.struct<"struct.tup", _combined
  simp_alive_peephole
  sorry
def same_types_diff_align_no_merge_combined := [llvmfunc|
  llvm.func @same_types_diff_align_no_merge(%arg0: i1, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i16 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_same_types_diff_align_no_merge   : same_types_diff_align_no_merge_before  ⊑  same_types_diff_align_no_merge_combined := by
  unfold same_types_diff_align_no_merge_before same_types_diff_align_no_merge_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 8 : i64} : i16, !llvm.ptr]

theorem inst_combine_same_types_diff_align_no_merge   : same_types_diff_align_no_merge_before  ⊑  same_types_diff_align_no_merge_combined := by
  unfold same_types_diff_align_no_merge_before same_types_diff_align_no_merge_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 4 : i64} : i16, !llvm.ptr]

theorem inst_combine_same_types_diff_align_no_merge   : same_types_diff_align_no_merge_before  ⊑  same_types_diff_align_no_merge_combined := by
  unfold same_types_diff_align_no_merge_before same_types_diff_align_no_merge_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 2 : i64} : !llvm.ptr -> i16]

theorem inst_combine_same_types_diff_align_no_merge   : same_types_diff_align_no_merge_before  ⊑  same_types_diff_align_no_merge_combined := by
  unfold same_types_diff_align_no_merge_before same_types_diff_align_no_merge_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i16
  }]

theorem inst_combine_same_types_diff_align_no_merge   : same_types_diff_align_no_merge_before  ⊑  same_types_diff_align_no_merge_combined := by
  unfold same_types_diff_align_no_merge_before same_types_diff_align_no_merge_combined
  simp_alive_peephole
  sorry
def ptrtoint_merge_combined := [llvmfunc|
  llvm.func @ptrtoint_merge(%arg0: i1, %arg1: i64, %arg2: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_ptrtoint_merge   : ptrtoint_merge_before  ⊑  ptrtoint_merge_combined := by
  unfold ptrtoint_merge_before ptrtoint_merge_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %arg1, %1 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_ptrtoint_merge   : ptrtoint_merge_before  ⊑  ptrtoint_merge_combined := by
  unfold ptrtoint_merge_before ptrtoint_merge_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %arg2, %1 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_ptrtoint_merge   : ptrtoint_merge_before  ⊑  ptrtoint_merge_combined := by
  unfold ptrtoint_merge_before ptrtoint_merge_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i64]

theorem inst_combine_ptrtoint_merge   : ptrtoint_merge_before  ⊑  ptrtoint_merge_combined := by
  unfold ptrtoint_merge_before ptrtoint_merge_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i64
  }]

theorem inst_combine_ptrtoint_merge   : ptrtoint_merge_before  ⊑  ptrtoint_merge_combined := by
  unfold ptrtoint_merge_before ptrtoint_merge_combined
  simp_alive_peephole
  sorry
def inttoptr_merge_combined := [llvmfunc|
  llvm.func @inttoptr_merge(%arg0: i1, %arg1: i64, %arg2: !llvm.ptr) -> !llvm.ptr {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.inttoptr %arg1 : i64 to !llvm.ptr
    llvm.br ^bb3(%0 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg2 : !llvm.ptr)
  ^bb3(%1: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_inttoptr_merge   : inttoptr_merge_before  ⊑  inttoptr_merge_combined := by
  unfold inttoptr_merge_before inttoptr_merge_combined
  simp_alive_peephole
  sorry
def pr46688_combined := [llvmfunc|
  llvm.func @pr46688(%arg0: i1, %arg1: i32, %arg2: i16, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %0 = llvm.zext %arg2 : i16 to i32
    %1 = llvm.lshr %0, %arg1  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    %4 = llvm.lshr %3, %arg1  : i32
    %5 = llvm.trunc %4 : i32 to i16
    llvm.store %5, %arg3 {alignment = 2 : i64} : i16, !llvm.ptr]

theorem inst_combine_pr46688   : pr46688_before  ⊑  pr46688_combined := by
  unfold pr46688_before pr46688_combined
  simp_alive_peephole
  sorry
    llvm.store %4, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_pr46688   : pr46688_before  ⊑  pr46688_combined := by
  unfold pr46688_before pr46688_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_pr46688   : pr46688_before  ⊑  pr46688_combined := by
  unfold pr46688_before pr46688_combined
  simp_alive_peephole
  sorry
