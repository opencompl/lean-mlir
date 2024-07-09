module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @XorZextXor(%arg0: i3) -> i5 {
    %0 = llvm.mlir.constant(3 : i3) : i3
    %1 = llvm.mlir.constant(12 : i5) : i5
    %2 = llvm.xor %arg0, %0  : i3
    %3 = llvm.zext %2 : i3 to i5
    %4 = llvm.xor %3, %1  : i5
    llvm.return %4 : i5
  }
  llvm.func @XorZextXorVec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %3 = llvm.mlir.constant(dense<[3, 1]> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.xor %arg0, %2  : vector<2xi1>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    %6 = llvm.xor %5, %3  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @OrZextOr(%arg0: i3) -> i5 {
    %0 = llvm.mlir.constant(3 : i3) : i3
    %1 = llvm.mlir.constant(8 : i5) : i5
    %2 = llvm.or %arg0, %0  : i3
    %3 = llvm.zext %2 : i3 to i5
    %4 = llvm.or %3, %1  : i5
    llvm.return %4 : i5
  }
  llvm.func @OrZextOrVec(%arg0: vector<2xi2>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i2) : i2
    %1 = llvm.mlir.constant(-2 : i2) : i2
    %2 = llvm.mlir.constant(dense<[-2, 0]> : vector<2xi2>) : vector<2xi2>
    %3 = llvm.mlir.constant(dense<[1, 5]> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.or %arg0, %2  : vector<2xi2>
    %5 = llvm.zext %4 : vector<2xi2> to vector<2xi32>
    %6 = llvm.or %5, %3  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @AndZextAnd(%arg0: i3) -> i5 {
    %0 = llvm.mlir.constant(3 : i3) : i3
    %1 = llvm.mlir.constant(14 : i5) : i5
    %2 = llvm.and %arg0, %0  : i3
    %3 = llvm.zext %2 : i3 to i5
    %4 = llvm.and %3, %1  : i5
    llvm.return %4 : i5
  }
  llvm.func @AndZextAndVec(%arg0: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[7, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[261, 1]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.zext %2 : vector<2xi8> to vector<2xi32>
    %4 = llvm.and %3, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @zext_nneg(%arg0: i16) -> i24 {
    %0 = llvm.mlir.constant(32767 : i16) : i16
    %1 = llvm.mlir.constant(8388607 : i24) : i24
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.zext %2 : i16 to i24
    %4 = llvm.and %3, %1  : i24
    llvm.return %4 : i24
  }
}
