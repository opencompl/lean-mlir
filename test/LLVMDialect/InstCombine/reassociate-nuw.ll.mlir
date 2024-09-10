module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @reassoc_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.add %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @reassoc_sub_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.sub %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.sub %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @reassoc_mul_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(65 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.mul %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @no_reassoc_add_nuw_none(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @no_reassoc_add_none_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @reassoc_x2_add_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.add %arg1, %1 overflow<nuw>  : i32
    %4 = llvm.add %2, %3 overflow<nuw>  : i32
    llvm.return %4 : i32
  }
  llvm.func @reassoc_x2_mul_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.mul %arg1, %1 overflow<nuw>  : i32
    %4 = llvm.mul %2, %3 overflow<nuw>  : i32
    llvm.return %4 : i32
  }
  llvm.func @reassoc_x2_sub_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.sub %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.sub %arg1, %1 overflow<nuw>  : i32
    %4 = llvm.sub %2, %3 overflow<nuw>  : i32
    llvm.return %4 : i32
  }
  llvm.func @tryFactorization_add_nuw_mul_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.add %1, %arg0 overflow<nuw>  : i32
    llvm.return %2 : i32
  }
  llvm.func @tryFactorization_add_nuw_mul_nuw_int_max(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.add %1, %arg0 overflow<nuw>  : i32
    llvm.return %2 : i32
  }
  llvm.func @tryFactorization_add_mul_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.add %1, %arg0 overflow<nuw>  : i32
    llvm.return %2 : i32
  }
  llvm.func @tryFactorization_add_nuw_mul(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.add %1, %arg0  : i32
    llvm.return %2 : i32
  }
  llvm.func @tryFactorization_add_nuw_mul_nuw_mul_nuw_var(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.mul %arg0, %arg2 overflow<nuw>  : i32
    %2 = llvm.add %0, %1 overflow<nuw>  : i32
    llvm.return %2 : i32
  }
  llvm.func @tryFactorization_add_nuw_mul_mul_nuw_var(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1  : i32
    %1 = llvm.mul %arg0, %arg2 overflow<nuw>  : i32
    %2 = llvm.add %0, %1 overflow<nuw>  : i32
    llvm.return %2 : i32
  }
  llvm.func @tryFactorization_add_nuw_mul_nuw_mul_var(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.mul %arg0, %arg2  : i32
    %2 = llvm.add %0, %1 overflow<nuw>  : i32
    llvm.return %2 : i32
  }
  llvm.func @tryFactorization_add_mul_nuw_mul_var(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.mul %arg0, %arg2 overflow<nuw>  : i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }
}
