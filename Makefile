LIBRARY = libspkhtml.a 
INCLUDE = spk_html.hpp

BINARY_TAGS = abbr acronym address a applet article aside audio bdi bdo big blockquote body b caption canvas center cite code colgroup data datalist dd dfn details dialog dir div dl dt fieldset figcaption figure font footer form frame head header h1 h2 h3 h4 h5 h6 hgroup html iframe input ins i kbd label legend li main mark marquee menuitem meter nav nobr noembed noscript object optgroup option output p em pre progress q rp rt ruby s samp script section small source span strike strong sub sup summary table tbody td tfoot th thead time title tr tt u var video xmp
UNARY_TAGS  = area base basefont bgsound br button col embed frameset heading hr img input isindex keygen meta param spacer style svg track wbr

INC_TEMP = inc/inc_template.hpp
SRC_TEMP = inc/src_template.hpp

BLD_DIR = bld
DEP_DIR = dep
INC_DIR = inc
OTH_SRC_DIR = src

BIN_SRC_DIR = bin_src
UN_SRC_DIR  = un_src

BIN_BLD_DIR = bin_bld
UN_BLD_DIR  = un_bld

OTH_SRC = $(wildcard $(OTH_SRC_DIR)/*.cpp)
BIN_SRC = $(patsubst %, $(BIN_SRC_DIR)/%.cpp, $(BINARY_TAGS))
UN_SRC  = $(patsubst %, $(UN_SRC_DIR)/%.cpp, $(UNARY_TAGS))

OTH_DEP = $(patsubst $(OTH_SRC_DIR)/%.cpp, $(DEP_DIR)/%.d, $(OTH_SRC))
BIN_DEP = $(patsubst $(BIN_SRC_DIR)/%.cpp, $(DEP_DIR)/%.d, $(BIN_SRC))
UN_DEP  = $(patsubst $(UN_SRC_DIR)/%.cpp, $(DEP_DIR)/%.d, $(UN_SRC))

OTH_OBJ = $(patsubst $(OTH_SRC_DIR)/%.cpp, $(BLD_DIR)/%.o, $(OTH_SRC))
BIN_OBJ = $(patsubst $(BIN_SRC_DIR)/%.cpp, $(BIN_BLD_DIR)/%.o, $(BIN_SRC))
UN_OBJ  = $(patsubst $(UN_SRC_DIR)/%.cpp, $(UN_BLD_DIR)/%.o, $(UN_SRC))

SRC = $(BIN_SRC) $(UN_SRC) $(OTH_SRC)
DEP = $(BIN_DEP) $(UN_DEP) $(OTH_DEP)
OBJ = $(BIN_OBJ) $(UN_OBJ) $(OTH_OBJ)

COMPILE_FLAG = -std=c++23 -Wextra -Wno-implicit-fallthrough -fconcepts-diagnostics-depth=2
INCLUDE_FLAG = -I$(INC_DIR)
DEPEND_FLAG = -MT $@ -MMD -MP -MF 
COMPILE = g++ $(COMPILE_FLAG) $(INCLUDE_FLAG)

.PHONY: all
all: $(LIBRARY) $(INCLUDE)

$(INCLUDE): $(INC_TEMP)
	cat $(INC_TEMP) > $@
	for tag in $(BINARY_TAGS); do echo "HTML_BIN($$tag);" >> $@; done
	for tag in $(UNARY_TAGS); do echo "HTML_UN($$tag);" >> $@; done
	echo '};};'>> $@
	echo '#undef HTML_BIN' >> $@
	echo '#undef HTML_UN' >> $@

$(BIN_SRC_DIR)/%.cpp: $(SRC_TEMP)
	mkdir -p $(BIN_SRC_DIR)
	echo '#include "src_template.hpp"' > $@
	echo 'HTML_BIN($*);' >> $@
	echo '};};'>> $@
	echo '#undef HTML_BIN' >> $@

$(UN_SRC_DIR)/%.cpp: $(SRC_TEMP)
	mkdir -p $(UN_SRC_DIR)
	echo '#include "src_template.hpp"' > $@
	echo 'HTML_UN($*);' >> $@
	echo '};};'>> $@
	echo '#undef HTML_UN' >> $@

$(BLD_DIR)/%.o: $(OTH_SRC_DIR)/%.cpp $(DEP_DIR)/%.d
	mkdir -p $(@D)
	$(COMPILE) $(DEPEND_FLAG) $(DEP_DIR)/$*.d -c $< -o $@

$(UN_BLD_DIR)/%.o: $(UN_SRC_DIR)/%.cpp $(DEP_DIR)/%.d
	mkdir -p $(@D) 
	$(COMPILE) $(DEPEND_FLAG) $(DEP_DIR)/$*.d -c $< -o $@

$(BIN_BLD_DIR)/%.o: $(BIN_SRC_DIR)/%.cpp $(DEP_DIR)/%.d
	mkdir -p $(@D)
	$(COMPILE) $(DEPEND_FLAG) $(DEP_DIR)/$*.d -c $< -o $@

$(LIBRARY): $(OBJ)
	ar r $@ $^
	ranlib $@

%.d:
	mkdir -p $(@D)
	touch $@

$(DEP):

include $(wildcard $(DEP))

.PHONY: clean
clean:
	rm -rf $(BIN_SRC_DIR) $(UN_SRC_DIR) $(DEP_DIR) $(BLD_DIR) $(BIN_BLD_DIR) $(UN_BLD_DIR) $(INCLUDE) $(LIBRARY)
