module  {
  llvm.func @f_0() -> !llvm.ptr<i8, 4> {
    %0 = llvm.mlir.constant(50 : i64) : i64
    %1 = llvm.mlir.null : !llvm.ptr<i8, 4>
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr<i8, 4>, i64) -> !llvm.ptr<i8, 4>
    llvm.return %2 : !llvm.ptr<i8, 4>
  }
  llvm.func @f_1() -> !llvm.ptr<i8, 3> {
    %0 = llvm.mlir.constant(50 : i64) : i64
    %1 = llvm.mlir.null : !llvm.ptr<i8, 3>
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr<i8, 3>, i64) -> !llvm.ptr<i8, 3>
    llvm.return %2 : !llvm.ptr<i8, 3>
  }
  llvm.func @f_2(%arg0: !llvm.ptr<ptr<i8, 4>>, %arg1: !llvm.ptr<ptr<i8, 4>>) {
    %0 = llvm.load %arg0 : !llvm.ptr<ptr<i8, 4>>
    llvm.store %0, %arg1 : !llvm.ptr<ptr<i8, 4>>
    llvm.return
  }
  llvm.func @f_3(%arg0: !llvm.ptr<ptr<i8, 3>>, %arg1: !llvm.ptr<ptr<i8, 3>>) {
    %0 = llvm.load %arg0 : !llvm.ptr<ptr<i8, 3>>
    llvm.store %0, %arg1 : !llvm.ptr<ptr<i8, 3>>
    llvm.return
  }
  llvm.func @g(%arg0: !llvm.ptr<ptr<i8, 4>>) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.load %arg0 : !llvm.ptr<ptr<i8, 4>>
    %2 = llvm.call @alloc() : () -> !llvm.ptr<i8, 4>
    %3 = llvm.addrspacecast %2 : !llvm.ptr<i8, 4> to !llvm.ptr<i8>
    %4 = llvm.bitcast %3 : !llvm.ptr<i8> to !llvm.ptr<ptr<i8, 4>>
    %5 = llvm.getelementptr %4[%0] : (!llvm.ptr<ptr<i8, 4>>, i64) -> !llvm.ptr<ptr<i8, 4>>
    llvm.store %1, %5 : !llvm.ptr<ptr<i8, 4>>
    %6 = llvm.bitcast %5 : !llvm.ptr<ptr<i8, 4>> to !llvm.ptr<i64>
    %7 = llvm.load %6 : !llvm.ptr<i64>
    llvm.return %7 : i64
  }
  llvm.func @g2(%arg0: !llvm.ptr<ptr<i8>, 4>) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.load %arg0 : !llvm.ptr<ptr<i8>, 4>
    %2 = llvm.call @alloc() : () -> !llvm.ptr<i8, 4>
    %3 = llvm.bitcast %2 : !llvm.ptr<i8, 4> to !llvm.ptr<ptr<i8>, 4>
    %4 = llvm.getelementptr %3[%0] : (!llvm.ptr<ptr<i8>, 4>, i64) -> !llvm.ptr<ptr<i8>, 4>
    llvm.store %1, %4 : !llvm.ptr<ptr<i8>, 4>
    %5 = llvm.bitcast %4 : !llvm.ptr<ptr<i8>, 4> to !llvm.ptr<i64, 4>
    %6 = llvm.load %5 : !llvm.ptr<i64, 4>
    llvm.return %6 : i64
  }
  llvm.func @alloc() -> !llvm.ptr<i8, 4>
  llvm.func @f_4(%arg0: !llvm.ptr<i8, 4>) -> i64 {
    %0 = llvm.mlir.addressof @f_5 : !llvm.ptr<func<i64 (i64)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<i64 (i64)>> to !llvm.ptr<func<i64 (ptr<i8, 4>)>>
    %2 = llvm.call %1(%arg0) : (!llvm.ptr<i8, 4>) -> i64
    llvm.return %2 : i64
  }
  llvm.func @f_5(i64) -> i64
}
