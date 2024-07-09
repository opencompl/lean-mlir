module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use8(i8)
  llvm.func @use1(i1)
  llvm.func @t0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    %3 = llvm.icmp "ule" %1, %arg0 : i8
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @t0_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ule" %2, %arg0 : i8
    %5 = llvm.select %3, %4, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @t1_oneuse0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ule" %1, %arg0 : i8
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @t1_oneuse0_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ule" %2, %arg0 : i8
    %5 = llvm.select %3, %4, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @t2_oneuse1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    %3 = llvm.icmp "ule" %1, %arg0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @t2_oneuse1_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ule" %2, %arg0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %3, %4, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @n3_oneuse2_bad(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ule" %1, %arg0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @n3_oneuse2_bad_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ule" %2, %arg0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %3, %4, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @t4_commutativity0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    %3 = llvm.icmp "ule" %1, %arg0 : i8
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @t4_commutativity0_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ule" %2, %arg0 : i8
    %5 = llvm.select %4, %3, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @t5_commutativity1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    %3 = llvm.icmp "uge" %arg0, %1 : i8
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @t5_commutativity1_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "uge" %arg0, %2 : i8
    %5 = llvm.select %3, %4, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @t6_commutativity3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    %3 = llvm.icmp "uge" %arg0, %1 : i8
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @t6_commutativity3_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "uge" %arg0, %2 : i8
    %5 = llvm.select %4, %3, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @t7(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i8
    %3 = llvm.icmp "ugt" %1, %arg0 : i8
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @t7_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %0 : i8
    %4 = llvm.icmp "ugt" %2, %arg0 : i8
    %5 = llvm.select %3, %1, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @t8(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    %3 = llvm.icmp "ule" %1, %arg1 : i8
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @t8_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ule" %2, %arg1 : i8
    %5 = llvm.select %3, %4, %1 : i1, i1
    llvm.return %5 : i1
  }
}
