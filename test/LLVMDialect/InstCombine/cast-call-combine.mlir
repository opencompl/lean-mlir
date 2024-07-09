module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func internal @foo(%arg0: !llvm.ptr) attributes {dso_local, passthrough = ["alwaysinline"]} {
    llvm.return
  }
  llvm.func @bar() attributes {passthrough = ["noinline", "noreturn"]} {
    llvm.unreachable
  }
  llvm.func @test() {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @foo(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
}
