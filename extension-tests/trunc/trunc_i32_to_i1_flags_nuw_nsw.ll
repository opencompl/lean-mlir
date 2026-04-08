
define i1 @main(i32 %0) {
  %2 = trunc nuw nsw i32 %0 to i1
  ret i1 %2
}
