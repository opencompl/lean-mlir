module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @factorize(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg0, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @factorize2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %0, %arg0  : i32
    %3 = llvm.mul %1, %arg0  : i32
    %4 = llvm.sub %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @factorize3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg1, %arg2  : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.or %arg0, %arg2  : i32
    %3 = llvm.and %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @factorize4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %arg1, %0  : i32
    %2 = llvm.mul %1, %arg0  : i32
    %3 = llvm.mul %arg0, %arg1  : i32
    %4 = llvm.sub %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @factorize5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mul %arg1, %0  : i32
    %2 = llvm.mul %1, %arg0  : i32
    %3 = llvm.mul %arg0, %arg1  : i32
    %4 = llvm.sub %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @expand(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    %4 = llvm.and %3, %0  : i32
    llvm.return %4 : i32
  }
}
