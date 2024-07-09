module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(%arg0: !llvm.ptr, %arg1: !llvm.ptr) attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(16 : i64) : i64
    %4 = llvm.mlir.constant(1648 : i32) : i32
    %5 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %6 = llvm.and %5, %0  : i64
    %7 = llvm.icmp "eq" %6, %1 : i64
    "llvm.intr.assume"(%7) : (i1) -> ()
    %8 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %9 = llvm.and %8, %0  : i64
    %10 = llvm.icmp "eq" %9, %1 : i64
    "llvm.intr.assume"(%10) : (i1) -> ()
    llvm.br ^bb1(%1 : i64)
  ^bb1(%11: i64):  // 2 preds: ^bb0, ^bb1
    %12 = llvm.getelementptr inbounds %arg1[%11] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %13 = llvm.load %12 {alignment = 4 : i64} : !llvm.ptr -> i32
    %14 = llvm.add %13, %2 overflow<nsw>  : i32
    %15 = llvm.getelementptr inbounds %arg0[%11] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %14, %15 {alignment = 4 : i64} : i32, !llvm.ptr
    %16 = llvm.add %11, %3 overflow<nsw, nuw>  : i64
    %17 = llvm.trunc %16 : i64 to i32
    %18 = llvm.icmp "slt" %17, %4 : i32
    llvm.cond_br %18, ^bb1(%16 : i64), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
}
