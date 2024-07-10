module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use.i1(i1)
  llvm.func @use.i8(i8)
  llvm.func @use.i16(i16)
  llvm.func @and_test1(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17664 : i16) : i16
    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i16
    %4 = llvm.trunc %3 : i16 to i8
    %5 = llvm.icmp "eq" %4, %0 : i8
    %6 = llvm.and %3, %1  : i16
    %7 = llvm.icmp "eq" %6, %2 : i16
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @and_test1_logical(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17664 : i16) : i16
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i16
    %5 = llvm.trunc %4 : i16 to i8
    %6 = llvm.icmp "eq" %5, %0 : i8
    %7 = llvm.and %4, %1  : i16
    %8 = llvm.icmp "eq" %7, %2 : i16
    %9 = llvm.select %6, %8, %3 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @and_test1_vector(%arg0: !llvm.ptr) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-256> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.mlir.constant(dense<17664> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> vector<2xi16>
    %4 = llvm.trunc %3 : vector<2xi16> to vector<2xi8>
    %5 = llvm.icmp "eq" %4, %0 : vector<2xi8>
    %6 = llvm.and %3, %1  : vector<2xi16>
    %7 = llvm.icmp "eq" %6, %2 : vector<2xi16>
    %8 = llvm.and %5, %7  : vector<2xi1>
    llvm.return %8 : vector<2xi1>
  }
  llvm.func @and_test2(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-256 : i16) : i16
    %1 = llvm.mlir.constant(32512 : i16) : i16
    %2 = llvm.mlir.constant(69 : i8) : i8
    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i16
    %4 = llvm.and %3, %0  : i16
    %5 = llvm.icmp "eq" %4, %1 : i16
    %6 = llvm.trunc %3 : i16 to i8
    %7 = llvm.icmp "eq" %6, %2 : i8
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @and_test2_logical(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-256 : i16) : i16
    %1 = llvm.mlir.constant(32512 : i16) : i16
    %2 = llvm.mlir.constant(69 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i16
    %5 = llvm.and %4, %0  : i16
    %6 = llvm.icmp "eq" %5, %1 : i16
    %7 = llvm.trunc %4 : i16 to i8
    %8 = llvm.icmp "eq" %7, %2 : i8
    %9 = llvm.select %6, %8, %3 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @and_test2_vector(%arg0: !llvm.ptr) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-256> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<32512> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.mlir.constant(dense<69> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> vector<2xi16>
    %4 = llvm.and %3, %0  : vector<2xi16>
    %5 = llvm.icmp "eq" %4, %1 : vector<2xi16>
    %6 = llvm.trunc %3 : vector<2xi16> to vector<2xi8>
    %7 = llvm.icmp "eq" %6, %2 : vector<2xi8>
    %8 = llvm.and %5, %7  : vector<2xi1>
    llvm.return %8 : vector<2xi1>
  }
  llvm.func @or_basic(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17664 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @or_basic_commuted(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-256 : i16) : i16
    %1 = llvm.mlir.constant(32512 : i16) : i16
    %2 = llvm.mlir.constant(69 : i8) : i8
    %3 = llvm.and %arg0, %0  : i16
    %4 = llvm.icmp "ne" %3, %1 : i16
    %5 = llvm.trunc %arg0 : i16 to i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @or_vector(%arg0: vector<2xi16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-256> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.mlir.constant(dense<17664> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.trunc %arg0 : vector<2xi16> to vector<2xi8>
    %4 = llvm.icmp "ne" %3, %0 : vector<2xi8>
    %5 = llvm.and %arg0, %1  : vector<2xi16>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi16>
    %7 = llvm.or %4, %6  : vector<2xi1>
    llvm.return %7 : vector<2xi1>
  }
  llvm.func @or_nontrivial_mask1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(3840 : i16) : i16
    %2 = llvm.mlir.constant(1280 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @or_nontrivial_mask2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-4096 : i16) : i16
    %2 = llvm.mlir.constant(20480 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @or_extra_use1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-4096 : i16) : i16
    %2 = llvm.mlir.constant(20480 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    llvm.call @use.i1(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @or_extra_use2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-4096 : i16) : i16
    %2 = llvm.mlir.constant(20480 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    llvm.call @use.i1(%6) : (i1) -> ()
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @or_extra_use3(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-4096 : i16) : i16
    %2 = llvm.mlir.constant(20480 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @or_extra_use4(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-4096 : i16) : i16
    %2 = llvm.mlir.constant(20480 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    llvm.call @use.i16(%5) : (i16) -> ()
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @or_wrong_pred1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17664 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "eq" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @or_wrong_pred2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17664 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "eq" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @or_wrong_pred3(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17664 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "eq" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "eq" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @or_wrong_op(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17664 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg1, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @or_wrong_const1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17665 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @or_wrong_const2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-255 : i16) : i16
    %2 = llvm.mlir.constant(17665 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
}
