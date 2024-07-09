module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @gen8() -> i8
  llvm.func @gen2x8() -> vector<2xi8>
  llvm.func @gen3x8() -> vector<3xi8>
  llvm.func @p0() -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.icmp "ugt" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @pv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "ugt" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @p1_vec_splat() -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.call @gen2x8() : () -> vector<2xi8>
    %2 = llvm.and %1, %0  : vector<2xi8>
    %3 = llvm.icmp "ugt" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @p2_vec_nonsplat() -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, 15]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.call @gen2x8() : () -> vector<2xi8>
    %2 = llvm.and %1, %0  : vector<2xi8>
    %3 = llvm.icmp "ugt" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @p2_vec_nonsplat_edgecase0() -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.call @gen2x8() : () -> vector<2xi8>
    %2 = llvm.and %1, %0  : vector<2xi8>
    %3 = llvm.icmp "ugt" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @p2_vec_nonsplat_edgecase1() -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, -1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.call @gen2x8() : () -> vector<2xi8>
    %2 = llvm.and %1, %0  : vector<2xi8>
    %3 = llvm.icmp "ugt" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @p3_vec_splat_poison() -> vector<3xi1> {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.call @gen3x8() : () -> vector<3xi8>
    %10 = llvm.and %9, %8  : vector<3xi8>
    %11 = llvm.icmp "ugt" %9, %10 : vector<3xi8>
    llvm.return %11 : vector<3xi1>
  }
  llvm.func @p3_vec_nonsplat_poison() -> vector<3xi1> {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.call @gen3x8() : () -> vector<3xi8>
    %11 = llvm.and %10, %9  : vector<3xi8>
    %12 = llvm.icmp "ugt" %10, %11 : vector<3xi8>
    llvm.return %12 : vector<3xi1>
  }
  llvm.func @c0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "ugt" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @cv0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "ugt" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @cv1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.and %1, %2  : i8
    %4 = llvm.icmp "ugt" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @cv2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.icmp "ugt" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @use8(i8)
  llvm.func @oneuse0() -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.and %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ugt" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @n0() -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.icmp "ugt" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.icmp "ugt" %2, %arg1 : i8
    llvm.return %3 : i1
  }
  llvm.func @n2() -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, 16]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.call @gen2x8() : () -> vector<2xi8>
    %2 = llvm.and %1, %0  : vector<2xi8>
    %3 = llvm.icmp "ugt" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
}
