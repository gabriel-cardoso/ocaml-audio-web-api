open Js

class type arrayBuffer = object
  method byteLength : int readonly_prop
end

let arrayBuffer : (int -> arrayBuffer t) constr = 
  Unsafe.variable "ArrayBuffer"
