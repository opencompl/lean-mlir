
define i31 @main(i53 %0) {
  %2 = trunc nuw nsw i53 %0 to i31
  ret i31 %2
}
