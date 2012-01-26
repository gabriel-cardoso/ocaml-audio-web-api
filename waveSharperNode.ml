open Js
open AudioNode

class type waveSharperNode = object
  inherit audioNode

  method curve : float t js_array t prop
end
