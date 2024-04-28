#include "parameter.hpp"

#include <list>
#include <string>
namespace spk {
namespace html {
using std::list;
using std::string;
string concat_params (const list<Parameter>& params) {
    string ret = "";
    for (const Parameter& p : params)
        ret += string (" ") + p.key +
               (p.has_value ? "=\"" + p.value : "") + "\"";
    return ret;
}
string Comment (const string& content) {
    return string ("<!--") + content + "-->";
}
string Doctype () { return "<!DOCTYPE html>"; }

Parameter::Parameter (string _key)
    : key {_key}, value {""}, has_value {false} {}
Parameter::Parameter (string _key, string _value)
    : key {_key}, value {_value}, has_value {true} {}
}; // namespace html
}; // namespace spk
