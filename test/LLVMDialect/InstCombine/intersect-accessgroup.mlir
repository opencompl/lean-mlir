#access_group = #llvm.access_group<id = distinct[0]<>>
#access_group1 = #llvm.access_group<id = distinct[1]<>>
#access_group2 = #llvm.access_group<id = distinct[2]<>>
#loop_annotation = #llvm.loop_annotation<parallelAccesses = #access_group>
#loop_annotation1 = #llvm.loop_annotation<parallelAccesses = #access_group2>
#loop_annotation2 = #llvm.loop_annotation<parallelAccesses = #access_group2, #access_group1>
#loop_annotation3 = #llvm.loop_annotation<parallelAccesses = #access_group1>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @arg(f64)
  llvm.func @func(%arg0: i64, %arg1: !llvm.ptr {llvm.noalias, llvm.nonnull}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb8
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.icmp "slt" %3, %arg0 : i64
    llvm.cond_br %4, ^bb2(%0 : i32), ^bb9
  ^bb2(%5: i32):  // 2 preds: ^bb1, ^bb7
    %6 = llvm.sext %5 : i32 to i64
    %7 = llvm.icmp "slt" %6, %arg0 : i64
    llvm.cond_br %7, ^bb3(%0 : i32), ^bb8
  ^bb3(%8: i32):  // 2 preds: ^bb2, ^bb6
    %9 = llvm.sext %8 : i32 to i64
    %10 = llvm.icmp "slt" %9, %arg0 : i64
    llvm.cond_br %10, ^bb4(%0 : i32), ^bb7
  ^bb4(%11: i32):  // 2 preds: ^bb3, ^bb5
    %12 = llvm.sext %11 : i32 to i64
    %13 = llvm.icmp "slt" %12, %arg0 : i64
    llvm.cond_br %13, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    %14 = llvm.add %2, %5 overflow<nsw>  : i32
    %15 = llvm.add %14, %8 overflow<nsw>  : i32
    %16 = llvm.add %15, %11 overflow<nsw>  : i32
    %17 = llvm.sext %16 : i32 to i64
    %18 = llvm.getelementptr inbounds %arg1[%17] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %19 = llvm.load %18 {access_groups = [#access_group, #access_group1], alignment = 8 : i64} : !llvm.ptr -> f64
    %20 = llvm.load %18 {access_groups = [#access_group, #access_group2], alignment = 8 : i64} : !llvm.ptr -> f64
    %21 = llvm.fadd %19, %20  : f64
    llvm.call @arg(%21) {access_groups = [#access_group, #access_group2, #access_group1]} : (f64) -> ()
    %22 = llvm.add %11, %1 overflow<nsw>  : i32
    llvm.br ^bb4(%22 : i32) {loop_annotation = #loop_annotation}
  ^bb6:  // pred: ^bb4
    %23 = llvm.add %8, %1 overflow<nsw>  : i32
    llvm.br ^bb3(%23 : i32) {loop_annotation = #loop_annotation1}
  ^bb7:  // pred: ^bb3
    %24 = llvm.add %5, %1 overflow<nsw>  : i32
    llvm.br ^bb2(%24 : i32) {loop_annotation = #loop_annotation2}
  ^bb8:  // pred: ^bb2
    %25 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.br ^bb1(%25 : i32) {loop_annotation = #loop_annotation3}
  ^bb9:  // pred: ^bb1
    llvm.return
  }
}
