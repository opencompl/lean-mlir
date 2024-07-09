module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t0_umul(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i4
    %3 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i4, i4) -> !llvm.struct<(i4, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i4, i1)> 
    %5 = llvm.xor %4, %1  : i1
    %6 = llvm.select %2, %1, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @t1_commutative(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i4
    %3 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i4, i4) -> !llvm.struct<(i4, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i4, i1)> 
    %5 = llvm.xor %4, %1  : i1
    %6 = llvm.select %5, %1, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @n2_wrong_size(%arg0: i4, %arg1: i4, %arg2: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg1, %0 : i4
    %3 = "llvm.intr.umul.with.overflow"(%arg0, %arg2) : (i4, i4) -> !llvm.struct<(i4, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i4, i1)> 
    %5 = llvm.xor %4, %1  : i1
    %6 = llvm.select %2, %1, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @n3_wrong_pred(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i4
    %3 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i4, i4) -> !llvm.struct<(i4, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i4, i1)> 
    %5 = llvm.xor %4, %1  : i1
    %6 = llvm.select %2, %1, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @n4_not_and(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i4
    %4 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i4, i4) -> !llvm.struct<(i4, i1)>
    %5 = llvm.extractvalue %4[1] : !llvm.struct<(i4, i1)> 
    %6 = llvm.xor %5, %1  : i1
    %7 = llvm.select %3, %6, %2 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @n5_not_zero(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i4
    %3 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i4, i4) -> !llvm.struct<(i4, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i4, i1)> 
    %5 = llvm.xor %4, %1  : i1
    %6 = llvm.select %2, %1, %5 : i1, i1
    llvm.return %6 : i1
  }
}
