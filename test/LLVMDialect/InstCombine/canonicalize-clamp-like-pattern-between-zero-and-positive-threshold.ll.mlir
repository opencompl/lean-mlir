module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t0_ult_slt_65536(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.select %1, %arg1, %arg2 : i1, i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.select %3, %arg0, %2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @t1_ult_slt_0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @t2_ult_sgt_65536(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg2, %arg1 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @t3_ult_sgt_neg1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg2, %arg1 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @t4_ugt_slt_65536(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %arg0 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @t5_ugt_slt_0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %arg0 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @t6_ugt_sgt_65536(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.select %1, %arg2, %arg1 : i1, i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %arg0 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @t7_ugt_sgt_neg1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg2, %arg1 : i1, i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %arg0 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @n8_ult_slt_65537(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @n9_ult_slt_neg1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @use32(i32)
  llvm.func @use1(i1)
  llvm.func @n10_oneuse0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @n11_oneuse1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @n12_oneuse2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @n13_oneuse3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @n14_oneuse4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @n15_oneuse5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @n16_oneuse6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @t17_ult_slt_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65536> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %2 = llvm.select %1, %arg1, %arg2 : vector<2xi1>, vector<2xi32>
    %3 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %arg0, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @t18_ult_slt_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65536, 32768]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %2 = llvm.select %1, %arg1, %arg2 : vector<2xi1>, vector<2xi32>
    %3 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %arg0, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @t19_ult_slt_vec_poison0(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<65536> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.icmp "slt" %arg0, %8 : vector<3xi32>
    %11 = llvm.select %10, %arg1, %arg2 : vector<3xi1>, vector<3xi32>
    %12 = llvm.icmp "ult" %arg0, %9 : vector<3xi32>
    %13 = llvm.select %12, %arg0, %11 : vector<3xi1>, vector<3xi32>
    llvm.return %13 : vector<3xi32>
  }
  llvm.func @t20_ult_slt_vec_poison1(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<[65536, 65537, 65536]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.icmp "slt" %arg0, %0 : vector<3xi32>
    %11 = llvm.select %10, %arg1, %arg2 : vector<3xi1>, vector<3xi32>
    %12 = llvm.icmp "ult" %arg0, %9 : vector<3xi32>
    %13 = llvm.select %12, %arg0, %11 : vector<3xi1>, vector<3xi32>
    llvm.return %13 : vector<3xi32>
  }
  llvm.func @t21_ult_slt_vec_poison2(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.icmp "slt" %arg0, %8 : vector<3xi32>
    %10 = llvm.select %9, %arg1, %arg2 : vector<3xi1>, vector<3xi32>
    %11 = llvm.icmp "ult" %arg0, %8 : vector<3xi32>
    %12 = llvm.select %11, %arg0, %10 : vector<3xi1>, vector<3xi32>
    llvm.return %12 : vector<3xi32>
  }
  llvm.func @t22_pointers(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(65536 : i64) : i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    %2 = llvm.icmp "slt" %arg0, %1 : !llvm.ptr
    %3 = llvm.select %2, %arg1, %arg2 : i1, !llvm.ptr
    %4 = llvm.icmp "ult" %arg0, %1 : !llvm.ptr
    %5 = llvm.select %4, %arg0, %3 : i1, !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }
}
