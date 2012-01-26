open Js

class type arrayBuffer = object
  method byteLength : int readonly_prop
end

val arrayBuffer : (int -> arrayBuffer t) constr
