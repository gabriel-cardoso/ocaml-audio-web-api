SRC=$(wildcard *.ml)
EXECS=$(SRC:.ml=.byte)
TARGETS=$(SRC:.ml=.js)
OAWAPI_DIR=..
OAWAPI_LIB=ocaml_audio_web_api.cma
LIB=-package js_of_ocaml $(OAWAPI_LIB)
OCAMLFLAGS=-package js_of_ocaml,js_of_ocaml.syntax -syntax camlp4o -I $(OAWAPI_DIR)
OCAMLLFLAGS=

all: $(TARGETS)

%.byte: %.ml $(OAWAPI_DIR)/$(OAWAPI_LIB)
	@echo "[CC]" $@
	ocamlfind ocamlc -linkpkg -o $@ $(OCAMLFLAGS) $(LIB) $<

%.js: %.byte
	js_of_ocaml $^ -pretty

ocamldep:
	ocamlfind ocamldep -I $(OAWAPI_DIR) $(OCAMLFLAGS) $(SRC) 

clean:
	@echo "[CLEAN]"
	-rm -f *.cmo *.cmi $(TARGETS) $(EXECS)

var: 
	@echo $(TARGETS)
	@echo $(EXECS)