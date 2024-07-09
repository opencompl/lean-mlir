module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(%arg0: !llvm.ptr {llvm.nocapture, llvm.writeonly}) -> i32 {
    %0 = llvm.call @baz() : () -> i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %1 = llvm.call @baz() : () -> i32
    llvm.return %1 : i32
  }
  llvm.func @baz() -> i32
  llvm.func @test() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.intr.lifetime.start 4, %2 : !llvm.ptr
    %4 = llvm.call @foo(%2) : (!llvm.ptr) -> i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb5(%1 : i32)
  ^bb1:  // pred: ^bb0
    llvm.intr.lifetime.start 4, %3 : !llvm.ptr
    %6 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.call @foo(%3) : (!llvm.ptr) -> i32
    llvm.cond_br %7, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %9 = llvm.call @bar() : () -> i32
    llvm.br ^bb4(%9 : i32)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%8 : i32)
  ^bb4(%10: i32):  // 2 preds: ^bb2, ^bb3
    llvm.intr.lifetime.end 4, %3 : !llvm.ptr
    llvm.br ^bb5(%10 : i32)
  ^bb5(%11: i32):  // 2 preds: ^bb0, ^bb4
    llvm.intr.lifetime.end 4, %2 : !llvm.ptr
    llvm.return %11 : i32
  }
  llvm.func @unknown(!llvm.ptr) -> i32
  llvm.func @unknown.as2(!llvm.ptr<2>) -> i32
  llvm.func @sink_write_to_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }
  llvm.func @sink_readwrite_to_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }
  llvm.func @sink_bitcast(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i8 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }
  llvm.func @sink_gep1(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %4 = llvm.call @unknown(%3) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %4 : i32
  }
  llvm.func @sink_gep2(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }
  llvm.func @sink_addrspacecast(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.addrspacecast %2 : !llvm.ptr to !llvm.ptr<2>
    %4 = llvm.call @unknown.as2(%3) : (!llvm.ptr<2>) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %4 : i32
  }
  llvm.func @neg_infinite_loop(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }
  llvm.func @neg_throw(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }
  llvm.func @neg_unknown_write(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }
  llvm.func @sink_lifetime1(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.intr.lifetime.start 4, %2 : !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.intr.lifetime.end 4, %2 : !llvm.ptr
    llvm.return %3 : i32
  }
  llvm.func @sink_lifetime2(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.intr.lifetime.start 4, %2 : !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1(%1 : i32), ^bb2
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb2
    llvm.intr.lifetime.end 4, %2 : !llvm.ptr
    llvm.return %4 : i32
  ^bb2:  // pred: ^bb0
    llvm.br ^bb1(%3 : i32)
  }
  llvm.func @sink_lifetime3(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.intr.lifetime.start 4, %2 : !llvm.ptr
    llvm.intr.lifetime.end 4, %2 : !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }
  llvm.func @sink_lifetime4a(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.intr.lifetime.start 4, %2 : !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.intr.lifetime.end 4, %2 : !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }
  llvm.func @sink_lifetime4b(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.intr.lifetime.start 4, %2 : !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.intr.lifetime.end 4, %2 : !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }
  llvm.func @sink_atomicrmw_to_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.atomicrmw add %2, %0 seq_cst {alignment = 4 : i64} : !llvm.ptr, i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }
  llvm.func @bar() -> i32
}
