module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @cmpeq_xor_cst1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "eq" %1, %arg1 : i32
    llvm.return %2 : i1
  }
  llvm.func @cmpeq_xor_cst2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @cmpeq_xor_cst3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @cmpne_xor_cst1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "ne" %1, %arg1 : i32
    llvm.return %2 : i1
  }
  llvm.func @cmpne_xor_cst2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @cmpne_xor_cst3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @cmpeq_xor_cst1_multiuse(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %arg1 : i32
    llvm.return %2 : i1
  }
  llvm.func @cmpeq_xor_cst1_commuted(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mul %arg1, %arg1  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @cmpeq_xor_cst1_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[10, 11]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "eq" %arg1, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @foo1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.icmp "eq" %2, %4 : i32
    llvm.return %5 : i1
  }
  llvm.func @foo2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.icmp "eq" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @foo3(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-2, -1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[9, 79]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @use.i8(i8)
  llvm.func @fold_xorC_eq0_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.xor %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    llvm.return %2 : i1
  }
  llvm.func @fold_xorC_eq1_multiuse_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.xor %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    llvm.return %2 : i1
  }
  llvm.func @fold_xorC_neC_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(45 : i8) : i8
    %1 = llvm.mlir.constant(67 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.return %3 : i1
  }
}
