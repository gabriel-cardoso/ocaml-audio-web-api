open Audio_web_api
open Dom_html
open Js

let doc = Dom_html.document
let win = Dom_html.window

let gebi s = Js.Opt.get (doc##getElementById (Js.string s)) 
  (fun () -> assert false)

let jss_of_float f = Js.string (string_of_float (Js.to_float f))

let audio_context_time_el = gebi "context_time"

let audioContext = jsnew audioContext () 

let rec schedule () =
  let ctx_time = audioContext##currentTime in
  audio_context_time_el##innerHTML <- jss_of_float (ctx_time);
  ignore (
    win##setTimeout (Js.wrap_callback (fun () -> schedule ()), 0.)
  )

let _ = 
  schedule ()




















