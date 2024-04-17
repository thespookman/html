# SpkHTML  

Simple C++ html builder

## Building  

Just `make all`, it doesn't have any dependencies other than the standard libraries.

## Usage  

Each HTML tag is a function that returns a string. The strings are all valid HTML, so they can be concatenated with each other, and any other strings of HTML you like.

Single tags (such as `<br>`) are created by calling the function of the same name, e.g. `br()`. The take an optional map of parameters as an argument, such as `param({{"name","a_name"}, {"value", "a_value"}})` which produces `<param name="a_name" value="a_value">`.

Double tags (such as `<b></b>`) are created similarly, but they have an optional first parameter for content. This takes a string to be inserted between the tags. Hence `a("Example",{{"href","example.com"}})` produces `<a href="example.com">Example</a>`. Either, neither or both of the arguments can be omitted.


### Example  

Here's a little programme that prints the HTML for a simple login page:
```
#include "spk_html.hpp"

#include <iostream>

using namespace spk::html;
using std::cout;
using std::endl;
int main () {
    cout << html (head (title ("Login")) +
                  body (h1 ("Login") +
                        form (label ("Name", {{"for", "name"}}) +
                              input ({{"type", "text"},
                                      {"id", "name"},
                                      {"name", "name"}}) +
                              br () +
                              label ("Password", {{"for", "password"}}) +
                              input ({{"type", "password"},
                                      {"id", "password"},
                                      {"name", "password"}}) +
                              br () +
                              input ({{"type", "submit"},
                                      {"value", "Submit"}}))))
         << endl;
    return 0;
}
```
