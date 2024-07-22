module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @n0(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.lshr %arg1, %6  : i64
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }
  llvm.func @t1(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.mlir.constant(-16 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.shl %1, %4  : i32
    %6 = llvm.add %arg1, %2  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %arg0, %7  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }
  llvm.func @t1_single_bit(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(32768 : i32) : i32
    %2 = llvm.mlir.constant(-16 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.shl %1, %4  : i32
    %6 = llvm.add %arg1, %2  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %arg0, %7  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }
  llvm.func @n2(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(131071 : i32) : i32
    %2 = llvm.mlir.constant(-16 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.shl %1, %4  : i32
    %6 = llvm.add %arg1, %2  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %arg0, %7  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }
  llvm.func @t3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-16 : i32) : i32
    %2 = llvm.mlir.constant(131071 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.shl %arg0, %4  : i32
    %6 = llvm.add %arg1, %1  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %2, %7  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }
  llvm.func @t3_singlebit(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-16 : i32) : i32
    %2 = llvm.mlir.constant(65536 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.shl %arg0, %4  : i32
    %6 = llvm.add %arg1, %1  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %2, %7  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }
  llvm.func @n4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-16 : i32) : i32
    %2 = llvm.mlir.constant(262143 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.shl %arg0, %4  : i32
    %6 = llvm.add %arg1, %1  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %2, %7  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }
  llvm.func @t5_vec(%arg0: vector<2xi64>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, 32767]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-16> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.sub %0, %arg1  : vector<2xi32>
    %6 = llvm.shl %1, %5  : vector<2xi32>
    %7 = llvm.add %arg1, %2  : vector<2xi32>
    %8 = llvm.zext %7 : vector<2xi32> to vector<2xi64>
    %9 = llvm.lshr %arg0, %8  : vector<2xi64>
    %10 = llvm.trunc %9 : vector<2xi64> to vector<2xi32>
    %11 = llvm.and %6, %10  : vector<2xi32>
    %12 = llvm.icmp "ne" %11, %4 : vector<2xi32>
    llvm.return %12 : vector<2xi1>
  }
  llvm.func @n6_vec(%arg0: vector<2xi64>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, 131071]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-16> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.sub %0, %arg1  : vector<2xi32>
    %6 = llvm.shl %1, %5  : vector<2xi32>
    %7 = llvm.add %arg1, %2  : vector<2xi32>
    %8 = llvm.zext %7 : vector<2xi32> to vector<2xi64>
    %9 = llvm.lshr %arg0, %8  : vector<2xi64>
    %10 = llvm.trunc %9 : vector<2xi64> to vector<2xi32>
    %11 = llvm.and %6, %10  : vector<2xi32>
    %12 = llvm.icmp "ne" %11, %4 : vector<2xi32>
    llvm.return %12 : vector<2xi1>
  }
  llvm.func @t7_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[131071, 65535]> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.sub %0, %arg1  : vector<2xi32>
    %6 = llvm.shl %arg0, %5  : vector<2xi32>
    %7 = llvm.add %arg1, %1  : vector<2xi32>
    %8 = llvm.zext %7 : vector<2xi32> to vector<2xi64>
    %9 = llvm.lshr %2, %8  : vector<2xi64>
    %10 = llvm.trunc %9 : vector<2xi64> to vector<2xi32>
    %11 = llvm.and %6, %10  : vector<2xi32>
    %12 = llvm.icmp "ne" %11, %4 : vector<2xi32>
    llvm.return %12 : vector<2xi1>
  }
  llvm.func @n8_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[131071, 262143]> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.sub %0, %arg1  : vector<2xi32>
    %6 = llvm.shl %arg0, %5  : vector<2xi32>
    %7 = llvm.add %arg1, %1  : vector<2xi32>
    %8 = llvm.zext %7 : vector<2xi32> to vector<2xi64>
    %9 = llvm.lshr %2, %8  : vector<2xi64>
    %10 = llvm.trunc %9 : vector<2xi64> to vector<2xi32>
    %11 = llvm.and %6, %10  : vector<2xi32>
    %12 = llvm.icmp "ne" %11, %4 : vector<2xi32>
    llvm.return %12 : vector<2xi1>
  }
  llvm.func @t9_highest_bit(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.lshr %arg1, %6  : i64
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }
  llvm.func @t10_almost_highest_bit(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.lshr %arg1, %6  : i64
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }
  llvm.func @t11_no_shift(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(-64 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.lshr %arg1, %6  : i64
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }
  llvm.func @t10_shift_by_one(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(-63 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.lshr %arg1, %6  : i64
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }
  llvm.func @t11_zero_and_almost_bitwidth(%arg0: vector<2xi32>, %arg1: vector<2xi64>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-1, -64]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.sub %0, %arg2  : vector<2xi32>
    %5 = llvm.shl %arg0, %4  : vector<2xi32>
    %6 = llvm.add %arg2, %1  : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi32> to vector<2xi64>
    %8 = llvm.lshr %arg1, %7  : vector<2xi64>
    %9 = llvm.trunc %8 : vector<2xi64> to vector<2xi32>
    %10 = llvm.and %5, %9  : vector<2xi32>
    %11 = llvm.icmp "ne" %10, %3 : vector<2xi32>
    llvm.return %11 : vector<2xi1>
  }
  llvm.func @n12_bad(%arg0: vector<2xi32>, %arg1: vector<2xi64>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-2, -64]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.sub %0, %arg2  : vector<2xi32>
    %5 = llvm.shl %arg0, %4  : vector<2xi32>
    %6 = llvm.add %arg2, %1  : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi32> to vector<2xi64>
    %8 = llvm.lshr %arg1, %7  : vector<2xi64>
    %9 = llvm.trunc %8 : vector<2xi64> to vector<2xi32>
    %10 = llvm.and %5, %9  : vector<2xi32>
    %11 = llvm.icmp "ne" %10, %3 : vector<2xi32>
    llvm.return %11 : vector<2xi1>
  }
  llvm.func @t13_x_is_one(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-16 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.shl %1, %4  : i32
    %6 = llvm.add %arg1, %2  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %arg0, %7  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }
  llvm.func @t14_x_is_one(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-16 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.shl %arg0, %4  : i32
    %6 = llvm.add %arg1, %1  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %2, %7  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }
  llvm.func @t15_vec_x_is_one_or_zero(%arg0: vector<2xi64>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-16> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.sub %0, %arg1  : vector<2xi32>
    %6 = llvm.shl %1, %5  : vector<2xi32>
    %7 = llvm.add %arg1, %2  : vector<2xi32>
    %8 = llvm.zext %7 : vector<2xi32> to vector<2xi64>
    %9 = llvm.lshr %arg0, %8  : vector<2xi64>
    %10 = llvm.trunc %9 : vector<2xi64> to vector<2xi32>
    %11 = llvm.and %6, %10  : vector<2xi32>
    %12 = llvm.icmp "ne" %11, %4 : vector<2xi32>
    llvm.return %12 : vector<2xi1>
  }
  llvm.func @t16_vec_y_is_one_or_zero(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.sub %0, %arg1  : vector<2xi32>
    %6 = llvm.shl %arg0, %5  : vector<2xi32>
    %7 = llvm.add %arg1, %1  : vector<2xi32>
    %8 = llvm.zext %7 : vector<2xi32> to vector<2xi64>
    %9 = llvm.lshr %2, %8  : vector<2xi64>
    %10 = llvm.trunc %9 : vector<2xi64> to vector<2xi32>
    %11 = llvm.and %6, %10  : vector<2xi32>
    %12 = llvm.icmp "ne" %11, %4 : vector<2xi32>
    llvm.return %12 : vector<2xi1>
  }
  llvm.func @rawspeed_signbit(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1 overflow<nsw>  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.add %arg1, %1 overflow<nsw>  : i32
    %9 = llvm.shl %2, %8  : i32
    %10 = llvm.and %9, %7  : i32
    %11 = llvm.icmp "eq" %10, %3 : i32
    llvm.return %11 : i1
  }
}
