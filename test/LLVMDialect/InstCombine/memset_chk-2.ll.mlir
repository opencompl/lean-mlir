module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global common @t() {addr_space = 0 : i32} : !llvm.struct<"struct.T", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    llvm.return %7 : !llvm.struct<"struct.T", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
  }
  llvm.func @test_no_simplify() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %8 = llvm.mlir.addressof @t : !llvm.ptr
    %9 = llvm.mlir.constant(1824 : i64) : i64
    %10 = llvm.call @__memset_chk(%8, %2, %9) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return
  }
  llvm.func @__memset_chk(!llvm.ptr, i32, i64) -> !llvm.ptr
}
