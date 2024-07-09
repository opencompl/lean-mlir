module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use1(i1)
  llvm.func @use16(i16)
  llvm.func @use32(i32)
  llvm.func @use64(i64)
  llvm.func @t0_notrunc_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @t0_notrunc_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.or %4, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @t1_notrunc_sub(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.sub %4, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @t2_trunc_add(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.icmp "slt" %arg0, %1 : i64
    %9 = llvm.shl %2, %arg1  : i32
    %10 = llvm.select %8, %9, %3 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use1(%8) : (i1) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    %11 = llvm.add %10, %7  : i32
    llvm.return %11 : i32
  }
  llvm.func @t2_trunc_or(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.icmp "slt" %arg0, %1 : i64
    %9 = llvm.shl %2, %arg1  : i32
    %10 = llvm.select %8, %9, %3 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use1(%8) : (i1) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    %11 = llvm.or %10, %7  : i32
    llvm.return %11 : i32
  }
  llvm.func @t3_trunc_sub(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.icmp "slt" %arg0, %1 : i64
    %9 = llvm.shl %2, %arg1  : i32
    %10 = llvm.select %8, %9, %3 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use1(%8) : (i1) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    %11 = llvm.sub %7, %10  : i32
    llvm.return %11 : i32
  }
  llvm.func @t4_commutativity0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @t5_commutativity1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "sgt" %arg0, %1 : i32
    %6 = llvm.shl %1, %arg1  : i32
    %7 = llvm.select %5, %2, %6 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @t6_commutativity2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %7, %4  : i32
    llvm.return %8 : i32
  }
  llvm.func @t7_trunc_extrause0(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.icmp "slt" %arg0, %1 : i64
    %9 = llvm.shl %2, %arg1  : i32
    %10 = llvm.select %8, %9, %3 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use1(%8) : (i1) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    %11 = llvm.add %10, %7  : i32
    llvm.return %11 : i32
  }
  llvm.func @t8_trunc_extrause1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.icmp "slt" %arg0, %1 : i64
    %9 = llvm.shl %2, %arg1  : i32
    %10 = llvm.select %8, %9, %3 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use1(%8) : (i1) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.add %10, %7  : i32
    llvm.return %11 : i32
  }
  llvm.func @n9_trunc_extrause2(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.icmp "slt" %arg0, %1 : i64
    %9 = llvm.shl %2, %arg1  : i32
    %10 = llvm.select %8, %9, %3 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use1(%8) : (i1) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.add %10, %7  : i32
    llvm.return %11 : i32
  }
  llvm.func @t10_preserve_exact(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @t11_different_zext_of_shamt(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.zext %arg1 : i8 to i16
    %4 = llvm.sub %0, %3  : i16
    %5 = llvm.zext %4 : i16 to i32
    %6 = llvm.lshr %arg0, %5  : i32
    %7 = llvm.icmp "slt" %arg0, %1 : i32
    %8 = llvm.zext %arg1 : i8 to i32
    %9 = llvm.shl %2, %8  : i32
    %10 = llvm.select %7, %9, %1 : i1, i32
    llvm.call @use16(%3) : (i16) -> ()
    llvm.call @use16(%4) : (i16) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.add %6, %10  : i32
    llvm.return %11 : i32
  }
  llvm.func @t12_add_sext_of_magic(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.sub %0, %4  : i32
    %6 = llvm.lshr %arg0, %5  : i32
    %7 = llvm.icmp "slt" %arg0, %1 : i32
    %8 = llvm.zext %arg1 : i8 to i16
    %9 = llvm.shl %2, %8  : i16
    %10 = llvm.select %7, %9, %3 : i1, i16
    %11 = llvm.sext %10 : i16 to i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use16(%8) : (i16) -> ()
    llvm.call @use16(%9) : (i16) -> ()
    llvm.call @use16(%10) : (i16) -> ()
    llvm.call @use32(%11) : (i32) -> ()
    %12 = llvm.add %6, %11  : i32
    llvm.return %12 : i32
  }
  llvm.func @t13_sub_zext_of_magic(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.sub %0, %4  : i32
    %6 = llvm.lshr %arg0, %5  : i32
    %7 = llvm.icmp "slt" %arg0, %1 : i32
    %8 = llvm.zext %arg1 : i8 to i16
    %9 = llvm.shl %2, %8  : i16
    %10 = llvm.select %7, %9, %3 : i1, i16
    %11 = llvm.zext %10 : i16 to i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use16(%8) : (i16) -> ()
    llvm.call @use16(%9) : (i16) -> ()
    llvm.call @use16(%10) : (i16) -> ()
    llvm.call @use32(%11) : (i32) -> ()
    %12 = llvm.sub %6, %11  : i32
    llvm.return %12 : i32
  }
  llvm.func @t14_add_sext_of_shl(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.zext %arg1 : i8 to i32
    %4 = llvm.sub %0, %3  : i32
    %5 = llvm.lshr %arg0, %4  : i32
    %6 = llvm.icmp "slt" %arg0, %1 : i32
    %7 = llvm.zext %arg1 : i8 to i16
    %8 = llvm.shl %2, %7  : i16
    %9 = llvm.sext %8 : i16 to i32
    %10 = llvm.select %6, %9, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use1(%6) : (i1) -> ()
    llvm.call @use16(%7) : (i16) -> ()
    llvm.call @use16(%8) : (i16) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.add %5, %10  : i32
    llvm.return %11 : i32
  }
  llvm.func @t15_sub_zext_of_shl(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.zext %arg1 : i8 to i32
    %4 = llvm.sub %0, %3  : i32
    %5 = llvm.lshr %arg0, %4  : i32
    %6 = llvm.icmp "slt" %arg0, %1 : i32
    %7 = llvm.zext %arg1 : i8 to i16
    %8 = llvm.shl %2, %7  : i16
    %9 = llvm.zext %8 : i16 to i32
    %10 = llvm.select %6, %9, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use1(%6) : (i1) -> ()
    llvm.call @use16(%7) : (i16) -> ()
    llvm.call @use16(%8) : (i16) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.sub %5, %10  : i32
    llvm.return %11 : i32
  }
  llvm.func @n16(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @n17_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @n18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %1, %6 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @n19(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg1, %1 : i32
    %6 = llvm.shl %2, %arg2  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @n20(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg2  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @n21(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "sgt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @n22(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(63 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.icmp "slt" %arg0, %1 : i64
    %9 = llvm.shl %2, %arg1  : i32
    %10 = llvm.select %8, %9, %3 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use1(%8) : (i1) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.add %10, %7  : i32
    llvm.return %11 : i32
  }
  llvm.func @n23(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.ashr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @n24(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.sub %7, %4  : i32
    llvm.return %8 : i32
  }
  llvm.func @n25_sub(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.sub %4, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @n26(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %2 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @n27_add_zext_of_magic(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.sub %0, %4  : i32
    %6 = llvm.lshr %arg0, %5  : i32
    %7 = llvm.icmp "slt" %arg0, %1 : i32
    %8 = llvm.zext %arg1 : i8 to i16
    %9 = llvm.shl %2, %8  : i16
    %10 = llvm.select %7, %9, %3 : i1, i16
    %11 = llvm.zext %10 : i16 to i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use16(%8) : (i16) -> ()
    llvm.call @use16(%9) : (i16) -> ()
    llvm.call @use16(%10) : (i16) -> ()
    llvm.call @use32(%11) : (i32) -> ()
    %12 = llvm.add %6, %11  : i32
    llvm.return %12 : i32
  }
  llvm.func @n28_sub_sext_of_magic(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.sub %0, %4  : i32
    %6 = llvm.lshr %arg0, %5  : i32
    %7 = llvm.icmp "slt" %arg0, %1 : i32
    %8 = llvm.zext %arg1 : i8 to i16
    %9 = llvm.shl %2, %8  : i16
    %10 = llvm.select %7, %9, %3 : i1, i16
    %11 = llvm.sext %10 : i16 to i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use16(%8) : (i16) -> ()
    llvm.call @use16(%9) : (i16) -> ()
    llvm.call @use16(%10) : (i16) -> ()
    llvm.call @use32(%11) : (i32) -> ()
    %12 = llvm.sub %6, %11  : i32
    llvm.return %12 : i32
  }
  llvm.func @n290_or_with_wrong_magic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.or %4, %7  : i32
    llvm.return %8 : i32
  }
}
