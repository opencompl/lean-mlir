module  {
  llvm.mlir.global private constant @charbuf("\00\00\00\01")
  llvm.mlir.global private constant @intbuf_unaligned(dense<[1, 2, 3, 4]> : tensor<4xi16>) : !llvm.array<4 x i16>
  llvm.mlir.global private constant @intbuf(dense<[0, 1]> : tensor<2xi32>) : !llvm.array<2 x i32>
  llvm.func @memcmp(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
  llvm.func @memcmp_4bytes_unaligned_constant_i8(%arg0: !llvm.ptr<i8>) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @charbuf : !llvm.ptr<array<4 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @memcmp(%arg0, %4, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %6 = llvm.icmp "eq" %5, %0 : i32
    llvm.return %6 : i1
  }
  llvm.func @memcmp_4bytes_unaligned_constant_i16(%arg0: !llvm.ptr<i8>) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.addressof @intbuf_unaligned : !llvm.ptr<array<4 x i16>>
    %3 = llvm.bitcast %2 : !llvm.ptr<array<4 x i16>> to !llvm.ptr<i8>
    %4 = llvm.call @memcmp(%3, %arg0, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    llvm.return %5 : i1
  }
  llvm.func @memcmp_3bytes_aligned_constant_i32(%arg0: !llvm.ptr<i8>) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.addressof @intbuf : !llvm.ptr<array<2 x i32>>
    %3 = llvm.bitcast %2 : !llvm.ptr<array<2 x i32>> to !llvm.ptr<i8>
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.mlir.addressof @intbuf : !llvm.ptr<array<2 x i32>>
    %7 = llvm.getelementptr %6[%5, %4] : (!llvm.ptr<array<2 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %8 = llvm.bitcast %7 : !llvm.ptr<i32> to !llvm.ptr<i8>
    %9 = llvm.call @memcmp(%8, %3, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %10 = llvm.icmp "eq" %9, %0 : i32
    llvm.return %10 : i1
  }
  llvm.func @memcmp_4bytes_one_unaligned_i8(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.bitcast %arg0 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %3 = llvm.load %2 : !llvm.ptr<i32>
    %4 = llvm.call @memcmp(%arg0, %arg1, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    llvm.return %5 : i1
  }
}
