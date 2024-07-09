module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @visible(%arg0: i32, %arg1: i64, %arg2: i64, %arg3: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.alloca %0 x !llvm.struct<"struct.point", (i32, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.alloca %0 x !llvm.struct<"struct.point", (i32, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %5 = llvm.alloca %0 x !llvm.struct<"struct.point", (i32, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.bitcast %1 : i32 to i32
    %7 = llvm.getelementptr %3[%2, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(i64)>
    llvm.store %arg1, %7 {alignment = 4 : i64} : i64, !llvm.ptr
    %8 = llvm.getelementptr %4[%2, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(i64)>
    llvm.store %arg2, %8 {alignment = 4 : i64} : i64, !llvm.ptr
    %9 = llvm.getelementptr %5[%2, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(i64)>
    llvm.store %arg3, %9 {alignment = 4 : i64} : i64, !llvm.ptr
    %10 = llvm.icmp "eq" %arg0, %1 : i32
    %11 = llvm.getelementptr %3[%2, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(i64)>
    %12 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> i64
    %13 = llvm.getelementptr %4[%2, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(i64)>
    %14 = llvm.load %13 {alignment = 4 : i64} : !llvm.ptr -> i64
    %15 = llvm.getelementptr %5[%2, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(i64)>
    %16 = llvm.load %15 {alignment = 4 : i64} : !llvm.ptr -> i64
    %17 = llvm.call @determinant(%12, %14, %16) : (i64, i64, i64) -> i32
    llvm.cond_br %10, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %18 = llvm.icmp "slt" %17, %1 : i32
    %19 = llvm.zext %18 : i1 to i32
    llvm.br ^bb3(%19 : i32)
  ^bb2:  // pred: ^bb0
    %20 = llvm.icmp "sgt" %17, %1 : i32
    %21 = llvm.zext %20 : i1 to i32
    llvm.br ^bb3(%21 : i32)
  ^bb3(%22: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %22 : i32
  }
  llvm.func @determinant(i64, i64, i64) -> i32
}
