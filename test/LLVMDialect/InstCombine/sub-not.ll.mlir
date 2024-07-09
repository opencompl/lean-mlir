module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i8)
  llvm.func @sub_not(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_not_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.return %2 : i8
  }
  llvm.func @sub_not_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.sub %arg0, %arg1  : vector<2xi8>
    %8 = llvm.xor %7, %6  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }
  llvm.func @dec_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @dec_sub_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.return %2 : i8
  }
  llvm.func @dec_sub_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.sub %arg0, %arg1  : vector<2xi8>
    %8 = llvm.add %7, %6  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }
  llvm.func @sub_inc(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_inc_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.sub %arg1, %1  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.return %2 : i8
  }
  llvm.func @sub_inc_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.add %arg0, %6  : vector<2xi8>
    %8 = llvm.sub %arg1, %7  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }
  llvm.func @sub_dec(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.sub %1, %arg1  : i8
    llvm.return %2 : i8
  }
  llvm.func @sub_dec_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.sub %1, %arg1  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.return %2 : i8
  }
  llvm.func @sub_dec_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.add %arg0, %6  : vector<2xi8>
    %8 = llvm.sub %7, %arg1  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }
}
