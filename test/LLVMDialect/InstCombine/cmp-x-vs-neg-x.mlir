module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @gen8() -> i8
  llvm.func @use8(i8)
  llvm.func @t0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "sgt" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @t0_commutative() -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.sub %0, %1 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @t0_extrause(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "sgt" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @t1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "sge" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @t2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "slt" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @t3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "sle" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @t4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "ugt" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @t5(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "uge" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @t6(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "ult" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @t7(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "ule" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @t8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "eq" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @t9(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "ne" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @n10(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "sgt" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @n11(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "sgt" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @n12(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "sgt" %1, %arg1 : i8
    llvm.return %2 : i1
  }
}
