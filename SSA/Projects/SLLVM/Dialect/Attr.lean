import Lean

namespace FooAttr
open Lean

initialize foo : TagAttribute ←
  registerTagAttribute `foo "Test foo attribute"
