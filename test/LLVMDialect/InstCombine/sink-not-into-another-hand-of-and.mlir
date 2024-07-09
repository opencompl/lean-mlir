module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use1(i1)
  llvm.func @use8(i8)
  llvm.func @t0(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i8
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.and %2, %1  : i1
    %4 = llvm.select %3, %arg3, %arg4 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @t1(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg2, %arg3 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %3 = llvm.xor %1, %0  : i1
    %4 = llvm.and %3, %2  : i1
    %5 = llvm.select %4, %arg4, %arg5 : i1, i8
    llvm.return %5 : i8
  }
  llvm.func @n2(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i8
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @n3(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.and %2, %1  : i1
    %4 = llvm.select %3, %arg3, %arg4 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @t4(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: i8, %arg6: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i8
    %2 = llvm.select %1, %arg3, %arg4 : i1, i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.and %3, %1  : i1
    %5 = llvm.select %4, %arg5, %arg6 : i1, i8
    llvm.return %5 : i8
  }
  llvm.func @t4_commutative(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: i8, %arg6: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i8
    %2 = llvm.select %1, %arg3, %arg4 : i1, i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.and %1, %3  : i1
    %5 = llvm.select %4, %arg5, %arg6 : i1, i8
    llvm.return %5 : i8
  }
}
