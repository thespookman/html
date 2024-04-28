#include "parameter.hpp"

#include <list>
#include <string>
using std::list;
using std::string;
namespace spk {
namespace html {
#define HTML_BIN(tag)                                                     \
    string tag (const string& contents, const list<Parameter>& params) {  \
        return string ("<") + #tag + concat_params (params) + ">" +       \
               contents + "</" + #tag + ">";                              \
    }                                                                     \
    string tag (const list<Parameter>& params) { return tag ({}, params); }

#define HTML_UN(tag)                                                      \
    string tag (const list<Parameter>& params) {                          \
        return string ("<") + #tag + concat_params (params) + ">";        \
    }
string concat_params (const list<Parameter>& params);
