module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @call_thunk(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.addressof @inc_first_arg_thunk : !llvm.ptr
    %1 = llvm.call %0(%arg0, %arg1) : !llvm.ptr, (i32, i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func internal @inc_first_arg_thunk(%arg0: i32, ...) attributes {dso_local, passthrough = ["thunk"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @plus : !llvm.ptr
    %2 = llvm.add %arg0, %0  : i32
    llvm.call %1(%2) vararg(!llvm.func<void (i32, ...)>) : !llvm.ptr, (i32) -> ()
    llvm.return
  }
  llvm.func internal @plus(%arg0: i32, %arg1: i32) -> i32 attributes {dso_local} {
    %0 = llvm.add %arg0, %arg1  : i32
    llvm.return %0 : i32
  }
}
