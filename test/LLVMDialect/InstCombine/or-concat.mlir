module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @concat_bswap32_unary_split(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.intr.bswap(%2)  : (i32) -> i32
    %5 = llvm.intr.bswap(%3)  : (i32) -> i32
    %6 = llvm.zext %4 : i32 to i64
    %7 = llvm.zext %5 : i32 to i64
    %8 = llvm.shl %7, %0 overflow<nuw>  : i64
    %9 = llvm.or %6, %8  : i64
    llvm.return %9 : i64
  }
  llvm.func @concat_bswap32_unary_split_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.lshr %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    %3 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %4 = llvm.intr.bswap(%2)  : (vector<2xi32>) -> vector<2xi32>
    %5 = llvm.intr.bswap(%3)  : (vector<2xi32>) -> vector<2xi32>
    %6 = llvm.zext %4 : vector<2xi32> to vector<2xi64>
    %7 = llvm.zext %5 : vector<2xi32> to vector<2xi64>
    %8 = llvm.shl %7, %0 overflow<nuw>  : vector<2xi64>
    %9 = llvm.or %6, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @concat_bswap32_unary_flip(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.intr.bswap(%2)  : (i32) -> i32
    %5 = llvm.intr.bswap(%3)  : (i32) -> i32
    %6 = llvm.zext %4 : i32 to i64
    %7 = llvm.zext %5 : i32 to i64
    %8 = llvm.shl %6, %0 overflow<nuw>  : i64
    %9 = llvm.or %7, %8  : i64
    llvm.return %9 : i64
  }
  llvm.func @concat_bswap32_unary_flip_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.lshr %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    %3 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %4 = llvm.intr.bswap(%2)  : (vector<2xi32>) -> vector<2xi32>
    %5 = llvm.intr.bswap(%3)  : (vector<2xi32>) -> vector<2xi32>
    %6 = llvm.zext %4 : vector<2xi32> to vector<2xi64>
    %7 = llvm.zext %5 : vector<2xi32> to vector<2xi64>
    %8 = llvm.shl %6, %0 overflow<nuw>  : vector<2xi64>
    %9 = llvm.or %7, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @concat_bswap32_binary(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %2 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %3 = llvm.zext %1 : i32 to i64
    %4 = llvm.zext %2 : i32 to i64
    %5 = llvm.shl %4, %0 overflow<nuw>  : i64
    %6 = llvm.or %3, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @concat_bswap32_binary_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.intr.bswap(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.zext %1 : vector<2xi32> to vector<2xi64>
    %4 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %5 = llvm.shl %4, %0 overflow<nuw>  : vector<2xi64>
    %6 = llvm.or %3, %5  : vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }
  llvm.func @concat_bitreverse32_unary_split(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.intr.bitreverse(%2)  : (i32) -> i32
    %5 = llvm.intr.bitreverse(%3)  : (i32) -> i32
    %6 = llvm.zext %4 : i32 to i64
    %7 = llvm.zext %5 : i32 to i64
    %8 = llvm.shl %7, %0 overflow<nuw>  : i64
    %9 = llvm.or %6, %8  : i64
    llvm.return %9 : i64
  }
  llvm.func @concat_bitreverse32_unary_split_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.lshr %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    %3 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %4 = llvm.intr.bitreverse(%2)  : (vector<2xi32>) -> vector<2xi32>
    %5 = llvm.intr.bitreverse(%3)  : (vector<2xi32>) -> vector<2xi32>
    %6 = llvm.zext %4 : vector<2xi32> to vector<2xi64>
    %7 = llvm.zext %5 : vector<2xi32> to vector<2xi64>
    %8 = llvm.shl %7, %0 overflow<nuw>  : vector<2xi64>
    %9 = llvm.or %6, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @concat_bitreverse32_unary_flip(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.intr.bitreverse(%2)  : (i32) -> i32
    %5 = llvm.intr.bitreverse(%3)  : (i32) -> i32
    %6 = llvm.zext %4 : i32 to i64
    %7 = llvm.zext %5 : i32 to i64
    %8 = llvm.shl %6, %0 overflow<nuw>  : i64
    %9 = llvm.or %7, %8  : i64
    llvm.return %9 : i64
  }
  llvm.func @concat_bitreverse32_unary_flip_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.lshr %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    %3 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %4 = llvm.intr.bitreverse(%2)  : (vector<2xi32>) -> vector<2xi32>
    %5 = llvm.intr.bitreverse(%3)  : (vector<2xi32>) -> vector<2xi32>
    %6 = llvm.zext %4 : vector<2xi32> to vector<2xi64>
    %7 = llvm.zext %5 : vector<2xi32> to vector<2xi64>
    %8 = llvm.shl %6, %0 overflow<nuw>  : vector<2xi64>
    %9 = llvm.or %7, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @concat_bitreverse32_binary(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %2 = llvm.intr.bitreverse(%arg1)  : (i32) -> i32
    %3 = llvm.zext %1 : i32 to i64
    %4 = llvm.zext %2 : i32 to i64
    %5 = llvm.shl %4, %0 overflow<nuw>  : i64
    %6 = llvm.or %3, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @concat_bitreverse32_binary_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.intr.bitreverse(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.intr.bitreverse(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.zext %1 : vector<2xi32> to vector<2xi64>
    %4 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %5 = llvm.shl %4, %0 overflow<nuw>  : vector<2xi64>
    %6 = llvm.or %3, %5  : vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }
}
