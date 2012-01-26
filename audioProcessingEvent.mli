open Js
open AudioBuffer
open AudioNode

class type audioProcessingEvent = object
  inherit Dom_html.event

  method node : javaScriptAudioNode t prop

  method playbackTime : float t readonly_prop

  method inputBuffer : audioBuffer t js_array t readonly_prop

  method outputBuffer : audioBuffer t js_array t readonly_prop
end
