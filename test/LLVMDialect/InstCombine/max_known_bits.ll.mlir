module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(255 : i16) : i16
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    %6 = llvm.trunc %5 : i32 to i16
    %7 = llvm.and %6, %0  : i16
    llvm.return %7 : i16
  }
  llvm.func @min_max_clamp(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.icmp "sgt" %arg0, %0 : i16
    %4 = llvm.select %3, %arg0, %0 : i1, i16
    %5 = llvm.icmp "slt" %4, %1 : i16
    %6 = llvm.select %5, %4, %1 : i1, i16
    %7 = llvm.add %6, %2  : i16
    llvm.return %7 : i16
  }
  llvm.func @min_max_clamp_2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(-2048 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.icmp "slt" %arg0, %0 : i16
    %4 = llvm.select %3, %arg0, %0 : i1, i16
    %5 = llvm.icmp "sgt" %4, %1 : i16
    %6 = llvm.select %5, %4, %1 : i1, i16
    %7 = llvm.add %6, %2  : i16
    llvm.return %7 : i16
  }
  llvm.func @min_max_clamp_3(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.icmp "sgt" %arg0, %0 : i16
    %5 = llvm.select %4, %arg0, %0 : i1, i16
    %6 = llvm.icmp "slt" %5, %1 : i16
    %7 = llvm.select %6, %5, %1 : i1, i16
    %8 = llvm.add %7, %2  : i16
    %9 = llvm.sext %8 : i16 to i32
    %10 = llvm.add %9, %3  : i32
    llvm.return %10 : i32
  }
  llvm.func @min_max_clamp_4(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(-2048 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.icmp "slt" %arg0, %0 : i16
    %5 = llvm.select %4, %arg0, %0 : i1, i16
    %6 = llvm.icmp "sgt" %5, %1 : i16
    %7 = llvm.select %6, %5, %1 : i1, i16
    %8 = llvm.add %7, %2  : i16
    %9 = llvm.sext %8 : i16 to i32
    %10 = llvm.add %9, %3  : i32
    llvm.return %10 : i32
  }
  llvm.func @min_max_clamp_intrinsic(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.intr.smax(%arg0, %0)  : (i16, i16) -> i16
    %4 = llvm.intr.smin(%3, %1)  : (i16, i16) -> i16
    %5 = llvm.add %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @min_max_clamp_intrinsic_2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(-2048 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.intr.smin(%arg0, %0)  : (i16, i16) -> i16
    %4 = llvm.intr.smax(%3, %1)  : (i16, i16) -> i16
    %5 = llvm.add %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @min_max_clamp_intrinsic_3(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.intr.smax(%arg0, %0)  : (i16, i16) -> i16
    %5 = llvm.intr.smin(%4, %1)  : (i16, i16) -> i16
    %6 = llvm.add %5, %2  : i16
    %7 = llvm.sext %6 : i16 to i32
    %8 = llvm.add %7, %3  : i32
    llvm.return %8 : i32
  }
  llvm.func @min_max_clamp_intrinsic_4(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(-2048 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.intr.smin(%arg0, %0)  : (i16, i16) -> i16
    %5 = llvm.intr.smax(%4, %1)  : (i16, i16) -> i16
    %6 = llvm.add %5, %2  : i16
    %7 = llvm.sext %6 : i16 to i32
    %8 = llvm.add %7, %3  : i32
    llvm.return %8 : i32
  }
}
