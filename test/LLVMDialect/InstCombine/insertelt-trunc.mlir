module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i16)
  llvm.func @use_vec(vector<8xi16>)
  llvm.func @insert_01_poison_v4i16(%arg0: i32) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi16>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi16>
    llvm.return %8 : vector<4xi16>
  }
  llvm.func @insert_10_poison_v8i16(%arg0: i32) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.poison : vector<8xi16>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<8xi16>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<8xi16>
    llvm.return %8 : vector<8xi16>
  }
  llvm.func @insert_12_poison_v4i32(%arg0: i64) -> vector<4xi32> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi32>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.trunc %arg0 : i64 to i32
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi32>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }
  llvm.func @insert_21_poison_v4i16(%arg0: i32) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi16>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi16>
    llvm.return %8 : vector<4xi16>
  }
  llvm.func @insert_23_poison_v4i32(%arg0: i64) -> vector<4xi32> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi32>
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.trunc %arg0 : i64 to i32
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi32>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }
  llvm.func @insert_32_poison_v4i16(%arg0: i32) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi16>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi16>
    llvm.return %8 : vector<4xi16>
  }
  llvm.func @insert_01_v2i16(%arg0: i32, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<2xi16>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<2xi16>
    llvm.return %7 : vector<2xi16>
  }
  llvm.func @insert_10_v8i16(%arg0: i32, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<8xi16>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<8xi16>
    llvm.return %7 : vector<8xi16>
  }
  llvm.func @insert_12_v4i32(%arg0: i64, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.trunc %arg0 : i64 to i32
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<4xi32>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }
  llvm.func @insert_21_v4i16(%arg0: i32, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<4xi16>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<4xi16>
    llvm.return %7 : vector<4xi16>
  }
  llvm.func @insert_23_v4i32(%arg0: i64, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.trunc %arg0 : i64 to i32
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<4xi32>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }
  llvm.func @insert_32_v4i16(%arg0: i32, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<4xi16>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<4xi16>
    llvm.return %7 : vector<4xi16>
  }
  llvm.func @insert_01_v4i16_wrong_shift1(%arg0: i32) -> vector<4xi16> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi16>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi16>
    llvm.return %8 : vector<4xi16>
  }
  llvm.func @insert_01_v4i16_wrong_op(%arg0: i32, %arg1: i32) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg1 : i32 to i16
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi16>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi16>
    llvm.return %8 : vector<4xi16>
  }
  llvm.func @insert_67_v4i16_uses1(%arg0: i32, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    llvm.call @use(%4) : (i16) -> ()
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<8xi16>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<8xi16>
    llvm.return %7 : vector<8xi16>
  }
  llvm.func @insert_76_v4i16_uses2(%arg0: i32, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.mlir.constant(6 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.trunc %arg0 : i32 to i16
    llvm.call @use(%5) : (i16) -> ()
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<8xi16>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<8xi16>
    llvm.return %7 : vector<8xi16>
  }
  llvm.func @insert_67_v4i16_uses3(%arg0: i32, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<8xi16>
    llvm.call @use_vec(%6) : (vector<8xi16>) -> ()
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<8xi16>
    llvm.return %7 : vector<8xi16>
  }
  llvm.func @insert_01_poison_v4i16_high_first(%arg0: i32) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.insertelement %5, %1[%2 : i64] : vector<4xi16>
    %8 = llvm.insertelement %6, %7[%3 : i64] : vector<4xi16>
    llvm.return %8 : vector<4xi16>
  }
}
