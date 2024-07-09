module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @sext_xor_sub(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0  : i64
    %2 = llvm.sub %1, %0  : i64
    llvm.return %2 : i64
  }
  llvm.func @sext_xor_sub_1(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %0, %arg0  : i64
    %2 = llvm.sub %1, %0  : i64
    llvm.return %2 : i64
  }
  llvm.func @sext_xor_sub_2(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0  : i64
    %2 = llvm.sub %0, %1  : i64
    llvm.return %2 : i64
  }
  llvm.func @sext_xor_sub_3(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %0, %arg0  : i64
    %2 = llvm.sub %0, %1  : i64
    llvm.return %2 : i64
  }
  llvm.func @sext_non_bool_xor_sub(%arg0: i64, %arg1: i8) -> i64 {
    %0 = llvm.sext %arg1 : i8 to i64
    %1 = llvm.xor %arg0, %0  : i64
    %2 = llvm.sub %1, %0  : i64
    llvm.return %2 : i64
  }
  llvm.func @sext_non_bool_xor_sub_1(%arg0: i64, %arg1: i8) -> i64 {
    %0 = llvm.sext %arg1 : i8 to i64
    %1 = llvm.xor %0, %arg0  : i64
    %2 = llvm.sub %1, %0  : i64
    llvm.return %2 : i64
  }
  llvm.func @sext_diff_i1_xor_sub(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.xor %arg0, %0  : i64
    %3 = llvm.sub %0, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @sext_diff_i1_xor_sub_1(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.xor %0, %arg0  : i64
    %3 = llvm.sub %0, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @sext_multi_uses(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0  : i64
    %2 = llvm.sub %1, %0  : i64
    %3 = llvm.mul %arg2, %0  : i64
    %4 = llvm.add %3, %2  : i64
    llvm.return %4 : i64
  }
  llvm.func @xor_multi_uses(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0  : i64
    %2 = llvm.sub %1, %0  : i64
    %3 = llvm.mul %arg2, %1  : i64
    %4 = llvm.add %3, %2  : i64
    llvm.return %4 : i64
  }
  llvm.func @absdiff(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.xor %1, %2  : i64
    %4 = llvm.sub %3, %1  : i64
    llvm.return %4 : i64
  }
  llvm.func @absdiff1(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.xor %2, %1  : i64
    %4 = llvm.sub %3, %1  : i64
    llvm.return %4 : i64
  }
  llvm.func @absdiff2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sub %arg1, %arg0  : i64
    %3 = llvm.xor %2, %1  : i64
    %4 = llvm.sub %3, %1  : i64
    llvm.return %4 : i64
  }
}
