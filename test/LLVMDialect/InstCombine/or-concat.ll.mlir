module  {
  llvm.func @concat_bswap32_unary_split(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.call @llvm.bswap.i32(%2) : (i32) -> i32
    %5 = llvm.call @llvm.bswap.i32(%3) : (i32) -> i32
    %6 = llvm.zext %4 : i32 to i64
    %7 = llvm.zext %5 : i32 to i64
    %8 = llvm.shl %7, %0  : i64
    %9 = llvm.or %6, %8  : i64
    llvm.return %9 : i64
  }
  llvm.func @concat_bswap32_unary_split_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.lshr %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    %3 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %4 = llvm.call @llvm.bswap.v2i32(%2) : (vector<2xi32>) -> vector<2xi32>
    %5 = llvm.call @llvm.bswap.v2i32(%3) : (vector<2xi32>) -> vector<2xi32>
    %6 = llvm.zext %4 : vector<2xi32> to vector<2xi64>
    %7 = llvm.zext %5 : vector<2xi32> to vector<2xi64>
    %8 = llvm.shl %7, %0  : vector<2xi64>
    %9 = llvm.or %6, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @concat_bswap32_unary_flip(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.call @llvm.bswap.i32(%2) : (i32) -> i32
    %5 = llvm.call @llvm.bswap.i32(%3) : (i32) -> i32
    %6 = llvm.zext %4 : i32 to i64
    %7 = llvm.zext %5 : i32 to i64
    %8 = llvm.shl %6, %0  : i64
    %9 = llvm.or %7, %8  : i64
    llvm.return %9 : i64
  }
  llvm.func @concat_bswap32_unary_flip_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.lshr %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    %3 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %4 = llvm.call @llvm.bswap.v2i32(%2) : (vector<2xi32>) -> vector<2xi32>
    %5 = llvm.call @llvm.bswap.v2i32(%3) : (vector<2xi32>) -> vector<2xi32>
    %6 = llvm.zext %4 : vector<2xi32> to vector<2xi64>
    %7 = llvm.zext %5 : vector<2xi32> to vector<2xi64>
    %8 = llvm.shl %6, %0  : vector<2xi64>
    %9 = llvm.or %7, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @concat_bswap32_binary(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.call @llvm.bswap.i32(%arg0) : (i32) -> i32
    %2 = llvm.call @llvm.bswap.i32(%arg1) : (i32) -> i32
    %3 = llvm.zext %1 : i32 to i64
    %4 = llvm.zext %2 : i32 to i64
    %5 = llvm.shl %4, %0  : i64
    %6 = llvm.or %3, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @concat_bswap32_binary_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.call @llvm.bswap.v2i32(%arg0) : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.call @llvm.bswap.v2i32(%arg1) : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.zext %1 : vector<2xi32> to vector<2xi64>
    %4 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %5 = llvm.shl %4, %0  : vector<2xi64>
    %6 = llvm.or %3, %5  : vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }
  llvm.func @llvm.bswap.i32(i32) -> i32
  llvm.func @llvm.bswap.v2i32(vector<2xi32>) -> vector<2xi32>
  llvm.func @concat_bitreverse32_unary_split(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.call @llvm.bitreverse.i32(%2) : (i32) -> i32
    %5 = llvm.call @llvm.bitreverse.i32(%3) : (i32) -> i32
    %6 = llvm.zext %4 : i32 to i64
    %7 = llvm.zext %5 : i32 to i64
    %8 = llvm.shl %7, %0  : i64
    %9 = llvm.or %6, %8  : i64
    llvm.return %9 : i64
  }
  llvm.func @concat_bitreverse32_unary_split_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.lshr %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    %3 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %4 = llvm.call @llvm.bitreverse.v2i32(%2) : (vector<2xi32>) -> vector<2xi32>
    %5 = llvm.call @llvm.bitreverse.v2i32(%3) : (vector<2xi32>) -> vector<2xi32>
    %6 = llvm.zext %4 : vector<2xi32> to vector<2xi64>
    %7 = llvm.zext %5 : vector<2xi32> to vector<2xi64>
    %8 = llvm.shl %7, %0  : vector<2xi64>
    %9 = llvm.or %6, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @concat_bitreverse32_unary_flip(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.call @llvm.bitreverse.i32(%2) : (i32) -> i32
    %5 = llvm.call @llvm.bitreverse.i32(%3) : (i32) -> i32
    %6 = llvm.zext %4 : i32 to i64
    %7 = llvm.zext %5 : i32 to i64
    %8 = llvm.shl %6, %0  : i64
    %9 = llvm.or %7, %8  : i64
    llvm.return %9 : i64
  }
  llvm.func @concat_bitreverse32_unary_flip_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.lshr %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    %3 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %4 = llvm.call @llvm.bitreverse.v2i32(%2) : (vector<2xi32>) -> vector<2xi32>
    %5 = llvm.call @llvm.bitreverse.v2i32(%3) : (vector<2xi32>) -> vector<2xi32>
    %6 = llvm.zext %4 : vector<2xi32> to vector<2xi64>
    %7 = llvm.zext %5 : vector<2xi32> to vector<2xi64>
    %8 = llvm.shl %6, %0  : vector<2xi64>
    %9 = llvm.or %7, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @concat_bitreverse32_binary(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.call @llvm.bitreverse.i32(%arg0) : (i32) -> i32
    %2 = llvm.call @llvm.bitreverse.i32(%arg1) : (i32) -> i32
    %3 = llvm.zext %1 : i32 to i64
    %4 = llvm.zext %2 : i32 to i64
    %5 = llvm.shl %4, %0  : i64
    %6 = llvm.or %3, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @concat_bitreverse32_binary_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.call @llvm.bitreverse.v2i32(%arg0) : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.call @llvm.bitreverse.v2i32(%arg1) : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.zext %1 : vector<2xi32> to vector<2xi64>
    %4 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %5 = llvm.shl %4, %0  : vector<2xi64>
    %6 = llvm.or %3, %5  : vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }
  llvm.func @llvm.bitreverse.i32(i32) -> i32
  llvm.func @llvm.bitreverse.v2i32(vector<2xi32>) -> vector<2xi32>
}
