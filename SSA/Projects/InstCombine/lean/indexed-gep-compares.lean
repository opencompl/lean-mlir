import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  indexed-gep-compares
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb1(%2 : !llvm.ptr)
  ^bb1(%3: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %5 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %6 = llvm.icmp "ult" %4, %3 : !llvm.ptr
    llvm.cond_br %6, ^bb2, ^bb1(%5 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    llvm.return %3 : !llvm.ptr
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb1(%3 : !llvm.ptr)
  ^bb1(%4: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %6 = llvm.getelementptr inbounds %4[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %7 = llvm.ptrtoint %5 : !llvm.ptr to i32
    %8 = llvm.ptrtoint %4 : !llvm.ptr to i32
    %9 = llvm.icmp "ult" %7, %8 : i32
    llvm.cond_br %9, ^bb2, ^bb1(%6 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    llvm.return %4 : !llvm.ptr
  }]

def test3_no_inbounds1_before := [llvmfunc|
  llvm.func @test3_no_inbounds1(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb1(%2 : !llvm.ptr)
  ^bb1(%3: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %5 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %6 = llvm.icmp "ult" %4, %3 : !llvm.ptr
    llvm.cond_br %6, ^bb2, ^bb1(%5 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    llvm.return %3 : !llvm.ptr
  }]

def test3_no_inbounds2_before := [llvmfunc|
  llvm.func @test3_no_inbounds2(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb1(%2 : !llvm.ptr)
  ^bb1(%3: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %5 = llvm.getelementptr %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %6 = llvm.icmp "ult" %4, %3 : !llvm.ptr
    llvm.cond_br %6, ^bb2, ^bb1(%5 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    llvm.return %3 : !llvm.ptr
  }]

def test3_no_inbounds3_before := [llvmfunc|
  llvm.func @test3_no_inbounds3(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb1(%2 : !llvm.ptr)
  ^bb1(%3: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %5 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %6 = llvm.icmp "ult" %4, %3 : !llvm.ptr
    llvm.cond_br %6, ^bb2, ^bb1(%5 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    llvm.return %3 : !llvm.ptr
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i16, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.inttoptr %arg0 : i16 to !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb1(%3 : !llvm.ptr)
  ^bb1(%4: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %6 = llvm.getelementptr inbounds %4[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %7 = llvm.ptrtoint %5 : !llvm.ptr to i32
    %8 = llvm.ptrtoint %4 : !llvm.ptr to i32
    %9 = llvm.icmp "ult" %7, %8 : i32
    llvm.cond_br %9, ^bb2, ^bb1(%6 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    llvm.return %4 : !llvm.ptr
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> !llvm.ptr attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.invoke @fun_ptr() to ^bb1 unwind ^bb4 : () -> !llvm.ptr
  ^bb1:  // pred: ^bb0
    %4 = llvm.getelementptr inbounds %3[%arg0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb2(%4 : !llvm.ptr)
  ^bb2(%5: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %6 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %7 = llvm.getelementptr inbounds %5[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %8 = llvm.icmp "ult" %6, %5 : !llvm.ptr
    llvm.cond_br %8, ^bb3, ^bb2(%7 : !llvm.ptr)
  ^bb3:  // pred: ^bb2
    llvm.return %5 : !llvm.ptr
  ^bb4:  // pred: ^bb0
    %9 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.return %0 : !llvm.ptr
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> !llvm.ptr attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.invoke @fun_i32() to ^bb1 unwind ^bb4 : () -> i32
  ^bb1:  // pred: ^bb0
    %4 = llvm.inttoptr %3 : i32 to !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%arg0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb2(%5 : !llvm.ptr)
  ^bb2(%6: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %7 = llvm.getelementptr inbounds %4[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %8 = llvm.getelementptr inbounds %6[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %9 = llvm.icmp "ult" %7, %6 : !llvm.ptr
    llvm.cond_br %9, ^bb3, ^bb2(%8 : !llvm.ptr)
  ^bb3:  // pred: ^bb2
    llvm.return %6 : !llvm.ptr
  ^bb4:  // pred: ^bb0
    %10 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.return %0 : !llvm.ptr
  }]

def test7_before := [llvmfunc|
  llvm.func @test7() -> i1 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.addressof @pr30402 : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.getelementptr inbounds %1[%2] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.br ^bb1(%1 : !llvm.ptr)
  ^bb1(%4: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.icmp "eq" %4, %3 : !llvm.ptr
    llvm.cond_br %5, ^bb2, ^bb1(%3 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    llvm.return %5 : i1
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

    %2 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %6 = llvm.icmp "eq" %5, %3 : !llvm.ptr
    llvm.return %6 : i1
  }]

def test_zero_offset_cycle_before := [llvmfunc|
  llvm.func @test_zero_offset_cycle(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr inbounds %arg0[%0, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i64, i64)>
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.br ^bb1(%3 : i32)
  ^bb1(%4: i32):  // 3 preds: ^bb0, ^bb1, ^bb2
    %5 = llvm.inttoptr %4 : i32 to !llvm.ptr
    %6 = llvm.icmp "eq" %2, %5 : !llvm.ptr
    llvm.cond_br %6, ^bb1(%4 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    %7 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.br ^bb1(%7 : i32)
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(400 : i32) : i32
    %3 = llvm.shl %arg1, %0 overflow<nsw>  : i32
    llvm.br ^bb1(%3 : i32)
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.add %4, %1 overflow<nsw>  : i32
    %6 = llvm.icmp "sgt" %4, %2 : i32
    llvm.cond_br %6, ^bb2, ^bb1(%5 : i32)
  ^bb2:  // pred: ^bb1
    %7 = llvm.getelementptr inbounds %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.return %7 : !llvm.ptr
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(400 : i32) : i32
    %3 = llvm.shl %arg1, %0 overflow<nsw>  : i32
    llvm.br ^bb1(%3 : i32)
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.add %4, %1 overflow<nsw>  : i32
    %6 = llvm.icmp "sgt" %4, %2 : i32
    llvm.cond_br %6, ^bb2, ^bb1(%5 : i32)
  ^bb2:  // pred: ^bb1
    %7 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %8 = llvm.getelementptr inbounds %7[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.return %8 : !llvm.ptr
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_no_inbounds1_combined := [llvmfunc|
  llvm.func @test3_no_inbounds1(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb1(%2 : !llvm.ptr)
  ^bb1(%3: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %5 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %6 = llvm.icmp "ult" %4, %3 : !llvm.ptr
    llvm.cond_br %6, ^bb2, ^bb1(%5 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_test3_no_inbounds1   : test3_no_inbounds1_before  ⊑  test3_no_inbounds1_combined := by
  unfold test3_no_inbounds1_before test3_no_inbounds1_combined
  simp_alive_peephole
  sorry
def test3_no_inbounds2_combined := [llvmfunc|
  llvm.func @test3_no_inbounds2(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb1(%2 : !llvm.ptr)
  ^bb1(%3: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %5 = llvm.getelementptr %3[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %6 = llvm.icmp "ult" %4, %3 : !llvm.ptr
    llvm.cond_br %6, ^bb2, ^bb1(%5 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_test3_no_inbounds2   : test3_no_inbounds2_before  ⊑  test3_no_inbounds2_combined := by
  unfold test3_no_inbounds2_before test3_no_inbounds2_combined
  simp_alive_peephole
  sorry
def test3_no_inbounds3_combined := [llvmfunc|
  llvm.func @test3_no_inbounds3(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb1(%2 : !llvm.ptr)
  ^bb1(%3: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %5 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %6 = llvm.icmp "ult" %4, %3 : !llvm.ptr
    llvm.cond_br %6, ^bb2, ^bb1(%5 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_test3_no_inbounds3   : test3_no_inbounds3_before  ⊑  test3_no_inbounds3_combined := by
  unfold test3_no_inbounds3_before test3_no_inbounds3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i16, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(400 : i32) : i32
    %3 = llvm.shl %arg1, %0 overflow<nsw>  : i32
    llvm.br ^bb1(%3 : i32)
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.add %4, %1 overflow<nsw>  : i32
    %6 = llvm.icmp "sgt" %4, %2 : i32
    llvm.cond_br %6, ^bb2, ^bb1(%5 : i32)
  ^bb2:  // pred: ^bb1
    %7 = llvm.zext %arg0 : i16 to i32
    %8 = llvm.inttoptr %7 : i32 to !llvm.ptr
    %9 = llvm.getelementptr inbounds %8[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.return %9 : !llvm.ptr
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> !llvm.ptr attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(400 : i32) : i32
    %4 = llvm.invoke @fun_ptr() to ^bb1 unwind ^bb4 : () -> !llvm.ptr
  ^bb1:  // pred: ^bb0
    %5 = llvm.shl %arg0, %1 overflow<nsw>  : i32
    llvm.br ^bb2(%5 : i32)
  ^bb2(%6: i32):  // 2 preds: ^bb1, ^bb2
    %7 = llvm.add %6, %2 overflow<nsw>  : i32
    %8 = llvm.icmp "sgt" %6, %3 : i32
    llvm.cond_br %8, ^bb3, ^bb2(%7 : i32)
  ^bb3:  // pred: ^bb2
    %9 = llvm.getelementptr inbounds %4[%6] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.return %9 : !llvm.ptr
  ^bb4:  // pred: ^bb0
    %10 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> !llvm.ptr attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(400 : i32) : i32
    %4 = llvm.invoke @fun_i32() to ^bb1 unwind ^bb4 : () -> i32
  ^bb1:  // pred: ^bb0
    %5 = llvm.shl %arg0, %1 overflow<nsw>  : i32
    llvm.br ^bb2(%5 : i32)
  ^bb2(%6: i32):  // 2 preds: ^bb1, ^bb2
    %7 = llvm.add %6, %2 overflow<nsw>  : i32
    %8 = llvm.icmp "sgt" %6, %3 : i32
    llvm.cond_br %8, ^bb3, ^bb2(%7 : i32)
  ^bb3:  // pred: ^bb2
    %9 = llvm.inttoptr %4 : i32 to !llvm.ptr
    %10 = llvm.getelementptr inbounds %9[%6] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.return %10 : !llvm.ptr
  ^bb4:  // pred: ^bb0
    %11 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.br ^bb1(%0 : i1)
  ^bb1(%2: i1):  // 2 preds: ^bb0, ^bb1
    llvm.cond_br %2, ^bb2, ^bb1(%1 : i1)
  ^bb2:  // pred: ^bb1
    llvm.return %2 : i1
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    %4 = llvm.trunc %arg1 : i64 to i32
    %5 = llvm.getelementptr inbounds %3[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %6 = llvm.trunc %1 : i64 to i32
    %7 = llvm.inttoptr %6 : i32 to !llvm.ptr
    %8 = llvm.getelementptr inbounds %7[%0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %9 = llvm.icmp "eq" %8, %5 : !llvm.ptr
    llvm.return %9 : i1
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test_zero_offset_cycle_combined := [llvmfunc|
  llvm.func @test_zero_offset_cycle(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr inbounds %arg0[%0, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i64, i64)>
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.br ^bb1(%3 : i32)
  ^bb1(%4: i32):  // 3 preds: ^bb0, ^bb1, ^bb2
    %5 = llvm.inttoptr %4 : i32 to !llvm.ptr
    %6 = llvm.icmp "eq" %2, %5 : !llvm.ptr
    llvm.cond_br %6, ^bb1(%4 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    %7 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.br ^bb1(%7 : i32)
  }]

theorem inst_combine_test_zero_offset_cycle   : test_zero_offset_cycle_before  ⊑  test_zero_offset_cycle_combined := by
  unfold test_zero_offset_cycle_before test_zero_offset_cycle_combined
  simp_alive_peephole
  sorry
