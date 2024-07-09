module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use_i8(i8)
  llvm.func @mul_selectp2_x(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.mul %2, %arg0  : i8
    llvm.return %3 : i8
  }
  llvm.func @mul_selectp2_x_propegate_nuw(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.mul %2, %arg0 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @mul_selectp2_x_multiuse_fixme(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.mul %2, %arg0  : i8
    llvm.call @use_i8(%2) : (i8) -> ()
    llvm.return %3 : i8
  }
  llvm.func @mul_selectp2_x_non_const(%arg0: i8, %arg1: i1, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %0, %arg2  : i8
    %3 = llvm.select %arg1, %1, %2 : i1, i8
    %4 = llvm.mul %3, %arg0  : i8
    llvm.return %4 : i8
  }
  llvm.func @mul_selectp2_x_non_const_multiuse(%arg0: i8, %arg1: i1, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %0, %arg2  : i8
    %3 = llvm.select %arg1, %1, %2 : i1, i8
    %4 = llvm.mul %3, %arg0  : i8
    llvm.call @use_i8(%2) : (i8) -> ()
    llvm.return %4 : i8
  }
  llvm.func @mul_x_selectp2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mul %arg0, %arg0  : i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.mul %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @mul_select_nonp2_x_fail(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.mul %2, %arg0  : i8
    llvm.return %3 : i8
  }
  llvm.func @mul_x_selectp2_vec(%arg0: vector<2xi8>, %arg1: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[8, 16]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[4, 1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %arg0  : vector<2xi8>
    %3 = llvm.select %arg1, %0, %1 : i1, vector<2xi8>
    %4 = llvm.mul %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @shl_add_log_may_cause_poison_pr62175_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    %2 = llvm.mul %arg1, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @shl_add_log_may_cause_poison_pr62175_with_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    %2 = llvm.mul %arg1, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @shl_add_log_may_cause_poison_pr62175_with_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.mul %arg1, %1  : i8
    llvm.return %2 : i8
  }
}
