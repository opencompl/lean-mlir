module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<32> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @pr30402(3 : i64) {addr_space = 0 : i32} : i64
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb1(%2 : !llvm.ptr)
  ^bb1(%3: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %5 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %6 = llvm.icmp "ult" %4, %3 : !llvm.ptr
    llvm.cond_br %6, ^bb2, ^bb1(%5 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @test2(%arg0: i32, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb1(%3 : !llvm.ptr)
  ^bb1(%4: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %6 = llvm.getelementptr inbounds %4[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %7 = llvm.ptrtoint %5 : !llvm.ptr to i32
    %8 = llvm.ptrtoint %4 : !llvm.ptr to i32
    %9 = llvm.icmp "ult" %7, %8 : i32
    llvm.cond_br %9, ^bb2, ^bb1(%6 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @test3_no_inbounds1(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb1(%2 : !llvm.ptr)
  ^bb1(%3: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %5 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %6 = llvm.icmp "ult" %4, %3 : !llvm.ptr
    llvm.cond_br %6, ^bb2, ^bb1(%5 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @test3_no_inbounds2(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb1(%2 : !llvm.ptr)
  ^bb1(%3: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %5 = llvm.getelementptr %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %6 = llvm.icmp "ult" %4, %3 : !llvm.ptr
    llvm.cond_br %6, ^bb2, ^bb1(%5 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @test3_no_inbounds3(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb1(%2 : !llvm.ptr)
  ^bb1(%3: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %5 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %6 = llvm.icmp "ult" %4, %3 : !llvm.ptr
    llvm.cond_br %6, ^bb2, ^bb1(%5 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @test4(%arg0: i16, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.inttoptr %arg0 : i16 to !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb1(%3 : !llvm.ptr)
  ^bb1(%4: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %6 = llvm.getelementptr inbounds %4[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %7 = llvm.ptrtoint %5 : !llvm.ptr to i32
    %8 = llvm.ptrtoint %4 : !llvm.ptr to i32
    %9 = llvm.icmp "ult" %7, %8 : i32
    llvm.cond_br %9, ^bb2, ^bb1(%6 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fun_ptr() -> !llvm.ptr
  llvm.func @test5(%arg0: i32) -> !llvm.ptr attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.invoke @fun_ptr() to ^bb1 unwind ^bb4 : () -> !llvm.ptr
  ^bb1:  // pred: ^bb0
    %4 = llvm.getelementptr inbounds %3[%arg0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb2(%4 : !llvm.ptr)
  ^bb2(%5: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %6 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %7 = llvm.getelementptr inbounds %5[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %8 = llvm.icmp "ult" %6, %5 : !llvm.ptr
    llvm.cond_br %8, ^bb3, ^bb2(%7 : !llvm.ptr)
  ^bb3:  // pred: ^bb2
    llvm.return %5 : !llvm.ptr
  ^bb4:  // pred: ^bb0
    %9 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @fun_i32() -> i32
  llvm.func @test6(%arg0: i32) -> !llvm.ptr attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.invoke @fun_i32() to ^bb1 unwind ^bb4 : () -> i32
  ^bb1:  // pred: ^bb0
    %4 = llvm.inttoptr %3 : i32 to !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%arg0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.br ^bb2(%5 : !llvm.ptr)
  ^bb2(%6: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %7 = llvm.getelementptr inbounds %4[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %8 = llvm.getelementptr inbounds %6[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %9 = llvm.icmp "ult" %7, %6 : !llvm.ptr
    llvm.cond_br %9, ^bb3, ^bb2(%8 : !llvm.ptr)
  ^bb3:  // pred: ^bb2
    llvm.return %6 : !llvm.ptr
  ^bb4:  // pred: ^bb0
    %10 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test7() -> i1 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.addressof @pr30402 : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.getelementptr inbounds %1[%2] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.br ^bb1(%1 : !llvm.ptr)
  ^bb1(%4: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.icmp "eq" %4, %3 : !llvm.ptr
    llvm.cond_br %5, ^bb2, ^bb1(%3 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    llvm.return %5 : i1
  }
  llvm.func @__gxx_personality_v0(...) -> i32
  llvm.func @test8(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %2 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %6 = llvm.icmp "eq" %5, %3 : !llvm.ptr
    llvm.return %6 : i1
  }
  llvm.func @test_zero_offset_cycle(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr inbounds %arg0[%0, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i64, i64)>
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.br ^bb1(%3 : i32)
  ^bb1(%4: i32):  // 3 preds: ^bb0, ^bb1, ^bb2
    %5 = llvm.inttoptr %4 : i32 to !llvm.ptr
    %6 = llvm.icmp "eq" %2, %5 : !llvm.ptr
    llvm.cond_br %6, ^bb1(%4 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    %7 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.br ^bb1(%7 : i32)
  }
}
