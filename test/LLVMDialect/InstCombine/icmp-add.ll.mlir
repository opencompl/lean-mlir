module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @cvt_icmp_0_zext_plus_zext_eq_i16(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.zext %arg1 : i16 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_0_zext_plus_zext_eq_i8(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.zext %arg1 : i8 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_neg_2_zext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_neg_1_zext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_0_zext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_1_zext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_1_zext_plus_zext_eq_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.zext %arg1 : vector<2xi1> to vector<2xi32>
    %3 = llvm.add %2, %1  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %0 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @cvt_icmp_2_zext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_neg_2_sext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_neg_1_sext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_0_sext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_1_sext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_2_sext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_neg_2_sext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_neg_1_sext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_0_sext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_1_sext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_2_sext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_neg_2_zext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_neg_1_zext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_0_zext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_1_zext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_1_zext_plus_zext_ne_extra_use_1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_1_zext_plus_zext_ne_extra_use_2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.zext %arg1 : i1 to i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_2_zext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_neg_2_sext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_neg_1_sext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_0_sext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_1_sext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_2_sext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_neg_2_sext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_neg_1_sext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_0_sext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_1_sext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_2_sext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_2_sext_plus_zext_ne_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.zext %arg1 : vector<2xi1> to vector<2xi32>
    %3 = llvm.add %1, %2 overflow<nsw>  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %0 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @cvt_icmp_neg_2_zext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_neg_2_zext_plus_sext_eq_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.sext %arg1 : vector<2xi1> to vector<2xi32>
    %3 = llvm.add %2, %1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %0 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @cvt_icmp_neg_1_zext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_0_zext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_1_zext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_2_zext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_neg_2_zext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_neg_1_zext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_0_zext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_1_zext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @cvt_icmp_2_zext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp1(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg0 : i1 to i32
    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.load %arg2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    llvm.return %5 : i1
  }
  llvm.func @test_cvt_icmp2(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg0 : i1 to i32
    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.load %arg2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    llvm.return %5 : i1
  }
  llvm.func @test_zext_zext_cvt_neg_2_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_zext_cvt_neg_1_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_zext_cvt_0_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_zext_cvt_2_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_sext_sext_cvt_neg_2_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_sext_sext_cvt_neg_1_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_sext_sext_cvt_0_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_sext_sext_cvt_1_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_sext_sext_cvt_2_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_sext_zext_cvt_neg_2_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_sext_zext_cvt_neg_1_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_sext_zext_cvt_0_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_sext_zext_cvt_2_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_sext_cvt_neg_1_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_sext_cvt_0_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_sext_cvt_1_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp4(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_zext_cvt_neg_2_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_zext_cvt_1_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_zext_cvt_2_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_sext_sext_cvt_neg_2_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_sext_sext_cvt_0_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_sext_sext_cvt_2_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_sext_cvt_neg_2_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_sext_cvt_neg_1_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_sext_cvt_0_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_sext_cvt_1_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_sext_cvt_2_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp5(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "uge" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp6(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ule" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp7(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_zext_cvt_neg_2_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_zext_cvt_neg_1_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_zext_cvt_2_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_sext_sext_cvt_neg_2_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_sext_sext_cvt_0_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_sext_sext_cvt_2_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_sext_cvt_neg_2_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_sext_cvt_neg_1_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_sext_cvt_0_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_sext_cvt_1_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_sext_cvt_2_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_zext_cvt_neg_2_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_zext_cvt_neg_1_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_zext_cvt_2_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_sext_sext_cvt_neg_2_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_sext_sext_cvt_0_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_sext_sext_cvt_2_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_sext_cvt_neg_2_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_sext_cvt_neg_1_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_sext_cvt_0_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_sext_cvt_1_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_zext_sext_cvt_2_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp8(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sge" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp9(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp10(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sle" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp11(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp12(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "uge" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp13(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp14(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ule" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp15(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp16(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sge" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp17(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp18(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sle" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp19(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp20(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "uge" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp21(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp22(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ule" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp23(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp24(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sge" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp25(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_cvt_icmp26(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sle" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @test1vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.add %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.sub %arg0, %0  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test2vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-5> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "ugt" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @test3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-2147483644 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test3vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2147483644> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483644 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "sge" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test4multiuse(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(-2147483644 : i32) : i32
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<(i32, i1)>
    %3 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.insertvalue %3, %2[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.insertvalue %4, %5[1] : !llvm.struct<(i32, i1)> 
    llvm.return %6 : !llvm.struct<(i32, i1)>
  }
  llvm.func @test4vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-2147483644> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "sge" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @nsw_slt1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(-27 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nsw_slt1_splat_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<100> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-27> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @nsw_slt2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-100 : i8) : i8
    %1 = llvm.mlir.constant(27 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nsw_slt2_splat_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-100> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<27> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @nsw_slt3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(-26 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nsw_slt4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-100 : i8) : i8
    %1 = llvm.mlir.constant(26 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nsw_sgt1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-100 : i8) : i8
    %1 = llvm.mlir.constant(26 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nsw_sgt1_splat_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-100> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<26> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @nsw_sgt2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(-26 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nsw_sgt2_splat_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<100> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-26> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @slt_zero_add_nsw(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @slt_zero_add_nsw_splat_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @nsw_slt3_ov_no(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(-28 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nsw_slt4_ov(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(-29 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @nsw_slt5_ov(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-100 : i8) : i8
    %1 = llvm.mlir.constant(28 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @slt_zero_add_nsw_signbit(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @slt_zero_add_nuw_signbit(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @reduce_add_ult(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @reduce_add_ugt(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @reduce_add_ule(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "ule" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @reduce_add_uge(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "uge" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @ult_add_ssubov(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(71 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @ult_add_nonuw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(71 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @uge_add_nonuw(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "uge" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @op_ugt_sum_commute1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg0  : i8
    %2 = llvm.sdiv %0, %arg1  : i8
    %3 = llvm.add %1, %2  : i8
    %4 = llvm.icmp "ugt" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @op_ugt_sum_vec_commute2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sdiv %0, %arg0  : vector<2xi8>
    %2 = llvm.sdiv %0, %arg1  : vector<2xi8>
    %3 = llvm.add %2, %1  : vector<2xi8>
    %4 = llvm.icmp "ugt" %1, %3 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @sum_ugt_op_uses(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg0  : i8
    %2 = llvm.sdiv %0, %arg1  : i8
    %3 = llvm.add %1, %2  : i8
    llvm.store %3, %arg2 {alignment = 1 : i64} : i8, !llvm.ptr
    %4 = llvm.icmp "ugt" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @sum_ult_op_vec_commute1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-42, 42]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sdiv %0, %arg0  : vector<2xi8>
    %3 = llvm.sdiv %1, %arg1  : vector<2xi8>
    %4 = llvm.add %2, %3  : vector<2xi8>
    %5 = llvm.icmp "ult" %4, %2 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @sum_ult_op_commute2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg0  : i8
    %2 = llvm.sdiv %0, %arg1  : i8
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @sum_ult_op_uses(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.add %arg1, %arg0  : i8
    llvm.store %0, %arg2 {alignment = 1 : i64} : i8, !llvm.ptr
    %1 = llvm.icmp "ult" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @common_op_nsw(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.add %arg0, %arg2 overflow<nsw>  : i32
    %1 = llvm.add %arg1, %arg2 overflow<nsw>  : i32
    %2 = llvm.icmp "sgt" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @common_op_nsw_extra_uses(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.add %arg0, %arg2 overflow<nsw>  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.add %arg1, %arg2 overflow<nsw>  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "sgt" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @common_op_nuw(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.add %arg0, %arg2 overflow<nuw>  : i32
    %1 = llvm.add %arg2, %arg1 overflow<nuw>  : i32
    %2 = llvm.icmp "ugt" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @common_op_nuw_extra_uses(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.add %arg0, %arg2 overflow<nuw>  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.add %arg2, %arg1 overflow<nuw>  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "ugt" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @common_op_nsw_commute(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.add %arg2, %arg0 overflow<nsw>  : i32
    %1 = llvm.add %arg1, %arg2 overflow<nsw>  : i32
    %2 = llvm.icmp "slt" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @common_op_nuw_commute(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.add %arg2, %arg0 overflow<nuw>  : i32
    %1 = llvm.add %arg2, %arg1 overflow<nuw>  : i32
    %2 = llvm.icmp "ult" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @common_op_test29(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.add %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.icmp "sgt" %0, %arg0 : i32
    llvm.return %1 : i1
  }
  llvm.func @sum_nuw(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.add %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.icmp "ugt" %0, %arg0 : i32
    llvm.return %1 : i1
  }
  llvm.func @sum_nsw_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.add %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }
  llvm.func @sum_nuw_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.add %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }
  llvm.func @use1(i1)
  llvm.func @use8(i8)
  llvm.func @bzip1(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.add %arg0, %arg2  : i8
    %1 = llvm.add %arg1, %arg2  : i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    llvm.return
  }
  llvm.func @bzip2(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.add %arg0, %arg2  : i8
    %1 = llvm.add %arg1, %arg2  : i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    llvm.call @use8(%0) : (i8) -> ()
    llvm.return
  }
  llvm.func @icmp_eq_add_undef(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.add %arg0, %6  : vector<2xi32>
    %9 = llvm.icmp "eq" %8, %7 : vector<2xi32>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @icmp_eq_add_non_splat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_eq_add_undef2(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.add %arg0, %0  : vector<2xi32>
    %9 = llvm.icmp "eq" %8, %7 : vector<2xi32>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @icmp_eq_add_non_splat2(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 11]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @without_nsw_nuw(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(37 : i8) : i8
    %1 = llvm.mlir.constant(35 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.icmp "eq" %3, %2 : i8
    llvm.return %4 : i1
  }
  llvm.func @with_nsw_nuw(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(37 : i8) : i8
    %1 = llvm.mlir.constant(35 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw, nuw>  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.icmp "eq" %3, %2 : i8
    llvm.return %4 : i1
  }
  llvm.func @with_nsw_large(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(37 : i8) : i8
    %1 = llvm.mlir.constant(35 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.icmp "eq" %3, %2 : i8
    llvm.return %4 : i1
  }
  llvm.func @with_nsw_small(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(35 : i8) : i8
    %1 = llvm.mlir.constant(37 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.icmp "eq" %3, %2 : i8
    llvm.return %4 : i1
  }
  llvm.func @with_nuw_large(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(37 : i8) : i8
    %1 = llvm.mlir.constant(35 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.icmp "eq" %3, %2 : i8
    llvm.return %4 : i1
  }
  llvm.func @with_nuw_small(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(35 : i8) : i8
    %1 = llvm.mlir.constant(37 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.icmp "eq" %3, %2 : i8
    llvm.return %4 : i1
  }
  llvm.func @with_nuw_large_negative(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-37 : i8) : i8
    %1 = llvm.mlir.constant(-35 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.icmp "eq" %3, %2 : i8
    llvm.return %4 : i1
  }
  llvm.func @ugt_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(124 : i8) : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ugt_offset_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-2147483607 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @ugt_offset_splat(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(9 : i5) : i5
    %1 = llvm.mlir.constant(dense<9> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.mlir.constant(-8 : i5) : i5
    %3 = llvm.mlir.constant(dense<-8> : vector<2xi5>) : vector<2xi5>
    %4 = llvm.add %arg0, %1  : vector<2xi5>
    %5 = llvm.icmp "ugt" %4, %3 : vector<2xi5>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @ugt_wrong_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ugt_offset_nuw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(124 : i8) : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ult_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(122 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ult_offset_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-2147483606 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @ult_offset_splat(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(9 : i5) : i5
    %1 = llvm.mlir.constant(dense<9> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.mlir.constant(-7 : i5) : i5
    %3 = llvm.mlir.constant(dense<-7> : vector<2xi5>) : vector<2xi5>
    %4 = llvm.add %arg0, %1  : vector<2xi5>
    %5 = llvm.icmp "ult" %4, %3 : vector<2xi5>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @ult_wrong_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ult_offset_nuw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-86 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @sgt_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(-7 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @sgt_offset_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(41 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "sgt" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @sgt_offset_splat(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(9 : i5) : i5
    %1 = llvm.mlir.constant(dense<9> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.mlir.constant(8 : i5) : i5
    %3 = llvm.mlir.constant(dense<8> : vector<2xi5>) : vector<2xi5>
    %4 = llvm.add %arg0, %1  : vector<2xi5>
    %5 = llvm.icmp "sgt" %4, %3 : vector<2xi5>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @sgt_wrong_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-7 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @sgt_offset_nsw(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(41 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @slt_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @slt_offset_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @slt_offset_splat(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(9 : i5) : i5
    %1 = llvm.mlir.constant(dense<9> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.add %arg0, %1  : vector<2xi5>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi5>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @slt_wrong_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(-7 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @slt_offset_nsw(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @increment_max(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @decrement_max(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @increment_min(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @decrement_min(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @icmp_add_add_C(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }
  llvm.func @icmp_add_add_C_pred(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.icmp "uge" %2, %arg0 : i32
    llvm.return %3 : i1
  }
  llvm.func @icmp_add_add_C_wrong_pred(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.icmp "ule" %2, %arg0 : i32
    llvm.return %3 : i1
  }
  llvm.func @icmp_add_add_C_wrong_operand(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.icmp "ult" %2, %arg2 : i32
    llvm.return %3 : i1
  }
  llvm.func @icmp_add_add_C_different_const(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }
  llvm.func @icmp_add_add_C_vector(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %arg1  : vector<2xi8>
    %2 = llvm.add %1, %0  : vector<2xi8>
    %3 = llvm.icmp "ult" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_add_add_C_vector_undef(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.add %arg0, %arg1  : vector<2xi8>
    %8 = llvm.add %7, %6  : vector<2xi8>
    %9 = llvm.icmp "ult" %8, %arg0 : vector<2xi8>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @icmp_add_add_C_comm1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg1, %arg0  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }
  llvm.func @icmp_add_add_C_comm2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.icmp "ugt" %2, %4 : i32
    llvm.return %5 : i1
  }
  llvm.func @icmp_add_add_C_comm2_pred(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.icmp "ule" %2, %4 : i32
    llvm.return %5 : i1
  }
  llvm.func @icmp_add_add_C_comm2_wrong_pred(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.icmp "ult" %2, %4 : i32
    llvm.return %5 : i1
  }
  llvm.func @icmp_add_add_C_comm3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.add %arg1, %2  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.icmp "ugt" %2, %4 : i32
    llvm.return %5 : i1
  }
  llvm.func @icmp_add_add_C_extra_use1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }
  llvm.func @icmp_add_add_C_extra_use2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }
  llvm.func @icmp_dec_assume_nonzero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.icmp "ult" %4, %2 : i8
    llvm.return %5 : i1
  }
  llvm.func @icmp_dec_sub_assume_nonzero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(11 : i8) : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.sub %arg0, %1  : i8
    %5 = llvm.icmp "ult" %4, %2 : i8
    llvm.return %5 : i1
  }
  llvm.func @icmp_dec_nonzero(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.mlir.constant(7 : i16) : i16
    %3 = llvm.or %arg0, %0  : i16
    %4 = llvm.add %3, %1  : i16
    %5 = llvm.icmp "ult" %4, %2 : i16
    llvm.return %5 : i1
  }
  llvm.func @icmp_dec_nonzero_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[15, 17]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.or %arg0, %0  : vector<2xi32>
    %4 = llvm.add %3, %1  : vector<2xi32>
    %5 = llvm.icmp "ult" %4, %2 : vector<2xi32>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @icmp_dec_notnonzero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_addnuw_nonzero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg1 overflow<nuw>  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @icmp_addnuw_nonzero_fail_multiuse(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.add %arg0, %arg1 overflow<nuw>  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %2 : i1
  }
  llvm.func @ult_add_C2_pow2_C_neg(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ult_add_nsw_C2_pow2_C_neg(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ult_add_nuw_nsw_C2_pow2_C_neg(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw, nuw>  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ult_add_C2_neg_C_pow2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.mlir.constant(32 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ult_add_C2_pow2_C_neg_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-32> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @ult_add_C2_pow2_C_neg_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.mlir.addressof @use : !llvm.ptr
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    llvm.call %2(%3) : !llvm.ptr, (i8) -> ()
    llvm.return %4 : i1
  }
  llvm.func @uge_add_C2_pow2_C_neg(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "uge" %2, %1 : i8
    llvm.return %3 : i1
  }
}
