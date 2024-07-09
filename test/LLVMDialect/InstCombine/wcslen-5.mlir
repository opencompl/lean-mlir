module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @ws3(dense<[1, 2, 3, 0]> : tensor<4xi32>) {addr_space = 0 : i32} : !llvm.array<4 x i32>
  llvm.mlir.global external constant @ws5(dense<[1, 2, 3, 4, 5, 0]> : tensor<6xi32>) {addr_space = 0 : i32} : !llvm.array<6 x i32>
  llvm.mlir.global external constant @ws5_3(dense<[1, 2, 3, 4, 5, 0, 6, 7, 8, 0]> : tensor<10xi32>) {addr_space = 0 : i32} : !llvm.array<10 x i32>
  llvm.func @wcslen(!llvm.ptr) -> i64
  llvm.func @fold_wcslen_s3_pi_s5(%arg0: i1 {llvm.zeroext}, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 0]> : tensor<4xi32>) : !llvm.array<4 x i32>
    %1 = llvm.mlir.addressof @ws3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(dense<[1, 2, 3, 4, 5, 0]> : tensor<6xi32>) : !llvm.array<6 x i32>
    %4 = llvm.mlir.addressof @ws5 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i32>
    %6 = llvm.select %arg0, %5, %4 : i1, !llvm.ptr
    %7 = llvm.call @wcslen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }
  llvm.func @fold_wcslen_s3_pi_p1_s5(%arg0: i1 {llvm.zeroext}, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 0]> : tensor<4xi32>) : !llvm.array<4 x i32>
    %1 = llvm.mlir.addressof @ws3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(dense<[1, 2, 3, 4, 5, 0]> : tensor<6xi32>) : !llvm.array<6 x i32>
    %5 = llvm.mlir.addressof @ws5 : !llvm.ptr
    %6 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i32>
    %7 = llvm.getelementptr inbounds %6[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %8 = llvm.select %arg0, %7, %5 : i1, !llvm.ptr
    %9 = llvm.call @wcslen(%8) : (!llvm.ptr) -> i64
    llvm.return %9 : i64
  }
  llvm.func @call_wcslen_s5_3_pi_s5(%arg0: i1 {llvm.zeroext}, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4, 5, 0, 6, 7, 8, 0]> : tensor<10xi32>) : !llvm.array<10 x i32>
    %1 = llvm.mlir.addressof @ws5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(dense<[1, 2, 3, 4, 5, 0]> : tensor<6xi32>) : !llvm.array<6 x i32>
    %4 = llvm.mlir.addressof @ws5 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i32>
    %6 = llvm.select %arg0, %5, %4 : i1, !llvm.ptr
    %7 = llvm.call @wcslen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }
  llvm.func @call_wcslen_s5_3_s5_pj(%arg0: i1 {llvm.zeroext}, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4, 5, 0]> : tensor<6xi32>) : !llvm.array<6 x i32>
    %1 = llvm.mlir.addressof @ws5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(dense<[1, 2, 3, 4, 5, 0, 6, 7, 8, 0]> : tensor<10xi32>) : !llvm.array<10 x i32>
    %4 = llvm.mlir.addressof @ws5_3 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i32>
    %6 = llvm.select %arg0, %4, %5 : i1, !llvm.ptr
    %7 = llvm.call @wcslen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }
  llvm.func @fold_wcslen_s3_s5_pj(%arg0: i1 {llvm.zeroext}, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4, 5, 0]> : tensor<6xi32>) : !llvm.array<6 x i32>
    %1 = llvm.mlir.addressof @ws5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(dense<[1, 2, 3, 0]> : tensor<4xi32>) : !llvm.array<4 x i32>
    %4 = llvm.mlir.addressof @ws3 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i32>
    %6 = llvm.select %arg0, %4, %5 : i1, !llvm.ptr
    %7 = llvm.call @wcslen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }
  llvm.func @call_wcslen_s3_s5_3_pj(%arg0: i1 {llvm.zeroext}, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4, 5, 0, 6, 7, 8, 0]> : tensor<10xi32>) : !llvm.array<10 x i32>
    %1 = llvm.mlir.addressof @ws5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(dense<[1, 2, 3, 0]> : tensor<4xi32>) : !llvm.array<4 x i32>
    %4 = llvm.mlir.addressof @ws3 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i32>
    %6 = llvm.select %arg0, %4, %5 : i1, !llvm.ptr
    %7 = llvm.call @wcslen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }
  llvm.func @fold_wcslen_s3_pi_s5_pj(%arg0: i1 {llvm.zeroext}, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 0]> : tensor<4xi32>) : !llvm.array<4 x i32>
    %1 = llvm.mlir.addressof @ws3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(dense<[1, 2, 3, 4, 5, 0]> : tensor<6xi32>) : !llvm.array<6 x i32>
    %4 = llvm.mlir.addressof @ws5 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i32>
    %6 = llvm.getelementptr inbounds %4[%2, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i32>
    %7 = llvm.select %arg0, %5, %6 : i1, !llvm.ptr
    %8 = llvm.call @wcslen(%7) : (!llvm.ptr) -> i64
    llvm.return %8 : i64
  }
}
