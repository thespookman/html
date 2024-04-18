#pragma once
#include <map>
#include <string>

#define HTML_BIN(tag)                                                     \
    std::string tag (std::string                        content = "",     \
                     std::map<std::string, std::string> params  = {});     \
    std::string tag (std::map<std::string, std::string> params);
#define HTML_UN(tag)                                                      \
    std::string tag (std::map<std::string, std::string> params = {});
namespace spk {
namespace html {
std::string Comment (std::string content);
std::string Doctype ();
