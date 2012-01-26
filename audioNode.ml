open Js
open AudioListener
open AudioParam
open AudioBuffer
open AudioGain
open ArrayBuffer
open Dom_html

class type audioNode = object ('self)

  method connect : 'self t -> int -> int -> unit meth

  method disconnect : int -> unit meth

  method context : audioContext t readonly_prop

  method numberOfInputs : int readonly_prop

  method numberOfOutputs : int readonly_prop
end

and audioSourceNode = object
  inherit audioNode
end

and audioBufferSourceNode = object
  inherit audioSourceNode

  method buffer : audioBuffer t prop

  method gain : audioGain t readonly_prop

  method playbackRate : audioParam t prop

  method loop : bool t prop

  method noteOn : float t -> unit meth

  method noteGrainOn : float t -> float t -> float t -> unit meth

  method noteOff : float t -> unit meth
end

and dynamicsCompressorNode = object
  inherit audioNode
end

and audioChannelMerger = object
  inherit audioNode
end

and audioChannelSplitter = object
  inherit audioNode
end

and audioGainNode = object
  inherit audioNode

  method gain : audioGain t prop
end
    
and audioPannerNode =object
  inherit audioNode

  method _EQUALPOWER : int prop
  method _HRTF : int prop
  method _SOUNDFIELD : int prop

  method panningModel : int prop

  method setPosition : float t -> float t -> float t -> unit meth
  method setOriention : float t -> float t -> float t -> unit meth
  method setVelocity : float t -> float t -> float t -> unit meth

  method distanceModel : int prop
  method refDistance : float t prop
  method maxDistance : float t prop
  method rolloffFactor : float t prop

  method coneInnerAngle : float t prop
  method coneOuterAngle : float t prop
  method coneOuterGain : float t prop

  method coneGain : audioGain t readonly_prop
  method distanceGain : audioGain t readonly_prop
end

and biquadFilterNode = object
  inherit audioNode

  method type_ : int prop

  method frequency : audioParam t readonly_prop
  method q : audioParam t readonly_prop
  method gain : audioParam t readonly_prop
end

and convolverNode = object 
  inherit audioNode

  method buffer : audioBuffer t prop
end

and audioDestinationNode = object
  inherit audioNode

  method numberOfChannels : int readonly_prop

end

and delayNode = object
  inherit audioNode

  method delayTime : audioParam t prop
end

and realtimeAnalyserNode = object
  inherit audioNode

  method getFloatFrequencyData : float t js_array t -> unit meth
  method getByteFrequencyData : int js_array t -> unit meth

  method getByteTimeDomainData : int js_array t -> unit meth

  method fftSize : int prop
  method frequencyBinCount : int readonly_prop

  method minDecibels : float t prop
  method maxDecibels : float t prop

  method smoothingTimeConstant : float t prop
end

and javaScriptAudioNode = object ('self)
  inherit audioNode

  method onaudioprocess : ('self t, event t) event_listener prop

  method bufferSize : int readonly_prop
end

(** This interface represents a set of AudioNode objects and their connections.
    It allows for arbitrary routing of signals to the AudioDestinationNode 
    (what the user ultimately hears). Nodes are created from the context and are
    then connected together. In most use cases, only a single AudioContext is 
    used per document. An AudioContext is constructed as follows:

    let context = jsnew AudioContext(); *)
and audioContext = object

  method destination : audioDestinationNode t readonly_prop
  (** An AudioDestinationNode with a single input representing the final 
      destination for all audio (to be rendered to the audio hardware). All 
      AudioNodes actively rendering audio will directly or indirectly connect 
      to destination. *)

  method sampleRate  : float t readonly_prop
  (** The sample rate (in sample-frames per second) at which the AudioContext 
      handles audio. It is assumed that all AudioNodes in the context run at 
      this rate. In making this assumption, sample-rate converters or 
      "varispeed" processors are not supported in real-time processing. *)

  method currentTime : float t readonly_prop
  (** This is a time in seconds which starts at zero when the context is created
      and increases in real-time. All scheduled times are relative to it. This 
      is not a "transport" time which can be started, paused, and re-positioned.
      It is always moving forward. *)

  method listener    : audioListener t readonly_prop
  (** An AudioListener which is used for 3D spatialization. *)

  method createBuffer_ : int -> int -> float t -> audioBuffer t meth

  method createBuffer  : arrayBuffer t -> bool t -> audioBuffer t meth

  method decodeAudioData : 
    arrayBuffer t -> (unit -> unit) callback -> (unit -> unit) callback opt 
      -> unit meth

  method createBufferSource : audioBufferSourceNode t meth
  method createJavaScriptNode : int -> int -> int -> javaScriptAudioNode t meth
  method createAnalyser : realtimeAnalyserNode t meth
  method createGainNode : audioGainNode t meth
  method createDelayNode : delayNode t meth
  method createBiquadFilter : biquadFilterNode t meth
  method createPanner : audioPannerNode t meth
  method createConvolver : convolverNode t meth
  method createChannelSplitter : audioChannelSplitter t meth
  method createChannelMerger : audioChannelMerger t meth
  method createDynamicsCompressor : dynamicsCompressorNode t meth
end
