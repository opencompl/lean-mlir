module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @t() {addr_space = 0 : i32} : !llvm.struct<"struct.p", packed (i8, i32)> {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.undef : !llvm.struct<"struct.p", packed (i8, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"struct.p", packed (i8, i32)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"struct.p", packed (i8, i32)> 
    llvm.return %4 : !llvm.struct<"struct.p", packed (i8, i32)>
  }
  llvm.mlir.global weak @u() {addr_space = 0 : i32} : !llvm.struct<"struct.p", packed (i8, i32)> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.undef : !llvm.struct<"struct.p", packed (i8, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"struct.p", packed (i8, i32)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"struct.p", packed (i8, i32)> 
    llvm.return %4 : !llvm.struct<"struct.p", packed (i8, i32)>
  }
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"struct.p", packed (i8, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.p", packed (i8, i32)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"struct.p", packed (i8, i32)> 
    %7 = llvm.mlir.addressof @t : !llvm.ptr
    %8 = llvm.getelementptr inbounds %7[%1, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.p", packed (i8, i32)>
    %9 = llvm.mlir.constant(0 : i8) : i8
    %10 = llvm.mlir.undef : !llvm.struct<"struct.p", packed (i8, i32)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<"struct.p", packed (i8, i32)> 
    %12 = llvm.insertvalue %1, %11[1] : !llvm.struct<"struct.p", packed (i8, i32)> 
    %13 = llvm.mlir.addressof @u : !llvm.ptr
    %14 = llvm.getelementptr inbounds %13[%1, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.p", packed (i8, i32)>
    %15 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %16 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %17 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %18 = llvm.bitcast %1 : i32 to i32
    %19 = llvm.load %8 {alignment = 1 : i64} : !llvm.ptr -> i32
    llvm.store %19, %17 {alignment = 4 : i64} : i32, !llvm.ptr
    %20 = llvm.load %17 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %20, %14 {alignment = 1 : i64} : i32, !llvm.ptr
    %21 = llvm.load %17 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %21, %16 {alignment = 4 : i64} : i32, !llvm.ptr
    %22 = llvm.load %16 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %22, %15 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %23 = llvm.load %15 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %23 : i32
  }
}
