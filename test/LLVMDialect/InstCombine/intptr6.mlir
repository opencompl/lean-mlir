module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.comdat @__llvm_global_comdat {
    llvm.comdat_selector @foo any
  }
  llvm.mlir.global external thread_local @bar() {addr_space = 0 : i32, alignment = 8 : i64} : !llvm.struct<"A", (struct<"B", (ptr)>)>
  llvm.func @__gxx_personality_v0(...) -> i32
  llvm.func local_unnamed_addr @foo(%arg0: i1) comdat(@__llvm_global_comdat::@foo) attributes {alignment = 2 : i64, passthrough = ["inlinehint", "sanitize_memory", ["uwtable", "2"]], personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.addressof @bar : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<(ptr, i32)>
    %5 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %6 = llvm.ptrtoint %5 : !llvm.ptr to i64
    %7 = llvm.getelementptr inbounds %5[%1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"C", packed (ptr, i32, array<4 x i8>)>
    llvm.store %3, %7 {alignment = 8 : i64} : i32, !llvm.ptr
    %8 = llvm.invoke @_Znwm() to ^bb1 unwind ^bb6 : () -> !llvm.ptr
  ^bb1:  // pred: ^bb0
    %9 = llvm.invoke @_Znwm() to ^bb2 unwind ^bb7 : () -> !llvm.ptr
  ^bb2:  // pred: ^bb1
    llvm.invoke @lazy() to ^bb4 unwind ^bb3 : () -> ()
  ^bb3:  // pred: ^bb2
    %10 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.br ^bb8
  ^bb4:  // pred: ^bb2
    %11 = llvm.ptrtoint %9 : !llvm.ptr to i64
    llvm.invoke @scale() to ^bb5 unwind ^bb9 : () -> ()
  ^bb5:  // pred: ^bb4
    llvm.return
  ^bb6:  // pred: ^bb0
    %12 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb7:  // pred: ^bb1
    %13 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb8:  // pred: ^bb3
    llvm.br ^bb10(%6 : i64)
  ^bb9:  // pred: ^bb4
    %14 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.br ^bb10(%11 : i64)
  ^bb10(%15: i64):  // 2 preds: ^bb8, ^bb9
    %16 = llvm.inttoptr %15 : i64 to !llvm.ptr
    llvm.cond_br %arg0, ^bb12, ^bb11
  ^bb11:  // pred: ^bb10
    %17 = llvm.getelementptr inbounds %16[%1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"C", packed (ptr, i32, array<4 x i8>)>
    %18 = llvm.load %17 {alignment = 8 : i64} : !llvm.ptr -> i32
    llvm.unreachable
  ^bb12:  // pred: ^bb10
    llvm.resume %4 : !llvm.struct<(ptr, i32)>
  }
  llvm.func local_unnamed_addr @_Znwm() -> (!llvm.ptr {llvm.noalias, llvm.nonnull}) attributes {passthrough = ["nobuiltin"]}
  llvm.func local_unnamed_addr @scale() attributes {alignment = 2 : i64, passthrough = ["sanitize_memory", ["uwtable", "2"]]}
  llvm.func unnamed_addr @lazy() attributes {alignment = 2 : i64, passthrough = ["sanitize_memory", ["uwtable", "2"]]}
}
