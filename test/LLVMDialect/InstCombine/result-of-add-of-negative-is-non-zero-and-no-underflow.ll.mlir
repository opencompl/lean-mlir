module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use8(i8)
  llvm.func @use1(i1)
  llvm.func @t0_bad(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    %3 = llvm.icmp "ult" %1, %arg0 : i8
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @t0_bad_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    %5 = llvm.select %3, %4, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @t1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @t1_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.icmp "ult" %3, %arg0 : i8
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @t2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @t2_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg1, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.icmp "ult" %3, %arg0 : i8
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @t3_oneuse0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @t3_oneuse0_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.icmp "ult" %3, %arg0 : i8
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @t4_oneuse1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @t4_oneuse1_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.icmp "ult" %3, %arg0 : i8
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @t5_oneuse2_bad(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @t5_oneuse2_bad_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.icmp "ult" %3, %arg0 : i8
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @t6_commutativity0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @t6_commutativity0_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.icmp "ult" %3, %arg0 : i8
    %6 = llvm.select %5, %4, %1 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @t7_commutativity1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ugt" %arg0, %2 : i8
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @t7_commutativity1_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.icmp "ugt" %arg0, %3 : i8
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @t7_commutativity3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ugt" %arg0, %2 : i8
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @t7_commutativity3_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.icmp "ugt" %arg0, %3 : i8
    %6 = llvm.select %5, %4, %1 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @t8(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %0 : i8
    %4 = llvm.icmp "uge" %2, %arg0 : i8
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @t8_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "eq" %3, %0 : i8
    %5 = llvm.icmp "uge" %3, %arg0 : i8
    %6 = llvm.select %4, %1, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @t9(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ult" %2, %arg1 : i8
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @t9_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.icmp "ult" %3, %arg1 : i8
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }
}
