module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test2(%arg0: i32) {
    %0 = llvm.mlir.constant(-12 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-16 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.inttoptr %3 : i32 to !llvm.ptr
    llvm.store %1, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.add %arg0, %2  : i32
    %6 = llvm.inttoptr %5 : i32 to !llvm.ptr
    %7 = llvm.getelementptr %6[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %9 = llvm.call @callee(%8) : (i32) -> i32
    llvm.return
  }
  llvm.func @callee(i32) -> i32
}
