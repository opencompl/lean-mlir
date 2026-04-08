
define i31 @main(i63 %0) {
  %2 = trunc nuw nsw i63 %0 to i31
  ret i31 %2
}
