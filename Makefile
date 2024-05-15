DESTDIR?=/usr
DEST_LIB=$(DESTDIR)/lib
DEST_INC=$(DESTDIR)/include

LIBRARY = libspkhtml.a 
INCLUDE = spk_html.hpp

BINARY_TAGS = Abbr Acronym Address A Applet Article Aside Audio Bdi Bdo Big Blockquote Body B Caption Canvas Center Cite Code Colgroup Data Datalist Dd Delete Dfn Details Dialog Dir Div Dl Dt Fieldset Figcaption Figure Font Footer Form Frame Head Header H1 H2 H3 H4 H5 H6 Hgroup Html Iframe Ins I Kbd Label Legend Li Main Mark Marquee Menuitem Meter Nav Nobr Noembed Noscript Object Optgroup Option Output P Em Pre Progress Q Rp Rt Ruby S Samp Script Section Small Source Span Strike Strong Sub Sup Summary Table Tbody Td Template Tfoot Th Thead Time Title Tr Tt U Var Video Xmp
UNARY_TAGS  = Area Base Basefont Bgsound Br Button Col Embed Frameset Heading Hr Img Input Isindex Keygen Meta Param Spacer Style Svg Track Wbr

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

TEST_SRC = test/html.spec.cpp
TEST = html.spec

COMPILE_FLAG = -std=c++23 -Wextra -Wno-implicit-fallthrough -fconcepts-diagnostics-depth=2
INCLUDE_FLAG = -I$(INC_DIR) -I.
DEPEND_FLAG = -MT $@ -MMD -MP -MF 
COMPILE = g++ $(COMPILE_FLAG) $(INCLUDE_FLAG)
TEST_LINK_FLAG = $(LIBRARY) -lCatch2Main -lCatch2 

.PHONY: install
install: $(LIBRARY) $(INCLUDE)
	mkdir -p "$(DEST_LIB)" "$(DEST_INC)"
	cp $(LIBRARY) "$(DEST_LIB)"
	cp $(INCLUDE) "$(DEST_INC)"

.PHONY: uninstall
uninstall:
	rm "$(DEST_LIB)/$(LIBRARY)" "$(DEST_INC)/$(INCLUDE)"

.PHONY: all
all: $(LIBRARY) $(INCLUDE) $(TEST)

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

$(TEST): $(TEST_SRC) $(INCLUDE) $(LIBRARY)
	$(COMPILE) $< -o $@ $(TEST_LINK_FLAG)
	./$@

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
