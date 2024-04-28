#include "spk_html.hpp"

#include <catch2/catch_test_macros.hpp>
#include <string>

using namespace spk::html;
using std::string;
TEST_CASE ("Can create a basic page with HTML tags", "[html]") {
    REQUIRE (Doctype () +
                 Html (Head (Title ("A test page")) +
                       Body (H2 ("A Test Page") + P ("Some test text"))) ==
             string ("<!DOCTYPE html><Html><Head><Title>A test "
                     "page</Title></Head><Body><H2>A Test "
                     "Page</H2><P>Some test text</P></Body></Html>"));
}

TEST_CASE ("Can create a simple link using a key/value parameter",
           "[html]") {
    REQUIRE (
        A ("An example link", {{"href", "https://www.example.com"}}) ==
        string (
            "<A href=\"https://www.example.com\">An example link</A>"));
}

TEST_CASE ("Can create a form using both key/value and boolean parameters",
           "[html]") {
    REQUIRE (
        Form (Label ("Username", {{"for", "uname"}}) +
                  Input ({{"type", "text"},
                          {"name", "uname"},
                          Parameter ("required")}) +
                  Label ("Password", {{"for", "pwd"}}) +
                  Input ({{"type", "password"},
                          {"name", "pwd"},
                          Parameter ("required")}) +
                  Input ({{"type", "submit"}, {"value", "Submit"}}),
              {{"action", "https://www.example.com/login"},
               {"method", "post"}}) ==
        string (
            "<Form action=\"https://www.example.com/login\" "
            "method=\"post\"><Label for=\"uname\">Username</Label><Input "
            "type=\"text\" name=\"uname\" required\"><Label "
            "for=\"pwd\">Password</Label><Input type=\"password\" "
            "name=\"pwd\" required\"><Input type=\"submit\" "
            "value=\"Submit\"></Form>"));
}

TEST_CASE ("Cam create a comment", "[html]") {
    REQUIRE (Comment ("A comment") == string ("<!--A comment-->"));
}
