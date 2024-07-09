module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g0(dense<0> : vector<4xi32>) {addr_space = 0 : i32, alignment = 16 : i64} : vector<4xi32>
  llvm.func @mload1(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> (vector<4xi32> {llvm.inreg}) attributes {passthrough = ["norecurse", "nounwind"]} {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.intr.masked.load %arg0, %1, %2 {alignment = 16 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @mload2() -> (vector<4xi32> {llvm.inreg}) attributes {passthrough = ["norecurse", "nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.addressof @g0 : !llvm.ptr
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(dense<[false, true, true, true]> : vector<4xi1>) : vector<4xi1>
    %6 = llvm.mlir.constant(16 : i32) : i32
    %7 = llvm.intr.masked.load %2, %5, %1 {alignment = 16 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }
  llvm.func @mstore(%arg0: vector<4xi32>, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) attributes {passthrough = ["norecurse", "nounwind"]} {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(16 : i32) : i32
    llvm.intr.masked.store %arg0, %arg1, %1 {alignment = 16 : i32} : vector<4xi32>, vector<4xi1> into !llvm.ptr
    llvm.return
  }
}
