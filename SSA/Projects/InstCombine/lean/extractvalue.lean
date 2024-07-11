import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  extractvalue
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.mlir.undef : !llvm.struct<(i32, struct<(i32, i32)>)>
    %2 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %arg1, %2[1] : !llvm.struct<(i32, i32)> 
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i32)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i32)> 
    %6 = llvm.insertvalue %4, %1[0] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    %7 = llvm.insertvalue %4, %6[1, 0] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    %8 = llvm.insertvalue %5, %7[1, 1] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    %9 = llvm.extractvalue %8[1] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    %10 = llvm.extractvalue %8[1, 1] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    llvm.call @bar(%9) : (!llvm.struct<(i32, i32)>) -> ()
    %11 = llvm.extractvalue %8[1] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    %12 = llvm.extractvalue %11[1] : !llvm.struct<(i32, i32)> 
    llvm.call @bar(%11) : (!llvm.struct<(i32, i32)>) -> ()
    %13 = llvm.insertvalue %10, %0[0] : !llvm.struct<(i32, i32)> 
    %14 = llvm.insertvalue %12, %13[1] : !llvm.struct<(i32, i32)> 
    %15 = llvm.insertvalue %14, %1[1] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    %16 = llvm.extractvalue %15[1, 1] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    llvm.return %16 : i32
  }]

def extract2gep_before := [llvmfunc|
  llvm.func @extract2gep(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<(i16, i32)>]

    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i16, i32)> 
    %3 = llvm.call @baz(%2) : (i32) -> i32
    llvm.store %3, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.cond_br %4, ^bb2, ^bb1
  ^bb2:  // pred: ^bb1
    llvm.return %2 : i32
  }]

def doubleextract2gep_before := [llvmfunc|
  llvm.func @doubleextract2gep(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<(i16, struct<(i32, i16)>)>]

    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i16, struct<(i32, i16)>)> 
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i16)> 
    llvm.return %2 : i16
  }]

def "nogep-multiuse"_before := [llvmfunc|
  llvm.func @"nogep-multiuse"(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<(i32, i32)>]

    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.add %1, %2  : i32
    llvm.return %3 : i32
  }]

def "nogep-volatile"_before := [llvmfunc|
  llvm.func @"nogep-volatile"(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<(i32, i32)>]

    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i32)> 
    llvm.return %1 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(i32, i32)> 
    llvm.call @bar(%2) : (!llvm.struct<(i32, i32)>) -> ()
    %3 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %arg1, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.call @bar(%4) : (!llvm.struct<(i32, i32)>) -> ()
    llvm.return %arg1 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def extract2gep_combined := [llvmfunc|
  llvm.func @extract2gep(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr inbounds %arg0[%0, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(i16, i32)>
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %5 = llvm.call @baz(%4) : (i32) -> i32
    llvm.store %5, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.cond_br %6, ^bb2, ^bb1
  ^bb2:  // pred: ^bb1
    llvm.return %4 : i32
  }]

theorem inst_combine_extract2gep   : extract2gep_before  ⊑  extract2gep_combined := by
  unfold extract2gep_before extract2gep_combined
  simp_alive_peephole
  sorry
def doubleextract2gep_combined := [llvmfunc|
  llvm.func @doubleextract2gep(%arg0: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr inbounds %arg0[%0, 1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(i16, struct<(i32, i16)>)>
    %3 = llvm.load %2 {alignment = 2 : i64} : !llvm.ptr -> i16
    llvm.return %3 : i16
  }]

theorem inst_combine_doubleextract2gep   : doubleextract2gep_before  ⊑  doubleextract2gep_combined := by
  unfold doubleextract2gep_before doubleextract2gep_combined
  simp_alive_peephole
  sorry
def "nogep-multiuse"_combined := [llvmfunc|
  llvm.func @"nogep-multiuse"(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.add %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_"nogep-multiuse"   : "nogep-multiuse"_before  ⊑  "nogep-multiuse"_combined := by
  unfold "nogep-multiuse"_before "nogep-multiuse"_combined
  simp_alive_peephole
  sorry
def "nogep-volatile"_combined := [llvmfunc|
  llvm.func @"nogep-volatile"(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i32)> 
    llvm.return %1 : i32
  }]

theorem inst_combine_"nogep-volatile"   : "nogep-volatile"_before  ⊑  "nogep-volatile"_combined := by
  unfold "nogep-volatile"_before "nogep-volatile"_combined
  simp_alive_peephole
  sorry
