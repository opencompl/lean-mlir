module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @barrier()
  llvm.func @umax_xor_Cpow2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.intr.umax(%arg0, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @umin_xor_Cpow2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.intr.umin(%arg0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smax_xor_Cpow2_pos(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.intr.smax(%arg0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @smin_xor_Cpow2_pos(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.intr.smin(%arg0, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @smax_xor_Cpow2_neg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.intr.smax(%arg0, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @smin_xor_Cpow2_neg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.intr.smin(%arg0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }
  llvm.func @umax_xor_pow2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %arg1, %1  : i8
    %3 = llvm.xor %arg0, %2  : i8
    %4 = llvm.intr.umax(%arg0, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }
  llvm.func @umin_xor_pow2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %1, %arg1  : vector<2xi8>
    %3 = llvm.and %arg1, %2  : vector<2xi8>
    %4 = llvm.xor %arg0, %3  : vector<2xi8>
    %5 = llvm.intr.umin(%arg0, %4)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @smax_xor_pow2_unk(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %arg1, %1  : i8
    %3 = llvm.xor %arg0, %2  : i8
    %4 = llvm.intr.smax(%arg0, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }
  llvm.func @smin_xor_pow2_unk(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %1, %arg1  : vector<2xi8>
    %3 = llvm.and %arg1, %2  : vector<2xi8>
    %4 = llvm.xor %arg0, %3  : vector<2xi8>
    %5 = llvm.intr.smin(%arg0, %4)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @smax_xor_pow2_neg(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %arg1, %1  : i8
    %3 = llvm.icmp "slt" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.xor %arg0, %2  : i8
    %5 = llvm.intr.smax(%arg0, %4)  : (i8, i8) -> i8
    llvm.return %5 : i8
  ^bb2:  // pred: ^bb0
    llvm.call @barrier() : () -> ()
    llvm.return %0 : i8
  }
  llvm.func @smin_xor_pow2_pos(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %arg1, %1  : i8
    %3 = llvm.icmp "sgt" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.xor %arg0, %2  : i8
    %5 = llvm.intr.smin(%arg0, %4)  : (i8, i8) -> i8
    llvm.return %5 : i8
  ^bb2:  // pred: ^bb0
    llvm.call @barrier() : () -> ()
    llvm.return %0 : i8
  }
}
