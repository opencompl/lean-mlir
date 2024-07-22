module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.getelementptr inbounds %arg0[%0, %arg1, 0, %0] : (!llvm.ptr, i32, i32, i32) -> !llvm.ptr, !llvm.array<0 x struct<"S", (array<2 x i32>)>>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"S", (array<2 x i32>)>
    %4 = llvm.icmp "eq" %3, %arg0 : !llvm.ptr
    llvm.return %4 : i1
  }
  llvm.func @test64(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i64) : i64
    %3 = llvm.getelementptr inbounds %arg0[%0, %arg1, 0, %0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<0 x struct<"S", (array<2 x i32>)>>
    %4 = llvm.getelementptr inbounds %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"S", (array<2 x i32>)>
    %5 = llvm.icmp "eq" %4, %arg0 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @test64_overflow(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8589934592 : i64) : i64
    %3 = llvm.mlir.constant(-1 : i64) : i64
    %4 = llvm.getelementptr inbounds %arg0[%0, %arg1, 0, %2] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<0 x struct<"S", (array<2 x i32>)>>
    %5 = llvm.getelementptr inbounds %4[%3] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"S", (array<2 x i32>)>
    %6 = llvm.icmp "eq" %5, %arg0 : !llvm.ptr
    llvm.return %6 : i1
  }
}
