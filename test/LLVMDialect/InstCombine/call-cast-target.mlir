module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.addressof @ctime : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.call %0(%1) : !llvm.ptr, (!llvm.ptr) -> i32
    llvm.return %2 : i32
  }
  llvm.func @ctime(!llvm.ptr) -> !llvm.ptr
  llvm.func internal @foo(%arg0: !llvm.ptr) -> !llvm.struct<(i8)> attributes {dso_local} {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.undef : !llvm.struct<(i8)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<(i8)> 
    llvm.return %2 : !llvm.struct<(i8)>
  }
  llvm.func @test_struct_ret() {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.call @foo(%0) : (!llvm.ptr) -> !llvm.struct<(i8)>
    llvm.return
  }
  llvm.func @fn1(i32) -> i32
  llvm.func @test1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.addressof @fn1 : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr) -> i32
    llvm.return %1 : i32
  }
  llvm.func @fn2(i16) -> i32
  llvm.func @test2(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.addressof @fn2 : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr) -> i32
    llvm.return %1 : i32
  }
  llvm.func @fn3(i64) -> i32
  llvm.func @test3(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.addressof @fn3 : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr) -> i32
    llvm.return %1 : i32
  }
  llvm.func @fn4(i32) -> i32 attributes {passthrough = ["thunk"]}
  llvm.func @test4(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.addressof @fn4 : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr) -> i32
    llvm.return %1 : i32
  }
  llvm.func @fn5(!llvm.ptr {llvm.align = 4 : i64, llvm.byval = !llvm.struct<(i32, i32)>}) -> i1
  llvm.func @test5() -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @fn5 : !llvm.ptr
    %3 = llvm.alloca %0 x !llvm.struct<(i32, i32)> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32, i32)>
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    %6 = llvm.getelementptr inbounds %3[%1, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32, i32)>
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %8 = llvm.call %2(%5, %7) : !llvm.ptr, (i32, i32) -> i1
    llvm.return %8 : i1
  }
}
