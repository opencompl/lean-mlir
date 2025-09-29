import SSA.Projects.SLLVM.Dialect

/-!
# SLLVM dialect printing
-/

/-! ## SLLVM dialect print tests -/

/--
info: builtin.module {
  ^entry(%0 : !ptr, %1 : i64):
    %2 = "ptr.add"(%0, %1) : (!ptr, i64) -> (!ptr)
    "llvm.return"(%2) : (!ptr) -> ()
}
-/
#guard_msgs in #eval Com.printModule [sllvm| {
  ^entry(%p: !ptr, %x: i64):
    %q = "ptr.add"(%p, %x) : (!ptr, i64) -> (!ptr)
    "llvm.return"(%q) : (!ptr) -> ()
}]

/--
info: builtin.module {
  ^entry(%0 : !ptr):
    %1 = "ptr.load"(%0) : (!ptr) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [sllvm| {
  ^entry(%p: !ptr):
    %x = "ptr.load"(%p) : (!ptr) -> (i64)
    "llvm.return"(%x) : (i64) -> ()
}]

/--
info: builtin.module {
  ^entry(%0 : !ptr, %1 : i64):
    "ptr.store"(%0, %1) : (!ptr, i64) -> ()
    "llvm.return"() : () -> ()
}
-/
#guard_msgs in #eval Com.printModule [sllvm| {
  ^entry(%p: !ptr, %x: i64):
    "ptr.store"(%p, %x) : (!ptr, i64) -> ()
    "llvm.return"() : () -> ()
}]

/--
info: builtin.module {
  ^entry():
    %0 = "ptr.alloca"() : () -> (!ptr)
    "llvm.return"(%0) : (!ptr) -> ()
}
-/
#guard_msgs in #eval Com.printModule [sllvm| {
  ^entry():
    %p = "ptr.alloca"() : () -> (!ptr)
    "llvm.return"(%p) : (!ptr) -> ()
}]
