module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @flip_add_of_shift_neg(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.shl %1, %arg1 overflow<nsw, nuw>  : i8
    %3 = llvm.add %2, %arg2  : i8
    llvm.return %3 : i8
  }
  llvm.func @flip_add_of_shift_neg_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg2, %arg2  : vector<2xi8>
    %3 = llvm.sub %1, %arg0  : vector<2xi8>
    %4 = llvm.shl %3, %arg1  : vector<2xi8>
    %5 = llvm.add %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @flip_add_of_shift_neg_fail_shr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.lshr %1, %arg1  : i8
    %3 = llvm.add %2, %arg2  : i8
    llvm.return %3 : i8
  }
  llvm.func @use.v2i8(vector<2xi8>)
  llvm.func @flip_add_of_shift_neg_vec_fail_multiuse_neg(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg2, %arg2  : vector<2xi8>
    %3 = llvm.sub %1, %arg0  : vector<2xi8>
    %4 = llvm.shl %3, %arg1  : vector<2xi8>
    llvm.call @use.v2i8(%3) : (vector<2xi8>) -> ()
    %5 = llvm.add %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @flip_add_of_shift_neg_vec_fail_multiuse_shift(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg2, %arg2  : vector<2xi8>
    %3 = llvm.sub %1, %arg0  : vector<2xi8>
    %4 = llvm.shl %3, %arg1  : vector<2xi8>
    llvm.call @use.v2i8(%4) : (vector<2xi8>) -> ()
    %5 = llvm.add %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
}
