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
string Comment (string content) {
    return string ("<!--") + content + "-->";
}
string Doctype () { return "<!DOCTYPE html>"; }
}; // namespace html
}; // namespace spk
