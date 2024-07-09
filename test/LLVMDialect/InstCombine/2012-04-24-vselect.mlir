module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo() -> vector<8xi32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(dense<[true, false, false, false, false, false, false, false]> : vector<8xi1>) : vector<8xi1>
    %3 = llvm.mlir.constant(dense<1> : vector<8xi32>) : vector<8xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(dense<0> : vector<8xi32>) : vector<8xi32>
    %6 = llvm.select %2, %3, %5 : vector<8xi1>, vector<8xi32>
    llvm.return %6 : vector<8xi32>
  }
}
