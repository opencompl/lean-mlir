module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @af(dense<[1.231200e+00, 0.000000e+00]> : tensor<2xf32>) {addr_space = 0 : i32} : !llvm.array<2 x f32>
  llvm.mlir.global external constant @aS() {addr_space = 0 : i32} : !llvm.array<3 x struct<"struct.S", (i32)>> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.struct<"struct.S", (i32)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"struct.S", (i32)> 
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"struct.S", (i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.S", (i32)> 
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.mlir.undef : !llvm.struct<"struct.S", (i32)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<"struct.S", (i32)> 
    %9 = llvm.mlir.undef : !llvm.array<3 x struct<"struct.S", (i32)>>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.array<3 x struct<"struct.S", (i32)>> 
    %11 = llvm.insertvalue %5, %10[1] : !llvm.array<3 x struct<"struct.S", (i32)>> 
    %12 = llvm.insertvalue %2, %11[2] : !llvm.array<3 x struct<"struct.S", (i32)>> 
    llvm.return %12 : !llvm.array<3 x struct<"struct.S", (i32)>>
  }
  llvm.func @wcslen(!llvm.ptr) -> i64
  llvm.func @fold_af() -> i64 {
    %0 = llvm.mlir.constant(dense<[1.231200e+00, 0.000000e+00]> : tensor<2xf32>) : !llvm.array<2 x f32>
    %1 = llvm.mlir.addressof @af : !llvm.ptr
    %2 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }
  llvm.func @fold_aS() -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.struct<"struct.S", (i32)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"struct.S", (i32)> 
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"struct.S", (i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.S", (i32)> 
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.mlir.undef : !llvm.struct<"struct.S", (i32)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<"struct.S", (i32)> 
    %9 = llvm.mlir.undef : !llvm.array<3 x struct<"struct.S", (i32)>>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.array<3 x struct<"struct.S", (i32)>> 
    %11 = llvm.insertvalue %5, %10[1] : !llvm.array<3 x struct<"struct.S", (i32)>> 
    %12 = llvm.insertvalue %2, %11[2] : !llvm.array<3 x struct<"struct.S", (i32)>> 
    %13 = llvm.mlir.addressof @aS : !llvm.ptr
    %14 = llvm.call @wcslen(%13) : (!llvm.ptr) -> i64
    llvm.return %14 : i64
  }
}
