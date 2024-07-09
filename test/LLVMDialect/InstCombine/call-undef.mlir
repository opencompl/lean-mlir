module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @c(i32 {llvm.noundef})
  llvm.func @d(!llvm.ptr {llvm.dereferenceable = 1 : i64})
  llvm.func @e(i32)
  llvm.func @f(!llvm.ptr)
  llvm.func @test1() {
    %0 = llvm.mlir.undef : i32
    llvm.call @c(%0) : (i32) -> ()
    llvm.return
  }
  llvm.func @test2() {
    %0 = llvm.mlir.poison : i32
    llvm.call @c(%0) : (i32) -> ()
    llvm.return
  }
  llvm.func @test3() {
    %0 = llvm.mlir.undef : i32
    llvm.call @e(%0) : (i32) -> ()
    llvm.return
  }
  llvm.func @test4() {
    %0 = llvm.mlir.poison : i32
    llvm.call @e(%0) : (i32) -> ()
    llvm.return
  }
  llvm.func @test5() {
    %0 = llvm.mlir.undef : !llvm.ptr
    llvm.call @d(%0) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test6() {
    %0 = llvm.mlir.poison : !llvm.ptr
    llvm.call @d(%0) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test7() {
    %0 = llvm.mlir.undef : !llvm.ptr
    llvm.call @f(%0) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test8() {
    %0 = llvm.mlir.poison : !llvm.ptr
    llvm.call @f(%0) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test_mismatched_call() {
    %0 = llvm.mlir.addressof @e : !llvm.ptr
    %1 = llvm.mlir.poison : i8
    llvm.call %0(%1) : !llvm.ptr, (i8) -> ()
    llvm.return
  }
}
