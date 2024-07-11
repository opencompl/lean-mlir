import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  gep-combine-loop-invariant
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr {llvm.nocapture, llvm.readnone}, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg5: i32, %arg6: i32, %arg7: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg8: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.zext %arg1 : i32 to i64
    %5 = llvm.getelementptr inbounds %arg7[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.zext %arg2 : i32 to i64
    %7 = llvm.getelementptr inbounds %5[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %8 = llvm.getelementptr inbounds %7[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %9 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %10 = llvm.icmp "eq" %9, %arg3 : i32
    llvm.cond_br %10, ^bb5(%1 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg6 : i32, i32)
  ^bb2(%11: i32, %12: i32):  // pred: ^bb4
    %13 = llvm.zext %12 : i32 to i64
    %14 = llvm.getelementptr inbounds %arg7[%13] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %15 = llvm.getelementptr inbounds %14[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %16 = llvm.getelementptr inbounds %15[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %17 = llvm.load %16 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %18 = llvm.icmp "eq" %17, %arg3 : i32
    llvm.cond_br %18, ^bb5(%1 : i32), ^bb3(%12, %11 : i32, i32)
  ^bb3(%19: i32, %20: i32):  // 2 preds: ^bb1, ^bb2
    %21 = llvm.and %19, %arg8  : i32
    %22 = llvm.zext %21 : i32 to i64
    %23 = llvm.getelementptr inbounds %arg4[%22] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %24 = llvm.load %23 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %25 = llvm.icmp "ugt" %24, %arg5 : i32
    llvm.cond_br %25, ^bb4, ^bb5(%2 : i32)
  ^bb4:  // pred: ^bb3
    %26 = llvm.add %20, %3  : i32
    %27 = llvm.icmp "eq" %26, %2 : i32
    llvm.cond_br %27, ^bb5(%2 : i32), ^bb2(%26, %24 : i32, i32)
  ^bb5(%28: i32):  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    llvm.return %28 : i32
  }]

def PR37005_before := [llvmfunc|
  llvm.func @PR37005(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.undef : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<21> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.mlir.constant(dense<7> : vector<2xi64>) : vector<2xi64>
    %5 = llvm.mlir.constant(80 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %7 = llvm.getelementptr inbounds %6[%1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %8 = llvm.getelementptr inbounds %7[%2] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, !llvm.ptr
    %9 = llvm.ptrtoint %8 : !llvm.vec<2 x ptr> to vector<2xi64>
    %10 = llvm.lshr %9, %3  : vector<2xi64>
    %11 = llvm.shl %10, %4 overflow<nsw, nuw>  : vector<2xi64>
    %12 = llvm.getelementptr inbounds %arg0[%11] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, i8
    %13 = llvm.getelementptr inbounds %12[%5] : (!llvm.vec<2 x ptr>, i64) -> !llvm.vec<2 x ptr>, i8
    llvm.call @blackhole(%13) : (!llvm.vec<2 x ptr>) -> ()
    llvm.br ^bb1
  }]

def PR37005_2_before := [llvmfunc|
  llvm.func @PR37005_2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.undef : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(21 : i64) : i64
    %3 = llvm.mlir.constant(7 : i64) : i64
    %4 = llvm.mlir.constant(dense<[80, 60]> : vector<2xi64>) : vector<2xi64>
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %5 = llvm.getelementptr inbounds %arg1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.lshr %7, %2  : i64
    %9 = llvm.shl %8, %3 overflow<nsw, nuw>  : i64
    %10 = llvm.getelementptr inbounds %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %11 = llvm.getelementptr inbounds %10[%4] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, i8
    llvm.call @blackhole(%11) : (!llvm.vec<2 x ptr>) -> ()
    llvm.br ^bb1
  }]

def PR37005_3_before := [llvmfunc|
  llvm.func @PR37005_3(%arg0: !llvm.vec<2 x ptr>, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.undef : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<21> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.mlir.constant(dense<7> : vector<2xi64>) : vector<2xi64>
    %5 = llvm.mlir.constant(80 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %7 = llvm.getelementptr inbounds %6[%1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %8 = llvm.getelementptr inbounds %7[%2] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, !llvm.ptr
    %9 = llvm.ptrtoint %8 : !llvm.vec<2 x ptr> to vector<2xi64>
    %10 = llvm.lshr %9, %3  : vector<2xi64>
    %11 = llvm.shl %10, %4 overflow<nsw, nuw>  : vector<2xi64>
    %12 = llvm.getelementptr inbounds %arg0[%11] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i8
    %13 = llvm.getelementptr inbounds %12[%5] : (!llvm.vec<2 x ptr>, i64) -> !llvm.vec<2 x ptr>, i8
    llvm.call @blackhole(%13) : (!llvm.vec<2 x ptr>) -> ()
    llvm.br ^bb1
  }]

def PR51485_before := [llvmfunc|
  llvm.func @PR51485(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.addressof @PR51485 : !llvm.ptr
    %2 = llvm.mlir.constant(80 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %3 = llvm.shl %arg0, %0 overflow<nsw, nuw>  : vector<2xi64>
    %4 = llvm.getelementptr inbounds %1[%3] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, i8
    %5 = llvm.getelementptr inbounds %4[%2] : (!llvm.vec<2 x ptr>, i64) -> !llvm.vec<2 x ptr>, i8
    llvm.call @blackhole(%5) : (!llvm.vec<2 x ptr>) -> ()
    llvm.br ^bb1
  }]

def gep_cross_loop_before := [llvmfunc|
  llvm.func @gep_cross_loop(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(16 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

    %5 = llvm.getelementptr inbounds %arg1[%4] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.br ^bb1(%0, %1 : i64, f32)
  ^bb1(%6: i64, %7: f32):  // 2 preds: ^bb0, ^bb3
    %8 = llvm.icmp "ule" %6, %2 : i64
    llvm.cond_br %8, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %7 : f32
  ^bb3:  // pred: ^bb1
    %9 = llvm.getelementptr inbounds %5[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %10 = llvm.load %9 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %11 = llvm.fadd %7, %10  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %12 = llvm.add %6, %3 overflow<nsw>  : i64
    llvm.br ^bb1(%12, %11 : i64, f32)
  }]

def only_one_inbounds_before := [llvmfunc|
  llvm.func @only_one_inbounds(%arg0: !llvm.ptr, %arg1: i1, %arg2: i32 {llvm.noundef}, %arg3: i32 {llvm.noundef}) {
    %0 = llvm.zext %arg3 : i32 to i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %1 = llvm.zext %arg2 : i32 to i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @use(%3) : (!llvm.ptr) -> ()
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

def both_inbounds_one_neg_before := [llvmfunc|
  llvm.func @both_inbounds_one_neg(%arg0: !llvm.ptr, %arg1: i1, %arg2: i32 {llvm.noundef}) {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %1 = llvm.zext %arg2 : i32 to i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @use(%3) : (!llvm.ptr) -> ()
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

def both_inbounds_pos_before := [llvmfunc|
  llvm.func @both_inbounds_pos(%arg0: !llvm.ptr, %arg1: i1, %arg2: i32 {llvm.noundef}) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %1 = llvm.zext %arg2 : i32 to i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @use(%3) : (!llvm.ptr) -> ()
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr {llvm.nocapture, llvm.readnone}, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg5: i32, %arg6: i32, %arg7: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg8: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.zext %arg1 : i32 to i64
    %5 = llvm.getelementptr inbounds %arg7[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.zext %arg2 : i32 to i64
    %7 = llvm.getelementptr inbounds %5[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %8 = llvm.getelementptr inbounds %7[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %9 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
    %10 = llvm.icmp "eq" %9, %arg3 : i32
    llvm.cond_br %10, ^bb5(%1 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg6 : i32, i32)
  ^bb2:  // pred: ^bb4
    %11 = llvm.zext %22 : i32 to i64
    %12 = llvm.getelementptr inbounds %arg7[%11] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %13 = llvm.getelementptr inbounds %12[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %14 = llvm.getelementptr inbounds %13[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %15 = llvm.load %14 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
    %16 = llvm.icmp "eq" %15, %arg3 : i32
    llvm.cond_br %16, ^bb5(%1 : i32), ^bb3(%22, %24 : i32, i32)
  ^bb3(%17: i32, %18: i32):  // 2 preds: ^bb1, ^bb2
    %19 = llvm.and %17, %arg8  : i32
    %20 = llvm.zext %19 : i32 to i64
    %21 = llvm.getelementptr inbounds %arg4[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %22 = llvm.load %21 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
    %23 = llvm.icmp "ugt" %22, %arg5 : i32
    llvm.cond_br %23, ^bb4, ^bb5(%2 : i32)
  ^bb4:  // pred: ^bb3
    %24 = llvm.add %18, %3  : i32
    %25 = llvm.icmp "eq" %24, %2 : i32
    llvm.cond_br %25, ^bb5(%2 : i32), ^bb2
  ^bb5(%26: i32):  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    llvm.return %26 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def PR37005_combined := [llvmfunc|
  llvm.func @PR37005(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.undef : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<14> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.mlir.constant(dense<1125899906842496> : vector<2xi64>) : vector<2xi64>
    %5 = llvm.mlir.constant(80 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %7 = llvm.getelementptr inbounds %6[%1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %8 = llvm.getelementptr inbounds %7[%2] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, !llvm.ptr
    %9 = llvm.ptrtoint %8 : !llvm.vec<2 x ptr> to vector<2xi64>
    %10 = llvm.lshr %9, %3  : vector<2xi64>
    %11 = llvm.and %10, %4  : vector<2xi64>
    %12 = llvm.getelementptr inbounds %arg0[%11] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, i8
    %13 = llvm.getelementptr inbounds %12[%5] : (!llvm.vec<2 x ptr>, i64) -> !llvm.vec<2 x ptr>, i8
    llvm.call @blackhole(%13) : (!llvm.vec<2 x ptr>) -> ()
    llvm.br ^bb1
  }]

theorem inst_combine_PR37005   : PR37005_before  ⊑  PR37005_combined := by
  unfold PR37005_before PR37005_combined
  simp_alive_peephole
  sorry
def PR37005_2_combined := [llvmfunc|
  llvm.func @PR37005_2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.undef : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(14 : i64) : i64
    %3 = llvm.mlir.constant(1125899906842496 : i64) : i64
    %4 = llvm.mlir.constant(dense<[80, 60]> : vector<2xi64>) : vector<2xi64>
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %5 = llvm.getelementptr inbounds %arg1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.lshr %7, %2  : i64
    %9 = llvm.and %8, %3  : i64
    %10 = llvm.getelementptr inbounds %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %11 = llvm.getelementptr inbounds %10[%4] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, i8
    llvm.call @blackhole(%11) : (!llvm.vec<2 x ptr>) -> ()
    llvm.br ^bb1
  }]

theorem inst_combine_PR37005_2   : PR37005_2_before  ⊑  PR37005_2_combined := by
  unfold PR37005_2_before PR37005_2_combined
  simp_alive_peephole
  sorry
def PR37005_3_combined := [llvmfunc|
  llvm.func @PR37005_3(%arg0: !llvm.vec<2 x ptr>, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.undef : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<14> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.mlir.constant(dense<1125899906842496> : vector<2xi64>) : vector<2xi64>
    %5 = llvm.mlir.constant(80 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %7 = llvm.getelementptr inbounds %6[%1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %8 = llvm.getelementptr inbounds %7[%2] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, !llvm.ptr
    %9 = llvm.ptrtoint %8 : !llvm.vec<2 x ptr> to vector<2xi64>
    %10 = llvm.lshr %9, %3  : vector<2xi64>
    %11 = llvm.and %10, %4  : vector<2xi64>
    %12 = llvm.getelementptr inbounds %arg0[%11] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i8
    %13 = llvm.getelementptr inbounds %12[%5] : (!llvm.vec<2 x ptr>, i64) -> !llvm.vec<2 x ptr>, i8
    llvm.call @blackhole(%13) : (!llvm.vec<2 x ptr>) -> ()
    llvm.br ^bb1
  }]

theorem inst_combine_PR37005_3   : PR37005_3_before  ⊑  PR37005_3_combined := by
  unfold PR37005_3_before PR37005_3_combined
  simp_alive_peephole
  sorry
def PR51485_combined := [llvmfunc|
  llvm.func @PR51485(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.addressof @PR51485 : !llvm.ptr
    %2 = llvm.mlir.constant(80 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %3 = llvm.shl %arg0, %0 overflow<nsw, nuw>  : vector<2xi64>
    %4 = llvm.getelementptr inbounds %1[%3] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, i8
    %5 = llvm.getelementptr inbounds %4[%2] : (!llvm.vec<2 x ptr>, i64) -> !llvm.vec<2 x ptr>, i8
    llvm.call @blackhole(%5) : (!llvm.vec<2 x ptr>) -> ()
    llvm.br ^bb1
  }]

theorem inst_combine_PR51485   : PR51485_before  ⊑  PR51485_combined := by
  unfold PR51485_before PR51485_combined
  simp_alive_peephole
  sorry
def gep_cross_loop_combined := [llvmfunc|
  llvm.func @gep_cross_loop(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(17 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

theorem inst_combine_gep_cross_loop   : gep_cross_loop_before  ⊑  gep_cross_loop_combined := by
  unfold gep_cross_loop_before gep_cross_loop_combined
  simp_alive_peephole
  sorry
    %5 = llvm.getelementptr inbounds %arg1[%4] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.br ^bb1(%0, %1 : i64, f32)
  ^bb1(%6: i64, %7: f32):  // 2 preds: ^bb0, ^bb3
    %8 = llvm.icmp "ult" %6, %2 : i64
    llvm.cond_br %8, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %7 : f32
  ^bb3:  // pred: ^bb1
    %9 = llvm.getelementptr inbounds %5[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %10 = llvm.load %9 {alignment = 4 : i64} : !llvm.ptr -> f32]

theorem inst_combine_gep_cross_loop   : gep_cross_loop_before  ⊑  gep_cross_loop_combined := by
  unfold gep_cross_loop_before gep_cross_loop_combined
  simp_alive_peephole
  sorry
    %11 = llvm.fadd %7, %10  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_gep_cross_loop   : gep_cross_loop_before  ⊑  gep_cross_loop_combined := by
  unfold gep_cross_loop_before gep_cross_loop_combined
  simp_alive_peephole
  sorry
    %12 = llvm.add %6, %3 overflow<nsw, nuw>  : i64
    llvm.br ^bb1(%12, %11 : i64, f32)
  }]

theorem inst_combine_gep_cross_loop   : gep_cross_loop_before  ⊑  gep_cross_loop_combined := by
  unfold gep_cross_loop_before gep_cross_loop_combined
  simp_alive_peephole
  sorry
def only_one_inbounds_combined := [llvmfunc|
  llvm.func @only_one_inbounds(%arg0: !llvm.ptr, %arg1: i1, %arg2: i32 {llvm.noundef}, %arg3: i32 {llvm.noundef}) {
    %0 = llvm.zext %arg3 : i32 to i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %1 = llvm.zext %arg2 : i32 to i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @use(%3) : (!llvm.ptr) -> ()
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

theorem inst_combine_only_one_inbounds   : only_one_inbounds_before  ⊑  only_one_inbounds_combined := by
  unfold only_one_inbounds_before only_one_inbounds_combined
  simp_alive_peephole
  sorry
def both_inbounds_one_neg_combined := [llvmfunc|
  llvm.func @both_inbounds_one_neg(%arg0: !llvm.ptr, %arg1: i1, %arg2: i32 {llvm.noundef}) {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %1 = llvm.zext %arg2 : i32 to i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @use(%3) : (!llvm.ptr) -> ()
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

theorem inst_combine_both_inbounds_one_neg   : both_inbounds_one_neg_before  ⊑  both_inbounds_one_neg_combined := by
  unfold both_inbounds_one_neg_before both_inbounds_one_neg_combined
  simp_alive_peephole
  sorry
def both_inbounds_pos_combined := [llvmfunc|
  llvm.func @both_inbounds_pos(%arg0: !llvm.ptr, %arg1: i1, %arg2: i32 {llvm.noundef}) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %1 = llvm.zext %arg2 : i32 to i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @use(%3) : (!llvm.ptr) -> ()
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

theorem inst_combine_both_inbounds_pos   : both_inbounds_pos_before  ⊑  both_inbounds_pos_combined := by
  unfold both_inbounds_pos_before both_inbounds_pos_combined
  simp_alive_peephole
  sorry
