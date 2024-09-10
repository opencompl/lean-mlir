module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @p0_ult_65536(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @p1_ugt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65534 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @p2_slt_65536(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @p3_sgt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65534 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @p4_vec_splat_ult_65536(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65536> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @p5_vec_splat_ugt(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65534> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @p6_vec_splat_slt_65536(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65536> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @p7_vec_splat_sgt(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65534> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @p8_vec_nonsplat_poison0(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.icmp "ult" %arg0, %6 : vector<2xi32>
    %9 = llvm.select %8, %arg1, %7 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }
  llvm.func @p9_vec_nonsplat_poison1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65536> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(65535 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %9 = llvm.select %8, %arg1, %7 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }
  llvm.func @p10_vec_nonsplat_poison2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(65535 : i32) : i32
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.icmp "ult" %arg0, %6 : vector<2xi32>
    %14 = llvm.select %13, %arg1, %12 : vector<2xi1>, vector<2xi32>
    llvm.return %14 : vector<2xi32>
  }
  llvm.func @p11_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65536, 32768]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, 32767]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @use1(i1)
  llvm.func @n12_extrause(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @p13_commutativity0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @p14_commutativity1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @p15_commutativity2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.mlir.constant(65535 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @n17_ult_zero(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65536, 0]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, -1]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @n18_ugt_allones(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65534, -1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, 0]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @n19_slt_int_min(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65536, -2147483648]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, 2147483647]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @n20_sgt_int_max(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65534, 2147483647]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, -2147483648]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @n21_equality(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @t22_sign_check(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @t22_sign_check2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @n23_type_mismatch(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i64) : i64
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i64
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @n24_ult_65534(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65534 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @n25_all_good0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @n26_all_good1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @ult_inf_loop(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(-3 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @ult_inf_loop_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-5> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.add %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ugt" %3, %1 : vector<2xi32>
    %5 = llvm.select %4, %2, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
}
