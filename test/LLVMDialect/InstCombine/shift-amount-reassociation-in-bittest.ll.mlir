module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global internal @f.a(0 : i16) {addr_space = 0 : i32, dso_local} : i16
  llvm.func @t0_const_lshr_shl_ne(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.shl %arg1, %0  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @t1_const_shl_lshr_ne(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.lshr %arg1, %0  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @t2_const_lshr_shl_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.shl %arg1, %0  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @t3_const_after_fold_lshr_shl_ne(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.shl %arg1, %5  : i32
    %7 = llvm.and %4, %6  : i32
    %8 = llvm.icmp "ne" %7, %2 : i32
    llvm.return %8 : i1
  }
  llvm.func @t4_const_after_fold_lshr_shl_ne(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.lshr %arg1, %5  : i32
    %7 = llvm.and %4, %6  : i32
    %8 = llvm.icmp "ne" %7, %2 : i32
    llvm.return %8 : i1
  }
  llvm.func @t5_const_lshr_shl_ne(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    %2 = llvm.shl %arg1, %arg3  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @t6_const_shl_lshr_ne(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg2  : i32
    %2 = llvm.lshr %arg1, %arg3  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @t7_const_lshr_shl_ne_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.lshr %arg0, %0  : vector<2xi32>
    %4 = llvm.shl %arg1, %0  : vector<2xi32>
    %5 = llvm.and %4, %3  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi32>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @t8_const_lshr_shl_ne_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %arg0, %0  : vector<2xi32>
    %5 = llvm.shl %arg1, %1  : vector<2xi32>
    %6 = llvm.and %5, %4  : vector<2xi32>
    %7 = llvm.icmp "ne" %6, %3 : vector<2xi32>
    llvm.return %7 : vector<2xi1>
  }
  llvm.func @t9_const_lshr_shl_ne_vec_poison0(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %12 = llvm.lshr %arg0, %8  : vector<3xi32>
    %13 = llvm.shl %arg1, %9  : vector<3xi32>
    %14 = llvm.and %13, %12  : vector<3xi32>
    %15 = llvm.icmp "ne" %14, %11 : vector<3xi32>
    llvm.return %15 : vector<3xi1>
  }
  llvm.func @t10_const_lshr_shl_ne_vec_poison1(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %12 = llvm.lshr %arg0, %0  : vector<3xi32>
    %13 = llvm.shl %arg1, %9  : vector<3xi32>
    %14 = llvm.and %13, %12  : vector<3xi32>
    %15 = llvm.icmp "ne" %14, %11 : vector<3xi32>
    llvm.return %15 : vector<3xi1>
  }
  llvm.func @t11_const_lshr_shl_ne_vec_poison2(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.lshr %arg0, %0  : vector<3xi32>
    %11 = llvm.shl %arg1, %0  : vector<3xi32>
    %12 = llvm.and %11, %10  : vector<3xi32>
    %13 = llvm.icmp "ne" %12, %9 : vector<3xi32>
    llvm.return %13 : vector<3xi1>
  }
  llvm.func @t12_const_lshr_shl_ne_vec_poison3(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %11 = llvm.lshr %arg0, %8  : vector<3xi32>
    %12 = llvm.shl %arg1, %8  : vector<3xi32>
    %13 = llvm.and %12, %11  : vector<3xi32>
    %14 = llvm.icmp "ne" %13, %10 : vector<3xi32>
    llvm.return %14 : vector<3xi1>
  }
  llvm.func @t13_const_lshr_shl_ne_vec_poison4(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.mlir.undef : vector<3xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<3xi32>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %2, %13[%14 : i32] : vector<3xi32>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %10, %15[%16 : i32] : vector<3xi32>
    %18 = llvm.lshr %arg0, %0  : vector<3xi32>
    %19 = llvm.shl %arg1, %9  : vector<3xi32>
    %20 = llvm.and %19, %18  : vector<3xi32>
    %21 = llvm.icmp "ne" %20, %17 : vector<3xi32>
    llvm.return %21 : vector<3xi1>
  }
  llvm.func @t14_const_lshr_shl_ne_vec_poison5(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.mlir.undef : vector<3xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<3xi32>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %1, %13[%14 : i32] : vector<3xi32>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %10, %15[%16 : i32] : vector<3xi32>
    %18 = llvm.lshr %arg0, %8  : vector<3xi32>
    %19 = llvm.shl %arg1, %9  : vector<3xi32>
    %20 = llvm.and %19, %18  : vector<3xi32>
    %21 = llvm.icmp "ne" %20, %17 : vector<3xi32>
    llvm.return %21 : vector<3xi1>
  }
  llvm.func @t15_const_lshr_shl_ne_vec_poison6(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.lshr %arg0, %8  : vector<3xi32>
    %18 = llvm.shl %arg1, %8  : vector<3xi32>
    %19 = llvm.and %18, %17  : vector<3xi32>
    %20 = llvm.icmp "ne" %19, %16 : vector<3xi32>
    llvm.return %20 : vector<3xi1>
  }
  llvm.func @gen32() -> i32
  llvm.func @t16_commutativity0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.shl %2, %0  : i32
    %5 = llvm.and %4, %3  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    llvm.return %6 : i1
  }
  llvm.func @t17_commutativity1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.lshr %2, %0  : i32
    %4 = llvm.shl %arg0, %0  : i32
    %5 = llvm.and %3, %4  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    llvm.return %6 : i1
  }
  llvm.func @use32(i32)
  llvm.func @t18_const_oneuse0(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %arg1, %0  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @t19_const_oneuse1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.shl %arg1, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @t20_const_oneuse2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.shl %arg1, %0  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @t21_const_oneuse3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %arg1, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @t22_const_oneuse4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %arg1, %0  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @t23_const_oneuse5(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.shl %arg1, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @t24_const_oneuse6(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %arg1, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }
  llvm.func @t25_var_oneuse0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %arg1, %arg3  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @t26_var_oneuse1(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    %2 = llvm.shl %arg1, %arg3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @t27_var_oneuse2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    %2 = llvm.shl %arg1, %arg3  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @t28_var_oneuse3(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %arg1, %arg3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @t29_var_oneuse4(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %arg1, %arg3  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @t30_var_oneuse5(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    %2 = llvm.shl %arg1, %arg3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @t31_var_oneuse6(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %arg1, %arg3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @t32_shift_of_const_oneuse0(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-52543054 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.lshr %1, %4  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.add %arg2, %2  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %arg1, %6  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.and %5, %7  : i32
    %9 = llvm.icmp "ne" %8, %3 : i32
    llvm.return %9 : i1
  }
  llvm.func @t33_shift_of_const_oneuse1(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(-52543054 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.lshr %arg0, %4  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %2, %6  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.and %5, %7  : i32
    %9 = llvm.icmp "ne" %8, %3 : i32
    llvm.return %9 : i1
  }
  llvm.func @t34_commutativity0_oneuse0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %2, %0  : i32
    %5 = llvm.and %4, %3  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    llvm.return %6 : i1
  }
  llvm.func @t35_commutativity0_oneuse1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.shl %2, %0  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.and %4, %3  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    llvm.return %6 : i1
  }
  llvm.func @t36_commutativity1_oneuse0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %arg0, %0  : i32
    %5 = llvm.and %3, %4  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    llvm.return %6 : i1
  }
  llvm.func @t37_commutativity1_oneuse1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.lshr %2, %0  : i32
    %4 = llvm.shl %arg0, %0  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.and %3, %4  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    llvm.return %6 : i1
  }
  llvm.func @n38_overshift(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[15, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[17, 1]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %arg0, %0  : vector<2xi32>
    %5 = llvm.shl %arg1, %1  : vector<2xi32>
    %6 = llvm.and %5, %4  : vector<2xi32>
    %7 = llvm.icmp "ne" %6, %3 : vector<2xi32>
    llvm.return %7 : vector<2xi1>
  }
  llvm.func @constantexpr() -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.addressof @f.a : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i16
    %4 = llvm.load %1 {alignment = 2 : i64} : !llvm.ptr -> i16
    %5 = llvm.ashr %4, %2  : i16
    %6 = llvm.icmp "ne" %3, %2 : i16
    %7 = llvm.zext %6 : i1 to i16
    %8 = llvm.ashr %5, %7  : i16
    %9 = llvm.and %8, %2  : i16
    %10 = llvm.icmp "ne" %9, %0 : i16
    llvm.return %10 : i1
  }
  llvm.func @pr44802(%arg0: i3, %arg1: i3, %arg2: i3) -> i1 {
    %0 = llvm.mlir.constant(0 : i3) : i3
    %1 = llvm.icmp "ne" %arg0, %0 : i3
    %2 = llvm.zext %1 : i1 to i3
    %3 = llvm.lshr %arg1, %2  : i3
    %4 = llvm.shl %arg2, %2  : i3
    %5 = llvm.and %3, %4  : i3
    %6 = llvm.icmp "ne" %5, %0 : i3
    llvm.return %6 : i1
  }
}
