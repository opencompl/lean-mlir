module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.sdiv %arg0, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @n1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.sdiv %arg0, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @t2_vec_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-32> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }
  llvm.func @t3_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-32, -16]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }
  llvm.func @n4_vec_mixed(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-32, 16]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }
  llvm.func @n4_vec_undef(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.sdiv %arg0, %6  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }
  llvm.func @prove_exact_with_high_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sdiv %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @prove_exact_with_high_mask_limit(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.sdiv %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @not_prove_exact_with_high_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sdiv %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @prove_exact_with_high_mask_splat_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-16> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.sdiv %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @prove_exact_with_high_mask_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-8, -4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.sdiv %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
}
