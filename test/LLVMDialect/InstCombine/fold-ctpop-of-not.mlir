module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use.i8(i8)
  llvm.func @fold_sub_c_ctpop(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @fold_sub_var_ctpop_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.intr.ctpop(%1)  : (i8) -> i8
    %3 = llvm.sub %arg1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @fold_sub_ctpop_c(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[63, 64]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.ctpop(%2)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.sub %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @fold_add_ctpop_c(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.add %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @fold_distjoint_or_ctpop_c(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.or %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @fold_or_ctpop_c_fail(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(65 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.or %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @fold_add_ctpop_var_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.intr.ctpop(%1)  : (i8) -> i8
    %3 = llvm.add %2, %arg1  : i8
    llvm.return %3 : i8
  }
  llvm.func @fold_icmp_sgt_ctpop_c_i2_fail(%arg0: i2, %arg1: i2) -> i1 {
    %0 = llvm.mlir.constant(-1 : i2) : i2
    %1 = llvm.mlir.constant(1 : i2) : i2
    %2 = llvm.xor %arg0, %0  : i2
    %3 = llvm.intr.ctpop(%2)  : (i2) -> i2
    %4 = llvm.icmp "sgt" %3, %1 : i2
    llvm.return %4 : i1
  }
  llvm.func @fold_cmp_eq_ctpop_c(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @fold_cmp_eq_ctpop_c_multiuse_fail(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    llvm.return %4 : i1
  }
  llvm.func @fold_cmp_ne_ctpop_c(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[44, 3]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.ctpop(%2)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ne" %3, %1 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @fold_cmp_ne_ctpop_var_fail(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "ne" %2, %arg1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @fold_cmp_ult_ctpop_c(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.select %arg2, %3, %4 : i1, i8
    %6 = llvm.intr.ctpop(%5)  : (i8) -> i8
    %7 = llvm.icmp "ult" %6, %2 : i8
    llvm.return %7 : i1
  }
  llvm.func @fold_cmp_sle_ctpop_c(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.select %arg2, %3, %4 : i1, i8
    %6 = llvm.intr.ctpop(%5)  : (i8) -> i8
    %7 = llvm.icmp "sle" %6, %2 : i8
    llvm.return %7 : i1
  }
  llvm.func @fold_cmp_ult_ctpop_c_no_not_inst_save_fail(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @fold_cmp_ugt_ctpop_c(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[8, 6]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.ctpop(%2)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ugt" %3, %1 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @fold_cmp_ugt_ctpop_c_out_of_range_fail(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 10]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.ctpop(%2)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ugt" %3, %1 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
}
