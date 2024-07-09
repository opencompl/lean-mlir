module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @umin_scalar(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i1, i1) -> i1
    llvm.return %0 : i1
  }
  llvm.func @smin_scalar(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (i1, i1) -> i1
    llvm.return %0 : i1
  }
  llvm.func @umax_scalar(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i1, i1) -> i1
    llvm.return %0 : i1
  }
  llvm.func @smax_scalar(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i1, i1) -> i1
    llvm.return %0 : i1
  }
  llvm.func @umin_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    llvm.return %0 : vector<4xi1>
  }
  llvm.func @smin_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    llvm.return %0 : vector<4xi1>
  }
  llvm.func @umax_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    llvm.return %0 : vector<4xi1>
  }
  llvm.func @smax_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    llvm.return %0 : vector<4xi1>
  }
}
