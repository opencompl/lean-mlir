module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t0_ult_slt_128(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @t1_ult_slt_0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @t2_ult_sgt_128(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg2, %arg1 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @t3_ult_sgt_neg1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-17 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg2, %arg1 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @t4_ugt_slt_128(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(143 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ugt" %5, %2 : i32
    %7 = llvm.select %6, %4, %arg0 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @t5_ugt_slt_0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(143 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ugt" %5, %2 : i32
    %7 = llvm.select %6, %4, %arg0 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @t6_ugt_sgt_128(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(143 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg2, %arg1 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ugt" %5, %2 : i32
    %7 = llvm.select %6, %4, %arg0 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @t7_ugt_sgt_neg1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-17 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(143 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg2, %arg1 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ugt" %5, %2 : i32
    %7 = llvm.select %6, %4, %arg0 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @n8_ult_slt_129(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(129 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @n9_ult_slt_neg17(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-17 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @n10_ugt_slt(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @n11_uge_slt(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(129 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %arg0 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @n12_ule_slt(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %arg0 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @use32(i32)
  llvm.func @use1(i1)
  llvm.func @t10_oneuse0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @n11_oneuse1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @t12_oneuse2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @n13_oneuse3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @n14_oneuse4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @n15_oneuse5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @n16_oneuse6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @n17_oneuse7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg0, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @n18_oneuse8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @n19_oneuse9(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(144 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg0, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.icmp "ult" %5, %2 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.select %6, %arg0, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @t20_ult_slt_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<144> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %arg1, %arg2 : vector<2xi1>, vector<2xi32>
    %5 = llvm.add %arg0, %1  : vector<2xi32>
    %6 = llvm.icmp "ult" %5, %2 : vector<2xi32>
    %7 = llvm.select %6, %arg0, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @t21_ult_slt_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[128, 64]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[16, 8]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[144, 264]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %arg1, %arg2 : vector<2xi1>, vector<2xi32>
    %5 = llvm.add %arg0, %1  : vector<2xi32>
    %6 = llvm.icmp "ult" %5, %2 : vector<2xi32>
    %7 = llvm.select %6, %arg0, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @use2xi1(vector<2xi1>)
  llvm.func @use(vector<2xi1>)
  llvm.func @t22_uge_slt(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[144, 0]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %arg1, %arg2 : vector<2xi1>, vector<2xi32>
    %5 = llvm.add %arg0, %1  : vector<2xi32>
    %6 = llvm.icmp "uge" %5, %2 : vector<2xi32>
    llvm.call @use2xi1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.select %6, %4, %arg0 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @t23_ult_sge(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[128, -2147483648]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[16, -2147483648]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[144, -1]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "sge" %arg0, %0 : vector<2xi32>
    llvm.call @use2xi1(%3) : (vector<2xi1>) -> ()
    %4 = llvm.select %3, %arg2, %arg1 : vector<2xi1>, vector<2xi32>
    %5 = llvm.add %arg0, %1  : vector<2xi32>
    %6 = llvm.icmp "ult" %5, %2 : vector<2xi32>
    %7 = llvm.select %6, %arg0, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
}
