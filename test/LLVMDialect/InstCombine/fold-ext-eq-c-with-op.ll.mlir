module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use.i8(i8)
  llvm.func @fold_add_zext_eq_0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.zext %1 : i1 to i8
    %3 = llvm.add %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @fold_add_sext_eq_4_6(%arg0: vector<2xi6>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[4, -127]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.zext %arg0 : vector<2xi6> to vector<2xi8>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi8>
    %3 = llvm.sext %2 : vector<2xi1> to vector<2xi8>
    %4 = llvm.add %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @fold_add_zext_eq_0_fail_multiuse_exp(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.zext %1 : i1 to i8
    %3 = llvm.add %arg0, %2  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.return %3 : i8
  }
  llvm.func @fold_add_sext_eq_4_fail_wrong_cond(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.icmp "eq" %arg1, %0 : i8
    %2 = llvm.sext %1 : i1 to i8
    %3 = llvm.add %arg0, %2  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.return %3 : i8
  }
}
