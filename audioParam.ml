open Js

class type audioParam = object

  method value : float t prop

  method minValue : float t readonly_prop

  method maxValue : float t readonly_prop

  method defaultValue : float t readonly_prop

  method name : js_string t readonly_prop

  method unit : int readonly_prop

  method setValueAtTime : float t -> float t -> unit meth

  method linearRampToValueAtTime : float t -> float t -> unit meth

  method exponentialRampToValueAtTime : float t -> float t -> unit meth

  method setTragetValueAtTime : float t -> float t -> float t -> unit meth

  method setValueCurveAtTime : 
    float t js_array t -> float t -> float t -> unit meth

  method cancelScheduledValues : float t -> unit meth
end
