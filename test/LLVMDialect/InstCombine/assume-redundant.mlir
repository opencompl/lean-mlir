module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @_Z3fooR1s(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64, llvm.nocapture, llvm.readonly}) attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(1599 : i64) : i64
    %6 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.and %7, %0  : i64
    %9 = llvm.icmp "eq" %8, %1 : i64
    llvm.br ^bb1(%1 : i64)
  ^bb1(%10: i64):  // 2 preds: ^bb0, ^bb1
    "llvm.intr.assume"(%9) : (i1) -> ()
    %11 = llvm.getelementptr inbounds %6[%10] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %12 = llvm.load %11 {alignment = 16 : i64} : !llvm.ptr -> f64
    %13 = llvm.fadd %12, %2  : f64
    "llvm.intr.assume"(%9) : (i1) -> ()
    %14 = llvm.fmul %13, %3  : f64
    llvm.store %14, %11 {alignment = 16 : i64} : f64, !llvm.ptr
    %15 = llvm.add %10, %4 overflow<nsw, nuw>  : i64
    "llvm.intr.assume"(%9) : (i1) -> ()
    %16 = llvm.getelementptr inbounds %6[%15] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %17 = llvm.load %16 {alignment = 8 : i64} : !llvm.ptr -> f64
    %18 = llvm.fadd %17, %2  : f64
    "llvm.intr.assume"(%9) : (i1) -> ()
    %19 = llvm.fmul %18, %3  : f64
    llvm.store %19, %16 {alignment = 8 : i64} : f64, !llvm.ptr
    %20 = llvm.add %15, %4 overflow<nsw, nuw>  : i64
    %21 = llvm.icmp "eq" %15, %5 : i64
    llvm.cond_br %21, ^bb2, ^bb1(%20 : i64)
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @get() -> (!llvm.ptr {llvm.align = 8 : i64})
  llvm.func @test1() {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @get() : () -> !llvm.ptr
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %4 = llvm.and %3, %0  : i64
    %5 = llvm.icmp "eq" %4, %1 : i64
    "llvm.intr.assume"(%5) : (i1) -> ()
    llvm.return
  }
  llvm.func @test3() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.alloca %0 x i8 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.and %4, %1  : i64
    %6 = llvm.icmp "eq" %5, %2 : i64
    "llvm.intr.assume"(%6) : (i1) -> ()
    llvm.return
  }
}
