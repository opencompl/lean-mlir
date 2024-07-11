import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  zext-or-icmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def zext_or_icmp_icmp_before := [llvmfunc|
  llvm.func @zext_or_icmp_icmp(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    %4 = llvm.icmp "eq" %arg1, %1 : i8
    %5 = llvm.or %3, %4  : i1
    %6 = llvm.zext %5 : i1 to i8
    llvm.return %6 : i8
  }]

def zext_or_icmp_icmp_logical_before := [llvmfunc|
  llvm.func @zext_or_icmp_icmp_logical(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    %5 = llvm.icmp "eq" %arg1, %1 : i8
    %6 = llvm.select %4, %2, %5 : i1, i1
    %7 = llvm.zext %6 : i1 to i8
    llvm.return %7 : i8
  }]

def dont_widen_undef_before := [llvmfunc|
  llvm.func @dont_widen_undef() -> i32 {
    %0 = llvm.mlir.constant(33 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(65535 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%4: i32):  // pred: ^bb0
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.lshr %1, %4  : i32
    %7 = llvm.and %6, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.or %5, %8  : i1
    %10 = llvm.zext %9 : i1 to i32
    llvm.return %10 : i32
  }]

def dont_widen_undef_logical_before := [llvmfunc|
  llvm.func @dont_widen_undef_logical() -> i32 {
    %0 = llvm.mlir.constant(33 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(65535 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    llvm.br ^bb1(%0 : i32)
  ^bb1(%5: i32):  // pred: ^bb0
    %6 = llvm.icmp "ugt" %5, %1 : i32
    %7 = llvm.lshr %1, %5  : i32
    %8 = llvm.and %7, %2  : i32
    %9 = llvm.icmp "ne" %8, %3 : i32
    %10 = llvm.select %6, %4, %9 : i1, i1
    %11 = llvm.zext %10 : i1 to i32
    llvm.return %11 : i32
  }]

def knownbits_out_of_range_shift_before := [llvmfunc|
  llvm.func @knownbits_out_of_range_shift(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(63 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%2: i32):  // pred: ^bb0
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def zext_or_eq_ult_add_before := [llvmfunc|
  llvm.func @zext_or_eq_ult_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    %5 = llvm.icmp "eq" %arg0, %2 : i32
    %6 = llvm.or %4, %5  : i1
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }]

def select_zext_or_eq_ult_add_before := [llvmfunc|
  llvm.func @select_zext_or_eq_ult_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.icmp "eq" %arg0, %2 : i32
    %7 = llvm.zext %6 : i1 to i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    llvm.return %8 : i32
  }]

def PR49475_before := [llvmfunc|
  llvm.func @PR49475(%arg0: i32, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.and %arg1, %0  : i16
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.icmp "eq" %3, %2 : i16
    %6 = llvm.or %4, %5  : i1
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }]

def PR49475_infloop_before := [llvmfunc|
  llvm.func @PR49475_infloop(%arg0: i32, %arg1: i16, %arg2: i64, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(140 : i64) : i64
    %3 = llvm.mlir.constant(32 : i64) : i64
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.icmp "eq" %arg1, %1 : i16
    %6 = llvm.or %4, %5  : i1
    %7 = llvm.zext %6 : i1 to i32
    %8 = llvm.and %arg0, %7  : i32
    %9 = llvm.zext %8 : i32 to i64
    %10 = llvm.xor %9, %2  : i64
    %11 = llvm.sext %arg3 : i8 to i64
    %12 = llvm.sub %11, %arg2  : i64
    %13 = llvm.shl %12, %3  : i64
    %14 = llvm.ashr %13, %3  : i64
    %15 = llvm.icmp "sge" %10, %14 : i64
    %16 = llvm.zext %15 : i1 to i16
    %17 = llvm.or %arg1, %16  : i16
    %18 = llvm.trunc %17 : i16 to i8
    %19 = llvm.add %arg3, %18  : i8
    %20 = llvm.icmp "eq" %17, %1 : i16
    "llvm.intr.assume"(%20) : (i1) -> ()
    llvm.return %19 : i8
  }]

def PR51762_before := [llvmfunc|
  llvm.func @PR51762(%arg0: !llvm.ptr, %arg1: i32, %arg2: i16, %arg3: !llvm.ptr, %arg4: !llvm.ptr, %arg5: !llvm.ptr, %arg6: i32, %arg7: i1) -> i1 {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(31 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb2
    llvm.cond_br %arg7, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %5 = llvm.ashr %arg1, %3  : i32
    llvm.br ^bb1(%5 : i32)
  ^bb3:  // pred: ^bb1
    %6 = llvm.sext %arg2 : i16 to i64
    %7 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i32]

    %8 = llvm.zext %4 : i32 to i64
    %9 = llvm.shl %8, %1 overflow<nuw>  : i64
    %10 = llvm.zext %7 : i32 to i64
    %11 = llvm.or %9, %10  : i64
    %12 = llvm.urem %6, %11  : i64
    %13 = llvm.icmp "ne" %12, %2 : i64
    %14 = llvm.icmp "eq" %11, %2 : i64
    %15 = llvm.or %13, %14  : i1
    %16 = llvm.zext %15 : i1 to i32
    %17 = llvm.load %arg4 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %18 = llvm.sext %arg2 : i16 to i32
    %19 = llvm.icmp "sge" %17, %18 : i32
    %20 = llvm.zext %19 : i1 to i32
    %21 = llvm.load %arg5 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %22 = llvm.add %21, %20 overflow<nsw>  : i32
    llvm.store %22, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr]

    %23 = llvm.srem %16, %22  : i32
    %24 = llvm.zext %23 : i32 to i64
    %25 = llvm.udiv %11, %24  : i64
    %26 = llvm.trunc %25 : i64 to i32
    llvm.store %26, %arg4 {alignment = 8 : i64} : i32, !llvm.ptr]

    %27 = llvm.icmp "ult" %11, %24 : i64
    "llvm.intr.assume"(%27) : (i1) -> ()
    llvm.return %27 : i1
  }]

def zext_or_icmp_icmp_combined := [llvmfunc|
  llvm.func @zext_or_icmp_icmp(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    %4 = llvm.icmp "eq" %arg1, %1 : i8
    %5 = llvm.or %3, %4  : i1
    %6 = llvm.zext %5 : i1 to i8
    llvm.return %6 : i8
  }]

theorem inst_combine_zext_or_icmp_icmp   : zext_or_icmp_icmp_before  ⊑  zext_or_icmp_icmp_combined := by
  unfold zext_or_icmp_icmp_before zext_or_icmp_icmp_combined
  simp_alive_peephole
  sorry
def zext_or_icmp_icmp_logical_combined := [llvmfunc|
  llvm.func @zext_or_icmp_icmp_logical(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    %5 = llvm.icmp "eq" %arg1, %1 : i8
    %6 = llvm.select %4, %2, %5 : i1, i1
    %7 = llvm.zext %6 : i1 to i8
    llvm.return %7 : i8
  }]

theorem inst_combine_zext_or_icmp_icmp_logical   : zext_or_icmp_icmp_logical_before  ⊑  zext_or_icmp_icmp_logical_combined := by
  unfold zext_or_icmp_icmp_logical_before zext_or_icmp_icmp_logical_combined
  simp_alive_peephole
  sorry
def dont_widen_undef_combined := [llvmfunc|
  llvm.func @dont_widen_undef() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_dont_widen_undef   : dont_widen_undef_before  ⊑  dont_widen_undef_combined := by
  unfold dont_widen_undef_before dont_widen_undef_combined
  simp_alive_peephole
  sorry
def dont_widen_undef_logical_combined := [llvmfunc|
  llvm.func @dont_widen_undef_logical() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_dont_widen_undef_logical   : dont_widen_undef_logical_before  ⊑  dont_widen_undef_logical_combined := by
  unfold dont_widen_undef_logical_before dont_widen_undef_logical_combined
  simp_alive_peephole
  sorry
def knownbits_out_of_range_shift_combined := [llvmfunc|
  llvm.func @knownbits_out_of_range_shift(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i1
  }]

theorem inst_combine_knownbits_out_of_range_shift   : knownbits_out_of_range_shift_before  ⊑  knownbits_out_of_range_shift_combined := by
  unfold knownbits_out_of_range_shift_before knownbits_out_of_range_shift_combined
  simp_alive_peephole
  sorry
def zext_or_eq_ult_add_combined := [llvmfunc|
  llvm.func @zext_or_eq_ult_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_zext_or_eq_ult_add   : zext_or_eq_ult_add_before  ⊑  zext_or_eq_ult_add_combined := by
  unfold zext_or_eq_ult_add_before zext_or_eq_ult_add_combined
  simp_alive_peephole
  sorry
def select_zext_or_eq_ult_add_combined := [llvmfunc|
  llvm.func @select_zext_or_eq_ult_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_select_zext_or_eq_ult_add   : select_zext_or_eq_ult_add_before  ⊑  select_zext_or_eq_ult_add_combined := by
  unfold select_zext_or_eq_ult_add_before select_zext_or_eq_ult_add_combined
  simp_alive_peephole
  sorry
def PR49475_combined := [llvmfunc|
  llvm.func @PR49475(%arg0: i32, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.and %arg1, %0  : i16
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.icmp "eq" %3, %2 : i16
    %6 = llvm.or %4, %5  : i1
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }]

theorem inst_combine_PR49475   : PR49475_before  ⊑  PR49475_combined := by
  unfold PR49475_before PR49475_combined
  simp_alive_peephole
  sorry
def PR49475_infloop_combined := [llvmfunc|
  llvm.func @PR49475_infloop(%arg0: i32, %arg1: i16, %arg2: i64, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(140 : i32) : i32
    %3 = llvm.mlir.constant(140 : i64) : i64
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.icmp "eq" %arg1, %0 : i16
    %6 = llvm.and %arg0, %1  : i32
    %7 = llvm.or %6, %2  : i32
    %8 = llvm.zext %7 : i32 to i64
    %9 = llvm.select %5, %8, %3 : i1, i64
    %10 = llvm.sext %arg3 : i8 to i64
    %11 = llvm.sub %10, %arg2  : i64
    %12 = llvm.shl %11, %4  : i64
    %13 = llvm.ashr %12, %4  : i64
    %14 = llvm.icmp "sge" %9, %13 : i64
    %15 = llvm.zext %14 : i1 to i16
    %16 = llvm.or %15, %arg1  : i16
    %17 = llvm.icmp "eq" %16, %0 : i16
    "llvm.intr.assume"(%17) : (i1) -> ()
    llvm.return %arg3 : i8
  }]

theorem inst_combine_PR49475_infloop   : PR49475_infloop_before  ⊑  PR49475_infloop_combined := by
  unfold PR49475_infloop_before PR49475_infloop_combined
  simp_alive_peephole
  sorry
def PR51762_combined := [llvmfunc|
  llvm.func @PR51762(%arg0: !llvm.ptr, %arg1: i32, %arg2: i16, %arg3: !llvm.ptr, %arg4: !llvm.ptr, %arg5: !llvm.ptr, %arg6: i32, %arg7: i1) -> i1 {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(31 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb2
    llvm.cond_br %arg7, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %5 = llvm.ashr %arg1, %3  : i32
    llvm.br ^bb1(%5 : i32)
  ^bb3:  // pred: ^bb1
    %6 = llvm.sext %arg2 : i16 to i64
    %7 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i32
    %8 = llvm.zext %4 : i32 to i64
    %9 = llvm.shl %8, %1 overflow<nuw>  : i64
    %10 = llvm.zext %7 : i32 to i64
    %11 = llvm.or %9, %10  : i64
    %12 = llvm.urem %6, %11  : i64
    %13 = llvm.icmp "ne" %12, %2 : i64
    %14 = llvm.zext %13 : i1 to i32
    %15 = llvm.load %arg4 {alignment = 4 : i64} : !llvm.ptr -> i32
    %16 = llvm.sext %arg2 : i16 to i32
    %17 = llvm.icmp "sge" %15, %16 : i32
    %18 = llvm.zext %17 : i1 to i32
    %19 = llvm.load %arg5 {alignment = 4 : i64} : !llvm.ptr -> i32
    %20 = llvm.add %19, %18 overflow<nsw>  : i32
    llvm.store %20, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr
    %21 = llvm.srem %14, %20  : i32
    %22 = llvm.zext %21 : i32 to i64
    llvm.store %7, %arg4 {alignment = 8 : i64} : i32, !llvm.ptr
    %23 = llvm.icmp "ult" %11, %22 : i64
    "llvm.intr.assume"(%23) : (i1) -> ()
    llvm.return %23 : i1
  }]

theorem inst_combine_PR51762   : PR51762_before  ⊑  PR51762_combined := by
  unfold PR51762_before PR51762_combined
  simp_alive_peephole
  sorry
