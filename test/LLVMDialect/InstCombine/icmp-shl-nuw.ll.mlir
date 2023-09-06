module  {
  llvm.func @icmp_ugt_32(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.shl %arg0, %1  : i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    llvm.return %3 : i1
  }
  llvm.func @icmp_ule_64(%arg0: i128) -> i1 {
    %0 = llvm.mlir.constant(18446744073709551615 : i128) : i128
    %1 = llvm.mlir.constant(64 : i128) : i128
    %2 = llvm.shl %arg0, %1  : i128
    %3 = llvm.icmp "ule" %2, %0 : i128
    llvm.return %3 : i1
  }
  llvm.func @icmp_ugt_16(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1048575 : i64) : i64
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.shl %arg0, %1  : i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    llvm.return %3 : i1
  }
  llvm.func @icmp_ule_16x2(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.shl %arg0, %1  : vector<2xi64>
    %3 = llvm.icmp "ule" %2, %0 : vector<2xi64>
    llvm.return %3 : i1
  }
  llvm.func @icmp_ule_16x2_nonzero(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<196608> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.shl %arg0, %1  : vector<2xi64>
    %3 = llvm.icmp "ule" %2, %0 : vector<2xi64>
    llvm.return %3 : i1
  }
  llvm.func @icmp_ule_12x2(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<12288> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<12> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.shl %arg0, %1  : vector<2xi64>
    %3 = llvm.icmp "ule" %2, %0 : vector<2xi64>
    llvm.return %3 : i1
  }
  llvm.func @icmp_ult_8(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(4095 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.shl %arg0, %1  : i64
    %3 = llvm.icmp "ult" %2, %0 : i64
    llvm.return %3 : i1
  }
  llvm.func @icmp_uge_8x2(%arg0: vector<2xi16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4095> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.shl %arg0, %1  : vector<2xi16>
    %3 = llvm.icmp "uge" %2, %0 : vector<2xi16>
    llvm.return %3 : i1
  }
  llvm.func @icmp_ugt_16x2(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1048575> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %1  : vector<2xi32>
    %3 = llvm.icmp "ugt" %2, %0 : vector<2xi32>
    llvm.return %3 : i1
  }
}
