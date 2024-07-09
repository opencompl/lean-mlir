module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @visible(%arg0: i32, %arg1: i64, %arg2: i64, %arg3: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x !llvm.struct<"struct.point", (i32, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x !llvm.struct<"struct.point", (i32, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.alloca %0 x !llvm.struct<"struct.point", (i32, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %5 = llvm.getelementptr %2[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i64)>
    llvm.store %arg1, %5 {alignment = 4 : i64} : i64, !llvm.ptr
    %6 = llvm.getelementptr %3[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i64)>
    llvm.store %arg2, %6 {alignment = 4 : i64} : i64, !llvm.ptr
    %7 = llvm.getelementptr %4[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i64)>
    llvm.store %arg3, %7 {alignment = 4 : i64} : i64, !llvm.ptr
    %8 = llvm.icmp "eq" %arg0, %1 : i32
    %9 = llvm.getelementptr %2[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i64)>
    %10 = llvm.load %9 {alignment = 4 : i64} : !llvm.ptr -> i64
    %11 = llvm.getelementptr %3[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i64)>
    %12 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> i64
    %13 = llvm.getelementptr %4[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i64)>
    %14 = llvm.load %13 {alignment = 4 : i64} : !llvm.ptr -> i64
    %15 = llvm.call @determinant(%10, %12, %14) : (i64, i64, i64) -> i32
    %16 = llvm.icmp "slt" %15, %1 : i32
    %17 = llvm.icmp "sgt" %15, %1 : i32
    %18 = llvm.select %8, %16, %17 : i1, i1
    %19 = llvm.zext %18 : i1 to i32
    llvm.return %19 : i32
  }
  llvm.func @determinant(i64, i64, i64) -> i32
}
