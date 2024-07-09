#tbaa_root = #llvm.tbaa_root<id = "Simple C/C++ TBAA">
#tbaa_type_desc = #llvm.tbaa_type_desc<id = "omnipotent char", members = {<#tbaa_root, 0>}>
#tbaa_type_desc1 = #llvm.tbaa_type_desc<id = "int", members = {<#tbaa_type_desc, 0>}>
#tbaa_tag = #llvm.tbaa_tag<base_type = #tbaa_type_desc1, access_type = #tbaa_type_desc1, offset = 0>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global common @b(0 : i32) {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.func @fn1() -> i32 attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["norecurse", "nounwind", "ssp", ["uwtable", "2"], ["disable-tail-calls", "false"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["target-cpu", "core2"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]], target_cpu = "core2", target_features = #llvm.target_features<["+cx16", "+fxsr", "+mmx", "+sse", "+sse2", "+sse3", "+ssse3"]>} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @b : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(32 : i32) : i32
    %4 = llvm.mlir.undef : i32
    %5 = llvm.load %1 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i32
    llvm.br ^bb1(%5, %0 : i32, i32)
  ^bb1(%6: i32, %7: i32):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.lshr %6, %2  : i32
    %9 = llvm.or %8, %6  : i32
    %10 = llvm.add %7, %2 overflow<nsw, nuw>  : i32
    %11 = llvm.icmp "eq" %10, %3 : i32
    llvm.cond_br %11, ^bb2, ^bb1(%9, %10 : i32, i32)
  ^bb2:  // pred: ^bb1
    llvm.store %9, %1 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : i32, !llvm.ptr
    llvm.return %4 : i32
  }
}
