module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use16(i16)
  llvm.func @use32(i32)
  llvm.func @testi8i8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @testi16i8(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.mlir.constant(27 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.xor %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @testi64i32(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.xor %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @testi128i128(%arg0: i128) -> i128 {
    %0 = llvm.mlir.constant(127 : i128) : i128
    %1 = llvm.mlir.constant(27 : i128) : i128
    %2 = llvm.ashr %arg0, %0  : i128
    %3 = llvm.xor %2, %1  : i128
    llvm.return %3 : i128
  }
  llvm.func @testv4i16i8(%arg0: vector<4xi16>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<15> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mlir.constant(dense<27> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.ashr %arg0, %0  : vector<4xi16>
    %3 = llvm.trunc %2 : vector<4xi16> to vector<4xi8>
    %4 = llvm.xor %3, %1  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }
  llvm.func @testv4i16i8_poison(%arg0: vector<4xi16>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<4xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi16>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xi16>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi16>
    %11 = llvm.mlir.constant(27 : i8) : i8
    %12 = llvm.mlir.poison : i8
    %13 = llvm.mlir.undef : vector<4xi8>
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.insertelement %11, %13[%14 : i32] : vector<4xi8>
    %16 = llvm.mlir.constant(1 : i32) : i32
    %17 = llvm.insertelement %11, %15[%16 : i32] : vector<4xi8>
    %18 = llvm.mlir.constant(2 : i32) : i32
    %19 = llvm.insertelement %12, %17[%18 : i32] : vector<4xi8>
    %20 = llvm.mlir.constant(3 : i32) : i32
    %21 = llvm.insertelement %11, %19[%20 : i32] : vector<4xi8>
    %22 = llvm.ashr %arg0, %10  : vector<4xi16>
    %23 = llvm.trunc %22 : vector<4xi16> to vector<4xi8>
    %24 = llvm.xor %23, %21  : vector<4xi8>
    llvm.return %24 : vector<4xi8>
  }
  llvm.func @wrongimm(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(14 : i16) : i16
    %1 = llvm.mlir.constant(27 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.xor %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @vectorpoison(%arg0: vector<6xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<6xi32>) : vector<6xi32>
    %1 = llvm.mlir.constant(dense<31> : vector<6xi32>) : vector<6xi32>
    %2 = llvm.mlir.poison : vector<6xi32>
    %3 = llvm.xor %arg0, %0  : vector<6xi32>
    %4 = llvm.ashr %3, %1  : vector<6xi32>
    %5 = llvm.shufflevector %4, %2 [0, 1, 0, 2] : vector<6xi32> 
    llvm.return %5 : vector<4xi32>
  }
  llvm.func @extrause(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.mlir.constant(27 : i16) : i16
    %2 = llvm.ashr %arg0, %0  : i16
    %3 = llvm.xor %2, %1  : i16
    llvm.call @use16(%2) : (i16) -> ()
    llvm.return %3 : i16
  }
  llvm.func @extrause_trunc1(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(127 : i16) : i16
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.call @use32(%2) : (i32) -> ()
    %4 = llvm.xor %3, %1  : i16
    llvm.return %4 : i16
  }
  llvm.func @extrause_trunc2(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(127 : i16) : i16
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.call @use16(%3) : (i16) -> ()
    %4 = llvm.xor %3, %1  : i16
    llvm.return %4 : i16
  }
}
