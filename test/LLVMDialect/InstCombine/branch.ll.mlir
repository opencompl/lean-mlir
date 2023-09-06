module  {
  llvm.mlir.global external @global(0 : i8) : i8
  llvm.func @test(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.cond_br %1, ^bb1, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb0
    llvm.return %arg0 : i32
  }
  llvm.func @pat(%arg0: i32) -> i32 {
    %0 = llvm.mlir.addressof @global : !llvm.ptr<i8>
    %1 = llvm.ptrtoint %0 : !llvm.ptr<i8> to i32
    %2 = llvm.mlir.constant(27 : i32) : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.cond_br %3, ^bb1, ^bb1
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
}
