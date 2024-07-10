module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(%arg0: vector<16xi8>, %arg1: vector<16xi8>, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.bitcast %arg0 : vector<16xi8> to vector<4xi32>
    %3 = llvm.bitcast %arg1 : vector<16xi8> to vector<4xi32>
    %4 = llvm.select %1, %2, %3 : vector<4xi1>, vector<4xi32>
    llvm.store %4, %arg2 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr
    llvm.return
  }
}
