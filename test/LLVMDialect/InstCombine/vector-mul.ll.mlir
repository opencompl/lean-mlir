module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @Zero_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mul %arg0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @Identity_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }
  llvm.func @AddToSelf_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }
  llvm.func @SplatPow2Test1_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<4> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }
  llvm.func @SplatPow2Test2_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }
  llvm.func @MulTest1_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 4, 8]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }
  llvm.func @MulTest2_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }
  llvm.func @MulTest3_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<[4, 4, 2, 2]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }
  llvm.func @MulTest4_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<[4, 4, 0, 1]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }
  llvm.func @Zero_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<4xi16>) : vector<4xi16>
    %2 = llvm.mul %arg0, %1  : vector<4xi16>
    llvm.return %2 : vector<4xi16>
  }
  llvm.func @Identity_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }
  llvm.func @AddToSelf_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }
  llvm.func @SplatPow2Test1_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<4> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }
  llvm.func @SplatPow2Test2_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }
  llvm.func @MulTest1_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<[1, 2, 4, 8]> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }
  llvm.func @MulTest2_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }
  llvm.func @MulTest3_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<[4, 4, 2, 2]> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }
  llvm.func @MulTest4_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<[4, 4, 0, 2]> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }
  llvm.func @Zero_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @Identity_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @AddToSelf_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @SplatPow2Test1_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @SplatPow2Test2_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @MulTest1_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 4, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @MulTest2_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @MulTest3_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[4, 4, 2, 2]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @MulTest4_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[4, 4, 0, 1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @Zero_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<4xi64>) : vector<4xi64>
    %2 = llvm.mul %arg0, %1  : vector<4xi64>
    llvm.return %2 : vector<4xi64>
  }
  llvm.func @Identity_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }
  llvm.func @AddToSelf_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }
  llvm.func @SplatPow2Test1_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<4> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }
  llvm.func @SplatPow2Test2_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }
  llvm.func @MulTest1_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<[1, 2, 4, 8]> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }
  llvm.func @MulTest2_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }
  llvm.func @MulTest3_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<[4, 4, 2, 2]> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }
  llvm.func @MulTest4_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<[4, 4, 0, 1]> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }
  llvm.func @ShiftMulTest1(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.shl %arg0, %0  : vector<4xi8>
    %3 = llvm.mul %2, %1  : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }
  llvm.func @ShiftMulTest2(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mlir.constant(dense<3> : vector<4xi16>) : vector<4xi16>
    %2 = llvm.shl %arg0, %0  : vector<4xi16>
    %3 = llvm.mul %2, %1  : vector<4xi16>
    llvm.return %3 : vector<4xi16>
  }
  llvm.func @ShiftMulTest3(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<3> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0  : vector<4xi32>
    %3 = llvm.mul %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @ShiftMulTest4(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mlir.constant(dense<3> : vector<4xi64>) : vector<4xi64>
    %2 = llvm.shl %arg0, %0  : vector<4xi64>
    %3 = llvm.mul %2, %1  : vector<4xi64>
    llvm.return %3 : vector<4xi64>
  }
}
