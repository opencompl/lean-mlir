module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @dummy()
  llvm.func @br_true(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.or %arg0, %0  : i1
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%2 : i32)
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%1 : i32)
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %4 : i32
  }
  llvm.func @br_false(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i1
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%2 : i32)
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%1 : i32)
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %4 : i32
  }
  llvm.func @br_undef(%arg0: i1) -> i32 {
    %0 = llvm.mlir.undef : i1
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.xor %arg0, %0  : i1
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%2 : i32)
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%1 : i32)
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %4 : i32
  }
  llvm.func @br_true_phi_with_repeated_preds(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.or %arg0, %0  : i1
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%3 : i32)
  ^bb2:  // pred: ^bb0
    llvm.cond_br %2, ^bb3(%1 : i32), ^bb3(%1 : i32)
  ^bb3(%5: i32):  // 3 preds: ^bb1, ^bb2, ^bb2
    llvm.return %5 : i32
  }
  llvm.func @br_true_const_phi_direct_edge(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(2 : i32) : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%2 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }
  llvm.func @br_true_var_phi_direct_edge(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.or %arg0, %0  : i1
    llvm.cond_br %3, ^bb1, ^bb2(%1 : i32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%2 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @switch_case(%arg0: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.switch %1 : i32, ^bb2 [
      0: ^bb1
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  }
  llvm.func @switch_default(%arg0: i32) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    llvm.switch %1 : i32, ^bb2 [
      0: ^bb1
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  }
  llvm.func @switch_undef(%arg0: i32) {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.switch %1 : i32, ^bb2 [
      0: ^bb1
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  }
  llvm.func @non_term_unreachable() {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : !llvm.ptr
    llvm.call @dummy() : () -> ()
    llvm.call @dummy() : () -> ()
    llvm.store %0, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.call @dummy() : () -> ()
    llvm.return
  }
  llvm.func @non_term_unreachable_phi(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.poison : !llvm.ptr
    %3 = llvm.mlir.constant(1 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    llvm.store %1, %2 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @non_term_unreachable_following_blocks() {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : !llvm.ptr
    llvm.call @dummy() : () -> ()
    llvm.store %0, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.call @dummy() : () -> ()
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb1, ^bb2
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  }
  llvm.func @br_not_into_loop(%arg0: i1) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg0, %0  : i1
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.call @dummy() : () -> ()
    llvm.br ^bb1
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  }
  llvm.func @br_into_loop(%arg0: i1) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg0, %0  : i1
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.call @dummy() : () -> ()
    llvm.br ^bb1
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  }
  llvm.func @two_br_not_into_loop(%arg0: i1) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg0, %0  : i1
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.or %arg0, %0  : i1
    llvm.cond_br %2, ^bb3, ^bb2
  ^bb2:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb3:  // pred: ^bb1
    llvm.call @dummy() : () -> ()
    llvm.return
  }
  llvm.func @one_br_into_loop_one_not(%arg0: i1, %arg1: i1) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg0, %0  : i1
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb3, ^bb2
  ^bb2:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb3:  // pred: ^bb1
    llvm.call @dummy() : () -> ()
    llvm.return
  }
  llvm.func @two_br_not_into_loop_with_split(%arg0: i1) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg0, %0  : i1
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.or %arg0, %0  : i1
    llvm.cond_br %2, ^bb5, ^bb3
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb4
  ^bb3:  // pred: ^bb1
    llvm.call @dummy() : () -> ()
    llvm.br ^bb4
  ^bb4:  // 3 preds: ^bb2, ^bb3, ^bb4
    llvm.call @dummy() : () -> ()
    llvm.br ^bb4
  ^bb5:  // pred: ^bb1
    llvm.call @dummy() : () -> ()
    llvm.return
  }
  llvm.func @irreducible() {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb2
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.call @dummy() : () -> ()
    llvm.cond_br %1, ^bb3, ^bb1
  ^bb3:  // pred: ^bb2
    llvm.call @dummy() : () -> ()
    llvm.return
  }
  llvm.func @really_unreachable() {
    llvm.return
  }
  llvm.func @really_unreachable_predecessor() {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.return
  }
  llvm.func @pr64235() -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    "llvm.intr.assume"(%0) : (i1) -> ()
    llvm.br ^bb3
  ^bb2:  // 2 preds: ^bb0, ^bb3
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    "llvm.intr.assume"(%0) : (i1) -> ()
    llvm.br ^bb2
  }
  llvm.func @invoke(!llvm.ptr)
  llvm.func @__gxx_personality_v0(...) -> i32
  llvm.func @test(%arg0: i1) attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.ptr
    %2 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb5
  ^bb1:  // pred: ^bb0
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.invoke @invoke(%2) to ^bb2 unwind ^bb3 : (!llvm.ptr) -> ()
  ^bb2:  // pred: ^bb1
    llvm.invoke @invoke(%2) to ^bb5 unwind ^bb4 : (!llvm.ptr) -> ()
  ^bb3:  // pred: ^bb1
    %3 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.br ^bb5
  ^bb4:  // pred: ^bb2
    %4 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.br ^bb6
  ^bb5:  // 3 preds: ^bb0, ^bb2, ^bb3
    llvm.return
  ^bb6:  // pred: ^bb4
    llvm.return
  }
}
