module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @str("a\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @str2("abc") {addr_space = 0 : i32}
  llvm.mlir.global external constant @str3("abcd") {addr_space = 0 : i32}
  llvm.func @strncpy(!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
  llvm.func @fill_with_zeros(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("a\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @str : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.call @strncpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }
  llvm.func @fill_with_zeros2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("abc") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @str2 : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.call @strncpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }
  llvm.func @fill_with_zeros3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("abcd") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @str3 : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.call @strncpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }
  llvm.func @fill_with_zeros4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("abcd") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @str3 : !llvm.ptr
    %2 = llvm.mlir.constant(128 : i64) : i64
    %3 = llvm.call @strncpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }
  llvm.func @no_simplify(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("abcd") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @str3 : !llvm.ptr
    %2 = llvm.mlir.constant(129 : i64) : i64
    %3 = llvm.call @strncpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }
}
