module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @s9("123456789\00") {addr_space = 0 : i32}
  llvm.func @strcmp(!llvm.ptr, !llvm.ptr) -> i32
  llvm.func @fold_strcmp_s3_x_s4_s3(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant("123456789\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @s9 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.mlir.constant(5 : i64) : i64
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %6 = llvm.getelementptr %1[%2, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %7 = llvm.select %arg0, %5, %6 : i1, !llvm.ptr
    %8 = llvm.call @strcmp(%7, %5) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %8 : i32
  }
}
