module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @func(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.call @__strcpy_chk(%2, %arg0, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @func2(%2) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @func_no_null_opt(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind", "null_pointer_is_valid", "ssp"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.call @__strcpy_chk(%2, %arg0, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @func2(%2) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @__strcpy_chk(!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr attributes {passthrough = ["nounwind"]}
  llvm.func @func2(!llvm.ptr)
}
