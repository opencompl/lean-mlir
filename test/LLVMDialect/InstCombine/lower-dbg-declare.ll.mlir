#di_basic_type = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "int", sizeInBits = 32, encoding = DW_ATE_signed>
#di_file = #llvm.di_file<"lower-dbg-declare.cpp" in "">
#loc = loc("lower-dbg-declare.cpp":7:0)
#loc1 = loc("lower-dbg-declare.cpp":8:0)
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C_plus_plus, file = #di_file, producer = "clang", isOptimized = true, emissionKind = Full>
#di_derived_type = #llvm.di_derived_type<tag = DW_TAG_volatile_type, baseType = #di_basic_type>
#di_subroutine_type = #llvm.di_subroutine_type<types = #di_basic_type>
#di_global_variable = #llvm.di_global_variable<scope = #di_compile_unit, name = "sink", linkageName = "sink", file = #di_file, line = 2, type = #di_derived_type, isLocalToUnit = true, isDefined = true>
#di_subprogram = #llvm.di_subprogram<id = distinct[1]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "main", file = #di_file, line = 5, scopeLine = 5, subprogramFlags = "Definition|Optimized", type = #di_subroutine_type>
#di_global_variable_expression = #llvm.di_global_variable_expression<var = #di_global_variable, expr = <>>
#di_local_variable = #llvm.di_local_variable<scope = #di_subprogram, name = "d1", file = #di_file, line = 6, type = #di_basic_type>
#loc2 = loc(fused<#di_subprogram>[#loc])
#loc3 = loc(fused<#di_subprogram>[#loc1])
#loop_annotation = #llvm.loop_annotation<startLoc = #loc2, endLoc = #loc3>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.mlir.global internal @_ZL4sink(0 : i32) {addr_space = 0 : i32, alignment = 4 : i64, dbg_expr = #di_global_variable_expression, dso_local} : i32
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %5 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.intr.dbg.declare #di_local_variable = %5 : !llvm.ptr
    llvm.store %1, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.intr.lifetime.start 4, %5 : !llvm.ptr
    llvm.store %2, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb2
    %6 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    %7 = llvm.call @_ZL5emptyi(%6) : (i32) -> i1
    %8 = llvm.xor %7, %3  : i1
    llvm.cond_br %8, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @_ZL6escapeRi(%5) : (!llvm.ptr) -> ()
    llvm.br ^bb1 {loop_annotation = #loop_annotation}
  ^bb3:  // pred: ^bb1
    llvm.intr.lifetime.end 4, %5 : !llvm.ptr
    llvm.return %1 : i32
  }
  llvm.func internal @_ZL5emptyi(%arg0: i32) -> (i1 {llvm.zeroext}) attributes {dso_local} {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }
  llvm.func internal @_ZL6escapeRi(%arg0: !llvm.ptr {llvm.dereferenceable = 4 : i64}) attributes {dso_local} {
    llvm.return
  }
}
