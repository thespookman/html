#pragma once
#include "parameter.hpp"

#include <list>
#include <string>

namespace spk {
namespace html {
#define HTML_BIN(tag)                                                     \
    std::string tag (const std::string&          content = "",            \
                     const std::list<Parameter>& params  = {});            \
    std::string tag (const std::list<Parameter>& params);
#define HTML_UN(tag)                                                      \
    std::string tag (const std::list<Parameter>& params = {});
std::string Comment (const std::string& content);
std::string Doctype ();
