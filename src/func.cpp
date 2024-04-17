#include <map>
#include <string>
namespace spk {
namespace html {
using std::map;
using std::pair;
using std::string;
string concat_params (map<string, string> params) {
    string ret = "";
    for (pair<string, string> p : params)
        ret += string (" ") + p.first + "=\"" + p.second + "\"";
    return ret;
}
string comment (string content) {
    return string ("<!--") + content + "-->";
}
string _delete (string contents, map<string, string> params) {
    return string ("<delete") + concat_params (params) + ">" + contents +
           "</delete> ";
}
string _delete (map<string, string> params) {
    return _delete ({}, params);
}
string doctype () { return "<!DOCTYPE html>"; }
string _template (string contents, map<string, string> params) {
    return string ("<template") + concat_params (params) + ">" + contents +
           "</template> ";
}
string _template (map<string, string> params) {
    return _template ({}, params);
}
}; // namespace html
}; // namespace spk
