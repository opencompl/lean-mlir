module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @hello("hello\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @hello_no_nul("hello") {addr_space = 0 : i32}
  llvm.func @__strlen_chk(!llvm.ptr, i32) -> i32
  llvm.func @unknown_str_known_object_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.call @__strlen_chk(%arg0, %0) : (!llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @known_str_known_object_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.call @__strlen_chk(%1, %2) : (!llvm.ptr, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @known_str_too_small_object_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.call @__strlen_chk(%1, %2) : (!llvm.ptr, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @known_str_no_nul(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("hello") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hello_no_nul : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.call @__strlen_chk(%1, %2) : (!llvm.ptr, i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @unknown_str_unknown_object_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @__strlen_chk(%arg0, %0) : (!llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }
}
