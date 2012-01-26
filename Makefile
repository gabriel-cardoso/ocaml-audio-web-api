JS_OF_OCAML?=$(shell ocamlfind query js_of_ocaml)
LIB=$(JS_OF_OCAML_PATH)/lib

OCAMLFLAGS=$(INCLUDES) -package js_of_ocaml.syntax -syntax camlp4o
OCAMLIFLAGS=$(INCLUDES) -package js_of_ocaml -pp "cpp -traditional-cpp"
LIBRARY=ocaml_audio_web_api
OAWAPI=$(LIBRARY).cma
MLS=$(shell find * -name "*.ml")
MLIS=$(shell find * -name "*.mli")
OCAMLFIND=ocamlfind
OCAMLDOC=ocamldoc
CMOS=arrayBuffer.cmo audioBuffer.cmo audioGain.cmo audioListener.cmo audioNode.cmo audioParam.cmo audioProcessingEvent.cmo mediaElementAudioSourceNode.cmo waveSharperNode.cmo


all: $(OAWAPI)

examples: all
	@(${MAKE} -C examples);


-include .depend

$(OAWAPI): $(CMOS)
	$(OCAMLFIND) ocamlc -a -o $@ $^

.SECONDEXPANSION:

%.cmo: %.ml
	@echo "[CC] $@"
	$(OCAMLFIND) ocamlc $(OCAMLFLAGS) -c $<

%.cmi: %.mli
	$(OCAMLFIND) ocamlc $(OCAMLIFLAGS) -c $<

depend: ocamldep

ocamldep:
	($(OCAMLFIND) ocamldep $(OCAMLFLAGS) $(MLS); \
	$(OCAMLFIND) ocamldep $(OCAMLIFLAGS) $(MLIS)) > .depend

cleanall: clean
	-rm -f .depend

clean:
	@echo "[CLEAN]"
	-rm -f $(OAWAPI)
	-find . -name "*.cm[oix]" -exec rm {} \;
	${MAKE} -C examples clean
