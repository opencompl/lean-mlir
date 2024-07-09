module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use32(i32)
  llvm.func @use64(i64)
  llvm.func @highest_bit_test_via_lshr(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.sub %arg1, %1  : i32
    %6 = llvm.lshr %4, %5  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.icmp "ne" %6, %2 : i32
    llvm.return %7 : i1
  }
  llvm.func @highest_bit_test_via_lshr_with_truncation(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.lshr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.sub %arg1, %1  : i32
    %8 = llvm.lshr %6, %7  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.icmp "ne" %8, %2 : i32
    llvm.return %9 : i1
  }
  llvm.func @highest_bit_test_via_ashr(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.ashr %arg0, %3  : i32
    %5 = llvm.sub %arg1, %1  : i32
    %6 = llvm.ashr %4, %5  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.icmp "ne" %6, %2 : i32
    llvm.return %7 : i1
  }
  llvm.func @highest_bit_test_via_ashr_with_truncation(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.sub %arg1, %1  : i32
    %8 = llvm.ashr %6, %7  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.icmp "ne" %8, %2 : i32
    llvm.return %9 : i1
  }
  llvm.func @highest_bit_test_via_lshr_ashr(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.sub %arg1, %1  : i32
    %6 = llvm.ashr %4, %5  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.icmp "ne" %6, %2 : i32
    llvm.return %7 : i1
  }
  llvm.func @highest_bit_test_via_lshr_ashe_with_truncation(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.lshr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.sub %arg1, %1  : i32
    %8 = llvm.ashr %6, %7  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.icmp "ne" %8, %2 : i32
    llvm.return %9 : i1
  }
  llvm.func @highest_bit_test_via_ashr_lshr(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.ashr %arg0, %3  : i32
    %5 = llvm.sub %arg1, %1  : i32
    %6 = llvm.lshr %4, %5  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.icmp "ne" %6, %2 : i32
    llvm.return %7 : i1
  }
  llvm.func @highest_bit_test_via_ashr_lshr_with_truncation(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.sub %arg1, %1  : i32
    %8 = llvm.lshr %6, %7  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.icmp "ne" %8, %2 : i32
    llvm.return %9 : i1
  }
  llvm.func @unsigned_sign_bit_extract(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @unsigned_sign_bit_extract_extrause(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @unsigned_sign_bit_extract_extrause__ispositive(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @signed_sign_bit_extract(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @signed_sign_bit_extract_extrause(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @unsigned_sign_bit_extract_with_trunc(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @unsigned_sign_bit_extract_with_trunc_extrause(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.trunc %2 : i64 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @signed_sign_bit_extract_trunc(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @signed_sign_bit_extract_trunc_extrause(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.trunc %2 : i64 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }
}
