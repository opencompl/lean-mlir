module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32) attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>}
  llvm.func @test(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %1 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return
  }
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.zext %arg1 : i32 to i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return
  }
  llvm.func @test3(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.mlir.constant(48 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %5 = llvm.getelementptr %2[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %6 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @test4(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.mlir.constant(48 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.getelementptr %2[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.call @use(%7) : (i32) -> ()
    llvm.return
  }
}
