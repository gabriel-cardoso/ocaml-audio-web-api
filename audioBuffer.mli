open Js
open AudioGain

class type audioBuffer = object

  method gain : audioGain t prop

  method sampleRate : float t readonly_prop

  method length : float t readonly_prop

  method numberOfChannels : int readonly_prop

  method getChannelData : int -> float t js_array t
end
