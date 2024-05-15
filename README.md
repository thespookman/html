# SpkHTML  

Simple C++ html builder

## Build

Just `make all`, it doesn't have any dependencies other than the standard libraries. 

## Install
`# make install`, which by default uses `DESTDIR=/usr`, I recommend setting `DESTDIR` to install somewhere else.

## Usage  

Each HTML tag is a function that returns a string. The strings are all valid HTML, so they can be concatenated with each other, and any other strings of HTML you like.

Single tags (such as `<br>`) are created by calling the function of the same name, e.g. `Br()`. The take an optional map of parameters as an argument, such as `Param({{"name","a_name"}, {"value", "a_value"}})` which produces `<param name="a_name" value="a_value">`.

Double tags (such as `<b></b>`) are created similarly, but they have an optional first parameter for content. This takes a string to be inserted between the tags. Hence `A("Example",{{"href","example.com"}})` produces `<a href="example.com">Example</a>`. Either, neither or both of the arguments can be omitted.

### Doctype

The function `Doctype()` produces `<!DOCTYPE html>`.

### Comments

HTML comments are created with the `Comment(string content)` function.

### Example  

Here's a little programme that prints the HTML for a simple login page:
```
#include "spk_html.hpp"

#include <iostream>

using namespace spk::html;
using std::cout;
using std::endl;
int main () {
    cout << Html (Head (Title ("Login")) +
                  Body (H1 ("Login") +
                        Form (Label ("Name", {{"for", "name"}}) +
                              Input ({{"type", "text"},
                                      {"id", "name"},
                                      {"name", "name"}}) +
                              Br () +
                              Label ("Password", {{"for", "password"}}) +
                              Input ({{"type", "password"},
                                      {"id", "password"},
                                      {"name", "password"}}) +
                              Br () +
                              Input ({{"type", "submit"},
                                      {"value", "Submit"}}))))
         << endl;
    return 0;
}
```
