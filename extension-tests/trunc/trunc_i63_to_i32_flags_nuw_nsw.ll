
define i32 @main(i63 %0) {
  %2 = trunc nuw nsw i63 %0 to i32
  ret i32 %2
}
