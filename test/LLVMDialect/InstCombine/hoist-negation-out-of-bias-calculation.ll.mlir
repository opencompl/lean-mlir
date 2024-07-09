module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }
  llvm.func @gen8() -> i8
  llvm.func @t1_commutative(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.and %1, %2  : i8
    %4 = llvm.sub %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @t2_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %1, %arg1  : vector<2xi8>
    %3 = llvm.and %2, %arg0  : vector<2xi8>
    %4 = llvm.sub %3, %arg0  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @t3_vec_poison(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.sub %6, %arg1  : vector<2xi8>
    %8 = llvm.and %7, %arg0  : vector<2xi8>
    %9 = llvm.sub %8, %arg0  : vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }
  llvm.func @use8(i8)
  llvm.func @n4_extrause0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }
  llvm.func @n5_extrause1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }
  llvm.func @n6_extrause2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.and %1, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }
  llvm.func @n7(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @n8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }
  llvm.func @n9(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg2  : i8
    %2 = llvm.and %arg1, %1  : i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }
}
