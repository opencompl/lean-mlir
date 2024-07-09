module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global common @a(dense<0> : tensor<60xi8>) {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.array<60 x i8>
  llvm.mlir.global common @b(dense<0> : tensor<60xi8>) {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.array<60 x i8>
  llvm.mlir.global private constant @".str"("abcdefghijk\00") {addr_space = 0 : i32, dso_local}
  llvm.func @test_simplify1() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant("abcdefghijk\00") : !llvm.array<12 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.mlir.constant(12 : i32) : i32
    %6 = llvm.mlir.constant(60 : i32) : i32
    %7 = llvm.call @__strncpy_chk(%2, %4, %5, %6) : (!llvm.ptr, !llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %7 : !llvm.ptr
  }
  llvm.func @test_simplify2() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant("abcdefghijk\00") : !llvm.array<12 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.mlir.constant(12 : i32) : i32
    %6 = llvm.call @__strncpy_chk(%2, %4, %5, %5) : (!llvm.ptr, !llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }
  llvm.func @test_simplify3() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(12 : i32) : i32
    %5 = llvm.mlir.constant(60 : i32) : i32
    %6 = llvm.call @__strncpy_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }
  llvm.func @test_no_simplify1() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant("abcdefghijk\00") : !llvm.array<12 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.mlir.constant(8 : i32) : i32
    %6 = llvm.mlir.constant(4 : i32) : i32
    %7 = llvm.call @__strncpy_chk(%2, %4, %5, %6) : (!llvm.ptr, !llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %7 : !llvm.ptr
  }
  llvm.func @test_no_simplify2() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(8 : i32) : i32
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.call @__strncpy_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }
  llvm.func @__strncpy_chk(!llvm.ptr, !llvm.ptr, i32, i32) -> !llvm.ptr
}
