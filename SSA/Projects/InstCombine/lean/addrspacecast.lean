import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  addrspacecast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def combine_redundant_addrspacecast_before := [llvmfunc|
  llvm.func @combine_redundant_addrspacecast(%arg0: !llvm.ptr<1>) -> !llvm.ptr attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<3>
    %1 = llvm.addrspacecast %0 : !llvm.ptr<3> to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def combine_redundant_addrspacecast_vector_before := [llvmfunc|
  llvm.func @combine_redundant_addrspacecast_vector(%arg0: !llvm.vec<4 x ptr<1>>) -> !llvm.vec<4 x ptr> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.vec<4 x ptr<1>> to !llvm.vec<4 x ptr<3>>
    %1 = llvm.addrspacecast %0 : !llvm.vec<4 x ptr<3>> to !llvm.vec<4 x ptr>
    llvm.return %1 : !llvm.vec<4 x ptr>
  }]

def combine_redundant_addrspacecast_types_before := [llvmfunc|
  llvm.func @combine_redundant_addrspacecast_types(%arg0: !llvm.ptr<1>) -> !llvm.ptr attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<3>
    %1 = llvm.addrspacecast %0 : !llvm.ptr<3> to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def combine_redundant_addrspacecast_types_vector_before := [llvmfunc|
  llvm.func @combine_redundant_addrspacecast_types_vector(%arg0: !llvm.vec<4 x ptr<1>>) -> !llvm.vec<4 x ptr> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.vec<4 x ptr<1>> to !llvm.vec<4 x ptr<3>>
    %1 = llvm.addrspacecast %0 : !llvm.vec<4 x ptr<3>> to !llvm.vec<4 x ptr>
    llvm.return %1 : !llvm.vec<4 x ptr>
  }]

def combine_addrspacecast_bitcast_1_before := [llvmfunc|
  llvm.func @combine_addrspacecast_bitcast_1(%arg0: !llvm.ptr<1>) -> !llvm.ptr<2> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    llvm.return %0 : !llvm.ptr<2>
  }]

def combine_addrspacecast_bitcast_2_before := [llvmfunc|
  llvm.func @combine_addrspacecast_bitcast_2(%arg0: !llvm.ptr<1>) -> !llvm.ptr<2> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    llvm.return %0 : !llvm.ptr<2>
  }]

def combine_bitcast_addrspacecast_1_before := [llvmfunc|
  llvm.func @combine_bitcast_addrspacecast_1(%arg0: !llvm.ptr<1>) -> !llvm.ptr<2> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    llvm.return %0 : !llvm.ptr<2>
  }]

def combine_bitcast_addrspacecast_2_before := [llvmfunc|
  llvm.func @combine_bitcast_addrspacecast_2(%arg0: !llvm.ptr<1>) -> !llvm.ptr<2> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    llvm.return %0 : !llvm.ptr<2>
  }]

def combine_addrspacecast_types_before := [llvmfunc|
  llvm.func @combine_addrspacecast_types(%arg0: !llvm.ptr<1>) -> !llvm.ptr<2> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    llvm.return %0 : !llvm.ptr<2>
  }]

def combine_addrspacecast_types_vector_before := [llvmfunc|
  llvm.func @combine_addrspacecast_types_vector(%arg0: !llvm.vec<4 x ptr<1>>) -> !llvm.vec<4 x ptr<2>> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.vec<4 x ptr<1>> to !llvm.vec<4 x ptr<2>>
    llvm.return %0 : !llvm.vec<4 x ptr<2>>
  }]

def combine_addrspacecast_types_scalevector_before := [llvmfunc|
  llvm.func @combine_addrspacecast_types_scalevector(%arg0: !llvm.vec<? x 4 x  ptr<1>>) -> !llvm.vec<? x 4 x  ptr<2>> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.vec<? x 4 x  ptr<1>> to !llvm.vec<? x 4 x  ptr<2>>
    llvm.return %0 : !llvm.vec<? x 4 x  ptr<2>>
  }]

def canonicalize_addrspacecast_before := [llvmfunc|
  llvm.func @canonicalize_addrspacecast(%arg0: !llvm.ptr<1>) -> i32 {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr
    %1 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %1 : i32
  }]

def memcpy_addrspacecast_before := [llvmfunc|
  llvm.func @memcpy_addrspacecast() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(48 : i32) : i32
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.constant("\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16") : !llvm.array<60 x i8>
    %4 = llvm.mlir.addressof @const_array : !llvm.ptr<2>
    %5 = llvm.getelementptr inbounds %4[%2, %1] : (!llvm.ptr<2>, i16, i16) -> !llvm.ptr<2>, !llvm.array<60 x i8>
    %6 = llvm.addrspacecast %5 : !llvm.ptr<2> to !llvm.ptr<1>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%9, %6, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i32) -> ()]

    llvm.br ^bb1(%7, %7 : i32, i32)
  ^bb1(%10: i32, %11: i32):  // 2 preds: ^bb0, ^bb1
    %12 = llvm.getelementptr %9[%10] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %13 = llvm.load %12 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %14 = llvm.zext %13 : i8 to i32
    %15 = llvm.add %11, %14  : i32
    %16 = llvm.add %10, %8  : i32
    %17 = llvm.icmp "ne" %10, %0 : i32
    llvm.cond_br %17, ^bb1(%16, %15 : i32, i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %15 : i32
  }]

def constant_fold_null_before := [llvmfunc|
  llvm.func @constant_fold_null() {
    %0 = llvm.mlir.zero : !llvm.ptr<3>
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.addrspacecast %0 : !llvm.ptr<3> to !llvm.ptr<4>
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr<4>]

    llvm.return
  }]

def constant_fold_undef_before := [llvmfunc|
  llvm.func @constant_fold_undef() -> !llvm.ptr<4> {
    %0 = llvm.mlir.undef : !llvm.ptr<3>
    %1 = llvm.addrspacecast %0 : !llvm.ptr<3> to !llvm.ptr<4>
    llvm.return %1 : !llvm.ptr<4>
  }]

def constant_fold_null_vector_before := [llvmfunc|
  llvm.func @constant_fold_null_vector() -> !llvm.vec<4 x ptr<4>> {
    %0 = llvm.mlir.zero : !llvm.ptr<3>
    %1 = llvm.mlir.undef : !llvm.vec<4 x ptr<3>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<4 x ptr<3>>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<4 x ptr<3>>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<4 x ptr<3>>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<4 x ptr<3>>
    %10 = llvm.addrspacecast %9 : !llvm.vec<4 x ptr<3>> to !llvm.vec<4 x ptr<4>>
    llvm.return %10 : !llvm.vec<4 x ptr<4>>
  }]

def constant_fold_inttoptr_before := [llvmfunc|
  llvm.func @constant_fold_inttoptr() {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr<3>
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.addrspacecast %1 : !llvm.ptr<3> to !llvm.ptr<4>
    llvm.store %2, %3 {alignment = 4 : i64} : i32, !llvm.ptr<4>]

    llvm.return
  }]

def constant_fold_gep_inttoptr_before := [llvmfunc|
  llvm.func @constant_fold_gep_inttoptr() {
    %0 = llvm.mlir.constant(1234 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.inttoptr %0 : i32 to !llvm.ptr<3>
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, i32
    %5 = llvm.addrspacecast %4 : !llvm.ptr<3> to !llvm.ptr<4>
    llvm.store %2, %5 {alignment = 4 : i64} : i32, !llvm.ptr<4>]

    llvm.return
  }]

def combine_redundant_addrspacecast_combined := [llvmfunc|
  llvm.func @combine_redundant_addrspacecast(%arg0: !llvm.ptr<1>) -> !llvm.ptr attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_combine_redundant_addrspacecast   : combine_redundant_addrspacecast_before  ⊑  combine_redundant_addrspacecast_combined := by
  unfold combine_redundant_addrspacecast_before combine_redundant_addrspacecast_combined
  simp_alive_peephole
  sorry
def combine_redundant_addrspacecast_vector_combined := [llvmfunc|
  llvm.func @combine_redundant_addrspacecast_vector(%arg0: !llvm.vec<4 x ptr<1>>) -> !llvm.vec<4 x ptr> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.vec<4 x ptr<1>> to !llvm.vec<4 x ptr>
    llvm.return %0 : !llvm.vec<4 x ptr>
  }]

theorem inst_combine_combine_redundant_addrspacecast_vector   : combine_redundant_addrspacecast_vector_before  ⊑  combine_redundant_addrspacecast_vector_combined := by
  unfold combine_redundant_addrspacecast_vector_before combine_redundant_addrspacecast_vector_combined
  simp_alive_peephole
  sorry
def combine_redundant_addrspacecast_types_combined := [llvmfunc|
  llvm.func @combine_redundant_addrspacecast_types(%arg0: !llvm.ptr<1>) -> !llvm.ptr attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_combine_redundant_addrspacecast_types   : combine_redundant_addrspacecast_types_before  ⊑  combine_redundant_addrspacecast_types_combined := by
  unfold combine_redundant_addrspacecast_types_before combine_redundant_addrspacecast_types_combined
  simp_alive_peephole
  sorry
def combine_redundant_addrspacecast_types_vector_combined := [llvmfunc|
  llvm.func @combine_redundant_addrspacecast_types_vector(%arg0: !llvm.vec<4 x ptr<1>>) -> !llvm.vec<4 x ptr> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.vec<4 x ptr<1>> to !llvm.vec<4 x ptr>
    llvm.return %0 : !llvm.vec<4 x ptr>
  }]

theorem inst_combine_combine_redundant_addrspacecast_types_vector   : combine_redundant_addrspacecast_types_vector_before  ⊑  combine_redundant_addrspacecast_types_vector_combined := by
  unfold combine_redundant_addrspacecast_types_vector_before combine_redundant_addrspacecast_types_vector_combined
  simp_alive_peephole
  sorry
def combine_addrspacecast_bitcast_1_combined := [llvmfunc|
  llvm.func @combine_addrspacecast_bitcast_1(%arg0: !llvm.ptr<1>) -> !llvm.ptr<2> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    llvm.return %0 : !llvm.ptr<2>
  }]

theorem inst_combine_combine_addrspacecast_bitcast_1   : combine_addrspacecast_bitcast_1_before  ⊑  combine_addrspacecast_bitcast_1_combined := by
  unfold combine_addrspacecast_bitcast_1_before combine_addrspacecast_bitcast_1_combined
  simp_alive_peephole
  sorry
def combine_addrspacecast_bitcast_2_combined := [llvmfunc|
  llvm.func @combine_addrspacecast_bitcast_2(%arg0: !llvm.ptr<1>) -> !llvm.ptr<2> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    llvm.return %0 : !llvm.ptr<2>
  }]

theorem inst_combine_combine_addrspacecast_bitcast_2   : combine_addrspacecast_bitcast_2_before  ⊑  combine_addrspacecast_bitcast_2_combined := by
  unfold combine_addrspacecast_bitcast_2_before combine_addrspacecast_bitcast_2_combined
  simp_alive_peephole
  sorry
def combine_bitcast_addrspacecast_1_combined := [llvmfunc|
  llvm.func @combine_bitcast_addrspacecast_1(%arg0: !llvm.ptr<1>) -> !llvm.ptr<2> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    llvm.return %0 : !llvm.ptr<2>
  }]

theorem inst_combine_combine_bitcast_addrspacecast_1   : combine_bitcast_addrspacecast_1_before  ⊑  combine_bitcast_addrspacecast_1_combined := by
  unfold combine_bitcast_addrspacecast_1_before combine_bitcast_addrspacecast_1_combined
  simp_alive_peephole
  sorry
def combine_bitcast_addrspacecast_2_combined := [llvmfunc|
  llvm.func @combine_bitcast_addrspacecast_2(%arg0: !llvm.ptr<1>) -> !llvm.ptr<2> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    llvm.return %0 : !llvm.ptr<2>
  }]

theorem inst_combine_combine_bitcast_addrspacecast_2   : combine_bitcast_addrspacecast_2_before  ⊑  combine_bitcast_addrspacecast_2_combined := by
  unfold combine_bitcast_addrspacecast_2_before combine_bitcast_addrspacecast_2_combined
  simp_alive_peephole
  sorry
def combine_addrspacecast_types_combined := [llvmfunc|
  llvm.func @combine_addrspacecast_types(%arg0: !llvm.ptr<1>) -> !llvm.ptr<2> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    llvm.return %0 : !llvm.ptr<2>
  }]

theorem inst_combine_combine_addrspacecast_types   : combine_addrspacecast_types_before  ⊑  combine_addrspacecast_types_combined := by
  unfold combine_addrspacecast_types_before combine_addrspacecast_types_combined
  simp_alive_peephole
  sorry
def combine_addrspacecast_types_vector_combined := [llvmfunc|
  llvm.func @combine_addrspacecast_types_vector(%arg0: !llvm.vec<4 x ptr<1>>) -> !llvm.vec<4 x ptr<2>> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.vec<4 x ptr<1>> to !llvm.vec<4 x ptr<2>>
    llvm.return %0 : !llvm.vec<4 x ptr<2>>
  }]

theorem inst_combine_combine_addrspacecast_types_vector   : combine_addrspacecast_types_vector_before  ⊑  combine_addrspacecast_types_vector_combined := by
  unfold combine_addrspacecast_types_vector_before combine_addrspacecast_types_vector_combined
  simp_alive_peephole
  sorry
def combine_addrspacecast_types_scalevector_combined := [llvmfunc|
  llvm.func @combine_addrspacecast_types_scalevector(%arg0: !llvm.vec<? x 4 x  ptr<1>>) -> !llvm.vec<? x 4 x  ptr<2>> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.vec<? x 4 x  ptr<1>> to !llvm.vec<? x 4 x  ptr<2>>
    llvm.return %0 : !llvm.vec<? x 4 x  ptr<2>>
  }]

theorem inst_combine_combine_addrspacecast_types_scalevector   : combine_addrspacecast_types_scalevector_before  ⊑  combine_addrspacecast_types_scalevector_combined := by
  unfold combine_addrspacecast_types_scalevector_before combine_addrspacecast_types_scalevector_combined
  simp_alive_peephole
  sorry
def canonicalize_addrspacecast_combined := [llvmfunc|
  llvm.func @canonicalize_addrspacecast(%arg0: !llvm.ptr<1>) -> i32 {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr
    %1 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_canonicalize_addrspacecast   : canonicalize_addrspacecast_before  ⊑  canonicalize_addrspacecast_combined := by
  unfold canonicalize_addrspacecast_before canonicalize_addrspacecast_combined
  simp_alive_peephole
  sorry
def memcpy_addrspacecast_combined := [llvmfunc|
  llvm.func @memcpy_addrspacecast() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.constant("\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16") : !llvm.array<60 x i8>
    %4 = llvm.mlir.addressof @const_array : !llvm.ptr<2>
    %5 = llvm.getelementptr inbounds %4[%2, %1] : (!llvm.ptr<2>, i16, i16) -> !llvm.ptr<2>, !llvm.array<60 x i8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.constant(48 : i32) : i32
    llvm.br ^bb1(%0, %0 : i32, i32)
  ^bb1(%8: i32, %9: i32):  // 2 preds: ^bb0, ^bb1
    %10 = llvm.trunc %8 : i32 to i16
    %11 = llvm.getelementptr %5[%10] : (!llvm.ptr<2>, i16) -> !llvm.ptr<2>, i8
    %12 = llvm.load %11 {alignment = 1 : i64} : !llvm.ptr<2> -> i8
    %13 = llvm.zext %12 : i8 to i32
    %14 = llvm.add %9, %13  : i32
    %15 = llvm.add %8, %6  : i32
    %16 = llvm.icmp "eq" %8, %7 : i32
    llvm.cond_br %16, ^bb2, ^bb1(%15, %14 : i32, i32)
  ^bb2:  // pred: ^bb1
    llvm.return %14 : i32
  }]

theorem inst_combine_memcpy_addrspacecast   : memcpy_addrspacecast_before  ⊑  memcpy_addrspacecast_combined := by
  unfold memcpy_addrspacecast_before memcpy_addrspacecast_combined
  simp_alive_peephole
  sorry
def constant_fold_null_combined := [llvmfunc|
  llvm.func @constant_fold_null() {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr<3>
    %2 = llvm.addrspacecast %1 : !llvm.ptr<3> to !llvm.ptr<4>
    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr<4>
    llvm.return
  }]

theorem inst_combine_constant_fold_null   : constant_fold_null_before  ⊑  constant_fold_null_combined := by
  unfold constant_fold_null_before constant_fold_null_combined
  simp_alive_peephole
  sorry
def constant_fold_undef_combined := [llvmfunc|
  llvm.func @constant_fold_undef() -> !llvm.ptr<4> {
    %0 = llvm.mlir.undef : !llvm.ptr<4>
    llvm.return %0 : !llvm.ptr<4>
  }]

theorem inst_combine_constant_fold_undef   : constant_fold_undef_before  ⊑  constant_fold_undef_combined := by
  unfold constant_fold_undef_before constant_fold_undef_combined
  simp_alive_peephole
  sorry
def constant_fold_null_vector_combined := [llvmfunc|
  llvm.func @constant_fold_null_vector() -> !llvm.vec<4 x ptr<4>> {
    %0 = llvm.mlir.zero : !llvm.ptr<3>
    %1 = llvm.mlir.undef : !llvm.vec<4 x ptr<3>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<4 x ptr<3>>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<4 x ptr<3>>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<4 x ptr<3>>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<4 x ptr<3>>
    %10 = llvm.addrspacecast %9 : !llvm.vec<4 x ptr<3>> to !llvm.vec<4 x ptr<4>>
    llvm.return %10 : !llvm.vec<4 x ptr<4>>
  }]

theorem inst_combine_constant_fold_null_vector   : constant_fold_null_vector_before  ⊑  constant_fold_null_vector_combined := by
  unfold constant_fold_null_vector_before constant_fold_null_vector_combined
  simp_alive_peephole
  sorry
def constant_fold_inttoptr_combined := [llvmfunc|
  llvm.func @constant_fold_inttoptr() {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.inttoptr %1 : i32 to !llvm.ptr<3>
    %3 = llvm.addrspacecast %2 : !llvm.ptr<3> to !llvm.ptr<4>
    llvm.store %0, %3 {alignment = 4 : i64} : i32, !llvm.ptr<4>
    llvm.return
  }]

theorem inst_combine_constant_fold_inttoptr   : constant_fold_inttoptr_before  ⊑  constant_fold_inttoptr_combined := by
  unfold constant_fold_inttoptr_before constant_fold_inttoptr_combined
  simp_alive_peephole
  sorry
def constant_fold_gep_inttoptr_combined := [llvmfunc|
  llvm.func @constant_fold_gep_inttoptr() {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(1274 : i64) : i64
    %2 = llvm.inttoptr %1 : i64 to !llvm.ptr<3>
    %3 = llvm.addrspacecast %2 : !llvm.ptr<3> to !llvm.ptr<4>
    llvm.store %0, %3 {alignment = 4 : i64} : i32, !llvm.ptr<4>
    llvm.return
  }]

theorem inst_combine_constant_fold_gep_inttoptr   : constant_fold_gep_inttoptr_before  ⊑  constant_fold_gep_inttoptr_combined := by
  unfold constant_fold_gep_inttoptr_before constant_fold_gep_inttoptr_combined
  simp_alive_peephole
  sorry
