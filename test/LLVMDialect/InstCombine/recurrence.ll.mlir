module  {
  llvm.func @test_or(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%1: i64):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.or %1, %0  : i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.br ^bb1(%2 : i64)
  }
  llvm.func @test_or2(%arg0: i64, %arg1: i64) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.or %0, %arg1  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.br ^bb1(%1 : i64)
  }
  llvm.func @test_or3(%arg0: i64, %arg1: i64) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.or %arg1, %0  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.br ^bb1(%1 : i64)
  }
  llvm.func @test_or4(%arg0: i64, %arg1: !llvm.ptr<i64>) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.load %arg1 : !llvm.ptr<i64>
    %2 = llvm.or %0, %1  : i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.br ^bb1(%2 : i64)
  }
  llvm.func @test_and(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%1: i64):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.and %1, %0  : i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.br ^bb1(%2 : i64)
  }
  llvm.func @test_and2(%arg0: i64, %arg1: i64) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.and %0, %arg1  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.br ^bb1(%1 : i64)
  }
  llvm.func @test_and3(%arg0: i64, %arg1: i64) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.and %arg1, %0  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.br ^bb1(%1 : i64)
  }
  llvm.func @test_and4(%arg0: i64, %arg1: !llvm.ptr<i64>) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.load %arg1 : !llvm.ptr<i64>
    %2 = llvm.and %0, %1  : i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.br ^bb1(%2 : i64)
  }
  llvm.func @use(i64)
}
