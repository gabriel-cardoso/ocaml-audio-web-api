JS_OF_OCAML?=$(shell ocamlfind query js_of_ocaml)
LIB=$(JS_OF_OCAML_PATH)/lib

OCAMLFLAGS=$(INCLUDES) -package js_of_ocaml.syntax -syntax camlp4o
OCAMLIFLAGS=$(INCLUDES) -package js_of_ocaml -pp "cpp -traditional-cpp"
OAWAPI=ocaml_audio_web_api.cma
MLS=$(shell find * -name "*.ml")
MLIS=$(shell find * -name "*.mli")
OCAMLFIND=ocamlfind
OCAMLC=$(OCAMLFIND) ocamlc
OCAMLDOC=ocamldoc
CMOS=arrayBuffer.cmo audio_web_api.cmo


all: $(OAWAPI)

examples: all
	@(${MAKE} -C examples);


-include .depend

$(OAWAPI): $(CMOS)
	$(OCAMLC) -a -o $@ $^

.SECONDEXPANSION:

%.cmo: %.ml
	@echo "[CC] $@"
	$(OCAMLC) $(OCAMLFLAGS) -c $<

%.cmi: %.mli
	$(OCAMLC) $(OCAMLIFLAGS) -c $<

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
