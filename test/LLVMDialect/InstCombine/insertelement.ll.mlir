module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @insert_known_idx(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : vector<4xi32>
    %4 = llvm.insertelement %1, %3[%2 : i32] : vector<4xi32>
    %5 = llvm.and %4, %0  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }
  llvm.func @insert_unknown_idx(%arg0: vector<4xi32>, %arg1: i32) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.and %arg0, %0  : vector<4xi32>
    %3 = llvm.insertelement %1, %2[%arg1 : i32] : vector<4xi32>
    %4 = llvm.and %3, %0  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @insert_known_any_idx(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.insertelement %3, %2[%arg2 : i32] : vector<2xi8>
    %5 = llvm.and %4, %0  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @insert_known_any_idx_fail1(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[17, 33]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.or %arg0, %0  : vector<2xi8>
    %4 = llvm.or %arg1, %1  : i8
    %5 = llvm.insertelement %4, %3[%arg2 : i32] : vector<2xi8>
    %6 = llvm.and %5, %2  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }
  llvm.func @insert_known_any_idx_fail2(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[17, 31]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.or %arg0, %0  : vector<2xi8>
    %4 = llvm.or %arg1, %1  : i8
    %5 = llvm.insertelement %4, %3[%arg2 : i32] : vector<2xi8>
    %6 = llvm.and %5, %2  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }
}
