module  {
  llvm.mlir.global private constant @".str"("abc\00")
  llvm.func @_abs(%arg0: i32) -> i32 {
    %0 = llvm.call @abs(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }
  llvm.func @abs(i32) -> i32
  llvm.func @_labs(%arg0: i32) -> i32 {
    %0 = llvm.call @labs(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }
  llvm.func @labs(i32) -> i32
  llvm.func @_strlen1() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr<array<4 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = llvm.call @strlen(%2) : (!llvm.ptr<i8>) -> i32
    llvm.return %3 : i32
  }
  llvm.func @strlen(!llvm.ptr<i8>) -> i32
  llvm.func @_strlen2(%arg0: !llvm.ptr<i8>) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @strlen(%arg0) : (!llvm.ptr<i8>) -> i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }
}
