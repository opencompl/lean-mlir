module  {
  llvm.mlir.global external @x() : vector<2xi64>
  llvm.mlir.global external @xx() : !llvm.array<13 x vector<2xi64>>
  llvm.mlir.global external @x.as2() : vector<2xi64>
  llvm.func @static_hem() -> vector<2xi64> {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.addressof @x : !llvm.ptr<vector<2xi64>>
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr<vector<2xi64>>, i32) -> !llvm.ptr<vector<2xi64>>
    %3 = llvm.load %2 : !llvm.ptr<vector<2xi64>>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @hem(%arg0: i32) -> vector<2xi64> {
    %0 = llvm.mlir.addressof @x : !llvm.ptr<vector<2xi64>>
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr<vector<2xi64>>, i32) -> !llvm.ptr<vector<2xi64>>
    %2 = llvm.load %1 : !llvm.ptr<vector<2xi64>>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @hem_2d(%arg0: i32, %arg1: i32) -> vector<2xi64> {
    %0 = llvm.mlir.addressof @xx : !llvm.ptr<array<13 x vector<2xi64>>>
    %1 = llvm.getelementptr %0[%arg0, %arg1] : (!llvm.ptr<array<13 x vector<2xi64>>>, i32, i32) -> !llvm.ptr<vector<2xi64>>
    %2 = llvm.load %1 : !llvm.ptr<vector<2xi64>>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @foo() -> vector<2xi64> {
    %0 = llvm.mlir.addressof @x : !llvm.ptr<vector<2xi64>>
    %1 = llvm.load %0 : !llvm.ptr<vector<2xi64>>
    llvm.return %1 : vector<2xi64>
  }
  llvm.func @bar() -> vector<2xi64> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x vector<2xi64> : (i32) -> !llvm.ptr<vector<2xi64>>
    llvm.call @kip(%1) : (!llvm.ptr<vector<2xi64>>) -> ()
    %2 = llvm.load %1 : !llvm.ptr<vector<2xi64>>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @static_hem_store(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.addressof @x : !llvm.ptr<vector<2xi64>>
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr<vector<2xi64>>, i32) -> !llvm.ptr<vector<2xi64>>
    llvm.store %arg0, %2 : !llvm.ptr<vector<2xi64>>
    llvm.return
  }
  llvm.func @hem_store(%arg0: i32, %arg1: vector<2xi64>) {
    %0 = llvm.mlir.addressof @x : !llvm.ptr<vector<2xi64>>
    %1 = llvm.getelementptr %0[%arg0] : (!llvm.ptr<vector<2xi64>>, i32) -> !llvm.ptr<vector<2xi64>>
    llvm.store %arg1, %1 : !llvm.ptr<vector<2xi64>>
    llvm.return
  }
  llvm.func @hem_2d_store(%arg0: i32, %arg1: i32, %arg2: vector<2xi64>) {
    %0 = llvm.mlir.addressof @xx : !llvm.ptr<array<13 x vector<2xi64>>>
    %1 = llvm.getelementptr %0[%arg0, %arg1] : (!llvm.ptr<array<13 x vector<2xi64>>>, i32, i32) -> !llvm.ptr<vector<2xi64>>
    llvm.store %arg2, %1 : !llvm.ptr<vector<2xi64>>
    llvm.return
  }
  llvm.func @foo_store(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.addressof @x : !llvm.ptr<vector<2xi64>>
    llvm.store %arg0, %0 : !llvm.ptr<vector<2xi64>>
    llvm.return
  }
  llvm.func @bar_store(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x vector<2xi64> : (i32) -> !llvm.ptr<vector<2xi64>>
    llvm.call @kip(%1) : (!llvm.ptr<vector<2xi64>>) -> ()
    llvm.store %arg0, %1 : !llvm.ptr<vector<2xi64>>
    llvm.return
  }
  llvm.func @kip(!llvm.ptr<vector<2xi64>>)
}
