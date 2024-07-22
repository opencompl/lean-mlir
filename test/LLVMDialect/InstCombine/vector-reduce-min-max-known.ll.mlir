module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @vec_reduce_umax_non_zero(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<[0, 1, 0, 0]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @vec_reduce_umax_non_zero_fail(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @vec_reduce_umin_non_zero(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @vec_reduce_umin_non_zero_fail(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<[0, 1, 1, 1]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @vec_reduce_smax_non_zero0(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.smax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @vec_reduce_smax_non_zero1(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<[127, -1, -1, -1]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[1, 0, 0, 0]> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.and %arg0, %0  : vector<4xi8>
    %4 = llvm.or %3, %1  : vector<4xi8>
    %5 = "llvm.intr.vector.reduce.smax"(%4) : (vector<4xi8>) -> i8
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.return %6 : i1
  }
  llvm.func @vec_reduce_smax_non_zero_fail(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<[127, -1, -1, -1]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[1, 0, 0, 0]> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.and %arg0, %0  : vector<4xi8>
    %4 = llvm.add %3, %1 overflow<nuw>  : vector<4xi8>
    %5 = "llvm.intr.vector.reduce.smax"(%4) : (vector<4xi8>) -> i8
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.return %6 : i1
  }
  llvm.func @vec_reduce_smin_non_zero0(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.smin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @vec_reduce_smin_non_zero1(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<[0, 0, 0, -128]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.smin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @vec_reduce_smin_non_zero_fail(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.constant(dense<[0, 0, 0, -128]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[0, 0, 0, 1]> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.or %arg0, %0  : vector<4xi8>
    %4 = llvm.add %3, %1  : vector<4xi8>
    %5 = "llvm.intr.vector.reduce.smin"(%4) : (vector<4xi8>) -> i8
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.return %6 : i1
  }
  llvm.func @vec_reduce_umax_known0(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @vec_reduce_umax_known1(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[1, 1, 1, -128]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @vec_reduce_umax_known_fail0(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[1, 1, 1, -128]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @vec_reduce_umax_known_fail1(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[1, 2, 4, 8]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @vec_reduce_umin_known0(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @vec_reduce_umin_known1(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[127, -1, -1, -1]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.and %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @vec_reduce_umin_known_fail0(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[127, -1, -1, -1]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[1, 0, 0, 0]> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.and %arg0, %0  : vector<4xi8>
    %4 = llvm.or %arg0, %1  : vector<4xi8>
    %5 = "llvm.intr.vector.reduce.umin"(%4) : (vector<4xi8>) -> i8
    %6 = llvm.and %5, %2  : i8
    llvm.return %6 : i8
  }
  llvm.func @vec_reduce_umin_known_fail1(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[1, 2, 4, 8]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @vec_reduce_smax_known(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[4, 4, 4, 5]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.smax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @vec_reduce_smax_known_fail(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[4, 4, 8, 5]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.umax"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @vec_reduce_smin_known(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[8, 24, 56, 9]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(8 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.smin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @vec_reduce_smin_known_fail(%arg0: vector<4xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[8, 23, 56, 9]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(8 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<4xi8>
    %3 = "llvm.intr.vector.reduce.smin"(%2) : (vector<4xi8>) -> i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
}
