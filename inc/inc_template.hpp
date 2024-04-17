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
std::string comment (std::string content);
std::string _delete (std::string                        content = "",
                     std::map<std::string, std::string> params  = {});
std::string _delete (std::map<std::string, std::string> params);
std::string doctype ();
std::string _template (std::string                        content = "",
                       std::map<std::string, std::string> params  = {});
std::string _template (std::map<std::string, std::string> params);
