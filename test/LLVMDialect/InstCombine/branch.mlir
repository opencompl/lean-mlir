module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @global(0 : i8) {addr_space = 0 : i32} : i8
  llvm.func @use(i1)
  llvm.func @test(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.cond_br %1, ^bb1, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb0
    llvm.return %arg0 : i32
  }
  llvm.func @pat(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(27 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.addressof @global : !llvm.ptr
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    %4 = llvm.icmp "eq" %0, %3 : i32
    llvm.cond_br %4, ^bb1, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb0
    llvm.return %arg0 : i32
  }
  llvm.func @test01(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i1)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i1)
  ^bb3(%2: i1):  // 2 preds: ^bb1, ^bb2
    llvm.cond_br %2, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    llvm.br ^bb6(%1 : i1)
  ^bb5:  // pred: ^bb3
    llvm.br ^bb6(%0 : i1)
  ^bb6(%3: i1):  // 2 preds: ^bb4, ^bb5
    llvm.return %3 : i1
  }
  llvm.func @test02(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i1)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i1)
  ^bb3(%2: i1):  // 2 preds: ^bb1, ^bb2
    llvm.cond_br %2, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    llvm.br ^bb6(%1 : i1)
  ^bb5:  // pred: ^bb3
    llvm.br ^bb6(%0 : i1)
  ^bb6(%3: i1):  // 2 preds: ^bb4, ^bb5
    llvm.return %3 : i1
  }
  llvm.func @logical_and_not(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.xor %arg1, %0  : i1
    %5 = llvm.select %arg0, %4, %1 : i1, i1
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }
  llvm.func @logical_and_or(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }
  llvm.func @logical_or_not(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.select %3, %0, %arg1 : i1, i1
    llvm.cond_br %4, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }
  llvm.func @logical_and_not_use1(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.select %arg0, %4, %1 : i1, i1
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }
  llvm.func @logical_and_not_use2(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.xor %arg1, %0  : i1
    %5 = llvm.select %arg0, %4, %1 : i1, i1
    llvm.call @use(%5) : (i1) -> ()
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }
}
