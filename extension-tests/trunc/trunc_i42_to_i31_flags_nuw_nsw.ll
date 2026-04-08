
define i31 @main(i42 %0) {
  %2 = trunc nuw nsw i42 %0 to i31
  ret i31 %2
}
