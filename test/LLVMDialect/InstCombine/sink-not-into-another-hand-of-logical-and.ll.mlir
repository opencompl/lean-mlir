module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use1(i1)
  llvm.func @use8(i8)
  llvm.func @t0(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg1, %arg2 : i8
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    %5 = llvm.select %4, %arg3, %arg4 : i1, i8
    llvm.return %5 : i8
  }
  llvm.func @t0_commutative(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg1, %arg2 : i8
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    %5 = llvm.select %4, %arg3, %arg4 : i1, i8
    llvm.return %5 : i8
  }
  llvm.func @t1(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg2, %arg3 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %4 = llvm.xor %2, %0  : i1
    %5 = llvm.select %4, %3, %1 : i1, i1
    %6 = llvm.select %5, %arg4, %arg5 : i1, i8
    llvm.return %6 : i8
  }
  llvm.func @t1_commutative(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg2, %arg3 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %4 = llvm.xor %2, %0  : i1
    %5 = llvm.select %3, %4, %1 : i1, i1
    %6 = llvm.select %5, %arg4, %arg5 : i1, i8
    llvm.return %6 : i8
  }
  llvm.func @n2(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg1, %arg2 : i8
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @n3(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg1, %arg2 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    %5 = llvm.select %4, %arg3, %arg4 : i1, i8
    llvm.return %5 : i8
  }
  llvm.func @t4(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: i8, %arg6: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg1, %arg2 : i8
    %3 = llvm.select %2, %arg3, %arg4 : i1, i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.xor %arg0, %0  : i1
    %5 = llvm.select %4, %2, %1 : i1, i1
    %6 = llvm.select %5, %arg5, %arg6 : i1, i8
    llvm.return %6 : i8
  }
  llvm.func @t4_commutative(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: i8, %arg6: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg1, %arg2 : i8
    %3 = llvm.select %2, %arg3, %arg4 : i1, i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.xor %arg0, %0  : i1
    %5 = llvm.select %2, %4, %1 : i1, i1
    %6 = llvm.select %5, %arg5, %arg6 : i1, i8
    llvm.return %6 : i8
  }
}
