module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @shl_C1_add_A_C2_i32(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.add %2, %0  : i32
    %4 = llvm.shl %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_C1_add_A_C2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.ashr %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @lshr_C1_add_A_C2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.shl %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @shl_C1_add_A_C2_v4i32(%arg0: vector<4xi16>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.zext %arg0 : vector<4xi16> to vector<4xi32>
    %3 = llvm.add %2, %0  : vector<4xi32>
    %4 = llvm.shl %1, %3  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @ashr_C1_add_A_C2_v4i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 15, 255, 65535]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.and %arg0, %0  : vector<4xi32>
    %4 = llvm.add %3, %1  : vector<4xi32>
    %5 = llvm.ashr %2, %4  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }
  llvm.func @lshr_C1_add_A_C2_v4i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 15, 255, 65535]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.and %arg0, %0  : vector<4xi32>
    %4 = llvm.add %3, %1  : vector<4xi32>
    %5 = llvm.lshr %2, %4  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }
  llvm.func @shl_C1_add_A_C2_v4i32_splat(%arg0: i16) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.zext %arg0 : i16 to i32
    %5 = llvm.insertelement %4, %0[%1 : i32] : vector<4xi32>
    %6 = llvm.shufflevector %5, %0 [0, 0, 0, 0] : vector<4xi32> 
    %7 = llvm.add %6, %2  : vector<4xi32>
    %8 = llvm.shl %3, %7  : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }
  llvm.func @ashr_C1_add_A_C2_v4i32_splat(%arg0: i16) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.zext %arg0 : i16 to i32
    %5 = llvm.insertelement %4, %0[%1 : i32] : vector<4xi32>
    %6 = llvm.shufflevector %5, %0 [0, 0, 0, 0] : vector<4xi32> 
    %7 = llvm.add %6, %2  : vector<4xi32>
    %8 = llvm.ashr %3, %7  : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }
  llvm.func @lshr_C1_add_A_C2_v4i32_splat(%arg0: i16) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.zext %arg0 : i16 to i32
    %5 = llvm.insertelement %4, %0[%1 : i32] : vector<4xi32>
    %6 = llvm.shufflevector %5, %0 [0, 0, 0, 0] : vector<4xi32> 
    %7 = llvm.add %6, %2  : vector<4xi32>
    %8 = llvm.lshr %3, %7  : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }
}
