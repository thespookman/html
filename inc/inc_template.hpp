#pragma once
#include <list>
#include <string>

namespace spk {
namespace html {
class Parameter {
  public:
    std::string key;
    std::string value;
    bool        has_value;
    Parameter (std::string key);
    Parameter (std::string key, std::string value);
};
#define HTML_BIN(tag)                                                     \
    std::string tag (const std::string&          content = "",            \
                     const std::list<Parameter>& params  = {});            \
    std::string tag (const std::list<Parameter>& params);
#define HTML_UN(tag)                                                      \
    std::string tag (const std::list<Parameter>& params = {});
std::string Comment (const std::string& content);
std::string Doctype ();
