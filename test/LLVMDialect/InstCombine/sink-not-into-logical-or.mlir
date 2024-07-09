module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use1(i1)
  llvm.func @t0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg2, %arg3 : i32
    %3 = llvm.select %2, %0, %1 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }
  llvm.func @n1(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i32
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }
  llvm.func @n2(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }
  llvm.func @n3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }
  llvm.func @n4(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg2, %arg3 : i32
    llvm.call @use1(%1) : (i1) -> ()
    %3 = llvm.select %2, %0, %1 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }
  llvm.func @n5(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg2, %arg3 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %0, %1 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }
  llvm.func @n6(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg2, %arg3 : i32
    llvm.call @use1(%1) : (i1) -> ()
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %0, %1 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }
  llvm.func @t7(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.xor %1, %0  : i1
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "eq" %arg2, %arg3 : i32
    %4 = llvm.select %3, %0, %1 : i1, i1
    %5 = llvm.xor %4, %0  : i1
    llvm.return %5 : i1
  }
  llvm.func @t8(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg2, %arg3 : i32
    %3 = llvm.xor %2, %0  : i1
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %2, %0, %1 : i1, i1
    %5 = llvm.xor %4, %0  : i1
    llvm.return %5 : i1
  }
  llvm.func @t9(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.xor %1, %0  : i1
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "eq" %arg2, %arg3 : i32
    %4 = llvm.xor %3, %0  : i1
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %3, %0, %1 : i1, i1
    %6 = llvm.xor %5, %0  : i1
    llvm.return %6 : i1
  }
  llvm.func @n10(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg2, %arg3 : i32
    %3 = llvm.select %2, %0, %1 : i1, i1
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }
  llvm.func @t11(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg2, %arg3 : i32
    %3 = llvm.select %2, %0, %1 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    %5 = llvm.select %3, %arg4, %arg5 : i1, i1
    llvm.call @use1(%5) : (i1) -> ()
    llvm.return %4 : i1
  }
}
