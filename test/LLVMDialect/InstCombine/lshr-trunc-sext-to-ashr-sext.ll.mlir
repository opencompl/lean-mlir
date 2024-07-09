module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use32(i32)
  llvm.func @use8(i8)
  llvm.func @use4(i4)
  llvm.func @usevec8(vector<2xi8>)
  llvm.func @usevec4(vector<2xi4>)
  llvm.func @t0(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.trunc %1 : i8 to i4
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }
  llvm.func @t1(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.trunc %1 : i8 to i3
    %3 = llvm.sext %2 : i3 to i16
    llvm.return %3 : i16
  }
  llvm.func @t2(%arg0: i7) -> i16 {
    %0 = llvm.mlir.constant(3 : i7) : i7
    %1 = llvm.lshr %arg0, %0  : i7
    %2 = llvm.trunc %1 : i7 to i4
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }
  llvm.func @n3(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.trunc %1 : i8 to i4
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }
  llvm.func @t4_vec_splat(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.lshr %arg0, %0  : vector<2xi8>
    %2 = llvm.trunc %1 : vector<2xi8> to vector<2xi4>
    %3 = llvm.sext %2 : vector<2xi4> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @t5_vec_poison(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.lshr %arg0, %6  : vector<2xi8>
    %8 = llvm.trunc %7 : vector<2xi8> to vector<2xi4>
    %9 = llvm.sext %8 : vector<2xi4> to vector<2xi16>
    llvm.return %9 : vector<2xi16>
  }
  llvm.func @t6_extrause0(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.trunc %1 : i8 to i4
    llvm.call @use4(%2) : (i4) -> ()
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }
  llvm.func @t7_extrause0_vec_poison(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.lshr %arg0, %6  : vector<2xi8>
    %8 = llvm.trunc %7 : vector<2xi8> to vector<2xi4>
    llvm.call @usevec4(%8) : (vector<2xi4>) -> ()
    %9 = llvm.sext %8 : vector<2xi4> to vector<2xi16>
    llvm.return %9 : vector<2xi16>
  }
  llvm.func @t8_extrause1(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.trunc %1 : i8 to i4
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }
  llvm.func @t9_extrause1_vec_poison(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.lshr %arg0, %6  : vector<2xi8>
    llvm.call @usevec8(%7) : (vector<2xi8>) -> ()
    %8 = llvm.trunc %7 : vector<2xi8> to vector<2xi4>
    %9 = llvm.sext %8 : vector<2xi4> to vector<2xi16>
    llvm.return %9 : vector<2xi16>
  }
  llvm.func @t10_extrause2(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.trunc %1 : i8 to i4
    llvm.call @use4(%2) : (i4) -> ()
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }
  llvm.func @t11_extrause2_vec_poison(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.lshr %arg0, %6  : vector<2xi8>
    llvm.call @usevec8(%7) : (vector<2xi8>) -> ()
    %8 = llvm.trunc %7 : vector<2xi8> to vector<2xi4>
    llvm.call @usevec4(%8) : (vector<2xi4>) -> ()
    %9 = llvm.sext %8 : vector<2xi4> to vector<2xi16>
    llvm.return %9 : vector<2xi16>
  }
  llvm.func @wide_source_shifted_signbit(%arg0: vector<2xi32>) -> vector<2xi10> {
    %0 = llvm.mlir.constant(dense<24> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi8>
    %3 = llvm.sext %2 : vector<2xi8> to vector<2xi10>
    llvm.return %3 : vector<2xi10>
  }
  llvm.func @wide_source_shifted_signbit_use1(%arg0: i32) -> i10 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.trunc %1 : i32 to i8
    %3 = llvm.sext %2 : i8 to i10
    llvm.return %3 : i10
  }
  llvm.func @wide_source_shifted_signbit_use2(%arg0: i32) -> i10 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sext %2 : i8 to i10
    llvm.return %3 : i10
  }
  llvm.func @same_source_shifted_signbit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i8
    %3 = llvm.sext %2 : i8 to i32
    llvm.return %3 : i32
  }
  llvm.func @same_source_shifted_signbit_use1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.trunc %1 : i32 to i8
    %3 = llvm.sext %2 : i8 to i32
    llvm.return %3 : i32
  }
  llvm.func @same_source_shifted_signbit_use2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sext %2 : i8 to i32
    llvm.return %3 : i32
  }
}
