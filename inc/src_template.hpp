#include <map>
#include <string>
using std::map;
using std::string;
#define HTML_BIN(tag)                                                     \
    string tag (string contents, map<string, string> params) {            \
        return string ("<") + #tag + concat_params (params) + ">" +       \
               contents + "</" + #tag + "> ";                             \
    }                                                                     \
    string tag (map<string, string> params) { return tag ({}, params); }

#define HTML_UN(tag)                                                      \
    string tag (map<string, string> params) {                             \
        return string ("<") + #tag + concat_params (params) + ">";        \
    }
namespace spk {
namespace html {
string concat_params (map<string, string> params);
