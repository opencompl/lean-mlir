module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use8(i8) -> i8
  llvm.func @use16(i16) -> i16
  llvm.func @use32(i32) -> i32
  llvm.func @use64(i64) -> i64
  llvm.func @use128(i128) -> i128
  llvm.func @use130(i130) -> i130
  llvm.func @use_v2i8(vector<2xi8>) -> vector<2xi8>
  llvm.func @mul8_low_A0_B0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.lshr %arg0, %1  : i8
    %4 = llvm.and %arg1, %0  : i8
    %5 = llvm.lshr %arg1, %1  : i8
    %6 = llvm.mul %5, %arg0  : i8
    %7 = llvm.mul %3, %arg1  : i8
    %8 = llvm.mul %4, %2  : i8
    %9 = llvm.add %6, %7  : i8
    %10 = llvm.shl %9, %1  : i8
    %11 = llvm.add %10, %8  : i8
    llvm.return %11 : i8
  }
  llvm.func @mul8_low_A0_B1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.call @use8(%arg0) : (i8) -> i8
    %3 = llvm.and %2, %0  : i8
    %4 = llvm.lshr %2, %1  : i8
    %5 = llvm.and %arg1, %0  : i8
    %6 = llvm.lshr %arg1, %1  : i8
    %7 = llvm.mul %2, %6  : i8
    %8 = llvm.mul %4, %arg1  : i8
    %9 = llvm.mul %5, %3  : i8
    %10 = llvm.add %7, %8  : i8
    %11 = llvm.shl %10, %1  : i8
    %12 = llvm.add %9, %11  : i8
    llvm.return %12 : i8
  }
  llvm.func @mul8_low_A0_B2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.call @use8(%arg1) : (i8) -> i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.lshr %arg0, %1  : i8
    %5 = llvm.and %2, %0  : i8
    %6 = llvm.lshr %2, %1  : i8
    %7 = llvm.mul %6, %arg0  : i8
    %8 = llvm.mul %2, %4  : i8
    %9 = llvm.mul %5, %3  : i8
    %10 = llvm.add %8, %7  : i8
    %11 = llvm.shl %10, %1  : i8
    %12 = llvm.add %11, %9  : i8
    llvm.return %12 : i8
  }
  llvm.func @mul8_low_A0_B3(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.call @use8(%arg0) : (i8) -> i8
    %3 = llvm.call @use8(%arg1) : (i8) -> i8
    %4 = llvm.and %2, %0  : i8
    %5 = llvm.lshr %2, %1  : i8
    %6 = llvm.and %3, %0  : i8
    %7 = llvm.lshr %3, %1  : i8
    %8 = llvm.mul %2, %7  : i8
    %9 = llvm.mul %3, %5  : i8
    %10 = llvm.mul %6, %4  : i8
    %11 = llvm.add %9, %8  : i8
    %12 = llvm.shl %11, %1  : i8
    %13 = llvm.add %10, %12  : i8
    llvm.return %13 : i8
  }
  llvm.func @mul16_low_A1_B0(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(255 : i16) : i16
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.mlir.addressof @use16 : !llvm.ptr
    %3 = llvm.and %arg0, %0  : i16
    %4 = llvm.lshr %arg0, %1  : i16
    %5 = llvm.and %arg1, %0  : i16
    %6 = llvm.lshr %arg1, %1  : i16
    %7 = llvm.mul %3, %6  : i16
    llvm.call %2(%7) : !llvm.ptr, (i16) -> ()
    %8 = llvm.mul %5, %4  : i16
    llvm.call %2(%8) : !llvm.ptr, (i16) -> ()
    %9 = llvm.mul %5, %3  : i16
    %10 = llvm.add %7, %8  : i16
    %11 = llvm.shl %10, %1  : i16
    %12 = llvm.add %11, %9  : i16
    llvm.return %12 : i16
  }
  llvm.func @mul16_low_A1_B1(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(255 : i16) : i16
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.mlir.addressof @use16 : !llvm.ptr
    %3 = llvm.and %arg0, %0  : i16
    %4 = llvm.lshr %arg0, %1  : i16
    %5 = llvm.and %arg1, %0  : i16
    %6 = llvm.lshr %arg1, %1  : i16
    %7 = llvm.mul %3, %6  : i16
    llvm.call %2(%7) : !llvm.ptr, (i16) -> ()
    %8 = llvm.mul %4, %5  : i16
    llvm.call %2(%8) : !llvm.ptr, (i16) -> ()
    %9 = llvm.mul %5, %3  : i16
    %10 = llvm.add %7, %8  : i16
    %11 = llvm.shl %10, %1  : i16
    %12 = llvm.add %9, %11  : i16
    llvm.return %12 : i16
  }
  llvm.func @mul16_low_A1_B2(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(255 : i16) : i16
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.mlir.addressof @use16 : !llvm.ptr
    %3 = llvm.and %arg0, %0  : i16
    %4 = llvm.lshr %arg0, %1  : i16
    %5 = llvm.and %arg1, %0  : i16
    %6 = llvm.lshr %arg1, %1  : i16
    %7 = llvm.mul %6, %3  : i16
    llvm.call %2(%7) : !llvm.ptr, (i16) -> ()
    %8 = llvm.mul %5, %4  : i16
    llvm.call %2(%8) : !llvm.ptr, (i16) -> ()
    %9 = llvm.mul %5, %3  : i16
    %10 = llvm.add %8, %7  : i16
    %11 = llvm.shl %10, %1  : i16
    %12 = llvm.add %11, %9  : i16
    llvm.return %12 : i16
  }
  llvm.func @mul16_low_A1_B3(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(255 : i16) : i16
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.mlir.addressof @use16 : !llvm.ptr
    %3 = llvm.and %arg0, %0  : i16
    %4 = llvm.lshr %arg0, %1  : i16
    %5 = llvm.and %arg1, %0  : i16
    %6 = llvm.lshr %arg1, %1  : i16
    %7 = llvm.mul %3, %6  : i16
    llvm.call %2(%7) : !llvm.ptr, (i16) -> ()
    %8 = llvm.mul %5, %4  : i16
    llvm.call %2(%8) : !llvm.ptr, (i16) -> ()
    %9 = llvm.mul %5, %3  : i16
    %10 = llvm.add %8, %7  : i16
    %11 = llvm.shl %10, %1  : i16
    %12 = llvm.add %9, %11  : i16
    llvm.return %12 : i16
  }
  llvm.func @mul32_low_A2_B0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.addressof @use32 : !llvm.ptr
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %arg1, %0  : i32
    %6 = llvm.lshr %arg1, %1  : i32
    %7 = llvm.mul %6, %3  : i32
    llvm.call %2(%7) : !llvm.ptr, (i32) -> ()
    %8 = llvm.mul %4, %arg1  : i32
    %9 = llvm.mul %5, %3  : i32
    %10 = llvm.add %7, %8  : i32
    %11 = llvm.shl %10, %1  : i32
    %12 = llvm.add %11, %9  : i32
    llvm.return %12 : i32
  }
  llvm.func @mul32_low_A2_B1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.addressof @use32 : !llvm.ptr
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %arg1, %0  : i32
    %6 = llvm.lshr %arg1, %1  : i32
    %7 = llvm.mul %6, %3  : i32
    llvm.call %2(%7) : !llvm.ptr, (i32) -> ()
    %8 = llvm.mul %4, %arg1  : i32
    %9 = llvm.mul %5, %3  : i32
    %10 = llvm.add %7, %8  : i32
    %11 = llvm.shl %10, %1  : i32
    %12 = llvm.add %9, %11  : i32
    llvm.return %12 : i32
  }
  llvm.func @mul32_low_A2_B2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.addressof @use32 : !llvm.ptr
    %3 = llvm.call @use32(%arg1) : (i32) -> i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.lshr %arg0, %1  : i32
    %6 = llvm.and %3, %0  : i32
    %7 = llvm.lshr %3, %1  : i32
    %8 = llvm.mul %4, %7  : i32
    llvm.call %2(%8) : !llvm.ptr, (i32) -> ()
    %9 = llvm.mul %3, %5  : i32
    %10 = llvm.mul %6, %4  : i32
    %11 = llvm.add %9, %8  : i32
    %12 = llvm.shl %11, %1  : i32
    %13 = llvm.add %12, %10  : i32
    llvm.return %13 : i32
  }
  llvm.func @mul32_low_A2_B3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.addressof @use32 : !llvm.ptr
    %3 = llvm.call @use32(%arg1) : (i32) -> i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.lshr %arg0, %1  : i32
    %6 = llvm.and %3, %0  : i32
    %7 = llvm.lshr %3, %1  : i32
    %8 = llvm.mul %7, %4  : i32
    llvm.call %2(%8) : !llvm.ptr, (i32) -> ()
    %9 = llvm.mul %3, %5  : i32
    %10 = llvm.mul %6, %4  : i32
    %11 = llvm.add %9, %8  : i32
    %12 = llvm.shl %11, %1  : i32
    %13 = llvm.add %10, %12  : i32
    llvm.return %13 : i32
  }
  llvm.func @mul64_low_A3_B0(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.addressof @use64 : !llvm.ptr
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %arg1, %0  : i64
    %6 = llvm.lshr %arg1, %1  : i64
    %7 = llvm.mul %6, %arg0  : i64
    %8 = llvm.mul %4, %5  : i64
    llvm.call %2(%8) : !llvm.ptr, (i64) -> ()
    %9 = llvm.mul %5, %3  : i64
    %10 = llvm.add %7, %8  : i64
    %11 = llvm.shl %10, %1  : i64
    %12 = llvm.add %11, %9  : i64
    llvm.return %12 : i64
  }
  llvm.func @mul64_low_A3_B1(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.addressof @use64 : !llvm.ptr
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %arg1, %0  : i64
    %6 = llvm.lshr %arg1, %1  : i64
    %7 = llvm.mul %6, %arg0  : i64
    %8 = llvm.mul %4, %5  : i64
    llvm.call %2(%8) : !llvm.ptr, (i64) -> ()
    %9 = llvm.mul %5, %3  : i64
    %10 = llvm.add %7, %8  : i64
    %11 = llvm.shl %10, %1  : i64
    %12 = llvm.add %9, %11  : i64
    llvm.return %12 : i64
  }
  llvm.func @mul64_low_A3_B2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.addressof @use64 : !llvm.ptr
    %3 = llvm.call @use64(%arg0) : (i64) -> i64
    %4 = llvm.and %3, %0  : i64
    %5 = llvm.lshr %3, %1  : i64
    %6 = llvm.and %arg1, %0  : i64
    %7 = llvm.lshr %arg1, %1  : i64
    %8 = llvm.mul %3, %7  : i64
    %9 = llvm.mul %5, %6  : i64
    llvm.call %2(%9) : !llvm.ptr, (i64) -> ()
    %10 = llvm.mul %6, %4  : i64
    %11 = llvm.add %9, %8  : i64
    %12 = llvm.shl %11, %1  : i64
    %13 = llvm.add %12, %10  : i64
    llvm.return %13 : i64
  }
  llvm.func @mul64_low_A3_B3(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.addressof @use64 : !llvm.ptr
    %3 = llvm.call @use64(%arg0) : (i64) -> i64
    %4 = llvm.and %3, %0  : i64
    %5 = llvm.lshr %3, %1  : i64
    %6 = llvm.and %arg1, %0  : i64
    %7 = llvm.lshr %arg1, %1  : i64
    %8 = llvm.mul %3, %7  : i64
    %9 = llvm.mul %6, %5  : i64
    llvm.call %2(%9) : !llvm.ptr, (i64) -> ()
    %10 = llvm.mul %6, %4  : i64
    %11 = llvm.add %9, %8  : i64
    %12 = llvm.shl %11, %1  : i64
    %13 = llvm.add %10, %12  : i64
    llvm.return %13 : i64
  }
  llvm.func @mul32_low_one_extra_user(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.addressof @use32 : !llvm.ptr
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %arg1, %0  : i32
    %6 = llvm.lshr %arg1, %1  : i32
    %7 = llvm.mul %6, %3  : i32
    %8 = llvm.mul %5, %4  : i32
    %9 = llvm.mul %5, %3  : i32
    %10 = llvm.add %7, %8  : i32
    llvm.call %2(%10) : !llvm.ptr, (i32) -> ()
    %11 = llvm.shl %10, %1  : i32
    %12 = llvm.add %11, %9  : i32
    llvm.return %12 : i32
  }
  llvm.func @mul8_low(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.lshr %arg0, %1  : i8
    %4 = llvm.and %arg1, %0  : i8
    %5 = llvm.lshr %arg1, %1  : i8
    %6 = llvm.mul %5, %2  : i8
    %7 = llvm.mul %4, %3  : i8
    %8 = llvm.mul %4, %2  : i8
    %9 = llvm.add %6, %7  : i8
    %10 = llvm.shl %9, %1  : i8
    %11 = llvm.add %10, %8  : i8
    llvm.return %11 : i8
  }
  llvm.func @mul16_low(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(255 : i16) : i16
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.lshr %arg0, %1  : i16
    %4 = llvm.and %arg1, %0  : i16
    %5 = llvm.lshr %arg1, %1  : i16
    %6 = llvm.mul %5, %2  : i16
    %7 = llvm.mul %4, %3  : i16
    %8 = llvm.mul %4, %2  : i16
    %9 = llvm.add %6, %7  : i16
    %10 = llvm.shl %9, %1  : i16
    %11 = llvm.add %10, %8  : i16
    llvm.return %11 : i16
  }
  llvm.func @mul32_low(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.and %arg1, %0  : i32
    %5 = llvm.lshr %arg1, %1  : i32
    %6 = llvm.mul %5, %2  : i32
    %7 = llvm.mul %4, %3  : i32
    %8 = llvm.mul %4, %2  : i32
    %9 = llvm.add %6, %7  : i32
    %10 = llvm.shl %9, %1  : i32
    %11 = llvm.add %10, %8  : i32
    llvm.return %11 : i32
  }
  llvm.func @mul64_low(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.and %arg1, %0  : i64
    %5 = llvm.lshr %arg1, %1  : i64
    %6 = llvm.mul %5, %2  : i64
    %7 = llvm.mul %4, %3  : i64
    %8 = llvm.mul %4, %2  : i64
    %9 = llvm.add %6, %7  : i64
    %10 = llvm.shl %9, %1  : i64
    %11 = llvm.add %10, %8  : i64
    llvm.return %11 : i64
  }
  llvm.func @mul128_low(%arg0: i128, %arg1: i128) -> i128 {
    %0 = llvm.mlir.constant(18446744073709551615 : i128) : i128
    %1 = llvm.mlir.constant(64 : i128) : i128
    %2 = llvm.and %arg0, %0  : i128
    %3 = llvm.lshr %arg0, %1  : i128
    %4 = llvm.and %arg1, %0  : i128
    %5 = llvm.lshr %arg1, %1  : i128
    %6 = llvm.mul %5, %2  : i128
    %7 = llvm.mul %4, %3  : i128
    %8 = llvm.mul %4, %2  : i128
    %9 = llvm.add %6, %7  : i128
    %10 = llvm.shl %9, %1  : i128
    %11 = llvm.add %10, %8  : i128
    llvm.return %11 : i128
  }
  llvm.func @mul_v2i8_low(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg0, %1  : vector<2xi8>
    %4 = llvm.and %arg1, %0  : vector<2xi8>
    %5 = llvm.lshr %arg1, %1  : vector<2xi8>
    %6 = llvm.mul %5, %2  : vector<2xi8>
    %7 = llvm.mul %4, %3  : vector<2xi8>
    %8 = llvm.mul %4, %2  : vector<2xi8>
    %9 = llvm.add %6, %7  : vector<2xi8>
    %10 = llvm.shl %9, %1  : vector<2xi8>
    %11 = llvm.add %10, %8  : vector<2xi8>
    llvm.return %11 : vector<2xi8>
  }
  llvm.func @mul_v2i8_low_one_extra_user(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.addressof @use_v2i8 : !llvm.ptr
    %3 = llvm.and %arg0, %0  : vector<2xi8>
    %4 = llvm.lshr %arg0, %1  : vector<2xi8>
    %5 = llvm.and %arg1, %0  : vector<2xi8>
    %6 = llvm.lshr %arg1, %1  : vector<2xi8>
    %7 = llvm.mul %6, %3  : vector<2xi8>
    %8 = llvm.mul %5, %4  : vector<2xi8>
    llvm.call %2(%8) : !llvm.ptr, (vector<2xi8>) -> ()
    %9 = llvm.mul %5, %3  : vector<2xi8>
    %10 = llvm.add %7, %8  : vector<2xi8>
    %11 = llvm.shl %10, %1  : vector<2xi8>
    %12 = llvm.add %11, %9  : vector<2xi8>
    llvm.return %12 : vector<2xi8>
  }
  llvm.func @mul130_low(%arg0: i130, %arg1: i130) -> i130 {
    %0 = llvm.mlir.constant(36893488147419103231 : i130) : i130
    %1 = llvm.mlir.constant(65 : i130) : i130
    %2 = llvm.and %arg0, %0  : i130
    %3 = llvm.lshr %arg0, %1  : i130
    %4 = llvm.and %arg1, %0  : i130
    %5 = llvm.lshr %arg1, %1  : i130
    %6 = llvm.mul %5, %2  : i130
    %7 = llvm.mul %4, %3  : i130
    %8 = llvm.mul %4, %2  : i130
    %9 = llvm.add %6, %7  : i130
    %10 = llvm.shl %9, %1  : i130
    %11 = llvm.add %10, %8  : i130
    llvm.return %11 : i130
  }
  llvm.func @mul130_low_one_extra_user(%arg0: i130, %arg1: i130) -> i130 {
    %0 = llvm.mlir.constant(36893488147419103231 : i130) : i130
    %1 = llvm.mlir.constant(65 : i130) : i130
    %2 = llvm.mlir.addressof @use130 : !llvm.ptr
    %3 = llvm.and %arg0, %0  : i130
    %4 = llvm.lshr %arg0, %1  : i130
    %5 = llvm.and %arg1, %0  : i130
    %6 = llvm.lshr %arg1, %1  : i130
    %7 = llvm.mul %6, %3  : i130
    llvm.call %2(%7) : !llvm.ptr, (i130) -> ()
    %8 = llvm.mul %5, %4  : i130
    %9 = llvm.mul %5, %3  : i130
    %10 = llvm.add %7, %8  : i130
    %11 = llvm.shl %10, %1  : i130
    %12 = llvm.add %11, %9  : i130
    llvm.return %12 : i130
  }
  llvm.func @mul9_low(%arg0: i9, %arg1: i9) -> i9 {
    %0 = llvm.mlir.constant(15 : i9) : i9
    %1 = llvm.mlir.constant(4 : i9) : i9
    %2 = llvm.and %arg0, %0  : i9
    %3 = llvm.lshr %arg0, %1  : i9
    %4 = llvm.and %arg1, %0  : i9
    %5 = llvm.lshr %arg1, %1  : i9
    %6 = llvm.mul %5, %2  : i9
    %7 = llvm.mul %4, %3  : i9
    %8 = llvm.mul %4, %2  : i9
    %9 = llvm.add %6, %7  : i9
    %10 = llvm.shl %9, %1  : i9
    %11 = llvm.add %10, %8  : i9
    llvm.return %11 : i9
  }
  llvm.func @mul64_low_no_and(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.lshr %arg1, %0  : i64
    %3 = llvm.mul %2, %arg0  : i64
    %4 = llvm.mul %arg1, %1  : i64
    %5 = llvm.mul %arg1, %arg0  : i64
    %6 = llvm.add %3, %4  : i64
    %7 = llvm.shl %6, %0  : i64
    %8 = llvm.add %7, %5  : i64
    llvm.return %8 : i64
  }
  llvm.func @mul16_low_miss_shift_amount(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(127 : i16) : i16
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.lshr %arg0, %1  : i16
    %4 = llvm.and %arg1, %0  : i16
    %5 = llvm.lshr %arg1, %1  : i16
    %6 = llvm.mul %5, %2  : i16
    %7 = llvm.mul %4, %3  : i16
    %8 = llvm.mul %4, %2  : i16
    %9 = llvm.add %6, %7  : i16
    %10 = llvm.shl %9, %1  : i16
    %11 = llvm.add %10, %8  : i16
    llvm.return %11 : i16
  }
  llvm.func @mul8_low_miss_half_width(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.lshr %arg0, %1  : i8
    %4 = llvm.and %arg1, %0  : i8
    %5 = llvm.lshr %arg1, %1  : i8
    %6 = llvm.mul %5, %2  : i8
    %7 = llvm.mul %4, %3  : i8
    %8 = llvm.mul %4, %2  : i8
    %9 = llvm.add %6, %7  : i8
    %10 = llvm.shl %9, %1  : i8
    %11 = llvm.add %10, %8  : i8
    llvm.return %11 : i8
  }
  llvm.func @mul32_low_extra_shl_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.addressof @use32 : !llvm.ptr
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %arg1, %0  : i32
    %6 = llvm.lshr %arg1, %1  : i32
    %7 = llvm.mul %6, %3  : i32
    %8 = llvm.mul %5, %4  : i32
    %9 = llvm.mul %5, %3  : i32
    %10 = llvm.add %7, %8  : i32
    %11 = llvm.shl %10, %1  : i32
    llvm.call %2(%11) : !llvm.ptr, (i32) -> ()
    %12 = llvm.add %11, %9  : i32
    llvm.return %12 : i32
  }
}
