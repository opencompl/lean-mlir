module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @add_mask_sign_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @add_mask_sign_commute_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @add_mask_sign_v2i32(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.add %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @add_mask_sign_v2i32_nonuniform(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[30, 31]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[8, 16]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.add %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @add_mask_ashr28_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(28 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @add_mask_ashr28_non_pow2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(28 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @add_mask_ashr27_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(27 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }
}
