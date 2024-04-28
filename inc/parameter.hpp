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
}; // namespace html
}; // namespace spk
