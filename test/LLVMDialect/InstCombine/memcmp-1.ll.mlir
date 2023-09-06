module  {
  llvm.mlir.global external constant @foo("foo\00")
  llvm.mlir.global external constant @hel("hel\00")
  llvm.mlir.global external constant @hello_u("hello_u\00")
  llvm.func @memcmp(!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
  llvm.func @test_simplify1(%arg0: !llvm.ptr<i8>, %arg1: i32) -> i32 {
    %0 = llvm.call @memcmp(%arg0, %arg0, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    llvm.return %0 : i32
  }
  llvm.func @test_simplify2(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify3(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify4() -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.addressof @hello_u : !llvm.ptr<array<8 x i8>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @hel : !llvm.ptr<array<4 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.getelementptr %1[%2, %2] : (!llvm.ptr<array<8 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.call @memcmp(%4, %5, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    llvm.return %6 : i32
  }
  llvm.func @test_simplify5() -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.addressof @foo : !llvm.ptr<array<4 x i8>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @hel : !llvm.ptr<array<4 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.getelementptr %1[%2, %2] : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.call @memcmp(%4, %5, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    llvm.return %6 : i32
  }
  llvm.func @test_simplify6() -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.addressof @hel : !llvm.ptr<array<4 x i8>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @foo : !llvm.ptr<array<4 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.getelementptr %1[%2, %2] : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.call @memcmp(%4, %5, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    llvm.return %6 : i32
  }
  llvm.func @test_simplify7(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x i64 : (i32) -> !llvm.ptr<i64>
    %4 = llvm.alloca %2 x i64 : (i32) -> !llvm.ptr<i64>
    llvm.store %arg0, %3 : !llvm.ptr<i64>
    llvm.store %arg1, %4 : !llvm.ptr<i64>
    %5 = llvm.bitcast %3 : !llvm.ptr<i64> to !llvm.ptr<i8>
    %6 = llvm.bitcast %4 : !llvm.ptr<i64> to !llvm.ptr<i8>
    %7 = llvm.call @memcmp(%5, %6, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    %8 = llvm.icmp "eq" %7, %0 : i32
    llvm.return %8 : i1
  }
  llvm.func @test_simplify8(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x i32 : (i32) -> !llvm.ptr<i32>
    %4 = llvm.alloca %2 x i32 : (i32) -> !llvm.ptr<i32>
    llvm.store %arg0, %3 : !llvm.ptr<i32>
    llvm.store %arg1, %4 : !llvm.ptr<i32>
    %5 = llvm.bitcast %3 : !llvm.ptr<i32> to !llvm.ptr<i8>
    %6 = llvm.bitcast %4 : !llvm.ptr<i32> to !llvm.ptr<i8>
    %7 = llvm.call @memcmp(%5, %6, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    %8 = llvm.icmp "eq" %7, %0 : i32
    llvm.return %8 : i1
  }
  llvm.func @test_simplify9(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x i16 : (i32) -> !llvm.ptr<i16>
    %4 = llvm.alloca %2 x i16 : (i32) -> !llvm.ptr<i16>
    llvm.store %arg0, %3 : !llvm.ptr<i16>
    llvm.store %arg1, %4 : !llvm.ptr<i16>
    %5 = llvm.bitcast %3 : !llvm.ptr<i16> to !llvm.ptr<i8>
    %6 = llvm.bitcast %4 : !llvm.ptr<i16> to !llvm.ptr<i8>
    %7 = llvm.call @memcmp(%5, %6, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    %8 = llvm.icmp "eq" %7, %0 : i32
    llvm.return %8 : i1
  }
  llvm.func @test_simplify10(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @memcmp(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
}
