open Js

class type audioListener = object
  method gain : float t prop

  method dopplerFactor : float t prop

  method speedOfSound : float t prop

  method setPosition : float t -> float t -> float t -> unit meth
  method setOriention : 
    float t -> float t -> float t -> float t -> float t -> float t -> unit meth
  method setVelocity : float t -> float t -> float t -> unit meth
end
