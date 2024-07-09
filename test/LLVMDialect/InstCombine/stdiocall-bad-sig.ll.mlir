module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @ca1("1") {addr_space = 0 : i32}
  llvm.mlir.global external constant @pcnt_s("%s\00") {addr_space = 0 : i32}
  llvm.func @fwrite(!llvm.ptr, i64, i64, !llvm.ptr) -> i32
  llvm.func @fputc(!llvm.ptr, !llvm.ptr) -> i8
  llvm.func @printf(!llvm.ptr)
  llvm.func @fprintf(!llvm.ptr, !llvm.ptr) -> i8
  llvm.func @sprintf(!llvm.ptr, !llvm.ptr) -> i8
  llvm.func @call_fwrite(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("1") : !llvm.array<1 x i8>
    %1 = llvm.mlir.addressof @ca1 : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.call @fwrite(%1, %2, %2, %arg0) : (!llvm.ptr, i64, i64, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @call_printf(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @printf : !llvm.ptr
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @pcnt_s : !llvm.ptr
    %3 = llvm.call %0(%2) : !llvm.ptr, (!llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @call_fprintf(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.addressof @fprintf : !llvm.ptr
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @pcnt_s : !llvm.ptr
    %3 = llvm.call %0(%arg0, %2, %arg1) vararg(!llvm.func<i8 (ptr, ptr, ...)>) : !llvm.ptr, (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i8
    llvm.return %3 : i8
  }
  llvm.func @call_sprintf(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.addressof @sprintf : !llvm.ptr
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @pcnt_s : !llvm.ptr
    %3 = llvm.call %0(%arg0, %2, %arg1) vararg(!llvm.func<i8 (ptr, ptr, ...)>) : !llvm.ptr, (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i8
    llvm.return %3 : i8
  }
}
