module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @neg_mask1_lshr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.lshr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.sub %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @sub_mask1_lshr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.and %2, %0  : i8
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @neg_mask1_lshr_vector_uniform(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.lshr %arg0, %0  : vector<4xi32>
    %5 = llvm.and %4, %1  : vector<4xi32>
    %6 = llvm.sub %3, %5  : vector<4xi32>
    llvm.return %6 : vector<4xi32>
  }
  llvm.func @neg_mask1_lshr_vector_nonuniform(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[3, 4, 5, 6]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.lshr %arg0, %0  : vector<4xi32>
    %5 = llvm.and %4, %1  : vector<4xi32>
    %6 = llvm.sub %3, %5  : vector<4xi32>
    llvm.return %6 : vector<4xi32>
  }
  llvm.func @sub_mask1_lshr_vector_nonuniform(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[3, 4, 5, 6]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<[5, 0, -1, 65556]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.lshr %arg0, %0  : vector<4xi32>
    %4 = llvm.and %3, %1  : vector<4xi32>
    %5 = llvm.sub %2, %4  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }
  llvm.func @sub_mask1_trunc_lshr(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(10 : i8) : i8
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i8
    %5 = llvm.and %4, %1  : i8
    %6 = llvm.sub %2, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @sub_sext_mask1_trunc_lshr(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i8
    %5 = llvm.and %4, %1  : i8
    %6 = llvm.sext %5 : i8 to i32
    %7 = llvm.sub %2, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @sub_zext_trunc_lshr(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.zext %3 : i1 to i32
    %5 = llvm.sub %1, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @neg_mask2_lshr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.lshr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.sub %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @neg_mask2_lshr_outofbounds(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.lshr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.sub %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @neg_mask1_lshr_vector_var(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.and %3, %0  : vector<2xi32>
    %5 = llvm.sub %2, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @neg_mask1_lshr_extrause_mask(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.lshr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.sub %2, %4  : i8
    llvm.call @usei8(%4) : (i8) -> ()
    llvm.return %5 : i8
  }
  llvm.func @neg_mask1_lshr_extrause_lshr(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %arg0, %0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.sub %3, %5  : vector<2xi32>
    llvm.call @usev2i32(%4) : (vector<2xi32>) -> ()
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @neg_signbit(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @neg_signbit_use1(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %9 = llvm.lshr %arg0, %6  : vector<2xi32>
    llvm.call @usev2i32(%9) : (vector<2xi32>) -> ()
    %10 = llvm.zext %9 : vector<2xi32> to vector<2xi64>
    %11 = llvm.sub %8, %10  : vector<2xi64>
    llvm.return %11 : vector<2xi64>
  }
  llvm.func @neg_signbit_use2(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i5
    %3 = llvm.zext %2 : i5 to i8
    llvm.call @usei8(%3) : (i8) -> ()
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @neg_not_signbit1(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @neg_not_signbit2(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @neg_not_signbit3(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @neg_mask(%arg0: i32, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sext %arg1 : i16 to i32
    %3 = llvm.sub %arg0, %2 overflow<nsw>  : i32
    %4 = llvm.lshr %arg1, %0  : i16
    %5 = llvm.zext %4 : i16 to i32
    %6 = llvm.sub %1, %5 overflow<nsw>  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @neg_mask_const(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(1000 : i32) : i32
    %1 = llvm.mlir.constant(15 : i16) : i16
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sext %arg0 : i16 to i32
    %4 = llvm.sub %0, %3 overflow<nsw>  : i32
    %5 = llvm.lshr %arg0, %1  : i16
    %6 = llvm.zext %5 : i16 to i32
    %7 = llvm.sub %2, %6 overflow<nsw>  : i32
    %8 = llvm.and %4, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @usei8(i8)
  llvm.func @usev2i32(vector<2xi32>)
}
