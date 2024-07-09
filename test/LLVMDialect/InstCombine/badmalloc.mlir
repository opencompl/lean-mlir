module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @malloc(i64) -> (!llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind", ["allockind", "9"], ["alloc-family", "malloc"]]}
  llvm.func @free(!llvm.ptr) attributes {passthrough = [["allockind", "4"], ["alloc-family", "malloc"]]}
  llvm.func @test1() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.icmp "eq" %3, %1 : !llvm.ptr
    llvm.store %2, %3 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.call @free(%3) : (!llvm.ptr) -> ()
    llvm.return %4 : i1
  }
  llvm.func @test2() -> (!llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.icmp "eq" %3, %1 : !llvm.ptr
    llvm.cond_br %4, ^bb2(%1 : !llvm.ptr), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.store %2, %3 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.br ^bb2(%3 : !llvm.ptr)
  ^bb2(%5: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : !llvm.ptr
  }
}
