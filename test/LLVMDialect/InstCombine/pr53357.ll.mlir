module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @src(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.or %arg1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.add %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @src_vec(%arg0: vector<2xi32> {llvm.noundef}, %arg1: vector<2xi32> {llvm.noundef}) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg1, %arg0  : vector<2xi32>
    %2 = llvm.or %arg1, %arg0  : vector<2xi32>
    %3 = llvm.xor %2, %0  : vector<2xi32>
    %4 = llvm.add %1, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @src_vec_poison(%arg0: vector<2xi32> {llvm.noundef}, %arg1: vector<2xi32> {llvm.noundef}) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.and %arg1, %arg0  : vector<2xi32>
    %8 = llvm.or %arg1, %arg0  : vector<2xi32>
    %9 = llvm.xor %8, %6  : vector<2xi32>
    %10 = llvm.add %7, %9  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }
  llvm.func @src2(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.add %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @src3(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg1, %0  : i32
    %4 = llvm.and %2, %3  : i32
    %5 = llvm.add %1, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @src4(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.or %arg1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.add %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @src5(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg1, %arg0  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @src6(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.or %arg2, %arg3  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.add %1, %3  : i32
    llvm.return %4 : i32
  }
}
