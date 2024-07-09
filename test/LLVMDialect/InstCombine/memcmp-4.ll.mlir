module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @ia16a(dense<[24930, 25444, 25958, 26472]> : tensor<4xi16>) {addr_space = 0 : i32} : !llvm.array<4 x i16>
  llvm.mlir.global external constant @ia16b(dense<[24930, 25444, 25958, 26472, 26992]> : tensor<5xi16>) {addr_space = 0 : i32} : !llvm.array<5 x i16>
  llvm.mlir.global external constant @ia16c(dense<[24930, 25444, 25958, 26472, 26993, 29042]> : tensor<6xi16>) {addr_space = 0 : i32} : !llvm.array<6 x i16>
  llvm.func @memcmp(!llvm.ptr, !llvm.ptr, i64) -> i32
  llvm.func @fold_memcmp_mismatch_too_big(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[24930, 25444, 25958, 26472, 26992]> : tensor<5xi16>) : !llvm.array<5 x i16>
    %1 = llvm.mlir.addressof @ia16b : !llvm.ptr
    %2 = llvm.mlir.constant(dense<[24930, 25444, 25958, 26472, 26993, 29042]> : tensor<6xi16>) : !llvm.array<6 x i16>
    %3 = llvm.mlir.addressof @ia16c : !llvm.ptr
    %4 = llvm.mlir.constant(12 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.call @memcmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %6, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %7 = llvm.call @memcmp(%3, %1, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %8 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %7, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_memcmp_match_too_big(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[24930, 25444, 25958, 26472]> : tensor<4xi16>) : !llvm.array<4 x i16>
    %1 = llvm.mlir.addressof @ia16a : !llvm.ptr
    %2 = llvm.mlir.constant(dense<[24930, 25444, 25958, 26472, 26992]> : tensor<5xi16>) : !llvm.array<5 x i16>
    %3 = llvm.mlir.addressof @ia16b : !llvm.ptr
    %4 = llvm.mlir.constant(9 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.call @memcmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %7, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %8 = llvm.call @memcmp(%1, %3, %5) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %9 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %8, %9 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
