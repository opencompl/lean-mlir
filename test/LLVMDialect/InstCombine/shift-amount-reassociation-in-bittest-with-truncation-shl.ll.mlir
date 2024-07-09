module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t0_const_after_fold_lshr_shl_ne(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.shl %arg1, %6  : i64
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }
  llvm.func @t1_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi64>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.sub %0, %arg2  : vector<2xi32>
    %5 = llvm.lshr %arg0, %4  : vector<2xi32>
    %6 = llvm.add %arg2, %1  : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi32> to vector<2xi64>
    %8 = llvm.shl %arg1, %7  : vector<2xi64>
    %9 = llvm.trunc %8 : vector<2xi64> to vector<2xi32>
    %10 = llvm.and %5, %9  : vector<2xi32>
    %11 = llvm.icmp "ne" %10, %3 : vector<2xi32>
    llvm.return %11 : vector<2xi1>
  }
  llvm.func @t2_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi64>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[30, 32]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[1, -2]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.sub %0, %arg2  : vector<2xi32>
    %5 = llvm.lshr %arg0, %4  : vector<2xi32>
    %6 = llvm.add %arg2, %1  : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi32> to vector<2xi64>
    %8 = llvm.shl %arg1, %7  : vector<2xi64>
    %9 = llvm.trunc %8 : vector<2xi64> to vector<2xi32>
    %10 = llvm.and %5, %9  : vector<2xi32>
    %11 = llvm.icmp "ne" %10, %3 : vector<2xi32>
    llvm.return %11 : vector<2xi1>
  }
  llvm.func @gen32() -> i32
  llvm.func @gen64() -> i64
  llvm.func @use32(i32)
  llvm.func @use64(i64)
  llvm.func @t3_oneuse0(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.lshr %arg0, %3  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.zext %5 : i32 to i64
    llvm.call @use64(%6) : (i64) -> ()
    %7 = llvm.shl %arg1, %6  : i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.trunc %7 : i64 to i32
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.and %4, %8  : i32
    llvm.call @use32(%9) : (i32) -> ()
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }
  llvm.func @t4_oneuse1(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.lshr %arg0, %3  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.zext %5 : i32 to i64
    llvm.call @use64(%6) : (i64) -> ()
    %7 = llvm.shl %arg1, %6  : i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.trunc %7 : i64 to i32
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }
  llvm.func @t5_oneuse2(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.zext %5 : i32 to i64
    llvm.call @use64(%6) : (i64) -> ()
    %7 = llvm.shl %arg1, %6  : i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.trunc %7 : i64 to i32
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }
  llvm.func @t6_oneuse3(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.zext %5 : i32 to i64
    llvm.call @use64(%6) : (i64) -> ()
    %7 = llvm.shl %arg1, %6  : i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }
  llvm.func @t7_oneuse4(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.zext %5 : i32 to i64
    llvm.call @use64(%6) : (i64) -> ()
    %7 = llvm.shl %arg1, %6  : i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.trunc %7 : i64 to i32
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }
  llvm.func @t8_oneuse5(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
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
    %7 = llvm.zext %6 : i32 to i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.shl %arg1, %7  : i64
    llvm.call @use64(%8) : (i64) -> ()
    %9 = llvm.trunc %8 : i64 to i32
    llvm.call @use32(%9) : (i32) -> ()
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }
  llvm.func @t9_oneuse5(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(4242424242 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.lshr %arg0, %4  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.zext %6 : i32 to i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.shl %2, %7  : i64
    llvm.call @use64(%8) : (i64) -> ()
    %9 = llvm.trunc %8 : i64 to i32
    llvm.call @use32(%9) : (i32) -> ()
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }
  llvm.func @t10_constants(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(14 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.shl %arg1, %1  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.and %3, %5  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    llvm.return %7 : i1
  }
  llvm.func @t11_constants_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<14> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %arg0, %0  : vector<2xi32>
    %5 = llvm.shl %arg1, %1  : vector<2xi64>
    %6 = llvm.trunc %5 : vector<2xi64> to vector<2xi32>
    %7 = llvm.and %4, %6  : vector<2xi32>
    %8 = llvm.icmp "ne" %7, %3 : vector<2xi32>
    llvm.return %8 : vector<2xi1>
  }
  llvm.func @t12_constants_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[12, 14]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[16, 14]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %arg0, %0  : vector<2xi32>
    %5 = llvm.shl %arg1, %1  : vector<2xi64>
    %6 = llvm.trunc %5 : vector<2xi64> to vector<2xi32>
    %7 = llvm.and %4, %6  : vector<2xi32>
    %8 = llvm.icmp "ne" %7, %3 : vector<2xi32>
    llvm.return %8 : vector<2xi1>
  }
  llvm.func @n13_overshift(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sub %0, %arg2  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg2, %0  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.shl %arg1, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.and %3, %7  : i32
    %9 = llvm.icmp "ne" %8, %1 : i32
    llvm.return %9 : i1
  }
  llvm.func @n14_trunc_of_lshr(%arg0: i64, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.lshr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.add %arg2, %1  : i32
    %8 = llvm.shl %arg1, %7  : i32
    %9 = llvm.and %6, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }
  llvm.func @n15_variable_shamts(%arg0: i32, %arg1: i64, %arg2: i32, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    %2 = llvm.shl %arg1, %arg3  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "ne" %4, %0 : i32
    llvm.return %5 : i1
  }
}
